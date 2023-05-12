/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INTEGER PRIMARY KEY NOT NULL,
    name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    escape_attempts INTEGER,
    neutered BOOLEAN,
    weight_kg DECIMAL NOT NULL
);

ALTER TABLE animals ADD COLUMN species varchar(200);

CREATE TABLE species (
   id SERIAL PRIMARY KEY,
   name varchar(100) NOT NULL
);

CREATE TABLE owners (
   id SERIAL PRIMARY KEY,
   full_name varchar(100) NOT NULL,
   age int NOT NULL
);

ALTER TABLE animals
ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY,
DROP COLUMN species,
ADD COLUMN species_id INTEGER REFERENCES species(id),
ADD COLUMN owner_id INTEGER REFERENCES owners(id);