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

--List of all animals that are pokemon (their type is Pokemon).
SELECT animals.name, species.name FROM animals
JOIN species
ON species.id = animals.species_id 
WHERE species.name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.

SELECT owners.full_name AS Owners, animals.name AS pet FROM owners
LEFT JOIN animals
ON animals.owner_id = owners.id;

-- How many animals are there per species?

SELECT species.name, count(species.name) FROM animals
JOIN species
ON animals.species_id = species.id
GROUP BY species.name;

-- List all Digimon owned by Jennifer Orwell.

SELECT
  animals.name AS Pet,
  species.name AS Type,
  owners.full_name AS Owner
FROM animals
JOIN species
ON animals.species_id = species.id
JOIN owners
ON animals.owner_id = owners.id
WHERE owners.full_name = 'Jennifer Orwell'
AND species.name = 'Digimon';

-- List all animals owned by Dean Winchester that haven't tried to escape.

SELECT animals.name , owners.full_name, animals.escape_attempts
FROM animals
JOIN owners
ON animals.owner_id = owners.id
WHERE owners.full_name = 'Dean Winchester'
AND animals.escape_attempts = 0
;

-- Who owns the most animals?

SELECT owners.full_name, count(owners.full_name) AS Number_of_Animals
FROM animals
JOIN owners
ON animals.owner_id = owners.id
GROUP BY owners.full_name
ORDER BY Number_of_Animals DESC
LIMIT 1
;

-- Advance join tables
-- Who was the last animal seen by William Tatcher?
SELECT a.name, vt.name as vet, v.date FROM animals a
JOIN visits v ON v.animal_Id = a.id
JOIN vets vt ON vt.id = v.vet_id
WHERE v.date =(
    SELECT MAX(visit_date) 
    FROM (
        SELECT a.name as animal, vt.name as vet, 
        vs.date as visit_date FROM animals a
        JOIN visits vs ON vs.animal_id = a.id
        JOIN vets vt ON vt.id = vs.vet_id
        WHERE vt.name = 'William Tatcher'
        ) AS subquery
);

-- How many different animals did Stephanie Mendez see?
SELECT COUNT(*) as animals_type_visited FROM (
    SELECT COUNT(*) FROM vets vt
    JOIN visits vs ON vt.id = vs.vet_id
    WHERE vt.name = 'Stephanie Mendez'
    GROUP BY vs.animal_id
) AS subquery;

-- List all vets and their specialties, including vets with no specialties.
SELECT v.name, s.name as speciality FROM vets v
LEFT JOIN specialization sp ON sp.vet_id = v.id
LEFT JOIN species s ON s.id = sp.species_id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.

SELECT a.name, v.name as vet, date FROM animals a
JOIN visits ON visits.animal_id = a.id
JOIN vets v ON visits.vet_id = v.id
WHERE v.name = 'Stephanie Mendez' 
AND date BETWEEN '2020-4-1' AND '2020-8-30';

-- What animal has the most visits to vets?
SELECT a.name AS animal, COUNT(*) AS visit_count
FROM animals a
JOIN visits v ON a.id = v.animal_id
GROUP BY a.id, a.name
ORDER BY visit_count DESC;
LIMIT 1;

-- Who was Maisy Smith's first visit?
SELECT a.name, v.name as vet, date FROM animals a
JOIN visits ON visits.animal_id = a.id
JOIN vets v ON visits.vet_id = v.id
WHERE v.name = 'Maisy Smith'
ORDER BY date
LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(*) as unspecialized_visits
FROM (
    SELECT a.id as animal_id, a.species_id as animal_species,
    sp.species_id as vet_specialization  FROM animals a
    JOIN visits vs ON a.id = vs.animal_id
    JOIN specialization sp ON sp.vet_id = vs.vet_id
    WHERE a.species_id != sp.species_id
    ) AS subquery;