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
