-- Table definitions for the tournament project.

--Cleaning the database before starting a new tournament
DROP VIEW IF EXISTS standings CASCADE;
DROP TABLE IF EXISTS matches CASCADE;
DROP TABLE IF EXISTS players CASCADE;

-- Creating tables for storing details of the players

CREATE TABLE players(
    player_id serial primary key NOT NULL,
    player_name text NOT NULL
    );

-- Creating Table to store the details of the match
-- Included Result column to handle match results in tie
-- Result column will store T(true) if there is a result, else F(False) in case of tie 
-- Winner will be player1(defualt) in case result is not a tie.
CREATE TABLE matches(
    match_id serial primary key NOT NULL,
    player1_id integer references players NOT NULL,
    player2_id integer references players NOT NULL,
    result boolean DEFAULT 'T'
    );

-- Creating a view to display the details of the player
-- and the matches they won and played
CREATE VIEW standings AS
SELECT players.Player_id as Player_id, Player_name,
(SELECT COUNT(*) FROM matches WHERE matches.player1_id=players.player_id and matches.result='T') as matches_won,
(SELECT COUNT(*) FROM matches WHERE players.player_id in (player1_id, player2_id)) as matches_played
FROM players GROUP BY players.player_id ORDER BY matches_won DESC;
