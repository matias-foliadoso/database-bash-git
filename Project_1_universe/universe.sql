--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE universe;
--
-- Name: universe; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE universe WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE universe OWNER TO freecodecamp;

\connect universe

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: galaxy; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy (
    galaxy_id integer NOT NULL,
    name character varying(100) NOT NULL,
    description text,
    age_in_millions_of_years numeric(5,0),
    distance_from_earth integer
);


ALTER TABLE public.galaxy OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.galaxy_galaxy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.galaxy_galaxy_id_seq OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.galaxy_galaxy_id_seq OWNED BY public.galaxy.galaxy_id;


--
-- Name: moon; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.moon (
    moon_id integer NOT NULL,
    name character varying(100) NOT NULL,
    description text,
    has_life boolean DEFAULT false,
    planet_id integer
);


ALTER TABLE public.moon OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.moon_moon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.moon_moon_id_seq OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.moon_moon_id_seq OWNED BY public.moon.moon_id;


--
-- Name: planet; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet (
    planet_id integer NOT NULL,
    name character varying(100) NOT NULL,
    description text,
    has_life boolean DEFAULT false,
    planet_type_id integer,
    star_id integer
);


ALTER TABLE public.planet OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.planet_planet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planet_planet_id_seq OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.planet_planet_id_seq OWNED BY public.planet.planet_id;


--
-- Name: planet_type; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet_type (
    planet_type_id integer NOT NULL,
    name character varying(100) NOT NULL,
    description text
);


ALTER TABLE public.planet_type OWNER TO freecodecamp;

--
-- Name: planet_type_planet_type_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.planet_type_planet_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planet_type_planet_type_id_seq OWNER TO freecodecamp;

--
-- Name: planet_type_planet_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.planet_type_planet_type_id_seq OWNED BY public.planet_type.planet_type_id;


--
-- Name: star; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.star (
    star_id integer NOT NULL,
    name character varying(100) NOT NULL,
    description text,
    distance_from_earth integer,
    galaxy_id integer
);


ALTER TABLE public.star OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.star_star_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.star_star_id_seq OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.star_star_id_seq OWNED BY public.star.star_id;


--
-- Name: galaxy galaxy_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy ALTER COLUMN galaxy_id SET DEFAULT nextval('public.galaxy_galaxy_id_seq'::regclass);


--
-- Name: moon moon_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon ALTER COLUMN moon_id SET DEFAULT nextval('public.moon_moon_id_seq'::regclass);


--
-- Name: planet planet_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet ALTER COLUMN planet_id SET DEFAULT nextval('public.planet_planet_id_seq'::regclass);


--
-- Name: planet_type planet_type_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet_type ALTER COLUMN planet_type_id SET DEFAULT nextval('public.planet_type_planet_type_id_seq'::regclass);


--
-- Name: star star_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star ALTER COLUMN star_id SET DEFAULT nextval('public.star_star_id_seq'::regclass);


--
-- Data for Name: galaxy; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy VALUES (1, 'Milky Way', 'Barred spiral galaxy', 13600, 0);
INSERT INTO public.galaxy VALUES (2, 'Whirlpool Galaxy', 'Spiral galaxy', 400, 23);
INSERT INTO public.galaxy VALUES (3, 'Sombrero Galaxy', 'Edge-on spiral galaxy', 8000, 29);
INSERT INTO public.galaxy VALUES (4, 'Triangulum Galaxy', 'Small spiral galaxy', 15000, 3);
INSERT INTO public.galaxy VALUES (5, 'Centaurus A', 'A peculiar galaxy, a result of a collision between a spiral and an elliptical galaxy', 12000, 12);
INSERT INTO public.galaxy VALUES (6, 'Pinwheel Galaxy', 'Face-on spiral galaxy ', 12000, 12);
INSERT INTO public.galaxy VALUES (7, 'Andromeda Galaxy', 'Spiral galaxy', 10000, 2537);


