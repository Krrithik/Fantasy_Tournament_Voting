-- triggers.sql
-- -----------------------------------------------------------------------------
-- TRIGGER: same_entry — prevent duplicate entry names within the same tournament
-- -----------------------------------------------------------------------------
DELIMITER //

DROP TRIGGER IF EXISTS trg_entry_same_ins //
CREATE TRIGGER trg_entry_same_ins
BEFORE INSERT ON entry
FOR EACH ROW
BEGIN
  IF EXISTS (
    SELECT 1
    FROM entry e
    WHERE e.tournament_id = NEW.tournament_id
      AND e.name = NEW.name
  ) THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Duplicate entry name in this tournament.';
  END IF;
END //

DROP TRIGGER IF EXISTS trg_entry_same_upd //
CREATE TRIGGER trg_entry_same_upd
BEFORE UPDATE ON entry
FOR EACH ROW
BEGIN
  IF EXISTS (
    SELECT 1
    FROM entry e
    WHERE e.tournament_id = NEW.tournament_id
      AND e.name = NEW.name
      AND e.entry_id <> NEW.entry_id
  ) THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Duplicate entry name in this tournament.';
  END IF;
END //

DELIMITER ;
-- Attempt to insert a duplicate "Spider-Man" (should FAIL)
-- INSERT INTO entry (name, description, image_URL, seed, tournament_id)
-- VALUES ('Spider-Man', 'test', NULL, 99, 2);




-- -----------------------------------------------------------------------------
-- TRIGGER: minimum_votes — require >= 1 vote before completing a matchup
-- -----------------------------------------------------------------------------
DELIMITER //

DROP TRIGGER IF EXISTS trg_matchup_min_votes_upd //
CREATE TRIGGER trg_matchup_min_votes_upd
BEFORE UPDATE ON matchup
FOR EACH ROW
BEGIN

 IF NEW.status = 'Completed' AND OLD.status <> 'Completed' THEN
    IF (SELECT COUNT(*) FROM vote WHERE matchup_id = NEW.matchup_id) < 1 THEN
      SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot complete matchup: minimum vote threshold not met.';
    END IF;
  END IF;
END //

DELIMITER ;




-- -----------------------------------------------------------------------------
-- TRIGGER: select_winner — decide and store the winner when matchup completes
-- -----------------------------------------------------------------------------
DELIMITER //

DROP TRIGGER IF EXISTS trg_matchup_select_winner //
CREATE TRIGGER trg_matchup_select_winner
AFTER UPDATE ON matchup
FOR EACH ROW
BEGIN
  DECLARE votesA INT DEFAULT 0;
  DECLARE votesB INT DEFAULT 0;
  DECLARE seedA INT DEFAULT NULL;
  DECLARE seedB INT DEFAULT NULL;

  -- Run ONLY when status just changed to Completed
  IF NEW.status = 'Completed' AND OLD.status <> 'Completed' THEN

    -- Count votes for each entry
    SELECT COUNT(*) INTO votesA
    FROM vote 
    WHERE matchup_id = NEW.matchup_id
      AND entry_id   = NEW.entryA_id;

    SELECT COUNT(*) INTO votesB
    FROM vote 
    WHERE matchup_id = NEW.matchup_id
      AND entry_id   = NEW.entryB_id;

    -- Winner by votes
    IF votesA > votesB THEN
      UPDATE matchup 
      SET winner_entry_id = NEW.entryA_id
      WHERE matchup_id = NEW.matchup_id;

    ELSEIF votesB > votesA THEN
      UPDATE matchup 
      SET winner_entry_id = NEW.entryB_id
      WHERE matchup_id = NEW.matchup_id;

    ELSE
      -- Tie → use seed tiebreaker
      SELECT seed INTO seedA FROM entry WHERE entry_id = NEW.entryA_id;
      SELECT seed INTO seedB FROM entry WHERE entry_id = NEW.entryB_id;

      SET seedA = COALESCE(seedA, 9999);
      SET seedB = COALESCE(seedB, 9999);

      IF seedA < seedB THEN
        UPDATE matchup 
        SET winner_entry_id = NEW.entryA_id
        WHERE matchup_id = NEW.matchup_id;

      ELSE
        UPDATE matchup 
        SET winner_entry_id = NEW.entryB_id
        WHERE matchup_id = NEW.matchup_id;

      END IF;

    END IF;

  END IF;

END //

DELIMITER ;

--- trg_entry_prevent_delete_active
/* Prevents anyone from deleling entries from active tournaments */
DELIMITER //

CREATE TRIGGER trg_entry_prevent_delete_active
BEFORE DELETE ON entry
FOR EACH ROW
BEGIN
    DECLARE tourney_status VARCHAR(20);
    
    -- Check the status of the tournament this entry belongs to
    SELECT tourneystatus INTO tourney_status
    FROM tournament
    WHERE tournament_id = OLD.tournament_id;
    
    -- If tournament is active, block the delete
    IF tourney_status = 'Active' THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Safety Lock: Cannot delete an entry while the tournament is Active.';
    END IF;
END //

DELIMITER ;
