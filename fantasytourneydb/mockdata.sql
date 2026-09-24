-- mockdata.sql

--------------------------------------------
set foreign_key_checks = 0;     -- turns off FK enforcement
delete from vote;
delete from matchup;
delete from entry;
delete from tournament;
delete from users;
set foreign_key_checks = 1;     -- turns on FK enforcement
--------------------------------------------

--------------------------------------------------------------------------------------
-- User  NO FK CONSTRAINTS
--------------------------------------------------------------------------------------

INSERT INTO users (email, role, displayname, password) VALUES
-- admin
('admin@fantasytourney.com', 'admin', 'TourneyMaster', 'admin123'),
('sarah.chen@email.com', 'admin', 'SarahC', 'password123'),
-- player
('marcus.johnson@gmail.com', 'player', 'MarcusJ', 'pass456'),
('emily.rodriguez@yahoo.com', 'player', 'EmilyR', 'secure789'),
('james.williams@email.com', 'player', 'JWilliams', 'mypass321'),
('priya.patel@gmail.com', 'player', 'PriyaP', 'hello123'),
('david.kim@email.com', 'player', 'DaveKim', 'password456'),
('jessica.brown@yahoo.com', 'player', 'JessBrown', 'pass789'),
('michael.lee@gmail.com', 'player', 'MikeLee', 'secure123'),
('amanda.garcia@email.com', 'player', 'AmandaG', 'mypass456'),
('ryan.nguyen@gmail.com', 'player', 'RyanN', 'hello789'),
('sophia.martinez@yahoo.com', 'player', 'SophiaM', 'password789'),
('daniel.anderson@email.com', 'player', 'DanA', 'pass123'),
('olivia.taylor@gmail.com', 'player', 'OliviaT', 'secure456'),
('ethan.thomas@email.com', 'player', 'EthanT', 'mypass789'),
('isabella.white@yahoo.com', 'player', 'IsabellaW', 'hello456'),
('noah.harris@gmail.com', 'player', 'NoahH', 'password321'),
-- guest
('guest_user1@temp.com', 'guest', 'GuestUser1', 'guest123'),
('guest_user2@temp.com', 'guest', 'GuestUser2', 'guest456'),
('guest_user3@temp.com', 'guest', 'GuestUser3', 'guest789');

--------------------------------------------------------------------------------------
-- TOURNAMENT  1 FK 
--------------------------------------------------------------------------------------
-- Insert Tournaments (references users table)

-- Insert Tournaments (created by ADMIN users only)
INSERT INTO tournament (title, description, start_at, end_at, tourneystatus, user_id) VALUES
('Best Pizza Toppings 2024', 'Vote for the ultimate pizza topping in this delicious showdown', '2024-01-15', '2024-02-15', 'Completed', 1),
('Ultimate Marvel Hero', 'Which Marvel superhero reigns supreme?', '2024-03-01', '2024-04-01', 'Completed', 1),
('Top Programming Languages', 'Battle of the best coding languages', '2024-10-01', '2024-11-15', 'Completed', 2),
('Best 90s Movie', 'Nostalgia bracket - vote for the greatest 90s film', '2024-11-01', NULL, 'Active', 1),
('Greatest Video Game', 'Tournament to crown the GOAT of gaming', '2024-11-10', NULL, 'Active', 2),
('Best Coffee Shop', 'Local coffee shop championship', '2024-12-01', NULL, 'Upcoming', 1),
('Cutest Dog Breed', 'Which dog breed is the cutest? You decide!', '2024-12-15', NULL, 'Upcoming', 2),
('Best Sci-Fi Novel', 'Classic and modern sci-fi books face off', '2025-01-05', NULL, 'Upcoming', 1);
--------------------------------------------------------------------------------------
-- ENTRY   1 FK
--------------------------------------------------------------------------------------
-- Insert Entries (references tournament table)
-- Tournament 1: Best Pizza Toppings (8 entries for 3 rounds)
INSERT INTO entry (name, description, image_URL, seed, tournament_id) VALUES
('Pepperoni', 'Classic and beloved pepperoni', NULL, 1, 1),
('Mushrooms', 'Earthy and savory mushrooms', NULL, 8, 1),
('Sausage', 'Italian sausage chunks', NULL, 4, 1),
('Green Peppers', 'Fresh green bell peppers', NULL, 5, 1),
('Onions', 'Sweet caramelized onions', NULL, 3, 1),
('Black Olives', 'Briny black olives', NULL, 6, 1),
('Extra Cheese', 'More cheese is always better', NULL, 2, 1),
('Bacon', 'Crispy bacon bits', NULL, 7, 1),

-- Tournament 2: Ultimate Marvel Hero (8 entries)
('Spider-Man', 'Your friendly neighborhood Spider-Man', NULL, 1, 2),
('Iron Man', 'Genius billionaire playboy philanthropist', NULL, 8, 2),
('Captain America', 'The first Avenger', NULL, 4, 2),
('Thor', 'God of Thunder', NULL, 5, 2),
('Black Widow', 'Master spy and assassin', NULL, 3, 2),
('Hulk', 'The strongest Avenger', NULL, 6, 2),
('Doctor Strange', 'Master of the Mystic Arts', NULL, 2, 2),
('Black Panther', 'King of Wakanda', NULL, 7, 2),

-- Tournament 3: Top Programming Languages (8 entries)
('Python', 'Versatile and beginner-friendly', NULL, 1, 3),
('JavaScript', 'The language of the web', NULL, 8, 3),
('Java', 'Enterprise standard', NULL, 4, 3),
('C++', 'High performance systems language', NULL, 5, 3),
('Go', 'Modern and efficient', NULL, 3, 3),
('Rust', 'Memory safe systems programming', NULL, 6, 3),
('TypeScript', 'JavaScript with types', NULL, 2, 3),
('C#', 'Microsoft powerhouse', NULL, 7, 3),

