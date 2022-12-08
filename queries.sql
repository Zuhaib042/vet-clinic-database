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


-- Queries with Link Tables

-- Who was the last animal seen by William Tatcher?
SELECT animals.name AS animal_name, vets.name AS vet_name, date_visit FROM visits
JOIN vets ON visits.vets_id = vets.id
JOIN animals ON visits.animals_id = animals.id
WHERE vets.name = 'William Tatcher' ORDER BY date_visit DESC LIMIT 1;

-- How many different animals did Stephanie Mendez see?
SELECT animals.name AS animal_name, vets.name AS vet_name FROM visits
JOIN vets ON vets.id = visits.vets_id
JOIN animals ON animals.id = visits.animals_id
WHERE vets.name = 'Stephanie Mendez';

-- List all vets and their specialties, including vets with no specialties.
SELECT vets.name AS vet_name , species.name AS species_name FROM vets
LEFT JOIN specializations ON specializations.vets_id = vets.id
LEFT JOIN species ON species.id = specializations.species_id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animals.name AS animal_name, vets.name AS vet_name, date_visit FROM animals
JOIN visits ON animals.id = visits.animals_id
JOIN vets ON vets.id =  visits.vets_id
WHERE vets.name = 'Stephanie Mendez' AND date_visit BETWEEN '2020-04-01' AND '2020-08-30';

-- What animal has the most visits to vets?
SELECT animals.name AS animal_name, COUNT(visits.animals_id) FROM animals
JOIN visits ON animals.id = visits.animals_id
GROUP BY animals.name ORDER BY COUNT(visits.animals_id) DESC LIMIT 1;

-- Who was Maisy Smith's first visit?
SELECT vets.name AS vet_name, animals.name AS animal_name, date_visit FROM animals
JOIN visits ON visits.animals_id = animals.id
JOIN vets ON vets.id = visits.vets_id
WHERE vets.name = 'Maisy Smith' ORDER BY date_visit ASC LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT animals.name AS animal_name, animals.date_of_birth AS animal_DOB,escape_attempts,weight_kg AS animal_weight, vets.name AS vet_name, vets.age AS vet_age, date_visit FROM vets
FULL OUTER JOIN visits ON visits.animals_id = vets.id
JOIN animals ON animals.id = visits.vets_id
ORDER BY date_visit DESC LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?

SELECT COUNT(visits.vets_id), vets.name AS vet_name FROM vets
FULL OUTER JOIN visits ON visits.vets_id = vets.id
FULL OUTER JOIN specializations ON specializations.vets_id = vets.id
WHERE specializations.species_id IS NULL
GROUP BY vets.name;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.

SELECT species.name , COUNT(visits.date_visit) AS visit_count
FROM animals
JOIN species ON species.id = animals.species_id
JOIN visits ON visits.animals_id = animals.id
JOIN vets ON vets.id = visits.vets_id
WHERE vets.name = 'Maisy Smith'
GROUP BY species.name
ORDER BY COUNT(species_id) DESC LIMIT 1;
