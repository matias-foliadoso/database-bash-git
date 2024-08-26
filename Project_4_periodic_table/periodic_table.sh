PSQL="psql --username=freecodecamp --dbname=<database_name> -t --no-align -c"

ALTER=$($PSQL "

    ALTER TABLE properties RENAME COLUMN weight TO atomic_mass;

    ALTER TABLE properties RENAME COLUMN melting_point TO melting_point_celsius;
    ALTER TABLE properties RENAME COLUMN boiling_point TO boiling_point_celsius;

    ALTER TABLE properties ALTER COLUMN melting_point_celsius SET NOT NULL;
    ALTER TABLE properties ALTER COLUMN boiling_point_celsius SET NOT NULL;

    ALTER TABLE elements ADD UNIQUE (symbol);
    ALTER TABLE elements ADD UNIQUE (name);

    ALTER TABLE elements ALTER COLUMN symbol SET NOT NULL;
    ALTER TABLE elements ALTER COLUMN name SET NOT NULL;

    ALTER TABLE properties ADD FOREIGN KEY (atomic_number) REFERENCES elements(atomic_number);

    CREATE TABLE types(
        type_id SERIAL,
        PRIMARY KEY (type_id),
        type VARCHAR(50) NOT NULL
    );

    INSERT INTO types(type) SELECT DISTINCT type FROM properties;

    
    ALTER TABLE properties ADD COLUMN type_id INT;
    UPDATE properties SET type_id = types.type_id FROM types WHERE properties.type = types.type;
    ALTER TABLE properties ALTER COLUMN type_id SET NOT NULL;
    ALTER TABLE properties ADD FOREIGN KEY (type_id) REFERENCES types(type_id);

    UPDATE elements SET symbol = INITCAP(symbol);

    UPDATE properties SET atomic_mass = CAST(atomic_mass::Real AS DECIMAL);

    INSERT INTO elements(atomic_number, symbol, name) VALUES (9, 'F', 'Fluorine');
    INSERT INTO properties(atomic_number, type, atomic_mass, melting_point_celsius, boiling_point_celsius, type_id) VALUES (
        9, 'nonmetal', 18.998, -220, -188.1, 3
    );

    INSERT INTO elements(atomic_number, symbol, name) VALUES (10, 'Ne', 'Neon');
    INSERT INTO properties(atomic_number, type, atomic_mass, melting_point_celsius, boiling_point_celsius, type_id) VALUES (
        10, 'nonmetal', 20.18, -248.6, -246.1, 3
    );

    DELETE FROM properties WHERE atomic_number=1000;
    DELETE FROM elements WHERE atomic_number=1000;

    ALTER TABLE properties DROP COLUMN type;

")

echo $ALTER