-- Tournament 4: Best 90s Movie (16 entries for 4 rounds)
('The Matrix', 'Mind-bending sci-fi classic', NULL, 1, 4),
('Pulp Fiction', 'Tarantino masterpiece', NULL, 16, 4),
('Jurassic Park', 'Dinosaurs come to life', NULL, 8, 4),
('The Shawshank Redemption', 'Prison drama perfection', NULL, 9, 4),
('Forrest Gump', 'Life is like a box of chocolates', NULL, 4, 4),
('Titanic', 'Epic romance and tragedy', NULL, 13, 4),
('Fight Club', 'First rule: dont talk about it', NULL, 5, 4),
('The Sixth Sense', 'I see dead people', NULL, 12, 4),
('Goodfellas', 'Mob movie excellence', NULL, 2, 4),
('Saving Private Ryan', 'War film masterpiece', NULL, 15, 4),
('The Big Lebowski', 'The Dude abides', NULL, 7, 4),
('Fargo', 'Dark comedy crime thriller', NULL, 10, 4),
('American Beauty', 'Suburban drama', NULL, 3, 4),
('The Truman Show', 'Reality TV before reality TV', NULL, 14, 4),
('Toy Story', 'Pixar animation revolution', NULL, 6, 4),
('The Lion King', 'Circle of life', NULL, 11, 4),

-- Tournament 5: Greatest Video Game (16 entries)
('The Legend of Zelda: Ocarina of Time', 'N64 adventure classic', NULL, 1, 5),
('Super Mario 64', 'Revolutionary 3D platformer', NULL, 16, 5),
('Half-Life 2', 'FPS storytelling masterpiece', NULL, 8, 5),
('The Last of Us', 'Post-apocalyptic emotional journey', NULL, 9, 5),
('Red Dead Redemption 2', 'Wild West epic', NULL, 4, 5),
('Minecraft', 'Infinite creativity sandbox', NULL, 13, 5),
('Dark Souls', 'Brutal but rewarding challenge', NULL, 5, 5),
('Portal 2', 'Puzzle game perfection', NULL, 12, 5),
('The Witcher 3', 'Massive RPG adventure', NULL, 2, 5),
('God of War (2018)', 'Norse mythology action', NULL, 15, 5),
('Elden Ring', 'Open world souls-like', NULL, 7, 5),
('Hades', 'Roguelike with amazing story', NULL, 10, 5),
('Baldurs Gate 3', 'Modern CRPG masterpiece', NULL, 3, 5),
('Hollow Knight', 'Metroidvania excellence', NULL, 14, 5),
('Celeste', 'Platforming and mental health', NULL, 6, 5),
('Stardew Valley', 'Farming sim with heart', NULL, 11, 5),

-- Tournament 6: Best Coffee Shop (4 entries for 2 rounds - smaller tournament)
('The Daily Grind', 'Local favorite with great vibes', NULL, 1, 6),
('Brew Haven', 'Artisan roasts and cozy atmosphere', NULL, 4, 6),
('Java Junction', 'Best espresso in town', NULL, 2, 6),
('Cafe Momentum', 'Fair trade and community focused', NULL, 3, 6),

-- Tournament 7: Cutest Dog Breed (8 entries)
('Golden Retriever', 'Friendly and loyal family dog', NULL, 1, 7),
('Corgi', 'Short legs, big personality', NULL, 8, 7),
('Husky', 'Beautiful blue eyes and fluffy', NULL, 4, 7),
('Pomeranian', 'Tiny fluffy cloud', NULL, 5, 7),
('Shiba Inu', 'Internet famous doge', NULL, 3, 7),
('French Bulldog', 'Compact and charming', NULL, 6, 7),
('Samoyed', 'Always smiling fluff ball', NULL, 2, 7),
('Beagle', 'Adorable floppy ears', NULL, 7, 7),

-- Tournament 8: Best Sci-Fi Novel (8 entries)
('Dune', 'Frank Herberts desert epic', NULL, 1, 8),
('Enders Game', 'Military sci-fi classic', NULL, 8, 8),
('Neuromancer', 'Cyberpunk foundation', NULL, 4, 8),
('The Left Hand of Darkness', 'Ursula K. Le Guin masterwork', NULL, 5, 8),
('Foundation', 'Asimovs galactic empire', NULL, 3, 8),
('Hyperion', 'Canterbury Tales in space', NULL, 6, 8),
('Snow Crash', 'Virtual reality and linguistics', NULL, 2, 8),
('The Hitchhikers Guide to the Galaxy', 'Dont panic!', NULL, 7, 8);

--------------------------------------------------------------------------------------
-- MATCHUP  3 FK
--------------------------------------------------------------------------------------
-- Insert Matchups (references tournament and entry tables)

-- Tournament 1: Best Pizza Toppings - COMPLETED (8 entries = 3 rounds: 4+2+1 = 7 matchups)
-- Round 1 (4 matchups) - Completed in January 2024
INSERT INTO matchup (round_number, status, opens_at, closes_at, tournament_id, entryA_id, entryB_id) VALUES
(1, 'Completed', '2024-01-15 10:00:00', '2024-01-20 23:59:59', 1, 1, 2),  -- Pepperoni vs Mushrooms
(1, 'Completed', '2024-01-15 10:00:00', '2024-01-20 23:59:59', 1, 7, 8),  -- Extra Cheese vs Bacon
(1, 'Completed', '2024-01-15 10:00:00', '2024-01-20 23:59:59', 1, 3, 4),  -- Sausage vs Green Peppers
(1, 'Completed', '2024-01-15 10:00:00', '2024-01-20 23:59:59', 1, 5, 6),  -- Onions vs Black Olives

-- Round 2 (2 matchups - semifinals)
(2, 'Completed', '2024-01-22 10:00:00', '2024-01-27 23:59:59', 1, 1, 7),  -- Pepperoni vs Extra Cheese
(2, 'Completed', '2024-01-22 10:00:00', '2024-01-27 23:59:59', 1, 3, 5),  -- Sausage vs Onions

-- Round 3 (1 matchup - finals)
(3, 'Completed', '2024-01-29 10:00:00', '2024-02-15 23:59:59', 1, 1, 3);  -- Pepperoni vs Sausage

