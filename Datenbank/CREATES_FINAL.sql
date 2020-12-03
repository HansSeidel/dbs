-- DBS, Project

-- Task 1, Make the following creates:
-- Creates für: Land,Ort,Anschrift,Verein,Match,Liga,Mannschaft,

--------------------------------------------------------------------------------------------------
-- Create CREATES
--------------------------------------------------------------------------------------------------

CREATE TABLE "LAND" 
   (	"LANDID" NUMBER, 
	"KENNZEICHEN" VARCHAR(20), 
	"BEZEICHNUNG" VARCHAR(255)
   ) ;
   
CREATE TABLE "ORT" 
   (	"PLZ" NUMBER, 
	"LANDID" NUMBER, --fk
	"BEZEICHNUNG" VARCHAR(255)
   ) ;

CREATE TABLE "ANSCHRIFT" 
   (	"ANSCHRIFTID" NUMBER, 
	"PLZ" NUMBER, --fk
	"STRASSE" VARCHAR(255),
	"HAUSNUMMER" VARCHAR(20)
   ) ;
   
CREATE TABLE "VEREIN"
  ( "VEREINID" NUMBER,
  "ANSCHRIFTID" NUMBER, --fk
  "NAME" VARCHAR(255)
  ) ;

CREATE TABLE "LIGA"
  ( "LIGAID" NUMBER,
  "DATUM_BEGONNEN" DATE,
  "DATUM_GEENDET" DATE,
  "NAME" VARCHAR(255),
  "ALTERSGRUPPE" NUMBER,
  "GESCHLECHTS_GRUPPE" CHAR(1)
  );  

CREATE TABLE "MANNSCHAFT_MATCH"
  ( "HEIMMANNSCHAFTID" NUMBER,
  "GASTMANNSCHAFTID" NUMBER,
  "MATCHID" NUMBER
  );

CREATE TABLE "MANNSCHAFT_TRAINER"
  ( "MANNSCHAFTID" NUMBER,
  "TRAINERID" NUMBER
  );
  
CREATE TABLE "MATCH_SCHIEDSRICHTER"
  ( "MATCHID" NUMBER,
  "SCHIEDRICHTERID" NUMBER
  );

CREATE TABLE "MATCH"
  ( "MATCHID" NUMBER,
  "ANSCHRIFTID" NUMBER, --fk
  "LIGAID" NUMBER, --fk
  "DATUM" DATE,
  "BEGONNEN_UM" TIMESTAMP,
  "GEENDET_UM" TIMESTAMP,
  "TORE_STAND" VARCHAR(7) -- "nnn/nnn" || "n/n"
  ) ;
  
CREATE TABLE "MANNSCHAFT"
  ( "MANNSCHAFTID" NUMBER,
  "VEREINID" NUMBER, --fk
  "NAME" VARCHAR(255),
  "ALTERSGRUPPE" NUMBER
  ) ;
  
CREATE TABLE SPIELER (
	personID Number,
	mannschaftid Number,
	status CHAR(5),
	eintrittsdatum Date,
	austrittsdatum Date
);
CREATE TABLE trainer (
	personID Number,
	eintrittsdatum Date,
	austrittsdatum Date
);
CREATE TABLE schiedsrichter (
	personID Number,
	eintrittsdatum Date,
	austrittsdatum Date
);
CREATE TABLE mitarbeiter_vorgesetzter (
	personID Number,
	vorgesetzterID Number 
);
CREATE TABLE mitarbeiter (
	personID Number,
	vereinID Number,
	funktion Varchar(50),
	eintrittsdatum Date,
	austrittsdatum Date
);
CREATE TABLE person (
	personID Number,
	anschriftID Number,
	vorname Varchar(50),
	nachname Varchar(50),
	geburtsdatum Date,
	geschlecht Char(1)
);

