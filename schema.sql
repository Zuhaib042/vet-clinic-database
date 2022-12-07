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