-- Tournament 2: Ultimate Marvel Hero - COMPLETED (8 entries = 7 matchups)
-- Round 1 (4 matchups)
INSERT INTO matchup (round_number, status, opens_at, closes_at, tournament_id, entryA_id, entryB_id) VALUES
(1, 'Completed', '2024-03-01 10:00:00', '2024-03-08 23:59:59', 2, 9, 10),   -- Spider-Man vs Iron Man
(1, 'Completed', '2024-03-01 10:00:00', '2024-03-08 23:59:59', 2, 15, 16),  -- Doctor Strange vs Black Panther
(1, 'Completed', '2024-03-01 10:00:00', '2024-03-08 23:59:59', 2, 11, 12),  -- Captain America vs Thor
(1, 'Completed', '2024-03-01 10:00:00', '2024-03-08 23:59:59', 2, 13, 14),  -- Black Widow vs Hulk

-- Round 2 (2 matchups)
(2, 'Completed', '2024-03-10 10:00:00', '2024-03-17 23:59:59', 2, 9, 15),   -- Spider-Man vs Doctor Strange
(2, 'Completed', '2024-03-10 10:00:00', '2024-03-17 23:59:59', 2, 11, 14),  -- Captain America vs Hulk

-- Round 3 (finals)
(3, 'Completed', '2024-03-20 10:00:00', '2024-04-01 23:59:59', 2, 9, 11);   -- Spider-Man vs Captain America

-- Tournament 3: Top Programming Languages - COMPLETED (8 entries = 7 matchups)
-- Round 1 (4 matchups)
INSERT INTO matchup (round_number, status, opens_at, closes_at, tournament_id, entryA_id, entryB_id) VALUES
(1, 'Completed', '2024-10-01 10:00:00', '2024-10-10 23:59:59', 3, 17, 18),  -- Python vs JavaScript
(1, 'Completed', '2024-10-01 10:00:00', '2024-10-10 23:59:59', 3, 23, 24),  -- TypeScript vs C#
(1, 'Completed', '2024-10-01 10:00:00', '2024-10-10 23:59:59', 3, 19, 20),  -- Java vs C++
(1, 'Completed', '2024-10-01 10:00:00', '2024-10-10 23:59:59', 3, 21, 22),  -- Go vs Rust

-- Round 2 (2 matchups)
(2, 'Completed', '2024-10-15 10:00:00', '2024-10-25 23:59:59', 3, 17, 23),  -- Python vs TypeScript
(2, 'Completed', '2024-10-15 10:00:00', '2024-10-25 23:59:59', 3, 19, 22),  -- Java vs Rust

-- Round 3 (finals)
(3, 'Completed', '2024-10-28 10:00:00', '2024-11-15 23:59:59', 3, 17, 22);  -- Python vs Rust

-- Tournament 4: Best 90s Movie - ACTIVE (16 entries = 4 rounds: 8+4+2+1 = 15 matchups)
-- Round 1 (8 matchups) - Completed
INSERT INTO matchup (round_number, status, opens_at, closes_at, tournament_id, entryA_id, entryB_id) VALUES
(1, 'Completed', '2024-11-01 10:00:00', '2024-11-05 23:59:59', 4, 25, 26),  -- The Matrix vs Pulp Fiction
(1, 'Completed', '2024-11-01 10:00:00', '2024-11-05 23:59:59', 4, 27, 28),  -- Jurassic Park vs Shawshank
(1, 'Completed', '2024-11-01 10:00:00', '2024-11-05 23:59:59', 4, 29, 30),  -- Forrest Gump vs Titanic
(1, 'Completed', '2024-11-01 10:00:00', '2024-11-05 23:59:59', 4, 31, 32),  -- Fight Club vs Sixth Sense
(1, 'Completed', '2024-11-01 10:00:00', '2024-11-05 23:59:59', 4, 33, 34),  -- Goodfellas vs Saving Private Ryan
(1, 'Completed', '2024-11-01 10:00:00', '2024-11-05 23:59:59', 4, 35, 36),  -- Big Lebowski vs Fargo
(1, 'Completed', '2024-11-01 10:00:00', '2024-11-05 23:59:59', 4, 37, 38),  -- American Beauty vs Truman Show
(1, 'Completed', '2024-11-01 10:00:00', '2024-11-05 23:59:59', 4, 39, 40),  -- Toy Story vs Lion King

-- Round 2 (4 matchups) - Completed
(2, 'Completed', '2024-11-07 10:00:00', '2024-11-12 23:59:59', 4, 25, 28),  -- Matrix vs Shawshank
(2, 'Completed', '2024-11-07 10:00:00', '2024-11-12 23:59:59', 4, 29, 31),  -- Forrest Gump vs Fight Club
(2, 'Completed', '2024-11-07 10:00:00', '2024-11-12 23:59:59', 4, 33, 35),  -- Goodfellas vs Big Lebowski
(2, 'Completed', '2024-11-07 10:00:00', '2024-11-12 23:59:59', 4, 39, 38),  -- Toy Story vs Truman Show

-- Round 3 (2 matchups - semifinals) - ACTIVE NOW
(3, 'Active', '2024-11-14 10:00:00', '2024-11-20 23:59:59', 4, 25, 29),     -- Matrix vs Forrest Gump
(3, 'Active', '2024-11-14 10:00:00', '2024-11-20 23:59:59', 4, 33, 39),     -- Goodfellas vs Toy Story

-- Round 4 (finals) - Upcoming
(4, 'Upcoming', '2024-11-22 10:00:00', '2024-11-30 23:59:59', 4, 25, 33);   -- Placeholder for finals

-- Tournament 5: Greatest Video Game - ACTIVE (16 entries = 15 matchups)
-- Round 1 (8 matchups) - Completed
INSERT INTO matchup (round_number, status, opens_at, closes_at, tournament_id, entryA_id, entryB_id) VALUES
(1, 'Completed', '2024-11-10 10:00:00', '2024-11-14 23:59:59', 5, 41, 42),  -- Zelda OoT vs Mario 64
(1, 'Completed', '2024-11-10 10:00:00', '2024-11-14 23:59:59', 5, 43, 44),  -- Half-Life 2 vs Last of Us
(1, 'Completed', '2024-11-10 10:00:00', '2024-11-14 23:59:59', 5, 45, 46),  -- RDR2 vs Minecraft
(1, 'Completed', '2024-11-10 10:00:00', '2024-11-14 23:59:59', 5, 47, 48),  -- Dark Souls vs Portal 2
(1, 'Completed', '2024-11-10 10:00:00', '2024-11-14 23:59:59', 5, 49, 50),  -- Witcher 3 vs God of War
(1, 'Completed', '2024-11-10 10:00:00', '2024-11-14 23:59:59', 5, 51, 52),  -- Elden Ring vs Hades
(1, 'Completed', '2024-11-10 10:00:00', '2024-11-14 23:59:59', 5, 53, 54),  -- Baldurs Gate 3 vs Hollow Knight
(1, 'Completed', '2024-11-10 10:00:00', '2024-11-14 23:59:59', 5, 55, 56),  -- Celeste vs Stardew Valley