--------------------------------------------------------------------------------------------------
-- Create Unique Indexes 
--------------------------------------------------------------------------------------------------
  CREATE UNIQUE INDEX "WS20_BIF_3D1_1_fbv_00001" ON "LAND" ("LANDID");
  CREATE UNIQUE INDEX "WS20_BIF_3D1_1_fbv_00002" ON "ORT" ("PLZ");
  CREATE UNIQUE INDEX "WS20_BIF_3D1_1_fbv_00003" ON "ANSCHRIFT" ("ANSCHRIFTID");
  CREATE UNIQUE INDEX "WS20_BIF_3D1_1_fbv_00004" ON "VEREIN" ("VEREINID");
  CREATE UNIQUE INDEX "WS20_BIF_3D1_1_fbv_00005" ON "LIGA" ("LIGAID");
  CREATE UNIQUE INDEX "WS20_BIF_3D1_1_fbv_00006" ON "MANNSCHAFT_MATCH" ("HEIMMANNSCHAFTID","GASTMANNSCHAFTID","MATCHID");
  CREATE UNIQUE INDEX "WS20_BIF_3D1_1_fbv_00007" ON "MANNSCHAFT_TRAINER" ("MANNSCHAFTID", "TRAINERID" );
  CREATE UNIQUE INDEX "WS20_BIF_3D1_1_fbv_00008" ON "MATCH_SCHIEDSRICHTER" ("MATCHID" ,"SCHIEDSRICHTERID");
  CREATE UNIQUE INDEX "WS20_BIF_3D1_1_fbv_00009" ON "MATCH" ("MATCHID");
  CREATE UNIQUE INDEX "WS20_BIF_3D1_1_fbv_00010" ON "MANNSCHAFT" ("MANNSCHAFTID");
  CREATE UNIQUE INDEX "WS20_BIF_3D1_1_fbv_00011" ON "SPIELER" ("PERSONID");
  CREATE UNIQUE INDEX "WS20_BIF_3D1_1_fbv_00012" ON "TRAINER" ("PERSONID");
  CREATE UNIQUE INDEX "WS20_BIF_3D1_1_fbv_00013" ON "SCHIEDSRICHTER" ("PERSONID");
  CREATE UNIQUE INDEX "WS20_BIF_3D1_1_fbv_00014" ON "MITARBEITER_VORGESETZTER" ("PERSONID","VORGESETZTERID");
  CREATE UNIQUE INDEX "WS20_BIF_3D1_1_fbv_00015" ON "MITARBEITER" ("PERSONID");
  CREATE UNIQUE INDEX "WS20_BIF_3D1_1_fbv_00016" ON "PERSON" ("PERSONID");


--------------------------------------------------------------------------------------------------
-- ALTER TABLES AND SET Primary KEYS
--------------------------------------------------------------------------------------------------
-------------------------------------------------
-- Land
-------------------------------------------------
  ALTER TABLE "LAND" MODIFY ("LANDID" NOT NULL ENABLE);
  ALTER TABLE "LAND" ADD PRIMARY KEY ("LANDID") ENABLE;
--------------------------------------------------------
--  Ort
--------------------------------------------------------
  ALTER TABLE "ORT" MODIFY ("PLZ" NOT NULL ENABLE);
  ALTER TABLE "ORT" MODIFY ("LANDID" NOT NULL ENABLE);
  ALTER TABLE "ORT" ADD PRIMARY KEY ("PLZ") ENABLE;
--------------------------------------------------------
--  Anschrift
--------------------------------------------------------
  ALTER TABLE "ANSCHRIFT" MODIFY ("ANSCHRIFTID" NOT NULL ENABLE);
  ALTER TABLE "ANSCHRIFT" MODIFY ("PLZ" NOT NULL ENABLE);
  ALTER TABLE "ANSCHRIFT" ADD PRIMARY KEY ("ANSCHRIFTID") ENABLE;  
