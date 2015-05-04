
Tournament Planner in fulfillment of Udacity's Full-Stack Web Developer Nanodegree

About

This project provides a Python module that uses a PostgreSQL database to keep track
of players and matches in a game tournament, using the Swiss pairing system.


Files

tournament.py -- implementation of a Swiss-system tournament
tournament.sql -- table definitions for the tournament project.
tournament_test.py -- Test cases for tournament.py

Requirement:
PosgreSQL 9.3.5
Python 2.7.6
psycopg2



How to get in to the working directory

1. In the Command prompt change the working directory to /fullstack/vagrant
2. Next command vagrant up 
3. Then vagrant ssh
4. Now change the working directory to cd /vagrant/tournament

Creating Database

Create a Database in the name 'tournament'

1.Type command psql tournament to get in to the Database

2.Now run the command \i tournament.sql to create tables
3.Exit the Database using ctrl+d


How to Run the program

Type the command python tournament_test.py




