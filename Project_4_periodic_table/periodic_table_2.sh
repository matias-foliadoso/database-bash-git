#! /bin/bash

if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
else
  PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"
  
  ATOMIC_NUMBER=$($PSQL "
    SELECT atomic_number
    FROM elements 
    WHERE symbol='$1' OR name='$1'
  ")
  
  if [[ $1 =~ [0-9] ]]
  then
    ATOMIC_NUMBER=$($PSQL "
      SELECT atomic_number
      FROM elements 
      WHERE atomic_number='$1'
    ")
  fi

  if [[ -z $ATOMIC_NUMBER ]]
  then
    echo "I could not find that element in the database."
  else
    ELEMENT=$($PSQL "SELECT atomic_number, symbol, name FROM elements WHERE atomic_number='$ATOMIC_NUMBER'")
    PROPERTIES=$($PSQL "SELECT atomic_mass, melting_point_celsius, boiling_point_celsius, type_id FROM properties WHERE atomic_number='$ATOMIC_NUMBER'")

    echo "$ELEMENT" | while IFS='|' read ATOMIC_NUMBER SYMBOL NAME
    do
      echo "$PROPERTIES" | while IFS='|' read ATOMIC_MASS MELTING_POINT_CELSIUS BOILING_POINT_CELSIUS TYPE_ID
      do
        TYPE=$($PSQL "SELECT type FROM types WHERE type_id=$TYPE_ID")

        echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
      done
    done
  fi
fi