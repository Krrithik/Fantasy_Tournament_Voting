-- procedures.sql
DROP PROCEDURE IF EXISTS register_user;
DROP PROCEDURE IF EXISTS delete_tournament;
DROP PROCEDURE IF EXISTS update_matchup_status;
DROP PROCEDURE IF EXISTS get_tournament_stats;

-- PROCEDURE 1
-- procedure for inserting registered users

DELIMITER //

CREATE PROCEDURE register_user(
    p_email VARCHAR (255),
    p_password VARCHAR(255),
    p_displayname VARCHAR (100),
    p_role VARCHAR (20)
)

BEGIN 
    declare email_exists int default 0;

    if p_email = "" or p_email is null then
        select "ERROR: Email is required" as message;

    elseif  p_password = "" or p_password is null then
        select "ERROR: Password is required" as message;

    elseif p_displayname = "" or p_displayname is null then
        select "ERROR: Displayname is required" as message;

    elseif p_role not in ("admin", "player", "guest") then
        select "ERROR: Invalid Role" as message;
    
    else 
        -- check if email already exists
            select count(*) into email_exists
            from users
            where email = p_email;

        if email_exists > 0 then
            select "ERROR: Email already exists" as message;
        else
            insert into users (email, password, displayname, role)
            values (p_email, p_password, p_displayname, p_role);

            -- returning successfully inserted user info row
            select "User registered successfully!" as message;

            select * from users 
            where email = p_email;
        end if;
    end if; 
END //

DELIMITER ;

---------------------------------------------------------------------------
-- PROCEDURE 2 
-- procedure for deleting old tournaments


DELIMITER //

CREATE PROCEDURE delete_tournament(
    IN p_tournament_id INT,
    IN p_role VARCHAR(20),
    IN p_user_id INT       -- NEW: caller's user_id
)
BEGIN
    DECLARE tournament_exists INT DEFAULT 0;
    DECLARE tournament_status VARCHAR(30);
    DECLARE active_matchup_count INT DEFAULT 0;
    DECLARE tournament_owner INT DEFAULT NULL;   -- NEW

    -- Does it exist?
    SELECT COUNT(*) INTO tournament_exists
    FROM tournament
    WHERE tournament_id = p_tournament_id;

    IF tournament_exists = 0 THEN
        SELECT 'Error: Tournament does not exist' AS message;
        LEAVE proc_end;
    END IF;

    -- Get status + owner  (NEW)
    SELECT tourneystatus, user_id
    INTO tournament_status, tournament_owner
    FROM tournament
    WHERE tournament_id = p_tournament_id;

    -- Count active matchups
    SELECT COUNT(*) INTO active_matchup_count
    FROM matchup
    WHERE tournament_id = p_tournament_id
      AND status = 'Active';

    -- ADMIN OVERRIDE
    IF p_role = 'admin' THEN
        
        -- DELETE order: votes -> matchups -> entries -> tournament
        DELETE FROM vote
        WHERE matchup_id IN (
            SELECT matchup_id FROM matchup WHERE tournament_id = p_tournament_id
        );

        DELETE FROM matchup
        WHERE tournament_id = p_tournament_id;

        DELETE FROM entry
        WHERE tournament_id = p_tournament_id;

        DELETE FROM tournament
        WHERE tournament_id = p_tournament_id;

        SELECT CONCAT('Admin deleted tournament ', p_tournament_id) AS message;
        LEAVE proc_end;
    END IF;

    -- USER DELETE RULES ----------------------------------

    -- NEW: Only allow the creator to delete their own tournaments
    IF p_user_id <> tournament_owner THEN
        SELECT 'Error: You are not the creator of this tournament' AS message;
        LEAVE proc_end;
    END IF;

    IF tournament_status = 'Active' THEN
        SELECT 'Error: Cannot delete an ACTIVE tournament' AS message;
        LEAVE proc_end;
    END IF;

    IF active_matchup_count > 0 THEN
        SELECT CONCAT('Error: Cannot delete tournament with ', active_matchup_count,
               ' active matchup(s).') AS message;
        LEAVE proc_end;
    END IF;

    -- DELETE order: votes -> matchups -> entries -> tournament
    DELETE FROM vote
    WHERE matchup_id IN (
        SELECT matchup_id FROM matchup WHERE tournament_id = p_tournament_id
    );

    DELETE FROM matchup
    WHERE tournament_id = p_tournament_id;

    DELETE FROM entry
    WHERE tournament_id = p_tournament_id;

    DELETE FROM tournament
    WHERE tournament_id = p_tournament_id;

    SELECT CONCAT('Tournament ', p_tournament_id, ' deleted successfully.') AS message;

    proc_end: BEGIN END;

END//
DELIMITER ;


---------------------------------------------------------------------------
-- PROCEDURE 3 
-- procedure for updating matchup status as they move from upcoming->active->completed

