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