-- Round 2 (4 matchups) - ACTIVE NOW
(2, 'Active', '2024-11-16 10:00:00', '2024-11-22 23:59:59', 5, 41, 44),     -- Zelda vs Last of Us
(2, 'Active', '2024-11-16 10:00:00', '2024-11-22 23:59:59', 5, 45, 48),     -- RDR2 vs Portal 2
(2, 'Active', '2024-11-16 10:00:00', '2024-11-22 23:59:59', 5, 49, 51),     -- Witcher vs Elden Ring
(2, 'Active', '2024-11-16 10:00:00', '2024-11-22 23:59:59', 5, 53, 56),     -- Baldurs Gate vs Stardew

-- Round 3 (semifinals) - Upcoming
(3, 'Upcoming', '2024-11-24 10:00:00', '2024-11-29 23:59:59', 5, 41, 45),   -- Placeholder
(3, 'Upcoming', '2024-11-24 10:00:00', '2024-11-29 23:59:59', 5, 49, 53),   -- Placeholder

-- Round 4 (finals) - Upcoming
(4, 'Upcoming', '2024-12-01 10:00:00', '2024-12-07 23:59:59', 5, 41, 49);   -- Placeholder

-- Tournament 6: Best Coffee Shop - UPCOMING (4 entries = 2 rounds: 2+1 = 3 matchups)
INSERT INTO matchup (round_number, status, opens_at, closes_at, tournament_id, entryA_id, entryB_id) VALUES
(1, 'Upcoming', '2024-12-01 10:00:00', '2024-12-07 23:59:59', 6, 57, 58),  -- Daily Grind vs Brew Haven
(1, 'Upcoming', '2024-12-01 10:00:00', '2024-12-07 23:59:59', 6, 59, 60),  -- Java Junction vs Cafe Momentum
(2, 'Upcoming', '2024-12-09 10:00:00', '2024-12-15 23:59:59', 6, 57, 59);  -- Placeholder finals

-- Tournament 7: Cutest Dog Breed - UPCOMING (8 entries = 7 matchups)
INSERT INTO matchup (round_number, status, opens_at, closes_at, tournament_id, entryA_id, entryB_id) VALUES
(1, 'Upcoming', '2024-12-15 10:00:00', '2024-12-20 23:59:59', 7, 61, 62),  -- Golden Retriever vs Corgi
(1, 'Upcoming', '2024-12-15 10:00:00', '2024-12-20 23:59:59', 7, 67, 68),  -- Samoyed vs Beagle
(1, 'Upcoming', '2024-12-15 10:00:00', '2024-12-20 23:59:59', 7, 63, 64),  -- Husky vs Pomeranian
(1, 'Upcoming', '2024-12-15 10:00:00', '2024-12-20 23:59:59', 7, 65, 66),  -- Shiba vs Frenchie
(2, 'Upcoming', '2024-12-22 10:00:00', '2024-12-27 23:59:59', 7, 61, 67),  -- Placeholder
(2, 'Upcoming', '2024-12-22 10:00:00', '2024-12-27 23:59:59', 7, 63, 65),  -- Placeholder
(3, 'Upcoming', '2024-12-29 10:00:00', '2025-01-03 23:59:59', 7, 61, 63);  -- Placeholder finals

-- Tournament 8: Best Sci-Fi Novel - UPCOMING (8 entries = 7 matchups)
INSERT INTO matchup (round_number, status, opens_at, closes_at, tournament_id, entryA_id, entryB_id) VALUES
(1, 'Upcoming', '2025-01-05 10:00:00', '2025-01-10 23:59:59', 8, 69, 70),  -- Dune vs Enders Game
(1, 'Upcoming', '2025-01-05 10:00:00', '2025-01-10 23:59:59', 8, 75, 76),  -- Snow Crash vs Hitchhikers
(1, 'Upcoming', '2025-01-05 10:00:00', '2025-01-10 23:59:59', 8, 71, 72),  -- Neuromancer vs Left Hand
(1, 'Upcoming', '2025-01-05 10:00:00', '2025-01-10 23:59:59', 8, 73, 74),  -- Foundation vs Hyperion
(2, 'Upcoming', '2025-01-12 10:00:00', '2025-01-17 23:59:59', 8, 69, 75),  -- Placeholder
(2, 'Upcoming', '2025-01-12 10:00:00', '2025-01-17 23:59:59', 8, 71, 73),  -- Placeholder
(3, 'Upcoming', '2025-01-19 10:00:00', '2025-01-24 23:59:59', 8, 69, 71);  -- Placeholder finals


--------------------------------------------------------------------------------------
-- VOTE  3 FK
--------------------------------------------------------------------------------------

-- Insert Votes (references users, matchup, and entry tables)
-- Remember: users can only vote once per matchup (primary key constraint)
-- They vote for one of the two entries in that matchup

-- Tournament 1: Best Pizza Toppings - COMPLETED
-- Round 1 matchups (multiple users voting)
INSERT INTO vote (user_id, matchup_id, entry_id, cast_at) VALUES
-- Matchup 1: Pepperoni vs Mushrooms (matchup_id 1)
(3, 1, 1, '2024-01-15 14:23:11'),   -- Marcus votes Pepperoni
(4, 1, 1, '2024-01-16 09:45:33'),   -- Emily votes Pepperoni
(5, 1, 2, '2024-01-17 11:20:45'),   -- James votes Mushrooms
(6, 1, 1, '2024-01-18 16:33:22'),   -- Priya votes Pepperoni
(7, 1, 1, '2024-01-19 10:11:09'),   -- David votes Pepperoni
(8, 1, 2, '2024-01-20 08:55:44'),   -- Jessica votes Mushrooms

