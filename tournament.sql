- Table definitions for the tournament project.


-- Dropping all the table and views after making sure is that one exists 
drop view if exists standings cascade;
drop table if exists matches cascade;
drop table if exists players cascade;




-- creating tables for storing details of the players

create table players(
	player_id serial primary key,
	name text
        );


--creating table to store the details of the match
create table matches(
	match_id serial primary key,
	player1_id integer references players,
	player2_id integer references players,
	winner_id integer references players
        );

--creating a view to store the details of the player and the matches they won and played
create view standings as
	select players.player_id as player_id, players.name,
        (select count(*) from matches where matches.winner_id = players.player_id) as matches_won,
        (select count(*) from matches where players.player_id in (player1_id, player2_id) ) as matches_played
	from players
	group by players.player_id
	order by matches_won DESC;

