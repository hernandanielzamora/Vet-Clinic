/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT * FROM animals WHERE date_of_birth BETWEEN '01-01-2016' AND '31-12-2019';
SELECT * FROM animals WHERE neutered=TRUE AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name='Agumon' OR name='Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered=TRUE;
SELECT * FROM animals WHERE name!='Gabumon';
SELECT * FROM animals WHERE weight_kg>=10.4 AND weight_kg<= 17.3;


/* TRANSACTIONS */

/* ROLLBACK SPECIES */
BEGIN;
UPDATE animals SET species='unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

/* UPDATE SPECIES (Pokemon and Digimon) */

BEGIN;

UPDATE animals SET species='digimon' WHERE name LIKE '%mon';
UPDATE animals SET species='pokemon' WHERE species IS NULL;
SELECT * FROM animals;
COMMIT;
SELECT * FROM animals;

/* DELETE */

BEGIN; 

DELETE FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;

DELETE FROM animals WHERE date_of_birth > '01-01-2022';
SAVEPOINT SP1;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO SP1;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;
SELECT * FROM animals;

/* QUESTIONS */

SELECT COUNT(id) FROM animals;

SELECT COUNT(id) FROM animals WHERE escape_attempts = 0;

SELECT SUM(weight_kg) / COUNT(id) FROM animals;

SELECT neutered, MAX(escape_attempts) AS escape_count FROM animals GROUP BY neutered;

SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight FROM animals GROUP BY species;

SELECT species, AVG(escape_attempts) AS escape_attempts FROM animals WHERE date_of_birth BETWEEN '01-01-1990' AND '31-12-2000' GROUP BY species;

/* Using JOIN queries */

SELECT An.name, Ow.full_name, Ow.age FROM animals AS An JOIN owners AS Ow ON An.owner_id=Ow.id WHERE Ow.full_name='Melody Pond';
SELECT  An.id, An.name, Sp.name FROM animals AS An JOIN species AS Sp ON An.species_id=Sp.id WHERE Sp.name='Pokemon';
SELECT An.name AS pet_name, Ow.full_name AS owner FROM animals AS An RIGHT JOIN owners AS Ow ON An.owner_id=Ow.id ORDER BY pet_name;
SELECT species.name AS species, COUNT(animals.species_id) FROM animals JOIN species ON animals.species_id=species.id GROUP BY species.name;
SELECT animals.name, owners.full_name, species.name FROM animals JOIN species ON animals.species_id=species.id JOIN owners ON animals.owner_id=owners.id WHERE species.name='Digimon' AND owners.full_name='Jennifer Orwell';
SELECT animals.name pet_name, animals.escape_attempts, owners.full_name owner FROM animals JOIN owners ON animals.species_id=owners.id WHERE owners.full_name='Dean Winchester' AND animals.escape_attempts = 0;
SELECT owners.full_name owner, COUNT(name) AS amount_of_pets FROM animals JOIN owners ON animals.owner_id = owners.id GROUP BY owners.full_name ORDER BY amount_of_pets DESC;