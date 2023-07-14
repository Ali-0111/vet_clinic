/* Database schema to keep the structure of entire database. */

CREATE DATABASE vet_clinic;

CREATE TABLE animals (
    id SERIAL NOT NULL,
    name VARCHAR(40),
    date_of_birth DATE NOT NULL,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL(10,2),
    PRIMARY KEY (id)
);


ALTER TABLE animals ADD
species VARCHAR(30);

-- owners table

CREATE TABLE owners (
    id INT,
    full_name VARCHAR(30),
    age INT,
    PRIMARY KEY (id) 
);

-- species table
CREATE TABLE species (
    id INT,
    name VARCHAR(30),
    PRIMARY KEY (id) 
);

-- ADD : auto increment FOR id field in owners
ALTER TABLE owners
ALTER COLUMN id 
ADD GENERATED ALWAYS AS IDENTITY;

-- ADD : auto increment FOR id field in species
ALTER TABLE species
ALTER COLUMN id 
ADD GENERATED ALWAYS AS IDENTITY;

-- ADD species_id column which is a FK from species(id)

ALTER TABLE animals
ADD species_id INT,
ADD CONSTRAINT species_fk 
FOREIGN KEY (species_id) REFERENCES species(id);

-- ADD owners_id column which is FK from owners(id)
ALTER TABLE animals
ADD owners_id INT,
ADD CONSTRAINT owners_fk
FOREIGN KEY (owners_id) REFERENCES owners(id);


-- ADD vets table

CREATE TABLE vets (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(30),
    age INT,
    date_of_graduation DATE,
    PRIMARY KEY (id)
);

-- specialization table

CREATE TABLE specialization (
    vet_id INT,
    species_id INT,
    PRIMARY KEY(vet_id, species_id),
    FOREIGN KEY(vet_id) REFERENCES vets(id),
    FOREIGN KEY(species_id) REFERENCES species(id)
);

-- visits table

CREATE TABLE visits (
    id INT GENERATED ALWAYS AS IDENTITY,
    animal_id INT,
    vet_id INT, 
    date DATE,
    FOREIGN KEY(animal_id) REFERENCES animals(id),
    FOREIGN KEY(vet_id) REFERENCES vets(id),
    PRIMARY KEY(id)
);