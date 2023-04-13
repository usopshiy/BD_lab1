CREATE TABLE place(
    place_id SERIAL PRIMARY KEY,
    name_place CHAR(80) NOT NULL ,
    number_of_residents INTEGER NOT NULL CHECK ( number_of_residents >=0 )
);

CREATE TABLE astronaut(
    astronaut_id SERIAL PRIMARY KEY,
    place_id INTEGER NOT NULL REFERENCES place(place_id),
    name_astronaut CHAR(80) NOT NULL ,
    age INT NOT NULL CHECK(age >= 0)
);

CREATE TYPE surface_enum AS ENUM('smooth', 'rough', 'scratchy', 'polished');

CREATE TABLE monolith
(
    monolith_id SERIAL PRIMARY KEY ,
    origin INTEGER NOT NULL REFERENCES place(place_id),
    material CHAR(80) NOT NULL,
    surface_type surface_enum NOT NULL ,
    color CHAR(80) NOT NULL
);

CREATE TYPE ocular_type_enum AS ENUM('magnifying', 'remissive');

CREATE TABLE ocular(
    ocular_id SERIAL PRIMARY KEY ,
    scale INT NOT NULL CHECK ( scale >= 10 ),
    ocular_type ocular_type_enum NOT NULL
);

CREATE TABLE contact_instance(
    astronaut_id INTEGER NOT NULL REFERENCES astronaut(astronaut_id),
    monolith_id INTEGER NOT NULL REFERENCES monolith (monolith_id),
    place_id INTEGER NOT NULL REFERENCES place(place_id),
    contact_date DATE NOT NULL,
    contact_time TIME NOT NULL,
    contact_type CHAR(80) NOT NULL
);

CREATE TABLE inspection_instance(
    astronaut_id INT NOT NULL REFERENCES astronaut(astronaut_id),
    monolith_id INT NOT NULL REFERENCES monolith (monolith_id),
    place_id INT NOT NULL REFERENCES place(place_id),
    ocular_id INT NOT NULL REFERENCES ocular(ocular_id),
    inspection_date DATE NOT NULL,
    inspection_time TIME NOT NULL
);

INSERT INTO place(
                  name_place,
                  number_of_residents
) VALUES ('Moon', 0),
      ('Cupol_base', 354),
      ('Tiho', 0);

INSERT INTO astronaut(
                      name_astronaut,
                      age,
                      place_id
) VALUES ('Floyd', 42, 2);

INSERT INTO monolith(
                     origin,
                     material,
                     surface_type,
                     color
) VALUES (3, 'Obsidian', 'smooth', 'eben');

INSERT INTO ocular(
                    scale,
                    ocular_type
) VALUES (100, 'magnifying');

INSERT INTO contact_instance(
                             astronaut_id,
                             monolith_id,
                             place_id,
                             contact_date,
                             contact_time,
                             contact_type
) VALUES (1, 1, 1, '12.12.2096', '12:00', 'in scafander' ),
         (1, 1, 3, '12.02.2098', '13:00','barehanded');


INSERT INTO inspection_instance(
                                astronaut_id,
                                monolith_id,
                                place_id,
                                ocular_id,
                                inspection_date,
                                inspection_time
) VALUES (1, 1, 2, 1, '11.03.2099', '15:00')