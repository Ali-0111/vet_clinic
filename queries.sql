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

BEGIN TRANSACTION;
UPDATE animals SET species = 'digimon' 
WHERE name LIKE '%mon';

SAVEPOINT a;

UPDATE animals SET species = 'pokemon' 
WHERE name NOT LIKE '%mon';

SAVEPOINT b;

SELECT * FROM animals;

COMMIT;


