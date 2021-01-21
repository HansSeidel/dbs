SELECT CONCAT(CONCAT(Person.vorname,' '),Person.nachname) AS Trainer, Mannschaft.name AS Mannschaft, tmp_Spieler.Spieler as Spieler FROM Person
JOIN Trainer ON (Person.personid = Trainer.personid)
JOIN MANNSCHAFT_TRAINER ON MANNSCHAFT_TRAINER.TrainerID = Trainer.Personid
JOIN MANNSCHAFT ON MANNSCHAFT_TRAINER.Mannschaftid = Mannschaft.mannschaftid
JOIN (SELECT Spieler.mannschaftid as mID, CONCAT(CONCAT(Person.vorname,' '),Person.nachname) AS Spieler FROM Person
      JOIN Spieler ON (Person.personid = Spieler.personid)) tmp_Spieler 
ON tmp_Spieler.mID = Mannschaft.mannschaftid
ORDER BY Trainer,Spieler;
