/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INT PRIMARY KEY NOT NULL GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL NOT NULL
);

CREATE TABLE owners (
    id INT PRIMARY KEY NOT NULL GENERATED ALWAYS AS IDENTITY,
    full_name VARCHAR(100) NOT NULL,
    age INT
)

CREATE TABLE species (
    id INT PRIMARY KEY NOT NULL GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100) NOT NULL,
)


/* Delte species Column */

ALTER TABLE animals DROP COLUMN species;

/* Adding new Columns */

ALTER TABLE animals 
ADD species_id INT, 
ADD owner_id INT,
ADD CONSTRAINT fk_species FOREIGN KEY (species_id) REFERENCES species(id) ON DELETE CASCADE,
ADD CONSTRAINT fk_owner FOREIGN KEY (owner_id) REFERENCES owners(id) ON DELETE CASCADE;