--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.moon VALUES (1, 'Luna', 'Luna, commonly known as the Moon, is Earths only natural satellite. It has a barren, cratered surface', false, 1);
INSERT INTO public.moon VALUES (2, 'Phobos', 'Phobos is one of Mars two small moons, known for its irregular shape and proximity to the planet', false, 4);
INSERT INTO public.moon VALUES (3, 'Deimos', 'Deimos is Mars smaller moon and has a heavily cratered surface', false, 4);
INSERT INTO public.moon VALUES (4, 'Io', 'Io is one of Jupiters Galilean moons and is known for its intense volcanic activity', false, 5);
INSERT INTO public.moon VALUES (5, 'Europa', 'Europa is another of Jupiters Galilean moons and is believed to have a subsurface ocean that could potentially harbor life', false, 5);
INSERT INTO public.moon VALUES (6, 'Ganymede', 'Ganymede is the largest moon in the Solar System and is also one of Jupiters Galilean moons', false, 5);
INSERT INTO public.moon VALUES (7, 'Callisto', 'Callisto is one of Jupiters Galilean moons and is heavily cratered, making it one of the most heavily cratered bodies in the Solar System', false, 5);
INSERT INTO public.moon VALUES (8, 'Titan', 'Titan is Saturns largest moon and is known for its thick, nitrogen-rich atmosphere', false, 6);
INSERT INTO public.moon VALUES (9, 'Enceladus', 'Enceladus is a moon of Saturn and is known for its geysers of water ice erupting from its surface', false, 6);
INSERT INTO public.moon VALUES (10, 'Miranda', 'Miranda is one of the moons of Uranus and has a highly varied and fractured surface', false, 7);
INSERT INTO public.moon VALUES (11, 'Triton', 'Triton is Neptunes largest moon and is notable for its retrograde orbit and geysers erupting from its surface', false, 8);
INSERT INTO public.moon VALUES (12, 'Charon', 'Charon is Plutos largest moon and is relatively large in comparison to Pluto itself', false, 9);
INSERT INTO public.moon VALUES (13, 'Nereid', 'Nereid is one of Neptunes irregularly shaped and distant moons', false, 8);
INSERT INTO public.moon VALUES (14, 'Mimas', 'Mimas is one of Saturns moons and is known for its distinctive Death Star appearance due to a large crater', false, 9);
INSERT INTO public.moon VALUES (15, 'Oberon', 'Oberon is one of Uranus moons and is heavily cratered with a mix of old and young surfaces', false, 7);
INSERT INTO public.moon VALUES (16, 'Hyperion', 'Hyperion is a moon of Saturn and is known for its irregular shape and sponge-like appearance', false, 9);
INSERT INTO public.moon VALUES (17, 'Ariel', 'Ariel is one of Uranus moons and is known for its relatively smooth and cratered surface', false, 7);
INSERT INTO public.moon VALUES (18, 'Iapetus', 'Iapetus is a moon of Saturn and is unique for its two-tone appearance with a dark leading side and bright trailing side', false, 9);
INSERT INTO public.moon VALUES (19, 'Rhea', 'Rhea is another of Saturns moons and is known for its heavily cratered surface', false, 9);
INSERT INTO public.moon VALUES (20, 'Titania', 'Titania is one of Uranus moons and is known for its diverse landscapes and canyons', false, 7);


--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet VALUES (1, 'Earth', 'Earth is the only planet known to support life. It has a diverse range of ecosystems, liquid water, and a breathable atmosphere', true, 1, 1);
INSERT INTO public.planet VALUES (2, 'Mercury', 'Mercury is the closest planet to the Sun in our Solar System. It has a barren, rocky surface with extreme temperature variations', false, 1, 1);
INSERT INTO public.planet VALUES (3, 'Venus', 'Venus is often called Earths sister planet due to its similar size and composition. It has a thick, toxic atmosphere and is known for its scorching temperatures', false, 1, 1);
INSERT INTO public.planet VALUES (4, 'Mars', 'Mars is often referred to as the Red Planet due to its reddish appearance. It has a thin atmosphere and is known for its potential for future human exploration', false, 1, 1);
INSERT INTO public.planet VALUES (5, 'Jupiter', 'Jupiter is the largest planet in our Solar System and is a gas giant. It has a strong magnetic field and numerous moons', false, 2, 1);
INSERT INTO public.planet VALUES (6, 'Saturn', 'Saturn is famous for its spectacular ring system, which is made up of ice and rock particles. Its also a gas giant and has a prominent set of rings', false, 2, 1);
INSERT INTO public.planet VALUES (7, 'Uranus', 'Uranus is a gas giant known for its unique feature: it rotates on its side. It has a bluish appearance due to the presence of methane in its atmosphere', false, 2, 1);
INSERT INTO public.planet VALUES (8, 'Neptune', 'Neptune is another gas giant, and its the farthest planet from the Sun. It has a vivid blue color and strong winds in its atmosphere', false, 2, 1);
INSERT INTO public.planet VALUES (9, 'Pluto', 'Pluto was once considered the ninth planet but is now classified as a dwarf planet. It is located in the Kuiper Belt and has a diverse surface', false, 3, 1);
INSERT INTO public.planet VALUES (10, 'Eris', 'Eris is one of the largest dwarf planets in the Kuiper Belt and played a role in the reclassification of Pluto. Its primarily composed of ice', false, 3, 1);
INSERT INTO public.planet VALUES (11, 'Ceres', 'Ceres is the largest object in the asteroid belt between Mars and Jupiter. It is classified as both a dwarf planet and an asteroid', false, 3, 1);
INSERT INTO public.planet VALUES (12, 'Haumea', 'Haumea is a dwarf planet located in the Kuiper Belt. It is notable for its elongated shape and rapid rotation', false, 3, 1);