--------------------------------------------------------
--  Verein
--------------------------------------------------------
  ALTER TABLE "VEREIN" MODIFY ("VEREINID" NOT NULL ENABLE);
  ALTER TABLE "VEREIN" MODIFY ("NAME" NOT NULL ENABLE);             -- Name is not allowed to be null
  ALTER TABLE "VEREIN" MODIFY ("ANSCHRIFTID" NOT NULL ENABLE);
  ALTER TABLE "VEREIN" ADD PRIMARY KEY ("VEREINID") ENABLE;
--------------------------------------------------------
--  Liga
--------------------------------------------------------
  ALTER TABLE "LIGA" MODIFY ("LIGAID" NOT NULL ENABLE);
  ALTER TABLE "LIGA" MODIFY ("NAME" NOT NULL ENABLE);               -- Name is not allowed to be null
  ALTER TABLE "LIGA" ADD PRIMARY KEY ("LIGAID") ENABLE;
--------------------------------------------------------
--  Mannschaft_Match
--------------------------------------------------------
  ALTER TABLE "MANNSCHAFT_MATCH" MODIFY ("HEIMMANNSCHAFTID" NOT NULL ENABLE);
  ALTER TABLE "MANNSCHAFT_MATCH" MODIFY ("GASTMANNSCHAFTID" NOT NULL ENABLE);
  ALTER TABLE "MANNSCHAFT_MATCH" ADD PRIMARY KEY ("HEIMMANNSCHAFTID", "GASTMANNSCHAFTID",  "MATCHID") ENABLE;
--------------------------------------------------------
--  Mannschaft_Trainer
--------------------------------------------------------
  ALTER TABLE "MANNSCHAFT_TRAINER" MODIFY ("TRAINERID" NOT NULL ENABLE);
  ALTER TABLE "MANNSCHAFT_TRAINER" MODIFY ("MANNSCHAFTID" NOT NULL ENABLE);
  ALTER TABLE "MANNSCHAFT_TRAINER" ADD PRIMARY KEY ("MANNSCHAFTID", "TRAINERID") ENABLE;
--------------------------------------------------------
--  Match_Schiedsrichter
--------------------------------------------------------
  ALTER TABLE "MATCH_SCHIEDSRICHTER" MODIFY ("MATCHID" NOT NULL ENABLE);
  ALTER TABLE "MATCH_SCHIEDSRICHTER" MODIFY ("SCHIEDSRICHTERID" NOT NULL ENABLE);
  ALTER TABLE "MATCH_SCHIEDSRICHTER" ADD PRIMARY KEY ("MATCHID","SCHIEDSRICHTERID") ENABLE;
--------------------------------------------------------
--  Match
--------------------------------------------------------
  ALTER TABLE "MATCH" MODIFY ("MATCHID" NOT NULL ENABLE);
  ALTER TABLE "MATCH" MODIFY ("ANSCHRIFTID" NOT NULL ENABLE);
  ALTER TABLE "MATCH" MODIFY ("LIGAID" NOT NULL ENABLE);
  ALTER TABLE "MATCH" ADD PRIMARY KEY ("MATCHID") ENABLE;
--------------------------------------------------------
--  Mannschaft
--------------------------------------------------------
  ALTER TABLE "MANNSCHAFT" MODIFY ("MANNSCHAFTID" NOT NULL ENABLE);
  ALTER TABLE "MANNSCHAFT" MODIFY ("VEREINID" NOT NULL ENABLE);
  ALTER TABLE "MANNSCHAFT" MODIFY ("NAME" NOT NULL ENABLE);               -- Name is not allowed to be null
  ALTER TABLE "MANNSCHAFT" ADD PRIMARY KEY ("MANNSCHAFTID") ENABLE;
--------------------------------------------------------
--  Spieler
--------------------------------------------------------
  ALTER TABLE "SPIELER" MODIFY ("PERSONID" NOT NULL ENABLE);
  ALTER TABLE "SPIELER" MODIFY ("MANNSCHAFTID" NOT NULL ENABLE);
  ALTER TABLE "SPIELER" MODIFY ("EINTRITTSDATUM" NOT NULL ENABLE);
  ALTER TABLE "SPIELER" ADD PRIMARY KEY ("PERSONID") ENABLE;