DELIMITER //
CREATE PROCEDURE update_matchup_status(
    p_matchup_id INT,
    p_new_status varchar(30)
)
BEGIN
    DECLARE matchup_exists INT DEFAULT 0;
    DECLARE old_status VARCHAR (30);
    DECLARE tournament_title VARCHAR (255);

    -- check if matchup exist
    select count(*) into matchup_exists
    from matchup
    where matchup_id = p_matchup_id;

    if matchup_exists = 0 then 
        select "Error: Matchup not found" as message;
    elseif p_new_status NOT IN ('Upcoming', 'Active', 'Completed') THEN
        -- Validation check for allowed status
        SELECT CONCAT('Error: Invalid status "', p_new_status,
                      '". Allowed values: Upcoming, Active, Completed.') AS message;
    else

        -- get current status and tournament info 
        select m.status
        into old_status
        from matchup m 
        where m.matchup_id = p_matchup_id;

        -- check if new status is passed in the param
        if old_status = p_new_status then
            select concat("Issue: Matchup id: ", p_matchup_id, " is already in status '", p_new_status, "' ") as message;
        else 

            -- update the status
            update matchup 
            set status = p_new_status
            where matchup_id = p_matchup_id;

            SELECT CONCAT('Matchup ', p_matchup_id, ' updated successfully!') AS message;
        end if;
    end if;
    
END //
DELIMITER ;

---------------------------------------------------------------------------
-- PROCEDURE 4
-- getting statistical metrics for tournament

DELIMITER //

CREATE PROCEDURE get_tournament_stats(
    p_tournament_id int 
)
BEGIN
    DECLARE tournament_exists INT DEFAULT 0;
    
    -- Check if tournament exists
    select count(*) into tournament_exists
    from tournament
    where tournament_id = p_tournament_id;
    
    if tournament_exists = 0 then
        select 'Error: Tournament not found' as message;
        
    else
        -- Tournament Overview
        select 
            t.tournament_id,
            t.title,
            t.description,
            t.tourneystatus,
            t.start_at,
            t.end_at,
            DATEDIFF(COALESCE(t.end_at, now()), t.start_at) as duration_days,
            u.displayname as created_by_admin
        from tournament t
        join users u ON t.user_id = u.user_id
        where t.tournament_id = p_tournament_id;
        
        -- Participation Statistics
        select 
            count(DISTINCT e.entry_id) as total_entries,
            count(DISTINCT m.matchup_id) as total_matchups,
            count(DISTINCT CASE WHEN m.status = 'Completed' THEN m.matchup_id END) as completed_matchups,
            count(DISTINCT CASE WHEN m.status = 'Active' THEN m.matchup_id END) as active_matchups,
            count(DISTINCT CASE WHEN m.status = 'Upcoming' THEN m.matchup_id END) as upcoming_matchups,
            count(DISTINCT v.user_id) as unique_voters,
            count(v.user_id) as total_votes,
            round(count(v.user_id) / nullif(count(DISTINCT m.matchup_id), 0), 2) as avg_votes_per_matchup,
            max(m.round_number) as max_round_reached
        from tournament t
        left join entry e on t.tournament_id = e.tournament_id
        left join matchup m on t.tournament_id = m.tournament_id
        left join vote v on m.matchup_id = v.matchup_id
        where t.tournament_id = p_tournament_id;
        
        -- Top 5 Most Popular Entries
        select 
            e.entry_id,
            e.name AS entry_name,
            e.seed,
            count(v.user_id) AS total_votes_received,
            count(DISTINCT m.matchup_id) AS matchups_participated
        from entry e
        left join vote v on e.entry_id = v.entry_id
        left join matchup m on (e.entry_id = m.entryA_id OR e.entry_id = m.entryB_id)
        where e.tournament_id = p_tournament_id
        group by e.entry_id, e.name, e.seed
        order by total_votes_received desc
        limit 5;
        
        -- Vote Distribution by Round
        select 
            m.round_number,
            count(DISTINCT m.matchup_id) as matchups_in_round,
            count(v.user_id) as votes_in_round,
            round(count(v.user_id) / nullif(count(DISTINCT m.matchup_id), 0), 2) as avg_votes_per_matchup
        from matchup m
        left join vote v on m.matchup_id = v.matchup_id
        where m.tournament_id = p_tournament_id
        group by m.round_number
        order by m.round_number;
    end if;
    
END //

DELIMITER ;

---Procedure 5----
---creating a new tournament from GUI d

DROP PROCEDURE IF EXISTS create_tournament;

DELIMITER //

CREATE PROCEDURE create_tournament(
    IN p_title        VARCHAR(255),
    IN p_description  TEXT,
    IN p_start        DATE,
    IN p_end          DATE,
    IN p_user_id      INT
)
BEGIN
    DECLARE v_status VARCHAR(20);

    -- Decide tournament status based on dates
    IF p_start > CURDATE() THEN
        SET v_status = 'Upcoming';
    ELSEIF p_end IS NOT NULL AND p_end < CURDATE() THEN
        SET v_status = 'Completed';
    ELSE
        SET v_status = 'Active';
    END IF;

    -- Insert the new tournament
    INSERT INTO tournament (title, description, start_at, end_at, tourneystatus, user_id)
    VALUES (p_title, p_description, p_start, p_end, v_status, p_user_id);

    -- Return the new tournament_id as a result set
    SELECT LAST_INSERT_ID() AS new_tournament_id;
END //

DELIMITER ;
