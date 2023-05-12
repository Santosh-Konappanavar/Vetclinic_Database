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
