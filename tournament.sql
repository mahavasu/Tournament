-- Table definitions for the tournament project.

--Cleaning the database before starting a new tournament
DROP VIEW IF EXISTS standings CASCADE;
DROP TABLE IF EXISTS matches CASCADE;
DROP TABLE IF EXISTS players CASCADE;

-- Creating tables for storing details of the players

CREATE TABLE players(
    Player_id serial primary key NOT NULL,
    Player_name text NOT NULL
    );

-- Creating Table to store the details of the match
-- Included Result column to handle match results in tie
-- Result column will store T(true) if there is a result, else F(False) in case of tie
CREATE TABLE matches(
    Match_id serial primary key NOT NULL,
    Player1_id integer references players NOT NULL,
    Player2_id integer references players NOT NULL,
    Result boolean DEFAULT 'T'
    );

-- Creating a view to display the details of the player
-- and the matches they won and played
CREATE VIEW standings AS
SELECT players.Player_id as Player_id, Player_name,
(SELECT COUNT(*) FROM matches WHERE matches.Player1_id=players.player_id and matches.Result='T') as matches_won,
(SELECT COUNT(*) FROM matches WHERE players.player_id in (player1_id, player2_id)) as matches_played
FROM players GROUP BY players.player_id ORDER BY matches_won DESC;
