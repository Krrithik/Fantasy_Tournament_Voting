-- tables.sql
select "Creating the Fantasy Tourney DB tables. ";

select "Creating tables with no foreign keys first: User";

drop table if exists vote;
drop table if exists matchup;
drop table if exists entry;
drop table if exists tournament;
drop table if exists users;

-- create User table
create table users (
    user_id int primary key auto_increment,
    email varchar(255) unique not null check(email <> ''),
    role ENUM('admin', 'player', 'guest') not null,
    displayname varchar(100) not null check(displayname <> ''),
    password varchar(255) not null check(password <> '')
);

-- create Tournament table
create table tournament (
    tournament_id int primary key auto_increment,
    title varchar (255) unique not null check(title <> ''),
    description varchar(255) not null check(description <> ''),
    start_at date not null,
    end_at date default null,
    tourneystatus ENUM('Upcoming', 'Active', 'Completed') not null,
    user_id int not null,
    foreign key (user_id) references users(user_id)
);

-- create Entry table
create table entry (
    entry_id int primary key auto_increment,
    name varchar(100) not null check(name <> ''),
    description varchar(255) default null,
    image_URL  varchar(255) default null,
    seed int default null,
    tournament_id int not null,
    foreign key (tournament_id) references tournament(tournament_id)
);

-- create MatchUp table
create table matchup (
    matchup_id int primary key auto_increment,
    round_number int not null,
    status enum('Upcoming', 'Active', 'Completed') not null,
    opens_at datetime not null,
    closes_at datetime not null,
    tournament_id int not null,
    entryA_id int not null, 
    entryB_id int not null, 
    winner_entry_id int null, 
    foreign key (tournament_id) references tournament(tournament_id),
    foreign key (entryA_id) references entry(entry_id),
    foreign key (entryB_id) references entry(entry_id),
    check (entryA_id <> entryB_id)
);

-- create Vote table;
create table vote (
    user_id int not null,
    matchup_id int not null,
    entry_id int not null,
    cast_at datetime default current_timestamp, 
    primary key (user_id, matchup_id),
    foreign key (user_id) references users(user_id),
    foreign key (matchup_id) references matchup(matchup_id),
    foreign key (entry_id) references entry(entry_id)
);
