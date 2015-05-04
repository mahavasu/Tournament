#!/usr/bin/env python
# 
# tournament.py -- implementation of a Swiss-system tournament
#

import psycopg2


def connect():
    """Connect to the PostgreSQL database.  Returns a database connection."""
    return psycopg2.connect("dbname=tournament")

def executeQuery(query):
    connection = connect()
    cursor = connection.cursor()
    cursor.execute(query)
    connection.commit()
    connection.close()
    	
    
	
def deleteMatches():
    """Removes all the match records from the database."""	    
    
    executeQuery("DELETE FROM matches")
   

def deletePlayers():
    """Removes all the player records from the database."""
    
    
    """Removing all the player records from the database."""
    executeQuery("DELETE FROM players")
   

def countPlayers():
    """Returns the number of players currently registered."""


    """Counting the number of players currently registered."""
    connection = connect()
    cursor = connection.cursor()
   
    cursor.execute("SELECT count(*) FROM players")
    player_count = cursor.fetchone()[0]

    connection.commit()
    connection.close()
    
   
    return player_count	

def registerPlayer(name):
    """Adds a player to the tournament database.
  
    The database assigns a unique serial id number for the player.  (This
    should be handled by your SQL database schema, not in your Python code.)
  
    Args:
      name: the player's full name (need not be unique).
    """
    # Connecting to the database tournament
    connection = connect()
    cursor = connection.cursor()

    # inserts a record in the player table
    cursor.execute("insert into players (Player_name) values (%s)",(name,))
    
    connection.commit()
    connection.close()

def playerStandings():
    """Returns a list of the players and their win records, sorted by wins.

    The first entry in the list should be the player in first place, or a player
    tied for first place if there is currently a tie.

    Returns:
      A list of tuples, each of which contains (id, name, wins, matches):
        id: the player's unique id (assigned by the database)
        name: the player's full name (as registered)
        wins: the number of matches the player has won
        matches: the number of matches the player has played
    """
    values = []

    connection = connect()
    cursor = connection.cursor()
   
  

    # Gets details from the View standing   which has the information about the players and their matches record
    cursor.execute("SELECT Player_id, Player_name, matches_won, matches_played FROM standings order by matches_won desc");
    
    values = cursor.fetchall()
    connection.commit()
    connection.close()
    
    
    return values	

def reportMatch(player1,player2,winner):
    """Records the outcome of a single match between two players.

    Args:
      winner:  the id number of the player who won
      loser:  the id number of the player who lost
    """
    # Connecting to the database tournament
    connection = connect()
    cursor = connection.cursor()

    # inserting record in to the matches table
    cursor.execute("insert into matches (Player1_id,Player2_id,Result) VALUES (%s,%s,%s)",(player1,player2,winner))
    
    connection.commit()
    connection.close()
 
def swissPairings():
    """Returns a list of pairs of players for the next round of a match.
  
    Assuming that there are an even number of players registered, each player
    appears exactly once in the pairings.  Each player is paired with another
    player with an equal or nearly-equal win record, that is, a player adjacent
    to him or her in the standings.
  
    Returns:
      A list of tuples, each of which contains (id1, name1, id2, name2)
        id1: the first player's unique id
        name1: the first player's name
        id2: the second player's unique id
        name2: the second player's name
    """
    # Connecting to the database tournament
    connection = connect()
    cursor = connection.cursor()

    cursor.execute("SELECT Player_id, Player_name, matches_won FROM standings")
    players = cursor.fetchall()
    
    connection.close()

    pairings = []
    noofplayers = len(players)
    # Here getting all the players pairing 
    for i in range(0,noofplayers-1 ,2):
       pairing = (players[i][0], players[i][1], players[i+1][0],players[i+1][1])
       pairings.append(pairing)
    
    return pairings