--------------------------------------------------------
--  Trainer
--------------------------------------------------------
  ALTER TABLE "TRAINER" MODIFY ("PERSONID" NOT NULL ENABLE);
  ALTER TABLE "TRAINER" MODIFY ("EINTRITTSDATUM" NOT NULL ENABLE);
  ALTER TABLE "TRAINER" ADD PRIMARY KEY ("PERSONID") ENABLE;
--------------------------------------------------------
--  Schiedrichter
--------------------------------------------------------
  ALTER TABLE "SCHIEDSRICHTER" MODIFY ("PERSONID" NOT NULL ENABLE);
  ALTER TABLE "SCHIEDSRICHTER" MODIFY ("EINTRITTSDATUM" NOT NULL ENABLE);
  ALTER TABLE "SCHIEDSRICHTER" ADD PRIMARY KEY ("PERSONID") ENABLE;
--------------------------------------------------------
--  mitarbeiter_vorgesetzter
--------------------------------------------------------
  ALTER TABLE "MITARBEITER_VORGESETZTER" MODIFY ("PERSONID" NOT NULL ENABLE);
  ALTER TABLE "MITARBEITER_VORGESETZTER" MODIFY ("VORGESETZTERID" NOT NULL ENABLE);
  ALTER TABLE "MITARBEITER_VORGESETZTER" ADD PRIMARY KEY ("PERSONID","VORGESETZTERID") ENABLE;
--------------------------------------------------------
--  mitarbeiter
--------------------------------------------------------
  ALTER TABLE "MITARBEITER" MODIFY ("PERSONID" NOT NULL ENABLE);
  ALTER TABLE "MITARBEITER" MODIFY ("VEREINID" NOT NULL ENABLE);
  ALTER TABLE "MITARBEITER" MODIFY ("EINTRITTSDATUM" NOT NULL ENABLE);
  ALTER TABLE "MITARBEITER" ADD PRIMARY KEY ("PERSONID") ENABLE;
--------------------------------------------------------
--  person
--------------------------------------------------------
  ALTER TABLE "PERSON" MODIFY ("PERSONID" NOT NULL ENABLE);
  ALTER TABLE "PERSON" ADD PRIMARY KEY ("PERSONID") ENABLE;
  

--------------------------------------------------------------------------------------------------
-- ALTER TABLES AND SET Foreign KEYS
--------------------------------------------------------------------------------------------------
--------------------------------------------------------
--  Ort
--------------------------------------------------------
 ALTER TABLE "ORT" ADD FOREIGN KEY ("LANDID")
	  REFERENCES "LAND" ("LANDID") ENABLE;

--------------------------------------------------------
--  Anschrift
--------------------------------------------------------
 ALTER TABLE "ANSCHRIFT" ADD FOREIGN KEY ("PLZ")
	  REFERENCES "ORT" ("PLZ") ENABLE;

--------------------------------------------------------
--  Verein
--------------------------------------------------------
 ALTER TABLE "VEREIN" ADD FOREIGN KEY ("ANSCHRIFTID")
	  REFERENCES "ANSCHRIFT" ("ANSCHRIFTID") ENABLE;

--------------------------------------------------------
--  Mannschaft_Match
--------------------------------------------------------
 ALTER TABLE "MANNSCHAFT_MATCH" ADD FOREIGN KEY ("HEIMMANNSCHAFTID")
	  REFERENCES "MANNSCHAFT" ("MANNSCHAFTID") ENABLE;
	  
 ALTER TABLE "MANNSCHAFT_MATCH" ADD FOREIGN KEY ("GASTMANNSCHAFTID")
	  REFERENCES "MANNSCHAFT" ("MANNSCHAFTID") ENABLE;
	  	  
 ALTER TABLE "MANNSCHAFT_MATCH" ADD FOREIGN KEY ("MATCHID")
	  REFERENCES "MATCH" ("MATCHID") ENABLE;
	  