-- Matchup 2: Extra Cheese vs Bacon (matchup_id 2)
(3, 2, 7, '2024-01-15 14:25:33'),   -- Marcus votes Extra Cheese
(4, 2, 7, '2024-01-16 10:12:18'),   -- Emily votes Extra Cheese
(5, 2, 8, '2024-01-17 13:44:55'),   -- James votes Bacon
(9, 2, 7, '2024-01-18 15:22:10'),   -- Michael votes Extra Cheese
(10, 2, 7, '2024-01-19 09:30:45'),  -- Amanda votes Extra Cheese

-- Matchup 3: Sausage vs Green Peppers (matchup_id 3)
(11, 3, 3, '2024-01-15 16:40:22'),  -- Ryan votes Sausage
(12, 3, 3, '2024-01-17 12:15:30'),  -- Sophia votes Sausage
(13, 3, 3, '2024-01-18 14:50:11'),  -- Daniel votes Sausage
(14, 3, 4, '2024-01-19 11:25:44'),  -- Olivia votes Green Peppers

-- Matchup 4: Onions vs Black Olives (matchup_id 4)
(3, 4, 5, '2024-01-16 10:30:15'),   -- Marcus votes Onions
(15, 4, 5, '2024-01-17 09:22:40'),  -- Ethan votes Onions
(16, 4, 6, '2024-01-18 13:11:28'),  -- Isabella votes Black Olives
(17, 4, 5, '2024-01-19 15:44:50'),  -- Noah votes Onions

-- Round 2 matchups
-- Matchup 5: Pepperoni vs Extra Cheese (matchup_id 5)
(3, 5, 1, '2024-01-22 11:20:30'),   -- Marcus votes Pepperoni
(4, 5, 1, '2024-01-23 14:35:22'),   -- Emily votes Pepperoni
(6, 5, 7, '2024-01-24 10:15:44'),   -- Priya votes Extra Cheese
(7, 5, 1, '2024-01-25 16:50:11'),   -- David votes Pepperoni
(10, 5, 1, '2024-01-26 09:22:33'),  -- Amanda votes Pepperoni

-- Matchup 6: Sausage vs Onions (matchup_id 6)
(11, 6, 3, '2024-01-22 12:40:15'),  -- Ryan votes Sausage
(12, 6, 3, '2024-01-23 15:22:40'),  -- Sophia votes Sausage
(8, 6, 5, '2024-01-24 11:10:28'),   -- Jessica votes Onions
(13, 6, 3, '2024-01-25 13:55:19'),  -- Daniel votes Sausage

-- Round 3 (Finals)
-- Matchup 7: Pepperoni vs Sausage (matchup_id 7)
(3, 7, 1, '2024-01-29 10:15:22'),   -- Marcus votes Pepperoni
(4, 7, 1, '2024-01-30 14:22:11'),   -- Emily votes Pepperoni
(5, 7, 3, '2024-02-01 09:30:45'),   -- James votes Sausage
(6, 7, 1, '2024-02-03 16:11:33'),   -- Priya votes Pepperoni
(7, 7, 1, '2024-02-05 11:44:28'),   -- David votes Pepperoni
(8, 7, 1, '2024-02-08 13:20:15'),   -- Jessica votes Pepperoni
(9, 7, 3, '2024-02-10 10:05:44'),   -- Michael votes Sausage
(10, 7, 1, '2024-02-12 15:33:22'),  -- Amanda votes Pepperoni

-- Tournament 2: Ultimate Marvel Hero - COMPLETED
-- Round 1
-- Matchup 8: Spider-Man vs Iron Man (matchup_id 8)
(3, 8, 9, '2024-03-01 12:20:33'),   -- Marcus votes Spider-Man
(5, 8, 9, '2024-03-02 14:35:11'),   -- James votes Spider-Man
(6, 8, 10, '2024-03-03 10:15:44'),  -- Priya votes Iron Man
(7, 8, 9, '2024-03-04 16:22:28'),   -- David votes Spider-Man
(11, 8, 9, '2024-03-05 11:40:15'),  -- Ryan votes Spider-Man
(15, 8, 10, '2024-03-06 09:18:50'), -- Ethan votes Iron Man

-- Matchup 9: Doctor Strange vs Black Panther (matchup_id 9)
(4, 9, 15, '2024-03-01 13:30:22'),  -- Emily votes Doctor Strange
(8, 9, 16, '2024-03-02 15:11:44'),  -- Jessica votes Black Panther
(12, 9, 15, '2024-03-04 12:25:33'), -- Sophia votes Doctor Strange
(14, 9, 16, '2024-03-05 10:40:18'), -- Olivia votes Black Panther
(16, 9, 15, '2024-03-06 14:55:40'), -- Isabella votes Doctor Strange

-- Matchup 10: Captain America vs Thor (matchup_id 10)
(3, 10, 11, '2024-03-01 14:20:15'), -- Marcus votes Captain America
(9, 10, 12, '2024-03-03 11:35:44'), -- Michael votes Thor
(10, 10, 11, '2024-03-04 13:22:28'),-- Amanda votes Captain America
(13, 10, 11, '2024-03-06 15:10:33'),-- Daniel votes Captain America

-- Matchup 11: Black Widow vs Hulk (matchup_id 11)
(5, 11, 14, '2024-03-02 10:25:40'), -- James votes Hulk
(7, 11, 14, '2024-03-03 14:18:22'), -- David votes Hulk
(17, 11, 13, '2024-03-05 12:33:11'),-- Noah votes Black Widow
(18, 11, 14, '2024-03-07 16:44:55'),-- Guest1 votes Hulk

-- Round 2
-- Matchup 12: Spider-Man vs Doctor Strange (matchup_id 12)
(3, 12, 9, '2024-03-10 11:15:30'),  -- Marcus votes Spider-Man
(4, 12, 15, '2024-03-11 13:22:44'), -- Emily votes Doctor Strange
(6, 12, 9, '2024-03-12 10:40:18'),  -- Priya votes Spider-Man
(8, 12, 9, '2024-03-14 15:25:33'),  -- Jessica votes Spider-Man
(11, 12, 9, '2024-03-15 09:18:40'), -- Ryan votes Spider-Man

