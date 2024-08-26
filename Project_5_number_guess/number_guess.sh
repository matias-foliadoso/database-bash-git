#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

INIR_RESULT=$($PSQL "

  CREATE TABLE users(
    user_id SERIAL,
    PRIMARY KEY (user_id),
    username VARCHAR(22) UNIQUE NOT NULL
  );

  CREATE TABLE games(
    game_id SERIAL,
    PRIMARY KEY (game_id),
    guesses INT,
    user_id INT,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
  );

")

echo -e "\nEnter your username:"
read USERNAME

USER_ID=$($PSQL "SELECT user_id FROM users WHERE username='$USERNAME'")

if [[ -z $USER_ID ]]
then
  USER_INSERT_RESULT=$($PSQL "INSERT INTO users(username) VALUES ('$USERNAME')")
  USER_ID=$($PSQL "SELECT user_id FROM users WHERE username='$USERNAME'")

  echo -e "Welcome, $USERNAME! It looks like this is your first time here."
else

  GAMES_PLAYED=$($PSQL "SELECT count(game_id) FROM games WHERE user_id=$USER_ID")
  MIN_GUESSES=$($PSQL "SELECT MIN(guesses) FROM games WHERE user_id=$USER_ID")

  echo -e "\nWelcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $MIN_GUESSES guesses."
fi

RANDOM_NUM=$((RANDOM % 1000 + 1))
echo "$RANDOM_NUM"
echo -e "\nGuess the secret number between 1 and 1000:"

GUESS=$((RANDOM_NUM + 1))
NUMBER_OF_GUESS=0

while [[ $GUESS -ne $RANDOM_NUM ]]
do
  read GUESS
  NUMBER_OF_GUESS=$((NUMBER_OF_GUESS + 1))
  if [[ $GUESS =~ ^[0-9]+$ ]]
  then
    if [[ $RANDOM_NUM -lt $GUESS ]]
    then
      echo -e "\nIt's lower than that, guess again:"
    fi
    if [[ $RANDOM_NUM -gt $GUESS ]]
    then
      echo -e "\nIt's higher than that, guess again:"
    fi
  else
    echo -e "\nThat is not an integer, guess again:"
  fi
done

INSERT_GAME_RESULT=$($PSQL "INSERT INTO games(guesses, user_id) VALUES($NUMBER_OF_GUESS, $USER_ID);")
echo -e "You guessed it in $NUMBER_OF_GUESS tries. The secret number was $RANDOM_NUM. Nice job!"