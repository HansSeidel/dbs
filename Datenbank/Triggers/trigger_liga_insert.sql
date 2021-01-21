CREATE OR REPLACE TRIGGER test
BEFORE INSERT ON liga
FOR EACH ROW
BEGIN
     IF :new.datum_begonnen = NULL OR :new.datum_geendet = NULL THEN
      raise_application_error(-20000, 'Bitte Datum ausfüllen');
     END IF;
END;
/
SELECT * FROM LIGA;
INSERT INTO liga(ligaid, datum_begonnen, datum_geendet, name, altersgruppe, geschlechts_gruppe) VALUES (23,'test',TO_DATE('05/11/2020','DD-MM-YYYY'),TO_DATE('22/01/2021','DD-MM-YYYY'),15,'M');