-- Matchup 13: Captain America vs Hulk (matchup_id 13)
(5, 13, 11, '2024-03-10 12:30:22'), -- James votes Captain America
(7, 13, 14, '2024-03-11 14:15:44'), -- David votes Hulk
(9, 13, 11, '2024-03-13 11:40:28'), -- Michael votes Captain America
(10, 13, 11, '2024-03-14 16:22:15'),-- Amanda votes Captain America

-- Round 3 (Finals)
-- Matchup 14: Spider-Man vs Captain America (matchup_id 14)
(3, 14, 9, '2024-03-20 10:20:33'),  -- Marcus votes Spider-Man
(4, 14, 11, '2024-03-21 14:35:11'), -- Emily votes Captain America
(5, 14, 11, '2024-03-23 12:15:44'), -- James votes Captain America
(6, 14, 9, '2024-03-25 16:22:28'),  -- Priya votes Spider-Man
(7, 14, 9, '2024-03-27 11:40:15'),  -- David votes Spider-Man
(8, 14, 9, '2024-03-29 09:18:50'),  -- Jessica votes Spider-Man
(11, 14, 9, '2024-03-30 13:30:22'), -- Ryan votes Spider-Man
(12, 14, 11, '2024-03-31 15:11:44'),-- Sophia votes Captain America

-- Tournament 3: Top Programming Languages - COMPLETED
-- Round 1
-- Matchup 15: Python vs JavaScript (matchup_id 15)
(3, 15, 17, '2024-10-01 11:25:40'), -- Marcus votes Python
(4, 15, 17, '2024-10-02 14:18:22'), -- Emily votes Python
(5, 15, 18, '2024-10-03 10:33:11'), -- James votes JavaScript
(6, 15, 17, '2024-10-05 16:44:55'), -- Priya votes Python
(7, 15, 17, '2024-10-07 12:20:33'), -- David votes Python
(8, 15, 18, '2024-10-08 09:35:11'), -- Jessica votes JavaScript

-- Matchup 16: TypeScript vs C# (matchup_id 16)
(9, 16, 23, '2024-10-01 13:15:44'), -- Michael votes TypeScript
(10, 16, 24, '2024-10-03 15:22:28'),-- Amanda votes C#
(11, 16, 23, '2024-10-05 11:40:15'),-- Ryan votes TypeScript
(13, 16, 23, '2024-10-07 14:18:50'),-- Daniel votes TypeScript

-- Matchup 17: Java vs C++ (matchup_id 17)
(3, 17, 19, '2024-10-02 10:30:22'), -- Marcus votes Java
(12, 17, 20, '2024-10-04 13:11:44'),-- Sophia votes C++
(14, 17, 19, '2024-10-06 12:25:33'),-- Olivia votes Java
(15, 17, 20, '2024-10-08 10:40:18'),-- Ethan votes C++

-- Matchup 18: Go vs Rust (matchup_id 18)
(5, 18, 22, '2024-10-01 14:25:40'), -- James votes Rust
(7, 18, 22, '2024-10-03 16:18:22'), -- David votes Rust
(16, 18, 21, '2024-10-05 11:33:11'),-- Isabella votes Go
(17, 18, 22, '2024-10-07 13:44:55'),-- Noah votes Rust

-- Round 2
-- Matchup 19: Python vs TypeScript (matchup_id 19)
(3, 19, 17, '2024-10-15 11:20:30'), -- Marcus votes Python
(4, 19, 17, '2024-10-17 14:35:22'), -- Emily votes Python
(6, 19, 17, '2024-10-19 10:15:44'), -- Priya votes Python
(9, 19, 23, '2024-10-21 16:50:11'), -- Michael votes TypeScript
(11, 19, 17, '2024-10-23 09:22:33'),-- Ryan votes Python

-- Matchup 20: Java vs Rust (matchup_id 20)
(5, 20, 22, '2024-10-15 12:40:15'), -- James votes Rust
(7, 20, 22, '2024-10-17 15:22:40'), -- David votes Rust
(12, 20, 19, '2024-10-19 11:10:28'),-- Sophia votes Java
(14, 20, 22, '2024-10-21 13:55:19'),-- Olivia votes Rust

-- Round 3 (Finals)
-- Matchup 21: Python vs Rust (matchup_id 21)
(3, 21, 17, '2024-10-28 10:15:22'), -- Marcus votes Python
(4, 21, 17, '2024-10-29 14:22:11'), -- Emily votes Python
(5, 21, 22, '2024-10-31 09:30:45'), -- James votes Rust
(6, 21, 17, '2024-11-02 16:11:33'), -- Priya votes Python
(7, 21, 22, '2024-11-05 11:44:28'), -- David votes Rust
(8, 21, 17, '2024-11-08 13:20:15'), -- Jessica votes Python
(9, 21, 17, '2024-11-10 10:05:44'), -- Michael votes Python
(11, 21, 22, '2024-11-12 15:33:22'),-- Ryan votes Rust

-- Tournament 4: Best 90s Movie - ACTIVE
-- Round 1 (all completed)
-- Matchup 22: Matrix vs Pulp Fiction (matchup_id 22)
(3, 22, 25, '2024-11-01 11:30:15'), -- Marcus votes Matrix
(5, 22, 25, '2024-11-02 14:20:44'), -- James votes Matrix
(8, 22, 26, '2024-11-03 10:45:22'), -- Jessica votes Pulp Fiction
(12, 22, 25, '2024-11-04 16:15:33'),-- Sophia votes Matrix
(15, 22, 25, '2024-11-05 09:40:11'),-- Ethan votes Matrix

-- Matchup 23: Jurassic Park vs Shawshank (matchup_id 23)
(4, 23, 28, '2024-11-01 12:15:30'), -- Emily votes Shawshank
(6, 23, 28, '2024-11-02 15:22:44'), -- Priya votes Shawshank
(7, 23, 28, '2024-11-03 11:40:18'), -- David votes Shawshank
(10, 23, 27, '2024-11-04 13:25:33'),-- Amanda votes Jurassic Park
(14, 23, 28, '2024-11-05 10:18:50'),-- Olivia votes Shawshank

-- Matchup 24: Forrest Gump vs Titanic (matchup_id 24)
(3, 24, 29, '2024-11-01 13:25:40'), -- Marcus votes Forrest Gump
(9, 24, 29, '2024-11-02 16:18:22'), -- Michael votes Forrest Gump
(11, 24, 30, '2024-11-03 12:33:11'),-- Ryan votes Titanic
(16, 24, 29, '2024-11-04 14:44:55'),-- Isabella votes Forrest Gump

