/* Populate database with sample data. */

-- insert into animals table
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Agumon', date '2020-02-03', 0 , 'true', 10.23);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Gabumon', date '2018-11-15', 2 , 'true', 8);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Pikachu', date '2021-01-07', 1 , 'false', 15.04);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Devimon', date '2017-05-12', 5 , 'true', 11);

-- insert into animals table
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Charmander', date '2020-02-08', 0, 'false', -11);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Plantmon', date '2021-11-15', 2, 'true', -5.7);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Squirtle', date '1993-04-02', 3, 'false',  -12.13);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Angemon', date '2005-06-12', 1, 'true', -45);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Boarmon', date '2005-06-07', 7, 'true', 20.4);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Blossom', date '1998-10-13', 3, 'true', 17);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Ditto', date '2022-05-14', 4, 'true', 22);

-- insert into owners table
INSERT INTO owners (full_name, age)
VALUES ('Sam Smith', 34), ('Jennifer Orwell', 19), ('Bob', 45), ('Melody Pond', 77), ('Dean Winchester', 14), ('Jodie Whittaker', 38);

-- insert into species table
INSERT INTO species (name)
VALUES ('Pokemon'), ('Digimon');

-- modify animals table to include species_id relevent to the ids of species table.
UPDATE animals
SET species_id = (SELECT id FROM species WHERE name = 'Digimon' ) 
WHERE name LIKE '%mon%';
UPDATE animals
SET species_id = (SELECT id FROM species WHERE name = 'Pokemon' )
WHERE name NOT LIKE '%mon%';

-- modify animals table to include owner_id relevent to the ids in owners table.

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith' )
WHERE name IN ('Agumon');

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell' )
WHERE name IN ('Gabumon', 'Pikachu');

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob' )
WHERE name IN ('Devimon', 'Plantmon');

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond' )
WHERE name IN ('Charmander', 'Squirtle', 'Blossom');

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester' )
WHERE name IN ('Angemon', 'Boarmon');


-- INSERT DATA INTO vets table
INSERT INTO vets(name, age, date_of_graduation)
VALUES ('William Tatcher', 45, '2000-04-23'),('Maisy Smith', 26, '2019-01-17'),('Stephanie Mendez', 64, '1981-05-04'),('Jack Harkness', 38, '2008-06-08');

-- INSERT DATA INTO link table specialties;

INSERT INTO specializations(species_id, vets_id)
VALUES ((SELECT id FROM species WHERE name = 'Pokemon'), (SELECT id FROM vets WHERE name = 'William Tatcher')),
 ((SELECT id FROM species WHERE name = 'Pokemon'),(SELECT id FROM vets WHERE name = 'Stephanie Mendez')),
 ((SELECT id FROM species WHERE name = 'Digimon'),(SELECT id FROM vets WHERE name = 'Stephanie Mendez')),
  ((SELECT id FROM species WHERE name = 'Digimon'),(SELECT id FROM vets WHERE name = 'Jack Harkness'));

-- INSERT DATA INTO link table visits;
INSERT INTO visits (vets_id, animals_id, date_visit)
VALUES ((SELECT id FROM vets WHERE name = 'William Tatcher'), (SELECT id FROM animals WHERE name = 'Agumon'), '2020-05-24'),
((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), (SELECT id FROM animals WHERE name = 'Agumon'), '2020-07-22'),
((SELECT id FROM vets WHERE name = 'Jack Harkness'), (SELECT id FROM animals WHERE name = 'Gabumon'), '2021-02-02'),
((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Pikachu'), '2020-01-05'),
((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Pikachu'), '2020-03-08'),
((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Pikachu'), '2020-05-14'),
((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), (SELECT id FROM animals WHERE name = 'Devimon'), '2021-05-04'),
((SELECT id FROM vets WHERE name = 'Jack Harkness'), (SELECT id FROM animals WHERE name = 'Charmander'), '2021-02-24'),
((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Plantmon'), '2019-12-21'),
((SELECT id FROM vets WHERE name = 'William Tatcher'), (SELECT id FROM animals WHERE name = 'Plantmon'), '2020-08-10'),
((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Plantmon'), '2021-04-07'),
((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), (SELECT id FROM animals WHERE name = 'Squirtle'), '2019-09-29'),
((SELECT id FROM vets WHERE name = 'Jack Harkness'), (SELECT id FROM animals WHERE name = 'Angemon'), '2020-10-03'),
((SELECT id FROM vets WHERE name = 'Jack Harkness'), (SELECT id FROM animals WHERE name = 'Angemon'), '2020-11-04'),
((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Boarmon'), '2019-01-24'),
((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Boarmon'), '2019-05-15'),
((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Boarmon'), '2020-02-27'),
((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Boarmon'), '2020-08-03'),
((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), (SELECT id FROM animals WHERE name = 'Blossom'), '2020-05-24'),
((SELECT id FROM vets WHERE name = 'William Tatcher'), (SELECT id FROM animals WHERE name = 'Blossom'), '2021-01-11');

-- insert more data into visits table;
INSERT INTO visits (animals_id, vets_id, date_visit) 
SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;
-- insert more data into owners table;
insert into owners (full_name, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';