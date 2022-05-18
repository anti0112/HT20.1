CREATE TABLE breed
(
    breed_id integer PRIMARY KEY AUTOINCREMENT,
    breed text(20)
);


INSERT INTO breed(breed)
SELECT DISTINCT breed
FROM animals;


CREATE TABLE colors
(
    color_id integer PRIMARY KEY AUTOINCREMENT,
    color  text(20)
);


INSERT INTO colors(color)
SELECT DISTINCT * FROM
(
    SELECT DISTINCT color1 as color FROM animals
    UNION ALL SELECT DISTINCT color2 as color FROM animals
    WHERE color2 IS NOT NULL
);


CREATE TABLE types
(
    type_id integer PRIMARY KEY AUTOINCREMENT,
    type text(20)
);


INSERT INTO types(type)
SELECT DISTINCT animal_type FROM animals;


CREATE TABLE programs
(
    program_id integer PRIMARY KEY AUTOINCREMENT,
    program text(20)
);

INSERT INTO programs(program)
SELECT DISTINCT outcome_subtype FROM animals
WHERE outcome_subtype IS NOT NULL;


CREATE TABLE Statuses
(
    status_id integer PRIMARY KEY AUTOINCREMENT,
    status    text(20)
);


INSERT INTO Statuses(status)
SELECT DISTINCT outcome_type FROM animals
WHERE outcome_type IS NOT NULL;


CREATE TABLE new_animal
(
    animal_id text PRIMARY KEY,
    name text(20),
    type_id integer,
    breed_id integer,
    main_color_id integer,
    second_color_id integer,
    date_of_birth text(20),
    FOREIGN KEY (type_id) REFERENCES types(type_id) ON UPDATE CASCADE,
    FOREIGN KEY (breed_id) REFERENCES breed(breed_id) ON UPDATE CASCADE,
    FOREIGN KEY (main_color_id) REFERENCES colors(color_id) ON UPDATE CASCADE,
    FOREIGN KEY (second_color_id) REFERENCES colors(color_id) ON UPDATE CASCADE
);


INSERT INTO new_animal(animal_id, name, date_of_birth, type_id, breed_id, main_color_id, second_color_id)
SELECT DISTINCT animals.animal_id,
                animals.name,
                animals.date_of_birth,
                types.type_id,
                breed.breed_id,
                colors1.color_id,
                colors2.color_id
FROM animals
LEFT JOIN breed ON breed.breed = animals.breed
LEFT JOIN types ON types.type = animals.animal_type
LEFT JOIN colors colors1 ON colors1.color = animals.color1
LEFT JOIN colors colors2 ON colors2.color = animals.color2;


CREATE TABLE outcome
(
    id integer PRIMARY KEY AUTOINCREMENT,
    animal_id text,
    age_upon_outcome text,
    program_id integer,
    status_id integer,
    outcome_month integer,
    outcome_year integer,
    FOREIGN KEY (animal_id) REFERENCES new_animal(animal_id) ON UPDATE CASCADE,
    FOREIGN KEY (program_id) REFERENCES programs(program_id) ON UPDATE CASCADE,
    FOREIGN KEY (status_id) REFERENCES Statuses(status_id) ON UPDATE CASCADE
);

INSERT INTO outcome(animal_id, outcome_month, outcome_year, age_upon_outcome, program_id, status_id)
SELECT DISTINCT animals.animal_id,
                animals.outcome_month,
                animals.outcome_year,
                animals.age_upon_outcome,
                programs.program_id,
                Statuses.status_id
FROM animals
LEFT JOIN programs ON programs.program = animals.outcome_subtype
LEFT JOIN Statuses ON Statuses.status = animals.outcome_type;


SELECT DISTINCT new_animal.name, Statuses.status, new_animal.date_of_birth, colors1.color, colors2.color
FROM outcome
LEFT JOIN Statuses ON outcome.status_id = Statuses.status_id
LEFT JOIN new_animal ON outcome.animal_id = new_animal.animal_id
LEFT JOIN colors colors1 ON new_animal.main_color_id = colors1.color_id
LEFT JOIN colors colors2 ON new_animal.second_color_id = colors2.color_id
WHERE id = 10;