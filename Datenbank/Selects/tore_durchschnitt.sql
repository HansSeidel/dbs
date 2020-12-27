-- Task by SEI
-- SELECT
/**
  Aufgabenstellung: 
  Es ist ein Select-Statement geschrieben, welches den durchschnittlichen Tore-Stand aller Mannschaften ausgibt. 
  Es soll nach den besten Mannschaften absteigend geordnet werden. 

**/
SELECT * FROM all_tables;
SELECT * FROM Mannschaft;
SELECT * FROM MATCH ORDER BY Matchid;
SELECT * FROM MANNSCHAFT_MATCH;
SELECT * FROM Mannschaft_Match WHERE GastMannschaftID = 1 ORDER BY MatchId;
SELECT * FROM Mannschaft_Match WHERE Heimmannschaftid = 1 ORDER BY MatchId;

SELECT * FROM MATCH JOIN MANNSCHAFT_MATCH USING (MatchID) JOIN Mannschaft ON HeimmannschaftID = MannschaftID;


SELECT MANNSCHAFT_MATCH.Heimmannschaftid AS Mannschaft, SUM(regexp_substr(tore_stand,'[^/]+',1)) AS TORE FROM MANNSCHAFT_MATCH
JOIN MATCH USING (MatchID)
GROUP BY MANNSCHAFT_MATCH.Heimmannschaftid
ORDER BY MANNSCHAFT_MATCH.Heimmannschaftid;

SELECT MANNSCHAFT_MATCH.GastmannschaftID AS Mannschaft, SUM(regexp_substr(tore_stand,'[^/]+',2)) AS TORE FROM MANNSCHAFT_MATCH
JOIN MATCH USING (MatchID)
GROUP BY MANNSCHAFT_MATCH.GastmannschaftID
ORDER BY MANNSCHAFT_MATCH.GastmannschaftID;

SELECT Mannschaft.Name AS Mannschaft, ((HEIM.tore_stand+GAST.tore_stand)/(HEIM.anz+GAST.anz)) AS TORE_DURCHSCHNITT FROM MANNSCHAFT
JOIN (SELECT MANNSCHAFT_MATCH.Heimmannschaftid AS mID, SUM(regexp_substr(tore_stand,'[^/]+',1)) AS tore_stand, COUNT(tore_stand) as anz 
      FROM MANNSCHAFT_MATCH JOIN MATCH USING (MatchID)GROUP BY MANNSCHAFT_MATCH.Heimmannschaftid) HEIM 
ON Mannschaft.MannschaftID = HEIM.mID
JOIN (SELECT MANNSCHAFT_MATCH.GastmannschaftID AS mID, SUM(regexp_substr(tore_stand,'[^/]+',2)) AS tore_stand, COUNT(tore_stand) as anz 
      FROM MANNSCHAFT_MATCH JOIN MATCH USING (MatchID)GROUP BY MANNSCHAFT_MATCH.GastmannschaftID) GAST 
ON Mannschaft.MannschaftID = GAST.mID
ORDER BY TORE_DURCHSCHNITT DESC, Mannschaft; 
