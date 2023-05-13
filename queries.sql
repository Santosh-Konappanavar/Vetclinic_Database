/*Queries that provide answers to the questions from all projects.*/
SELECT * from animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals
WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name  escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

BEGIN TRANSACTION;

UPDATE animals
SET species = 'unspecified';
SELECT * FROM animals;

-- Rollback the change to return to the previous state
ROLLBACK;

SELECT * FROM animals;

BEGIN TRANSACTION;

-- Update the species column to digimon for all animals that have a name ending in 'mon'
UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';
SELECT * FROM animals;


UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;

COMMIT;

SELECT * FROM animals;

-- Start the transaction
BEGIN TRANSACTION;

-- Delete all records in the animals table
DELETE FROM animals;

-- Rollback the transaction
ROLLBACK;

-- Verify if all records in the animals table still exist
SELECT * FROM animals;

-- Delete all animals born after Jan 1st, 2022
BEGIN TRANSACTION;

DELETE FROM animals
WHERE date_of_birth > DATE '2022-01-01';

-- -- Create a savepoint for the transaction
SAVEPOINT my_savepoint;
SELECT * FROM animals;


-- Update all animals' weight to be their weight multiplied by -1
UPDATE animals
SET weight_kg = weight_kg * -1;
SELECT * FROM animals;

-- Rollback to the savepoint
ROLLBACK TO my_savepoint;
SELECT * FROM animals;

-- Update all animals' weights that are negative to be their weight multiplied by -1
UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;

-- -- Commit the transaction
COMMIT;

-- -- Verify the final state of the animals table
SELECT * FROM animals;

SELECT COUNT(*) AS total_animals
FROM animals;

SELECT COUNT(*) AS num_no_escape
FROM animals
WHERE escape_attempts = 0;

SELECT AVG(weight_kg) AS average_weight
FROM animals;

SELECT neutered, SUM(escape_attempts) AS total_escape_attempts
FROM animals
GROUP BY neutered
ORDER BY total_escape_attempts DESC
LIMIT 1;

SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight
FROM animals
GROUP BY species;

SELECT species, AVG(escape_attempts) AS average_escape_attempts
FROM animals
WHERE date_of_birth BETWEEN DATE '1990-01-01' AND DATE '2000-12-31'
GROUP BY species;

-- multiple table
SELECT *
FROM animals a
JOIN owners o ON a.owner_id = o.id
WHERE o.full_name = 'Melody Pond';

SELECT *
FROM animals a
JOIN species s ON a.species_id = s.id
WHERE s.name = 'Pokemon';

SELECT  o.full_name, a.name 
FROM owners o
LEFT JOIN animals a ON a.owner_id = o.id;

SELECT s.name, COUNT(*) AS animal_count
FROM animals a
JOIN species s ON a.species_id = s.id
GROUP BY s.name;

SELECT *
FROM animals a
JOIN species s ON a.species_id = s.id
JOIN owners o ON a.owner_id = o.id
WHERE s.name = 'Digimon' AND o.full_name = 'Jennifer Orwell';

SELECT a.name
FROM animals a
JOIN owners o ON a.owner_id = o.id
WHERE o.full_name = 'Dean Winchester' AND a.escape_attempts = 0;

SELECT o.full_name, COUNT(*) AS animal_count
FROM animals a
JOIN owners o ON a.owner_id = o.id
GROUP BY o.full_name
ORDER BY animal_count DESC
LIMIT 1;

-- joint table

SELECT *
FROM animals a
INNER JOIN visits v ON a.id = v.animal_id
INNER JOIN vets vt ON vt.id = v.vet_id
WHERE vt.name = 'William Tatcher'
ORDER BY v.visit_date DESC
LIMIT 1;

SELECT COUNT(DISTINCT v.animal_id) AS animal_count
FROM visits v
INNER JOIN vets vt ON vt.id = v.vet_id
WHERE vt.name = 'Stephanie Mendez';

SELECT  vt.name, s.name AS specialty 
FROM vets vt
LEFT JOIN specializations sp ON vt.id = sp.vet_id
LEFT JOIN species s ON sp.species_id = s.id;

SELECT *
FROM animals a
INNER JOIN visits v ON a.id = v.animal_id
INNER JOIN vets vt ON vt.id = v.vet_id
WHERE vt.name = 'Stephanie Mendez'
    AND v.visit_date BETWEEN DATE'2020-04-01' AND DATE'2020-08-30';

SELECT a.name, COUNT(v.animal_id) AS visit_count
FROM animals a
INNER JOIN visits v ON a.id = v.animal_id
GROUP BY a.id
ORDER BY visit_count DESC
LIMIT 1;

SELECT vets.name AS VET_NAME, animals.name AS FIRST_VISITED_ANIMAL_NAME
FROM vets, animals, visits
WHERE vets.name = 'Maisy Smith'
AND vets.id = visits.vet_id
AND animals.id = visits.animal_id
ORDER BY visits.visit_date ASC LIMIT 1;

SELECT a.name AS animal_name, vt.name AS vet_name, v.visit_date
FROM visits v
INNER JOIN vets vt ON vt.id = v.vet_id
INNER JOIN animals a ON a.id = v.animal_id
ORDER BY v.visit_date DESC
LIMIT 1;

SELECT v.name AS vet_name, COUNT(*) AS amount_of_visits
FROM vets v
JOIN visits vs ON v.id = vs.vet_id
JOIN animals a ON vs.animal_id = a.id
LEFT JOIN specializations s ON v.id = s.vet_id AND a.species_id = s.species_id
WHERE s.vet_id IS NULL
GROUP BY v.name;

WITH new AS(
    SELECT DISTINCT(animals.name) animal, COUNT(animals.name) total_visits, vets.name vet
FROM vets, animals, visits
WHERE visits.animal_id = animals.id
AND visits.vet_id = vets.id
AND vets.name = 'Maisy Smith'
GROUP BY animals.name, vet
)
SELECT * FROM new WHERE total_visits = (SELECT MAX(total_visits) FROM new);