-- Matchup 25: Fight Club vs Sixth Sense (matchup_id 25)
(5, 25, 31, '2024-11-01 14:20:30'), -- James votes Fight Club
(13, 25, 31, '2024-11-02 11:35:22'),-- Daniel votes Fight Club
(17, 25, 32, '2024-11-03 15:15:44'),-- Noah votes Sixth Sense
(18, 25, 31, '2024-11-04 09:50:11'),-- Guest1 votes Fight Club

-- Matchup 26: Goodfellas vs Saving Private Ryan (matchup_id 26)
(4, 26, 33, '2024-11-01 15:40:15'), -- Emily votes Goodfellas
(7, 26, 33, '2024-11-02 12:22:40'), -- David votes Goodfellas
(8, 26, 34, '2024-11-03 16:10:28'), -- Jessica votes Saving Private Ryan
(12, 26, 33, '2024-11-04 10:55:19'),-- Sophia votes Goodfellas

-- Matchup 27: Big Lebowski vs Fargo (matchup_id 27)
(3, 27, 35, '2024-11-01 16:25:22'), -- Marcus votes Big Lebowski
(6, 27, 36, '2024-11-02 13:22:11'), -- Priya votes Fargo
(10, 27, 35, '2024-11-03 09:30:45'),-- Amanda votes Big Lebowski
(15, 27, 35, '2024-11-04 14:11:33'),-- Ethan votes Big Lebowski

-- Matchup 28: American Beauty vs Truman Show (matchup_id 28)
(5, 28, 38, '2024-11-01 17:15:30'), -- James votes Truman Show
(9, 28, 38, '2024-11-02 14:22:44'), -- Michael votes Truman Show
(11, 28, 37, '2024-11-03 10:40:18'),-- Ryan votes American Beauty
(14, 28, 38, '2024-11-04 15:25:33'),-- Olivia votes Truman Show

-- Matchup 29: Toy Story vs Lion King (matchup_id 29)
(4, 29, 39, '2024-11-01 18:20:15'), -- Emily votes Toy Story
(7, 29, 39, '2024-11-02 15:35:40'), -- David votes Toy Story
(13, 29, 40, '2024-11-03 11:22:28'),-- Daniel votes Lion King
(16, 29, 39, '2024-11-04 16:40:11'),-- Isabella votes Toy Story

-- Round 2 (completed)
-- Matchup 30: Matrix vs Shawshank (matchup_id 30)
(3, 30, 25, '2024-11-07 11:20:33'), -- Marcus votes Matrix
(4, 30, 28, '2024-11-08 14:35:11'), -- Emily votes Shawshank
(5, 30, 28, '2024-11-09 12:15:44'), -- James votes Shawshank
(6, 30, 25, '2024-11-10 16:22:28'), -- Priya votes Matrix
(8, 30, 25, '2024-11-11 11:40:15'), -- Jessica votes Matrix
(11, 30, 28, '2024-11-12 09:18:50'),-- Ryan votes Shawshank

-- Matchup 31: Forrest Gump vs Fight Club (matchup_id 31)
(7, 31, 29, '2024-11-07 12:30:22'), -- David votes Forrest Gump
(9, 31, 29, '2024-11-08 15:11:44'), -- Michael votes Forrest Gump
(10, 31, 31, '2024-11-09 13:25:33'),-- Amanda votes Fight Club
(12, 31, 29, '2024-11-10 10:40:18'),-- Sophia votes Forrest Gump
(15, 31, 29, '2024-11-11 14:55:40'),-- Ethan votes Forrest Gump

-- Matchup 32: Goodfellas vs Big Lebowski (matchup_id 32)
(3, 32, 33, '2024-11-07 13:40:15'), -- Marcus votes Goodfellas
(4, 32, 33, '2024-11-08 16:22:40'), -- Emily votes Goodfellas
(13, 32, 35, '2024-11-09 14:10:28'),-- Daniel votes Big Lebowski
(14, 32, 33, '2024-11-10 11:55:19'),-- Olivia votes Goodfellas

-- Matchup 33: Toy Story vs Truman Show (matchup_id 33)
(5, 33, 39, '2024-11-07 14:25:22'), -- James votes Toy Story
(6, 33, 39, '2024-11-08 17:22:11'), -- Priya votes Toy Story
(16, 33, 38, '2024-11-09 15:30:45'),-- Isabella votes Truman Show
(17, 33, 39, '2024-11-10 12:11:33'),-- Noah votes Toy Story

-- Round 3 (ACTIVE - semifinals happening now!)
-- Matchup 34: Matrix vs Forrest Gump (matchup_id 34)
(3, 34, 25, '2024-11-14 10:30:15'), -- Marcus votes Matrix
(4, 34, 29, '2024-11-15 14:20:44'), -- Emily votes Forrest Gump
(5, 34, 29, '2024-11-16 11:45:22'), -- James votes Forrest Gump
(7, 34, 25, '2024-11-17 16:15:33'), -- David votes Matrix
(8, 34, 25, '2024-11-18 09:40:11'), -- Jessica votes Matrix
(10, 34, 29, '2024-11-19 13:25:30'),-- Amanda votes Forrest Gump
-- More votes coming in real-time...

-- Matchup 35: Goodfellas vs Toy Story (matchup_id 35)
(6, 35, 33, '2024-11-14 11:15:30'), -- Priya votes Goodfellas
(9, 35, 39, '2024-11-15 15:22:44'), -- Michael votes Toy Story
(11, 35, 33, '2024-11-16 12:40:18'),-- Ryan votes Goodfellas
(12, 35, 39, '2024-11-17 10:25:33'),-- Sophia votes Toy Story
(14, 35, 39, '2024-11-18 14:18:50'),-- Olivia votes Toy Story
-- More votes coming in...

