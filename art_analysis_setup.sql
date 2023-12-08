/***************************************************************************
* Analyzing the Influence of Artists, Styles, and Museums on the Art World
****************************************************************************/

-- Check if the database exists
DO $$ 
BEGIN
    IF EXISTS (SELECT 1 FROM pg_database WHERE datname = 'art_analysis') THEN
        -- Drop the database if it exists
        PERFORM pg_terminate_backend(pg_stat_activity.pg_backend_pid)
        FROM pg_stat_activity
        WHERE pg_stat_activity.datname = 'art_analysis';

        DROP DATABASE art_analysis;
    END IF;
END $$;

-- Create the database
CREATE DATABASE art_analysis;

-- Connect to the database
\c art_analysis;

-- Create the Artists table
CREATE TABLE Artists (
    artist_id SERIAL PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    first_name VARCHAR(100),
    middle_names VARCHAR(100),
    last_name VARCHAR(100),
    nationality VARCHAR(100),
    style VARCHAR(100),
    birth INTEGER,
    death INTEGER
);

-- Create the Museums table
CREATE TABLE Museums (
    museum_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    address VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(100),
    postal VARCHAR(20),
    country VARCHAR(100),
    phone VARCHAR(20),
    url VARCHAR(255)
);

-- Create the Artworks table
CREATE TABLE Artworks (
    work_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    artist_id INTEGER REFERENCES Artists(artist_id),
    style VARCHAR(100),
    museum_id INTEGER REFERENCES Museums(museum_id)
);

-- Create the Work Subject table
CREATE TABLE work_subjects (
    work_id INTEGER PRIMARY KEY,
    subject VARCHAR(255)
);


-- Import Artist Data from CSV
\COPY artist FROM 'C:\Users\kfosu\OneDrive\Documents\PARK UNIVERSITY\CIS622 ASSIGNMENT\personal project\unit 2 personal project\artist.csv' WITH CSV HEADER;

-- import Museum Data from CSV
\COPY museum FROM 'C:\Users\kfosu\OneDrive\Documents\PARK UNIVERSITY\CIS622 ASSIGNMENT\personal project\unit 2 personal project\museum.csv' WITH CSV HEADER ENCODING 'UTF8';

-- Import Artwork Data from CSV
\COPY artwork FROM 'C:\Users\kfosu\OneDrive\Documents\PARK UNIVERSITY\CIS622 ASSIGNMENT\personal project\unit 2 personal project\work.csv' WITH CSV HEADER ENCODING 'UTF8';

-- Import Subject Data from CSV
\COPY work_subject FROM 'C:\Users\kfosu\OneDrive\Documents\PARK UNIVERSITY\CIS622 ASSIGNMENT\personal project\unit 2 personal project\subject.csv' WITH CSV HEADER;

-- Query to check the tables
SELECT * FROM Artists;
SELECT * FROM Museums;
SELECT * FROM Artworks;
SELECT * FROM work_subjects;