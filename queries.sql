/*Queries that provide answers to the questions from all projects.*/


select * from animals where name LIKE '%mon';
select * from animals where date_of_birth BETWEEN '2016-1-1' AND '2019-12-31'
select * from animals where neutered = true AND escape_attempts < 3; 
select * from animals where name IN ('Agumon', 'Pikachu');
select name, escape_attempts from animals where weight_kg > 10.5;
select * from animals where neutered = true; 
select * from animals where name !=  'Gabumon'; 
select * from animals where weight_kg BETWEEN 10.4 and 17.3;

-- Transaction and Roll back
BEGIN TRANSACTION;

UPDATE animals
SET species = 'unspecified';

COMMIT;

-- Requirements_1: 

BEGIN TRANSACTION;
UPDATE animals SET species = 'digimon' 
WHERE name LIKE '%mon';

SAVEPOINT a;

UPDATE animals SET species = 'pokemon' 
WHERE name NOT LIKE '%mon';

SAVEPOINT b;

SELECT * FROM animals;

COMMIT;



-- Requirement-2

BEGIN TRANSACTION;

TRUNCATE TABLE animals;

SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;


-- Requirement-3 

BEGIN TRANSACTION;

DELETE FROM animals WHERE date_of_birth > '2022-01-01';

SAVEPOINT delete;

UPDATE animals
SET weight_kg = -1 * weight_kg;
ROLLBACK TO delete;

SELECT * FROM animals;
COMMIT;

-- Requirement-4 
--  Number of available animals 
SELECT count(name) as Number_of_Animals from animals;

-- Number of animals did not escape 
SELECT name, escape_attempts FROM animals WHERE escape_attempts = 0;

-- AVG value of Weight_kg
SELECT AVG(weight_kg) AS Weight_Average  FROM animals;

-- Animal most escaped neutered or not neutered:
SELECT neutered, MAX(escape_attempts) AS Most_Escaped  FROM animals GROUP BY neutered;

--  Max and Min value for weight in each TYPE:

SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;

--The average number of escape attempts per animal type of those born between 1990 and 2000
SELECT AVG(escape_attempts) FROM animals WHERE date_of_birth  BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species; 

-- JOIN
-- What animals belong to Melody Pond?

SELECT animals.name as Pet_name, owners.full_name AS Owner FROM animals
JOIN owners
ON animals.owner_id = owners.id
WHERE full_name = 'Melody Pond';