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