PSQL="psql -X --username=freecodecamp --dbname=universe --no-align --tuples-only -c"

RES=$($PSQL "

    DROP TABLE IF EXISTS galaxy CASCADE;
    DROP TABLE IF EXISTS moon CASCADE;
    DROP TABLE IF EXISTS planet CASCADE;
    DROP TABLE IF EXISTS planet_type CASCADE;
    DROP TABLE IF EXISTS star CASCADE;

    CREATE TABLE galaxy(
        galaxy_id SERIAL NOT NULL PRIMARY KEY,
        name VARCHAR(100) UNIQUE NOT NULL,
        description TEXT,
        age_in_millions_of_years NUMERIC(5 ,0), 
        distance_from_earth INT
    );

    INSERT INTO galaxy (
        name, description, age_in_millions_of_years, distance_from_earth
    ) VALUES (
        'Milky Way', 'Barred spiral galaxy', 13600, 0
    ), (
        'Whirlpool Galaxy', 'Spiral galaxy', 400, 23
    ), (
        'Sombrero Galaxy', 'Edge-on spiral galaxy', 8000, 29
    ), (
        'Triangulum Galaxy', 'Small spiral galaxy', 15000, 3
    ), (
        'Centaurus A', 'A peculiar galaxy, a result of a collision between a spiral and an elliptical galaxy', 12000, 12
    ), (
        'Pinwheel Galaxy', 'Face-on spiral galaxy ', 12000, 12
    ), (
        'Andromeda Galaxy', 'Spiral galaxy', 10000, 2537
    );

    CREATE TABLE star(
        star_id SERIAL NOT NULL,
        PRIMARY KEY (star_id),
        name VARCHAR(100) UNIQUE NOT NULL,
        description TEXT,
        distance_from_earth INT,
        galaxy_id INT,
        FOREIGN KEY (galaxy_id) REFERENCES galaxy(galaxy_id)
    );

    INSERT INTO star(
        name, description, distance_from_earth, galaxy_id
    ) VALUES (
        'Sun', ' The Sun is the star at the center of our Solar System. It provides the energy that sustains life on Earth.', 93, 1
    ), (
        'Sirius', 'Sirius is the brightest star in the night sky and is part of the Canis Major constellation', 8.6, 1
    ), (
        'Alpha Centauri', 'Alpha Centauri is a triple star system, consisting of Alpha Centauri A, Alpha Centauri B, and Proxima Centauri', 4.37, 1
    ), (
        'Betelgeuse', 'Betelgeuse is a red supergiant star in the Orion constellation', 640, 1
    ), (
        'Vega', 'Vega is the brightest star in the Lyra constellation', 25, 1
    ), (
        'Polaris', 'Polaris, also known as the North Star, is a bright star located very close to the north celestial pole. It serves as a reference point for navigation', 433, 1
    ), (
        'Arcturus', 'Arcturus is the brightest star in the Boötes constellation', 36, 1
    );

    CREATE TABLE planet_type(
        planet_type_id SERIAL NOT NULL,
        PRIMARY KEY (planet_type_id),
        name VARCHAR(100) UNIQUE NOT NULL,
        description TEXT
    );

    INSERT INTO planet_type(
        name, description
    ) VALUES (
        'Terrestrial Planets', 'Terrestrial planets are rocky planets with solid surfaces. They are typically smaller and denser than gas giants'
    ), (
        'Gas Giants', 'Gas giants are massive planets primarily composed of gases, such as hydrogen and helium, with no solid surface'
    ), (
        'Dwarf Planets', 'Dwarf planets are celestial bodies that orbit the Sun and share some characteristics with planets but are smaller and have not cleared their orbits of other debris'
    );

    CREATE TABLE planet(
        planet_id SERIAL NOT NULL,
        PRIMARY KEY (planet_id),
        name VARCHAR(100) UNIQUE NOT NULL,
        description TEXT,
        has_life BOOLEAN DEFAULT FALSE,
        planet_type_id INT,
        FOREIGN KEY (planet_type_id) REFERENCES planet_type(planet_type_id),
        star_id INT,
        FOREIGN KEY (star_id) REFERENCES star(star_id)
    );

    INSERT INTO planet(
        name, description, has_life, planet_type_id, star_id
    ) VALUES (
        'Earth', 'Earth is the only planet known to support life. It has a diverse range of ecosystems, liquid water, and a breathable atmosphere', TRUE, 1, 1
    );

    INSERT INTO planet(
        name, description, planet_type_id, star_id
    ) VALUES (
        'Mercury', 'Mercury is the closest planet to the Sun in our Solar System. It has a barren, rocky surface with extreme temperature variations', 1, 1
    ), (
        'Venus', 'Venus is often called Earths sister planet due to its similar size and composition. It has a thick, toxic atmosphere and is known for its scorching temperatures', 1, 1
    ), (
        'Mars', 'Mars is often referred to as the Red Planet due to its reddish appearance. It has a thin atmosphere and is known for its potential for future human exploration', 1, 1
    ), (
        'Jupiter', 'Jupiter is the largest planet in our Solar System and is a gas giant. It has a strong magnetic field and numerous moons', 2, 1
    ), (
        'Saturn', 'Saturn is famous for its spectacular ring system, which is made up of ice and rock particles. Its also a gas giant and has a prominent set of rings', 2, 1
    ), (
        'Uranus', 'Uranus is a gas giant known for its unique feature: it rotates on its side. It has a bluish appearance due to the presence of methane in its atmosphere', 2, 1
    ), (
        'Neptune', 'Neptune is another gas giant, and its the farthest planet from the Sun. It has a vivid blue color and strong winds in its atmosphere', 2, 1
    ), (
        'Pluto', 'Pluto was once considered the ninth planet but is now classified as a dwarf planet. It is located in the Kuiper Belt and has a diverse surface', 3, 1
    ), (
        'Eris', 'Eris is one of the largest dwarf planets in the Kuiper Belt and played a role in the reclassification of Pluto. Its primarily composed of ice', 3, 1
    ), (
        'Ceres', 'Ceres is the largest object in the asteroid belt between Mars and Jupiter. It is classified as both a dwarf planet and an asteroid', 3, 1
    ), (
        'Haumea', 'Haumea is a dwarf planet located in the Kuiper Belt. It is notable for its elongated shape and rapid rotation', 3, 1
    );

    CREATE TABLE moon(
        moon_id SERIAL NOT NULL,
        PRIMARY KEY (moon_id),
        name VARCHAR(100) UNIQUE NOT NULL,
        description TEXT,
        has_life BOOLEAN DEFAULT FALSE,
        planet_id INT,
        FOREIGN KEY (planet_id) REFERENCES planet(planet_id)
    );

    INSERT INTO moon(
        name, description, planet_id
    ) VALUES (
        'Luna', 'Luna, commonly known as the Moon, is Earths only natural satellite. It has a barren, cratered surface', 1
    ), (
        'Phobos', 'Phobos is one of Mars two small moons, known for its irregular shape and proximity to the planet', 4
    ), (
        'Deimos', 'Deimos is Mars smaller moon and has a heavily cratered surface', 4
    ), (
        'Io', 'Io is one of Jupiters Galilean moons and is known for its intense volcanic activity', 5
    ), (
        'Europa', 'Europa is another of Jupiters Galilean moons and is believed to have a subsurface ocean that could potentially harbor life', 5
    ), (
        'Ganymede', 'Ganymede is the largest moon in the Solar System and is also one of Jupiters Galilean moons', 5
    ), (
        'Callisto', 'Callisto is one of Jupiters Galilean moons and is heavily cratered, making it one of the most heavily cratered bodies in the Solar System', 5
    ), (
        'Titan', 'Titan is Saturns largest moon and is known for its thick, nitrogen-rich atmosphere', 6
    ), (
        'Enceladus', 'Enceladus is a moon of Saturn and is known for its geysers of water ice erupting from its surface', 6
    ), (
        'Miranda', 'Miranda is one of the moons of Uranus and has a highly varied and fractured surface', 7
    ), (
        'Triton', 'Triton is Neptunes largest moon and is notable for its retrograde orbit and geysers erupting from its surface', 8
    ), (
        'Charon', 'Charon is Plutos largest moon and is relatively large in comparison to Pluto itself', 9
    ), (
        'Nereid', 'Nereid is one of Neptunes irregularly shaped and distant moons', 8
    ), (
        'Mimas', 'Mimas is one of Saturns moons and is known for its distinctive Death Star appearance due to a large crater', 9
    ), (
        'Oberon', 'Oberon is one of Uranus moons and is heavily cratered with a mix of old and young surfaces', 7
    ), (
        'Hyperion', 'Hyperion is a moon of Saturn and is known for its irregular shape and sponge-like appearance', 9
    ), (
        'Ariel', 'Ariel is one of Uranus moons and is known for its relatively smooth and cratered surface', 7
    ), (
        'Iapetus', 'Iapetus is a moon of Saturn and is unique for its two-tone appearance with a dark leading side and bright trailing side', 9
    ), (
        'Rhea', 'Rhea is another of Saturns moons and is known for its heavily cratered surface', 9
    ), (
        'Titania', 'Titania is one of Uranus moons and is known for its diverse landscapes and canyons', 7
    );
")

echo $RES