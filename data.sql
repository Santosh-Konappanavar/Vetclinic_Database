/* Populate database with sample data. */
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES
	(1,'Agumon', DATE'03/02/2020', 0, TRUE, 10.23),
	(2,'Gabumon', DATE'11/15/2020', 2, TRUE, 8),
	(3,'Pikachu', DATE'01/07/2021', 1, FALSE, 15.04),
	(4,'Devimon', DATE'05/12/2017', 5, TRUE, 11);

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES
    (5, 'Charmander', DATE '2020-02-08', 0, FALSE, -11),
    (6, 'Plantmon', DATE '2021-11-15', 2, TRUE, -5.7),
    (7, 'Squirtle', DATE '1993-04-02', 3, FALSE, -12.13),
    (8, 'Angemon', DATE '2005-06-12', 1, TRUE, -45),
    (9, 'Boarmon', DATE '2005-06-07', 7, TRUE, 20.4),
    (10, 'Blossom', DATE '1998-10-13', 3, TRUE, 17),
    (11, 'Ditto', DATE '2022-05-14', 4, TRUE, -22);

INSERT INTO owners (full_name, age)
VALUES 
('Sam Smith', 34),
('Jennifer Orwell', 19),
('Bob', 45),
('Melody Pond', 77),
('Dean Winchester', 14),
('Jodie Whittaker', 38);

INSERT INTO species (name)
VALUES 
('Pokemon'),
('Digimon');

UPDATE animals
SET species_id = (SELECT id species WHERE name = CASE
                        WHEN name LIKE '%mon' THEN 'Digimon'
                        ELSE 'Pokemon'
                        END);

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 
                CASE
                    WHEN name = 'Agumon' THEN 'Sam Smith'
                    WHEN name IN ('Gabumon', 'Pikachu') THEN 'Jennifer Orwell'
                    WHEN name IN ('Devimon', 'Plantmon') THEN 'Bob'
                    WHEN name IN ('Charmander', 'Squirtle', 'Blossom') THEN 'Melody Pond'
                    WHEN name IN ('Angemon', 'Boarmon') THEN 'Dean Winchester'
                END);

INSERT INTO vets (name, age, date_of_graduation)
VALUES
('William Tatcher', 45, DATE'04/23/2000'),
('Maisy Smith', 26, DATE'01/17/2019'),
('Stephanie Mendez', 64, DATE'05/04/1981'),
('Jack Harkness', 38, DATE'06/08/2008');

INSERT INTO specializations (vet_id, species_id)
VALUES
(1, 1),
(3, 1),
(3, 2),
(4, 2);

INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES
(1, 1, DATE'05/24/2020'),
(1, 3, DATE'07/22/2020'),
(2, 4, DATE'02/02/2021'),
(3, 2, DATE'01/05/2020'),
(3, 2, DATE'03/08/2020'),
(3, 2, DATE'05/14/2020'),
(4, 3, DATE'05/04/2021'),
(5, 4, DATE'02/24/2021'),
(6, 2, DATE'12/21/2019'),
(6, 1, DATE'08/10/2020'),
(6, 2, DATE'04/07/2021'),
(7, 3, DATE'09/29/2019'),
(8, 4, DATE'10/03/2020'),
(8, 4, DATE'11/04/2020'),
(9, 2, DATE'01/24/2019'),
(9, 2, DATE'05/15/2019'),
(9, 2, DATE'02/27/2020'),
(9, 2, DATE'08/03/2020'),
(10, 3, DATE'05/24/2020'),
(10, 1, DATE'01/11/2021');