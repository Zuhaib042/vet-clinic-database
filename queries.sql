/*Queries that provide answers to the questions from all projects.*/

SELECT * from animals WHERE name LIKE '%mon%';
SELECT * from animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT * from animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth from animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts from animals WHERE weight_kg > 10.5;
SELECT * from animals WHERE neutered = true;
SELECT * from animals WHERE name NOT IN ('Gabumon');
SELECT * from animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

BEGIN;
ALTER TABLE animals RENAME COLUMN species TO unspecified;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon%';

UPDATE animals
SET species = 'pokemon'
WHERE name NOT LIKE '%mon%';
COMMIT;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals
WHERE date_of_birth > '2022-01-01';
SAVEPOINT SP1;
UPDATE animals
SET weight_kg = weight_kg * -1;
ROLLBACK TO SP1;

UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;
COMMIT;

-- queries using aggregate functions

SELECT COUNT(*) FROM animals;
SELECT COUNT(escape_attempts) FROM animals
WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT neutered, AVG(escape_attempts) FROM animals
GROUP BY neutered;
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals
GROUP BY species;
SELECT species, AVG(escape_attempts) FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;


-- Queries using JOIN

SELECT name FROM animals 
JOIN owners ON animals.owner_id = owners.id
WHERE full_name = 'Melody Pond';

SELECT * FROM animals 
JOIN species ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

SELECT name, owner_id, full_name  FROM animals 
RIGHT JOIN owners ON animals.owner_id = owners.id;

SELECT species.name, COUNT(animals.name) FROM animals 
JOIN species ON animals.species_id = species.id
GROUP BY species.name;

SELECT animals.name AS animal_name, owner_id, full_name, species.name AS species_name FROM animals
JOIN owners ON animals.owner_id = owners.id
JOIN species ON animals.species_id = species.id 
WHERE species_id = (SELECT id FROM species WHERE name = 'Digimon') AND full_name = 'Jennifer Orwell';

SELECT owner_id, animals.name AS animal_name ,escape_attempts, full_name FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE escape_attempts = 0 AND full_name = 'Dean Winchester';

SELECT full_name , COUNT(animals.name) AS animal_count FROM animals 
JOIN owners ON animals.owner_id = owners.id
GROUP BY full_name ORDER BY COUNT(*) DESC LIMIT 1;