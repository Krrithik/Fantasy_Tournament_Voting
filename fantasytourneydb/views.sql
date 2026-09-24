-- views.sql
DROP VIEW IF EXISTS active_matchups_with_votes;
DROP VIEW IF EXISTS view_tournament_entries;
DROP VIEW IF EXISTS view_active_tournaments;
Drop VIEW IF EXISTS view_tournament_summary;


-- VIEW 1

CREATE VIEW active_matchups_with_votes as
SELECT 
    m.matchup_id,
    t.tournament_id,
    t.title as tournament_title,
    m.round_number,
    m.status,
    m.opens_at,
    m.closes_at,
    e1.entry_id as entryA_id,
    e1.name as entryA_name,
    e1.image_URL as entryA_image,
    e2.entry_id as entryB_id,
    e2.name as entryB_name,
    e2.image_URL as entryB_image,
    COUNT(DISTINCT case when v.entry_id = m.entryA_id then v.user_id end) as entryA_votes,
    COUNT(DISTINCT case when v.entry_id = m.entryB_id then v.user_id end) AS entryB_votes,
    COUNT(DISTINCT v.user_id) AS total_votes
FROM matchup m
JOIN tournament t on m.tournament_id = t.tournament_id
JOIN entry e1 on m.entryA_id = e1.entry_id
JOIN entry e2 on m.entryB_id = e2.entry_id
LEFT JOIN vote v on m.matchup_id = v.matchup_id
WHERE m.status = 'Active'
GROUP BY m.matchup_id, t.tournament_id, t.title, m.round_number, m.status, m.opens_at, m.closes_at, e1.entry_id, e1.name, e1.image_URL,
         e2.entry_id, e2.name, e2.image_URL;

        
/* 
    A USEFUL SAMPLE QUERY ON THIS VIEW ->

    SELECT 
        tournament_title, round_number, entryA_name, entryA_votes, entryB_name, entryB_votes, closes_at 
        FROM active_matchups_with_votes 
        ORDER BY closes_at ASC;
*/


-- VIEW 2

CREATE VIEW view_tournament_entries AS
SELECT 
    t.tournament_id,
    t.title AS tournament_title,
    e.entry_id,
    e.name AS entry_name,
    e.image_url
FROM tournament t
JOIN entry e 
    ON t.tournament_id = e.tournament_id
ORDER BY t.tournament_id, e.entry_id;

/*
    SAMPLE QUERY FOR THIS VIEW ->

    SELECT tournament_title, entry_id, entry_name
    FROM view_tournament_entries
    WHERE tournament_id = 1;

    -- This returns all entries that belong to a specific tournament.
*/

-- VIEW 3

CREATE VIEW view_active_tournaments AS
SELECT 
    tournament_id,
    title,
    description,
    start_at,
    end_at,
    tourneystatus,
    user_id
FROM tournament
WHERE tourneystatus = 'Active';


/*
    SAMPLE QUERY FOR THIS VIEW ->

    SELECT title, start_at, end_at
    FROM view_active_tournaments
    ORDER BY start_at ASC;

    -- This returns all tournaments that are currently active.
*/

CREATE VIEW view_tournament_summary AS 
SELECT
    t.tournament_id, 
    t.title,
    t.description,
    t.tourneystatus,
    t.start_at, 
    t.end_at,
    t.user_id
    FROM tournament AS t;
/* 
    SAMPLE QUERY FOR THIS VIEW ->

    SELECT * FROM view_tournament_summary LIMIT 5;
*/
