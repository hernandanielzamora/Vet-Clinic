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

CREATE TABLE vets (
    id INT PRIMARY KEY NOT NULL GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100) NOT NULL,
    age INT,
    date_of_graduation DATE
);

CREATE TABLE specializations (
    vet_id INT,
    species_id INT,
    PRIMARY KEY (vet_id, species_id),
    CONSTRAINT fk_vets
     FOREIGN KEY (vet_id) REFERENCES vets(id)
     ON DELETE CASCADE,
    CONSTRAINT fk_species
     FOREIGN KEY (species_id) REFERENCES species(id)
     ON DELETE CASCADE
);

SELECT * FROM specializations;

CREATE TABLE visits (
    id INT PRIMARY KEY NOT NULL GENERATED ALWAYS AS IDENTITY,
    animal_id INT,
    vet_id INT,
    date_of_visit DATE,
    CONSTRAINT fk_vets
     FOREIGN KEY (vet_id) REFERENCES vets(id)
     ON DELETE CASCADE,
    CONSTRAINT fk_animals
     FOREIGN KEY (animal_id) REFERENCES animals(id)
     ON DELETE CASCADE
);

SELECT * FROM visits;

/* Delte species Column */

ALTER TABLE animals DROP COLUMN species;

/* Adding new Columns */

ALTER TABLE animals 
ADD species_id INT, 
ADD owner_id INT,
ADD CONSTRAINT fk_species FOREIGN KEY (species_id) REFERENCES species(id) ON DELETE CASCADE,
ADD CONSTRAINT fk_owner FOREIGN KEY (owner_id) REFERENCES owners(id) ON DELETE CASCADE;


