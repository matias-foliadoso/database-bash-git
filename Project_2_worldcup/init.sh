
PSQL="psql -X --username=freecodecamp --dbname=worldcup --no-align --tuples-only -c"

RESULT=$($PSQL "
  DROP TABLE IF EXISTS teams CASCADE;
  DROP TABLE IF EXISTS games CASCADE;

  CREATE TABLE teams(
      team_id SERIAL NOT NULL,
      PRIMARY KEY (team_id),
      name VARCHAR(100) UNIQUE NOT NULL
  );

  CREATE TABLE games(
      game_id SERIAL NOT NULL,
      PRIMARY KEY (game_id),
      year INT NOT NULL,
      round VARCHAR(100) NOT NULL,
      winner_id INT NOT NULL,
      FOREIGN KEY (winner_id) REFERENCES teams(team_id),
      opponent_id INT NOT NULL,
      FOREIGN KEY (opponent_id) REFERENCES teams(team_id),
      winner_goals INT NOT NULL,
      opponent_goals INT NOT NULL
  );
")

echo $RESULT