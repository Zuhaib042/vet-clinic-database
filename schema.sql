/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id SERIAL        NOT NULL PRIMARY KEY,
    name             VARCHAR(250) NOT NULL,
    date_of_birth    DATE         NOT NULL,
    escape_attempts  INT          NOT NULL,
    neutered         BOOLEAN      NOT NULL,
    weight_kg        NUMERIC      NOT NULL,
    species          TEXT         NOT NULL   
);

CREATE TABLE owners(
    id           SERIAL PRIMARY KEY,
    full_name    VARCHAR(50) NOT NULL,
    age          INT NOT NULL
);

CREATE TABLE species(
    id          SERIAL    PRIMARY KEY,
    name         VARCHAR(50) NOT NULL
);

ALTER TABLE animals DROP COLUMN species;

ALTER TABLE animals
ADD COLUMN species_id INT REFERENCES species(id)
ON DELETE CASCADE;

ALTER TABLE animals
ADD COLUMN owner_id INT REFERENCES owners(id)
ON DELETE CASCADE;


CREATE TABLE vets(
    id     SERIAL         PRIMARY KEY,
    name   VARCHAR(200)   NOT NULL,
    age    INT            NOT NULL,
    date_of_graduation    DATE NOT NULL
);

-- TABLES JOIN

-- link table 1
CREATE TABLE specializations(
   species_id INT REFERENCES species(id),
   vets_id INT REFERENCES   vets(id)
);

-- link table 2
CREATE TABLE visits(
    vets_id INT REFERENCES vets(id),
    animals_id INT REFERENCES animals(id),
    date_visit DATE NOT NULL
);