--------------------------------------------------------
--  Mannschaft_Trainer
--------------------------------------------------------
 ALTER TABLE "MANNSCHAFT_TRAINER" ADD FOREIGN KEY ("MANNSCHAFTID")
	  REFERENCES "MANNSCHAFT" ("MANNSCHAFTID") ENABLE;
	  
 ALTER TABLE "MANNSCHAFT_TRAINER" ADD FOREIGN KEY ("TRAINERID")
	  REFERENCES "TRAINER" ("PERSONID") ENABLE;

--------------------------------------------------------
--  Mannschaft_Schiedsrichter
--------------------------------------------------------
 ALTER TABLE "MATCH_SCHIEDSRICHTER" ADD FOREIGN KEY ("MATCHID")
	  REFERENCES "MATCH" ("MATCHID") ENABLE;
	  
 ALTER TABLE "MATCH_SCHIEDSRICHTER" ADD FOREIGN KEY ("SCHIEDSRICHTERID")
	  REFERENCES "SCHIEDSRICHTER" ("PERSONID") ENABLE;

--------------------------------------------------------
--  Match
--------------------------------------------------------
 ALTER TABLE "MATCH" ADD FOREIGN KEY ("ANSCHRIFTID")
	  REFERENCES "ANSCHRIFT" ("ANSCHRIFTID") ENABLE;
	  
 ALTER TABLE "MATCH" ADD FOREIGN KEY ("LIGAID")
	  REFERENCES "LIGA" ("LIGAID") ENABLE;
	  
--------------------------------------------------------
--  Mannschaft
--------------------------------------------------------
 ALTER TABLE "MANNSCHAFT" ADD FOREIGN KEY ("VEREINID")
	  REFERENCES "VEREIN" ("VEREINID") ENABLE;

--------------------------------------------------------
--  Spieler, Trainer, Schiedsrichter
--------------------------------------------------------
 ALTER TABLE "SPIELER" ADD FOREIGN KEY ("PERSONID")
	  REFERENCES "PERSON" ("PERSONID") ENABLE;
 ALTER TABLE "SPIELER" ADD FOREIGN KEY ("MANNSCHAFTID")
	  REFERENCES "MANNSCHAFT" ("MANNSCHAFTID") ENABLE;
 ALTER TABLE "TRAINER" ADD FOREIGN KEY ("PERSONID")
	  REFERENCES "PERSON" ("PERSONID") ENABLE;
 ALTER TABLE "SCHIEDSRICHTER" ADD FOREIGN KEY ("PERSONID")
	  REFERENCES "PERSON" ("PERSONID") ENABLE;

--------------------------------------------------------
--  mitarbeiter, mitarbeiter_vorgesetzter
--------------------------------------------------------
ALTER TABLE "MITARBEITER" ADD FOREIGN KEY ("VEREINID")
    REFERENCES "VEREIN" ("VEREINID") ENABLE;

 ALTER TABLE "MITARBEITER_VORGESETZTER" ADD FOREIGN KEY ("PERSONID")
	  REFERENCES "MITARBEITER" ("PERSONID") ENABLE;
 ALTER TABLE "MITARBEITER_VORGESETZTER" ADD FOREIGN KEY ("VORGESETZTERID")
	  REFERENCES "MITARBEITER" ("PERSONID") ENABLE;
	  

--------------------------------------------------------------------------------------------------
-- ALTER TABLES Set Ruleset
--------------------------------------------------------------------------------------------------
ALTER TABLE person MODIFY geschlecht CHECK(geschlecht IN ('M','F','D'));
ALTER TABLE spieler MODIFY status CHECK(status IN ('KADER','RESER','NOTKA'));
ALTER TABLE liga modify geschlechts_gruppe CHECK(geschlechts_gruppe IN ('M','F'));
