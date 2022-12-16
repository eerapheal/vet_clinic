/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered IS true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered IS true;
SELECT * FROM animals WHERE name NOT IN ('Gabumon');
SELECT * FROM animals WHERE weight_kg >= 10.4  AND weight_kg <= 17.3;

UPDATE animals
SET species = 'unspecified';

SELECT * FROM animals;

/*Start transation*/
BEGIN;
/*Update transation*/
UPDATE animals 
SET species = 'digimon'
WHERE name LIKE '%mon';

SELECT * FROM animals;
/*Update transation*/
UPDATE animals 
SET species = 'pokemon'
WHERE species IS NULL;

SELECT * FROM animals;
/*Commit transation*/
COMMIT;

SELECT * FROM animals;

/*Return to previuse state of transation*/

ROLLBACK;

SELECT * FROM animals;

/*Delete transation*/

DELETE FROM animals
WHERE date_of_birth > '2022-01-01';

SELECT * FROM animals;

/*Set a save point transation*/
SAVEPOINT born_before_Jan2022;

SELECT * FROM animals;
/*update transation*/
UPDATE animals 
SET weight_kg = weight_kg * -1;

SELECT * FROM animals;
/*return to savepoint transation*/
ROLLBACK TO born_before_Jan2022;

SELECT * FROM animals;
/* Update transation*/
UPDATE animals 
SET weight_kg = weight_kg * -1 
WHERE weight_kg < 0;

SELECT * FROM animals;
/*Commit transation*/
COMMIT;

SELECT * FROM animals;

/*Transation details check*/

SELECT COUNT(*) FROM animals;

SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

SELECT AVG(weight_kg) FROM animals;

SELECT neutered, SUM(escape_attempts) FROM animals GROUP BY neutered;

SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;

SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;

