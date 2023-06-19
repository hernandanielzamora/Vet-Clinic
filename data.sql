/* Populate animals talbe with sample data. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Agumon', '03-02-2020', 0, TRUE, 10.23);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Gabumon', '15-11-2018', 2, TRUE, 8);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Pikachu', '07-01-2021', 1, FALSE, 15.04);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Devimon', '12-05-2017', 5, TRUE, 11);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Charmander', '08-02-2020', 0, FALSE, -11);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Plantmon', '15-11-2021', 2, TRUE, -5.7);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Squirtle', '02-04-1993', 3, FALSE, -12.13);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Angemon', '12-06-2005', 1, TRUE, -45);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Boarmon', '07-06-2005', 7, TRUE, 20.4);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Blossom', '13-10-1998', 3, TRUE, 17);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Ditto', '14-05-2022', 4, TRUE, 22);

/* Populate Owners table */

BEGIN;

INSERT INTO owners (full_name, age)
VALUES ('Sam Smith', 34),
('Jennifer Orwell', 19),
('Bob', 45),
('Melody Pond', 77),
('Dean Winchester', 14),
('Jodie Whittaker', 38);

INSERT INTO species (name)
VALUES ('Pokemon'),
('Digimon');

COMMIT;

/* Insert species_id */

BEGIN; 

UPDATE animals SET species_id=(SELECT id FROM species WHERE name='Digimon') WHERE name LIKE '%mon';
UPDATE animals SET species_id=(SELECT id FROM species WHERE name='Pokemon') WHERE species_id IS NUll;

SELECT * FROM animals;

COMMIT;

/* Insert owners_id */

BEGIN; 

UPDATE animals SET owner_id=(SELECT id FROM owners WHERE full_name='Sam Smith') WHERE name='Agumon';
UPDATE animals SET owner_id=(SELECT id FROM owners WHERE full_name='Jennifer Orwell') WHERE name IN ('Gabumon', 'Pikachu');
UPDATE animals SET owner_id=(SELECT id FROM owners WHERE full_name='Bob') WHERE name IN ('Devimon', 'Plantmon');
UPDATE animals SET owner_id=(SELECT id FROM owners WHERE full_name='Melody Pond') WHERE name IN ('Charmander', 'Squirtle', 'Blossom');
UPDATE animals SET owner_id=(SELECT id FROM owners WHERE full_name='Dean Winchester') WHERE name IN ('Angemon', 'Boarmon');

SELECT * FROM animals;

COMMIT;

/* Populate vets table */

INSERT INTO vets (name, age, date_of_graduation)
VALUES ('William Tatcher', 45, '23-04-2000'),
('Maisy Smith', 26, '17-01-2019'),
('Stephanie Mendez', 64, '04-05-1981'),
('Jack Harkness', 38, '08-06-2008');

/* Populate specializations table */

INSERT INTO specializations(vet_id, species_id) 
VALUES ((SELECT id FROM vets WHERE name='William Tatcher'), (SELECT id FROM species WHERE name='Pokemon')),
((SELECT id FROM vets WHERE name='Stephanie Mendez'), (SELECT id FROM species WHERE name='Digimon')),
((SELECT id FROM vets WHERE name='Stephanie Mendez'), (SELECT id FROM species WHERE name='Pokemon')),
((SELECT id FROM vets WHERE name='Jack Harkness'), (SELECT id FROM species WHERE name='Digimon'));

/* Populate visits table */

INSERT INTO visits (animal_id, vet_id, date_of_visit)
VALUES ((SELECT id FROM animals WHERE name='Agumon'), (SELECT id FROM vets WHERE name ='William Tatcher'), '24-05-2020'),
((SELECT id FROM animals WHERE name='Agumon'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '22-07-2020'),
((SELECT id FROM animals WHERE name = 'Gabumon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), '02-02-2021'),
((SELECT id FROM animals WHERE name ='Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '05-01-2020'),
((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '08-03-2020'),
((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '14-05-2020'),
((SELECT id FROM animals WHERE name = 'Devimon'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '04-05-2021'),
((SELECT id FROM animals WHERE name = 'Charmander'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), '24-02-2021'),
((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '21-12-2019'),
((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT id FROM vets WHERE name = 'William Tatcher'), '10-08-2020'),
((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '07-04-2021'),
((SELECT id FROM animals WHERE name = 'Squirtle'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '29-09-2019'),
((SELECT id FROM animals WHERE name = 'Angemon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), '03-10-2020'),
((SELECT id FROM animals WHERE name = 'Angemon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), '04-11-2020'),
((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '24-01-2019'),
((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '15-05-2019'),
((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '27-02-2020'),
((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '03-08-2020'),
((SELECT id FROM animals WHERE name = 'Blossom'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '24-05-2020'),
((SELECT id FROM animals WHERE name = 'Blossom'), (SELECT id FROM vets WHERE name = 'William Tatcher'), '11-01-2021');

/* Add data to the database */

/* Deleted previous visits table */
DROP TABLE visits;

-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animal_id, vet_id, date_of_visit) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
insert into owners (full_name, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';

/* Decreasing execution times for queries as requested */

EXPLAIN ANALYZE SELECT COUNT(*) FROM visits WHERE animal_id=4;
CREATE INDEX visits_animal_id ON visits(animal_id);
EXPLAIN ANALYZE SELECT COUNT(*) FROM visits where animal_id = 4;


EXPLAIN ANALYZE SELECT * FROM visits where vet_id = 2;
CREATE INDEX visits_vet_id ON visits(vet_id);
EXPLAIN ANALYZE SELECT * FROM visits where vet_id = 2;

EXPLAIN ANALYZE SELECT * FROM owners where email = 'owner_18327@mail.com';
CREATE INDEX owners_email ON owners(email);
EXPLAIN ANALYZE SELECT * FROM owners where email = 'owner_18327@mail.com';