
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



How to run

This directory can be initiated with Vagrant by executing the command

vagrant up

within the vagrant/ directory. The test cases can be run by executing the following 
commands:
vagrant ssh

cd /vagrant/tournament

Start PosgreSQL, and create a database called 'tournament'

Note that the test suite wipes and adds records to the database, so in the off chance 
that you are using this in a production environment, do not execute it!

Run the following command in the project directory: python tournament_test.py
