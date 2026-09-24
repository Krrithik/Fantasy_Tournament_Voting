-- fantasy_tournament.sql
-- Master rebuild script for the Fantasy Tournament Database


-- Helps us drop tables freely --
------------------------------------
SET foreign_key_checks = 0;

-- Drop tables if they exist (in reverse dependency order)
DROP TABLE IF EXISTS vote;
DROP TABLE IF EXISTS matchup;
DROP TABLE IF EXISTS entry;
DROP TABLE IF EXISTS tournament;
DROP TABLE IF EXISTS users;

SET foreign_key_checks = 1;

-- Recreate the schema
SOURCE fantasytourneydb/tables.sql;

-- Optionally insert mock data
SOURCE fantasytourneydb/data.sql;
