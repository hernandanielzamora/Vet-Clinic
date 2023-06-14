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

/* Queries for join tables */

/* Who was the last animal seen by William Tatcher? */

SELECT An.name pet_name, Sp.name species, Vet.name vet_name, Vis.date_of_visit date_of_visit FROM animals AS An
JOIN visits AS Vis ON An.id=Vis.animal_id 
JOIN vets AS Vet ON Vet.id = Vis.vet_id
JOIN species as Sp ON An.species_id=Sp.id
Where Vet.name = 'William Tatcher' ORDER BY date_of_visit DESC LIMIT 1;

/* How many different animals did Stephanie Mendez see? */

SELECT animals.name, species.name FROM animals
JOIN species ON animals.species_id = species.id 
JOIN visits ON visits.animal_id=animals.id
JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'Stephanie Mendez'

/* List all vets and their specialties, including vets with no specialties. */

SELECT vets.name, species.name FROM vets 
LEFT JOIN specializations ON vets.id = specializations.vet_id 
LEFT JOIN species ON specializations.species_id = species.id;

/* List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020. */

SELECT animals.name, species.name, visits.date_of_visit FROM animals
JOIN species ON animals.species_id = species.id
JOIN visits ON visits.animal_id = animals.id
JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'Stephanie Mendez' AND visits.date_of_visit BETWEEN '01-04-2020' AND '30-08-2020';

/* What animal has the most visits to vets? */

SELECT animals.name, COUNT(visits.animal_id) AS visits FROM animals
JOIN visits ON animals.id=visits.animal_id 
GROUP BY animals.name ORDER BY visits DESC LIMIT 1;

/* Who was Maisy Smith's first visit? */

SELECT  animals.name, visits.date_of_visit AS First_Visit FROM animals
JOIN visits ON animals.id=visits.animal_id
JOIN vets ON vets.id=visits.vet_id
WHERE vets.name='Maisy Smith' ORDER BY First_Visit LIMIT 1;

/* Details for most recent visit: animal information, vet information, and date of visit. */

SELECT animals.name AS pet_name, animals.date_of_birth, animals.escape_attempts, animals.neutered, animals.weight_kg, species.name AS species, owners.full_name AS Owner, visits.date_of_visit, vets.name AS vet_name, vets.age, vets.date_of_graduation FROM animals 
JOIN visits ON visits.animal_id=animals.id
JOIN owners ON animals.owner_id=owners.id
JOIN species ON animals.species_id=species.id
JOIN vets ON vets.id=visits.vet_id ORDER BY visits.date_of_visit DESC LIMIT 1;

/* How many visits were with a vet that did not specialize in that animal's species? */

SELECT vets.name, species.name FROM vets
JOIN visits ON vets.id=visits.vet_id
LEFT JOIN specializations ON specializations.vet_id=vets.id
LEFT JOIN species ON species.id=specializations.species_id
WHERE specializations.vet_id IS NULL GROUP BY vets.name, species.name ORDER BY vets.name;

/* What specialty should Maisy Smith consider getting? Look for the species she gets the most. */

SELECT species.name AS "species", COUNT(animals.species_id) FROM vets
JOIN visits ON visits.vet_id=vets.id
JOIN animals ON animals.id = visits.animal_id
JOIN species ON species.id = animals.species_id
WHERE vets.name = 'Maisy Smith' GROUP BY species.name ORDER BY count DESC LIMIT 1;
