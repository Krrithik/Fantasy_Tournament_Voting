-- Fantasy Tournament Sample Data
-- This file will insert test data for tables

-- helps us delete and reload data safely --
--------------------------------------------
set foreign_key_checks = 0;     -- turns off FK enforcement
delete from vote;
delete from matchup;
delete from entry;
delete from tournament;
delete from users;
set foreign_key_checks = 1;     -- turns on FK enforcement
--------------------------------------------

-- Users --
-----------
insert into users (email, role, displayname, password)
values
('jsoto24@csub.edu', 'admin', 'slug','dbnoob1'),
('krithickdagod@csub.edu', 'player', 'krrxthxk', 'dbnoob2'),
('angelBchillen@csub.edu', 'guest', 'angelB)', 'dbnoob3'),
('gerbertdadude@csub.edu', 'player','AZ', 'dbnoob4');

-- Tournaments --
-----------------
insert into tournament (title, description, start_at, end_at, tourneystatus, user_id)
values
('Autumn Showdown', 'A seasonal battle between the best entries.', '2025-09-01', '2025-09-15', 'Completed', 1),
('Winter Clash', 'Frosty fights for the winter crown.', '2025-12-01', '2025-12-15', 'Upcoming', 1);

-- Entries --
-------------
insert into entry (name, description, image_URL, seed, tournament_id)
values
('Crimson Blades', 'A fierce red-themed team.', 'https://example.com/img/crimson.png', 1, 1),
('Azure Storm', 'The team with unmatched agility.', 'https://example.com/img/azure.png', 2, 1),
('Golden Hawks', 'Rising stars of the tournament.', 'https://example.com/img/hawks.png', 3, 2),
('Emerald Titans', 'Green giants of the Winter Clash.', 'https://example.com/img/titans.png', 4, 2);

-- MatchUps --  
--------------
insert into matchup (round_number, status, opens_at, closes_at, tournament_id, entryA_id, entryB_id)
values
(1, 'Completed', '2025-09-01 10:00:00', '2025-09-01 22:00:00', 1, 1, 2),
(1, 'Upcoming', '2025-12-01 10:00:00', '2025-12-01 22:00:00', 2, 3, 4);

-- Votes --
-----------
insert into vote (user_id, matchup_id, entry_id)
values
(2, 1, 1),  -- Krrxthxk voted for Crimson Blades in Autumn Showdown
(3, 1, 2),  -- angelB voted for Azure Storm
(4, 2, 3);  -- AZ voted for Golden Hawks