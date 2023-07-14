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

-- INSERT DATA FOR vets table
BEGIN;
INSERT INTO vets (name, age, date_of_graduation) VALUES
('William Tatcher', 45, '2000-04-23');

INSERT INTO vets (name, age, date_of_graduation) VALUES
('Maisy Smith', 26, '2019-01-17');


INSERT INTO vets (name, age, date_of_graduation) VALUES
('Stephanie Mendez', 64, '1981-05-04');

INSERT INTO vets (name, age, date_of_graduation) VALUES
('Jack Harkness', 38, '2008-06-08');

COMMIT;

-- INSERT DATA FOR SPECIALIZATION
INSERT INTO specialization (vet_id, species_id)
VALUES 
    (1,1),
    (3,1),
    (3,2),
    (4,2);

-- INSERT DATA FOR VISITS
INSERT INTO visits (animal_id, vet_id, date)
VALUES
    ('1', '1', '2020-5-24'),
    ('1', '3', '2020-7-22'),
    ('2', '4', '2021-2-2'),
    ('3', '2', '2020-1-5'),
    ('3', '2', '2020-3-8'),
    ('3', '2', '2020-5-14'),
    ('4', '3', '2021-5-4'),
    ('5', '4', '2021-2-24'),
    ('6', '2', '2019-12-21'),
    ('6', '1', '2020-8-10'),
    ('6', '2', '2021-4-7'),
    ('7', '3', '2019-9-29'),
    ('8', '4', '2020-10-3'),
    ('8', '4', '2020-11-4'),
    ('9', '2', '2019-1-24'),
    ('9', '2', '2019-5-15'),
    ('9', '2', '2020-2-27'),
    ('9', '2', '2020-8-3'),
    ('10', '3', '2020-5-24'),
    ('10', '1', '2021-1-11');