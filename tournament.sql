-- Table definitions for the tournament project.


-- Dropping all the Table and views after making sure is that one exists 
DROP VIEW IF EXISTS standings CASCADE;
DROP TABLE IF EXISTS matches CASCADE;
DROP TABLE IF EXISTS players CASCADE;




-- creating tables for storing details of the players

CREATE TABLE players(
	Player_id serial primary key,
	Player_name text
        );


--creating Table to store the details of the match
CREATE TABLE matches(
	Match_id serial primary key,
	Player1_id integer references players,
	Player2_id integer references players,
	Result integer references players -- included this column to handle tie match
        );

--creating a view to store the details of the player and the matches they won and played
CREATE VIEW standings as
	SELECT players.Player_id as Player_id, Player_name,
        (SELECT COUNT(*) FROM matches WHERE matches.Result = players.player_id) as matches_won,
        (SELECT COUNT(*) FROM matches WHERE players.player_id in (player1_id, player2_id) ) as matches_played
	FROM players
	GROUP BY players.player_id
	ORDER BY matches_won DESC;

