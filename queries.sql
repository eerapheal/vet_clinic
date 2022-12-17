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



SELECT name FROM animals A
INNER JOIN owners O
ON A.owner_id = O.id
WHERE O.full_name = 'Melody Pond';

SELECT A.name FROM animals A
INNER JOIN species S
ON A.species_id = S.id
WHERE S.name = 'Pokemon';

SELECT full_name, name FROM owners O
LEFT JOIN animals A
ON A.owner_id = O.id;

SELECT COUNT(*), S.name FROM animals A
INNER JOIN species S
ON A.species_id = S.id
GROUP BY S.name;

SELECT A.name FROM animals A
INNER JOIN species S ON A.species_id = S.id
INNER JOIN owners O ON A.owner_id = O.id
WHERE O.full_name = 'Jennifer Orwell' AND S.name = 'Digimon';

SELECT name FROM animals A
INNER JOIN owners O ON A.owner_id = O.id
WHERE O.full_name = 'Dean Winchester' AND escape_attempts = 0;

SELECT COUNT(*) as count, full_name FROM animals A
INNER JOIN owners O ON A.owner_id = O.id
GROUP BY O.full_name
ORDER BY count DESC;



SELECT A.name FROM visits V
INNER JOIN animals A ON V.animal_id = A.id
INNER JOIN vets B ON V.vet_id = B.id
WHERE B.name = 'William Tatcher'
ORDER BY V.date_of_visit DESC LIMIT 1;


SELECT COUNT(*) As animals FROM visits V
INNER JOIN animals A ON V.animal_id = A.id
INNER JOIN vets B ON V.vet_id = B.id
WHERE B.name = 'Stephanie Mendez';


SELECT B.name AS vet, S.name AS species FROM specializations C
FULL OUTER JOIN vets B ON C.vets_id = B.id
FULL OUTER JOIN species S ON C.species_id = S.id;


SELECT A.name FROM visits V
INNER JOIN animals A ON V.animal_id = A.id
INNER JOIN vets B ON V.vet_id = B.id
WHERE B.name = 'Stephanie Mendez' AND date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';


SELECT A.name FROM visits V
INNER JOIN animals A ON V.animal_id = A.id
GROUP BY A.name
ORDER BY COUNT(date_of_visit) DESC LIMIT 1;


SELECT A.name FROM visits V
INNER JOIN animals A ON V.animal_id = A.id
INNER JOIN vets B ON V.vet_id = B.id
WHERE B.name = 'Maisy Smith'
ORDER BY V.date_of_visit LIMIT 1;


SELECT A.name AS animal, B.name as vet, V.date_of_visit FROM visits V
INNER JOIN animals A ON A.id = V.animal_id
INNER JOIN vets B ON B.id = V.vet_id
ORDER BY date_of_visit DESC LIMIT 1;


SELECT COUNT(*) AS visits FROM visits V
WHERE V.vet_id = (SELECT id FROM vets B
  INNER JOIN specializations C ON B.id != C.vets_id LIMIT 1);


SELECT S.name, COUNT(S.name) AS visits FROM animals A 
INNER JOIN visits V ON A.id = V.animal_id
INNER JOIN vets B ON V.vet_id = B.id
INNER JOIN species S ON A.species_id = S.id
WHERE B.name = 'Maisy Smith'
GROUP BY S.name
ORDER BY visits DESC LIMIT 1;