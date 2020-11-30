/*************************************
/**
/**Table:person, spieler, trainer, schiedsrichter, mitarbeiter
/**Developer:Lucian-Valentin Caraba
/**Description: 
/**
/*************************************/

<<<<<<< HEAD
CREATE TABLE person (
	personID_pk Number,
	anschriftID_fk Number,
	vorname Varchar(50),
	nachname Varchar(50),
	geschlecht Char(1)
);
CREATE TABLE spieler (
	spielerID Number,
	personID_fk Number,
	mannschaftsID_fk Number,
	--status CHAR(5),
	eintrittsdatum Date,
	austrittsdatum Date
);
CREATE TABLE trainer (
	trainerID Number,
	personID_fk Number,
	eintrittsdatum Date,
	austrittsdatum Date
);
CREATE TABLE schiedsrichter (
	schiedsrichterID Number,
	personID_fk Number,
	eintrittsdatum Date,
	austrittsdatum Date
);
CREATE TABLE mitarbeiter (
	mitarbeiterID Number,
	personID_fk Number,
	funktion Varchar(50),
	eintrittsdatum Date,
	austrittsdatum Date
);
=======

>>>>>>> tmp

----------PRIMARY KEY STATEMENTS-----------
ALTER TABLE person ADD PRIMARY KEY(personID_pk);
----------FOREIGN KEY STATEMENTS-----------
ALTER TABLE person ADD FOREIGN KEY(anschriftID_fk) REFERENCES anschrift(anschriftID_pk) ON DELETE SET NULL;
ALTER TABLE spieler ADD FOREIGN KEY(personID_fk) REFERENCES person(personID_pk) ON DELETE SET NULL
										ADD FOREIGN KEY(mannschaftsID_fk) REFERENCES mannschaft(mannschaftsID_pk) ON DELETE SET NULL
										ADD PRIMARY KEY(personID_fk);
ALTER TABLE trainer ADD FOREIGN KEY(personID_fk) REFERENCES person(personID_pk) ON DELETE SET NULL
										ADD PRIMARY KEY(personID_fk);
ALTER TABLE schiedsrichter ADD FOREIGN KEY(personID_fk) REFERENCES person(personID_pk) ON DELETE SET NULL
										ADD PRIMARY KEY(personID_fk);
ALTER TABLE mitarbeiter ADD FOREIGN KEY(personID_fk) REFERENCES person(personID_pk) ON DELETE SET NULL
										ADD PRIMARY KEY(personID_fk);
----------------CONSTRAINTS-----------------
ALTER TABLE person MODIFY (vorname NOT NULL, nachname NOT NULL, geschlecht CHECK(geschlecht IN ('M','F','D')));
--ALTER TABLE spieler MODIFY (spielerID NOT NULL, eintrittsdatum NOT NULL, status CHECK(status IN ('KADER','RESER','NOTKA')));
ALTER TABLE trainer MODIFY (trainerID NOT NULL, eintrittsdatum NOT NULL);
ALTER TABLE schiedsrichter MODIFY (schiedsrichterID NOT NULL, eintrittsdatum NOT NULL);
ALTER TABLE mitarbeiter MODIFY (mitarbeiterID NOT NULL, eintrittsdatum NOT NULL);
---------DROP STATEMENTS----------------------
DROP TABLE person;
DROP TABLE spieler;
DROP TABLE trainer;
DROP TABLE schiedsrichter;
DROP TABLE mitarbeiter;






