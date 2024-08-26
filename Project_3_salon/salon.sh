#! /bin/bash

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

INIT_RESULT=$($PSQL "
  DROP TABLE IF EXISTS customers CASCADE;
  DROP TABLE IF EXISTS appointments CASCADE;
  DROP TABLE IF EXISTS services CASCADE;

  CREATE TABLE customers(
    customer_id SERIAL,
    PRIMARY KEY (customer_id),
    name VARCHAR(50),
    phone VARCHAR(20) UNIQUE
  );
  CREATE TABLE services(
    service_id SERIAL,
    PRIMARY KEY (service_id),
    name VARCHAR(50)
  );
  CREATE TABLE appointments(
    appointment_id SERIAL,
    PRIMARY KEY (appointment_id),
    time VARCHAR(10),
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    service_id INT,
    FOREIGN KEY(service_id) REFERENCES services(service_id)
  );

  INSERT INTO services(name) VALUES ('cut'), ('color'), ('perm'), ('style'), ('trim');

")


echo -e "\n~~~~~ MY SALON ~~~~~\n"
echo -e "Welcome to My Salon, how can I help you?\n"

MAIN_MENU() {

  SERVICES_RESULT=$($PSQL "SELECT service_id, name FROM services")

  echo "$SERVICES_RESULT" | while read SERVICE_ID BAR SERVICE
  do
    echo -e "$SERVICE_ID) $SERVICE"
  done

  read SERVICE_ID_SELECTED
  SERVICE_ID=$($PSQL "SELECT service_id FROM services WHERE service_id='$SERVICE_ID_SELECTED'")

  if [[ -z $SERVICE_ID ]]
  then
    
    echo -e "\nI could not find that service. What would you like today?"
    MAIN_MENU

  else

      echo -e "\nWhat's your phone number?"
      read CUSTOMER_PHONE

      CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")

      if [[ -z $CUSTOMER_NAME ]]
      then
        
        echo -e "\nI don't have a record for that phone number, what's your name?"
        read CUSTOMER_NAME

        INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(name, phone) VALUES ('$CUSTOMER_NAME', '$CUSTOMER_PHONE')")

      fi

      CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")

      echo -e "\nWhat time would you like your cut,$CUSTOMER_NAME?"
      read SERVICE_TIME

      APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(time, customer_id, service_id) VALUES ('$SERVICE_TIME', '$CUSTOMER_ID', '$SERVICE_ID')")
      
      echo -e "\nI have put you down for a cut at $SERVICE_TIME, $CUSTOMER_NAME."

  fi

}

MAIN_MENU