--
-- Data for Name: planet_type; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet_type VALUES (1, 'Terrestrial Planets', 'Terrestrial planets are rocky planets with solid surfaces. They are typically smaller and denser than gas giants');
INSERT INTO public.planet_type VALUES (2, 'Gas Giants', 'Gas giants are massive planets primarily composed of gases, such as hydrogen and helium, with no solid surface');
INSERT INTO public.planet_type VALUES (3, 'Dwarf Planets', 'Dwarf planets are celestial bodies that orbit the Sun and share some characteristics with planets but are smaller and have not cleared their orbits of other debris');


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star VALUES (1, 'Sun', ' The Sun is the star at the center of our Solar System. It provides the energy that sustains life on Earth.', 93, 1);
INSERT INTO public.star VALUES (2, 'Sirius', 'Sirius is the brightest star in the night sky and is part of the Canis Major constellation', 9, 1);
INSERT INTO public.star VALUES (3, 'Alpha Centauri', 'Alpha Centauri is a triple star system, consisting of Alpha Centauri A, Alpha Centauri B, and Proxima Centauri', 4, 1);
INSERT INTO public.star VALUES (4, 'Betelgeuse', 'Betelgeuse is a red supergiant star in the Orion constellation', 640, 1);
INSERT INTO public.star VALUES (5, 'Vega', 'Vega is the brightest star in the Lyra constellation', 25, 1);
INSERT INTO public.star VALUES (6, 'Polaris', 'Polaris, also known as the North Star, is a bright star located very close to the north celestial pole. It serves as a reference point for navigation', 433, 1);
INSERT INTO public.star VALUES (7, 'Arcturus', 'Arcturus is the brightest star in the Boötes constellation', 36, 1);


--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.galaxy_galaxy_id_seq', 7, true);


--
-- Name: moon_moon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.moon_moon_id_seq', 20, true);


--
-- Name: planet_planet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.planet_planet_id_seq', 12, true);


--
-- Name: planet_type_planet_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.planet_type_planet_type_id_seq', 3, true);


--
-- Name: star_star_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.star_star_id_seq', 7, true);


--
-- Name: galaxy galaxy_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_name_key UNIQUE (name);


--
-- Name: galaxy galaxy_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_pkey PRIMARY KEY (galaxy_id);


--
-- Name: moon moon_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_name_key UNIQUE (name);


--
-- Name: moon moon_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_pkey PRIMARY KEY (moon_id);


--
-- Name: planet planet_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_name_key UNIQUE (name);


--
-- Name: planet planet_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_pkey PRIMARY KEY (planet_id);


--
-- Name: planet_type planet_type_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet_type
    ADD CONSTRAINT planet_type_name_key UNIQUE (name);


--
-- Name: planet_type planet_type_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet_type
    ADD CONSTRAINT planet_type_pkey PRIMARY KEY (planet_type_id);


--
-- Name: star star_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_name_key UNIQUE (name);


--
-- Name: star star_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_pkey PRIMARY KEY (star_id);


--
-- Name: moon moon_planet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_planet_id_fkey FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: planet planet_planet_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_planet_type_id_fkey FOREIGN KEY (planet_type_id) REFERENCES public.planet_type(planet_type_id);


--
-- Name: planet planet_star_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_star_id_fkey FOREIGN KEY (star_id) REFERENCES public.star(star_id);


--
-- Name: star star_galaxy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_galaxy_id_fkey FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- PostgreSQL database dump complete
--