-- Tournament 5: Greatest Video Game - ACTIVE
-- Round 1 (completed)
-- Matchup 37: Zelda OoT vs Mario 64 (matchup_id 37)
(3, 37, 41, '2024-11-10 11:30:15'), -- Marcus votes Zelda
(5, 37, 41, '2024-11-11 14:20:44'), -- James votes Zelda
(7, 37, 42, '2024-11-12 10:45:22'), -- David votes Mario 64
(11, 37, 41, '2024-11-13 16:15:33'),-- Ryan votes Zelda
(15, 37, 41, '2024-11-14 09:40:11'),-- Ethan votes Zelda

-- Matchup 38: Half-Life 2 vs Last of Us (matchup_id 38)
(4, 38, 44, '2024-11-10 12:15:30'), -- Emily votes Last of Us
(6, 38, 44, '2024-11-11 15:22:44'), -- Priya votes Last of Us
(8, 38, 43, '2024-11-12 11:40:18'), -- Jessica votes Half-Life 2
(9, 38, 44, '2024-11-13 13:25:33'), -- Michael votes Last of Us
(12, 38, 44, '2024-11-14 10:18:50'),-- Sophia votes Last of Us

-- Matchup 39: RDR2 vs Minecraft (matchup_id 39)
(3, 39, 45, '2024-11-10 13:25:40'), -- Marcus votes RDR2
(10, 39, 45, '2024-11-11 16:18:22'), -- Amanda votes RDR2
(13, 39, 46, '2024-11-12 12:33:11'),-- Daniel votes Minecraft
(16, 39, 45, '2024-11-13 14:44:55'),-- Isabella votes RDR2

-- Matchup 40: Dark Souls vs Portal 2 (matchup_id 40)
(5, 40, 48, '2024-11-10 14:20:30'), -- James votes Portal 2
(7, 40, 47, '2024-11-11 11:35:22'), -- David votes Dark Souls
(14, 40, 48, '2024-11-12 15:15:44'),-- Olivia votes Portal 2
(17, 40, 48, '2024-11-13 09:50:11'),-- Noah votes Portal 2

-- Matchup 41: Witcher 3 vs God of War (matchup_id 41)
(4, 41, 49, '2024-11-10 15:40:15'), -- Emily votes Witcher 3
(6, 41, 49, '2024-11-11 12:22:40'), -- Priya votes Witcher 3
(11, 41, 50, '2024-11-12 16:10:28'),-- Ryan votes God of War
(15, 41, 49, '2024-11-13 10:55:19'),-- Ethan votes Witcher 3

-- Matchup 42: Elden Ring vs Hades (matchup_id 42)
(3, 42, 51, '2024-11-10 16:25:22'), -- Marcus votes Elden Ring
(8, 42, 52, '2024-11-11 13:22:11'), -- Jessica votes Hades
(9, 42, 51, '2024-11-12 09:30:45'), -- Michael votes Elden Ring
(12, 42, 51, '2024-11-13 14:11:33'),-- Sophia votes Elden Ring

-- Matchup 43: Baldurs Gate 3 vs Hollow Knight (matchup_id 43)
(5, 43, 53, '2024-11-10 17:15:30'), -- James votes Baldurs Gate 3
(7, 43, 53, '2024-11-11 14:22:44'), -- David votes Baldurs Gate 3
(10, 43, 54, '2024-11-12 10:40:18'),-- Amanda votes Hollow Knight
(13, 43, 53, '2024-11-13 15:25:33'),-- Daniel votes Baldurs Gate 3

-- Matchup 44: Celeste vs Stardew Valley (matchup_id 44)
(4, 44, 56, '2024-11-10 18:20:15'), -- Emily votes Stardew Valley
(6, 44, 56, '2024-11-11 15:35:40'), -- Priya votes Stardew Valley
(14, 44, 55, '2024-11-12 11:22:28'),-- Olivia votes Celeste
(16, 44, 56, '2024-11-13 16:40:11'),-- Isabella votes Stardew Valley

-- Round 2 (ACTIVE NOW!)
-- Matchup 45: Zelda vs Last of Us (matchup_id 45)
(3, 45, 41, '2024-11-16 10:30:15'), -- Marcus votes Zelda
(4, 45, 44, '2024-11-17 14:20:44'), -- Emily votes Last of Us
(5, 45, 44, '2024-11-18 11:45:22'), -- James votes Last of Us
(8, 45, 41, '2024-11-19 16:15:33'), -- Jessica votes Zelda
-- Voting in progress...

-- Matchup 46: RDR2 vs Portal 2 (matchup_id 46)
(6, 46, 45, '2024-11-16 11:15:30'), -- Priya votes RDR2
(7, 46, 48, '2024-11-17 15:22:44'), -- David votes Portal 2
(10, 46, 45, '2024-11-18 12:40:18'),-- Amanda votes RDR2
(11, 46, 45, '2024-11-19 10:25:33'),-- Ryan votes RDR2
-- Voting in progress...

-- Matchup 47: Witcher vs Elden Ring (matchup_id 47)
(9, 47, 51, '2024-11-16 12:20:15'), -- Michael votes Elden Ring
(12, 47, 49, '2024-11-17 16:35:40'),-- Sophia votes Witcher 3
(13, 47, 51, '2024-11-18 13:22:28'),-- Daniel votes Elden Ring
(15, 47, 51, '2024-11-19 11:40:11'),-- Ethan votes Elden Ring
-- Voting in progress...

-- Matchup 48: Baldurs Gate vs Stardew (matchup_id 48)
(14, 48, 53, '2024-11-16 13:25:22'),-- Olivia votes Baldurs Gate 3
(16, 48, 56, '2024-11-17 17:22:11'),-- Isabella votes Stardew Valley
(17, 48, 53, '2024-11-18 14:30:45'),-- Noah votes Baldurs Gate 3
(18, 48, 56, '2024-11-19 12:11:33'),-- Guest1 votes Stardew Valley
-- Voting in progress...

-- Some guest users voting on various active tournaments
-- Guest users participating in Tournament 4 (Active)
(19, 34, 25, '2024-11-18 15:22:10'), -- Guest2 votes Matrix
(20, 35, 39, '2024-11-19 16:33:25'), -- Guest3 votes Toy Story

-- Guest users participating in Tournament 5 (Active)
(19, 45, 41, '2024-11-18 17:15:40'), -- Guest2 votes Zelda
(20, 46, 48, '2024-11-19 18:20:55'); -- Guest3 votes Portal 2
