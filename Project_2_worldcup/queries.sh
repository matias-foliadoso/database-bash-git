#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=worldcup --no-align --tuples-only -c"

# Do not change code above this line. Use the PSQL variable above to query your database.

echo -e "\nTotal number of goals in all games from winning teams:"
echo "$($PSQL "SELECT SUM(winner_goals) FROM games")"

echo -e "\nTotal number of goals in all games from both teams combined:"
echo "$($PSQL "SELECT SUM(winner_goals + opponent_goals) FROM games")"

echo -e "\nAverage number of goals in all games from the winning teams:"
echo "$($PSQL "SELECT AVG(winner_goals) FROM games;")"

echo -e "\nAverage number of goals in all games from the winning teams rounded to two decimal places:"
echo "$($PSQL "SELECT ROUND(AVG(winner_goals), 2) FROM games;")"

echo -e "\nAverage number of goals in all games from both teams:"
echo "$($PSQL "SELECT AVG(winner_goals + opponent_goals) FROM games")"
#SELECT CAST((winners_goals + opponents_goals)/CAST(total_games as FLOAT) as FLOAT) as TOTAL FROM (SELECT SUM(winner_goals) as winners_goals, SUM(opponent_goals) as opponents_goals, count(game_id) as total_games FROM games) AS sums;

echo -e "\nMost goals scored in a single game by one team:"
echo "$($PSQL "SELECT GREATEST(MAX(winner_goals), MAX(opponent_goals)) as opponent_max FROM games;")"

echo -e "\nNumber of games where the winning team scored more than two goals:"
echo "$($PSQL "SELECT count(winner_goals) FROM games WHERE winner_goals > 2;")"

echo -e "\nWinner of the 2018 tournament team name:"
echo "$($PSQL "SELECT t.name FROM teams t JOIN games g ON t.team_id = g.winner_id WHERE g.year=2018 AND round='Final'")"
#SELECT name FROM teams WHERE team_id IN (SELECT winner_id as winner FROM games WHERE round='Final' and year=2018);

echo -e "\nList of teams who played in the 2014 'Eighth-Final' round:"
echo "$($PSQL "SELECT DISTINCT t.name FROM teams t JOIN games g ON t.team_id = g.winner_id OR t.team_id = g.opponent_id WHERE g.year = 2014 AND g.round = 'Eighth-Final';")"

echo -e "\nList of unique winning team names in the whole data set:"
echo "$($PSQL "SELECT DISTINCT t.name FROM teams t JOIN games g ON t.team_id = g.winner_id ORDER BY t.name;")"
#SELECT DISTINCT name FROM teams WHERE team_id IN (SELECT winner_id FROM games) ORDER BY name ASC;

echo -e "\nYear and team name of all the champions:"
echo "$($PSQL "SELECT DISTINCT g.year, t.name FROM teams t JOIN games g ON t.team_id = g.winner_id WHERE g.round='Final';")"
#SELECT g.year, t.name FROM (SELECT winner_id, year FROM games WHERE round='Final') as g INNER JOIN teams as t ON g.winner_id = t.team_id;

echo -e "\nList of teams that start with 'Co':"
echo "$($PSQL "SELECT name FROM teams WHERE name LIKE 'Co%'")"
