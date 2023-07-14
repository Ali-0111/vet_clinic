/* Populate database with sample data. */

INSERT INTO animals
(name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES
('Agumon', '2020-02-03', 0, true, 10.23);

INSERT INTO animals 
(name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES
('Gabumon', '2018-11-15', 2, true, 8);

INSERT INTO animals 
(name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES
('Pikachu', '2021-01-07', 1, false, 15.04);

INSERT INTO animals 
(name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES
('Devimon', '2015-05-12', 5, true, 11);

INSERT INTO animals 
(name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES
('Charmander', '2020-02-08', 0, false, 11);

INSERT INTO animals 
(name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES
('Plantmon', '2021-11-15', 2, false, 5.7);

INSERT INTO animals 
(name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES
('Squirtle', '1993-04-2', 3, false, 12.13);

INSERT INTO animals 
(name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES
('Angemon', '2005-06-12', 1, false, 45 );

INSERT INTO animals 
(name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES
('Boarmon', '2005-06-7', 7, true, 20.4 );

INSERT INTO animals 
(name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES
('Blossom', '1998-10-13', 3, true, 17 );

INSERT INTO animals 
(name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES
('Ditto', '2022-05-14', 4, true, 22 );


-- INSERT VALUE FOR OWNERS TABLE
INSERT INTO owners(full_name, age) VALUES
('Sam Smith', 34);

INSERT INTO owners(full_name, age) VALUES
('Jennifer Orwell', 19);

INSERT INTO owners(full_name, age) VALUES
('BOB', 45);

INSERT INTO owners(full_name, age) VALUES
('Melody Pond', 77);

INSERT INTO owners(full_name, age) VALUES
('Dean Winchester', 14);

INSERT INTO owners(full_name, age) VALUES
('Jodie Whittaker', 38);

-- INSERT VALUES FOR species TABLE
INSERT INTO species(name) VALUES ('Pokemon');
INSERT INTO species(name) VALUES ('Digimon');

--Sam Smith owns Agumon.
BEGIN;
UPDATE animals 
SET owner_id = (SELECT id from owners WHERE full_name = 'Sam Smith')
WHERE name = 'Agumon';
COMMIT;
-- Jennifer Orwell owns Gabumon and Pikachu.
BEGIN;
UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')

WHERE name IN ('Gabumon', 'Pikachu');
COMMIT;

-- Bob owns Devimon and Plantmon.

BEGIN;
UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob')

WHERE name IN ('Devimon', 'Plantmon');
COMMIT;

-- Melody Pond owns Charmander, Squirtle, and Blossom.

BEGIN;
UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond')

WHERE name IN ('Charmander', 'Squirtle', 'Blossom');
COMMIT;

-- Dean Winchester owns Angemon and Boarmon.
BEGIN;
UPDATE animals 
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
WHERE name IN('Angemon', 'Boarmon');
COMMIT;