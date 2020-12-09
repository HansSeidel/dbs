-- VIEW
/**
  Aufgabenstellung: 
  Es wird ein Ranking eines Matches ausgegeben. Es zeigt an, welche Mannschaft im Moment am besten ist und die meisten Punkte hat. 
  Die Punkte werden in dieser View als zusätzliche Spalte ausgegeben und nach den gewonnen Spielen und dem Tore-Stand berechnet.
  Diese View soll so gestaltet sein, dass eine neue Mannschaft einem Verein hinzugefügt werden kann.
**/
SELECT   Mannschaft.MannschaftID, Mannschaft.Name, Mannschaft.VereinID FROM Mannschaft;

SELECT tmp.liganame, (VEREIN.Name||' - '||tmp.Mannschaftname) as Mannschaft, COUNT(tmp.mannschaftId) as gespielt, 
      COUNT(CASE WHEN tmp.ergebniss = 'W' THEN 1 END) as gewonnen, 
      COUNT(CASE WHEN tmp.ergebniss = 'D' THEN 1 END) as unnentschieden,  
      COUNT(CASE WHEN tmp.ergebniss = 'L' THEN 1 END) as verloren, 
      SUM(  CASE 
              WHEN tmp.ergebniss = 'W' THEN 3
              WHEN tmp.ergebniss = 'D' THEN 1
              WHEN tmp.ergebniss = 'L' THEN 0 
              ELSE 0 END) AS Punkte FROM VEREIN
JOIN (
    SELECT LIGA.name AS Liganame, MatchID AS MatchID, Mannschaft.MannschaftID AS MannschaftID, Mannschaft.Name AS Mannschaftname,
            CASE 
              WHEN Mannschaft_Match.Heimmannschaftid = Mannschaft.MannschaftID AND regexp_substr(MATCH.Tore_Stand,'[^/]+',1) > regexp_substr(MATCH.Tore_Stand,'[^/]+',2) THEN 'W'
              WHEN Mannschaft_Match.Heimmannschaftid = Mannschaft.MannschaftID AND regexp_substr(MATCH.Tore_Stand,'[^/]+',1) = regexp_substr(MATCH.Tore_Stand,'[^/]+',2) THEN 'D'
              WHEN Mannschaft_Match.Heimmannschaftid = Mannschaft.MannschaftID AND regexp_substr(MATCH.Tore_Stand,'[^/]+',1) < regexp_substr(MATCH.Tore_Stand,'[^/]+',2) THEN 'L'
           END AS Ergebniss,
           Mannschaft.VereinID AS VereinID FROM LIGA 
    
    JOIN MATCH USING (LigaID)
    JOIN Mannschaft_Match USING (MatchID)
    JOIN Mannschaft ON Mannschaft_Match.Heimmannschaftid = Mannschaft.MannschaftID
    UNION
    SELECT LIGA.name AS Liganame, MatchID AS MatchID, Mannschaft.MannschaftID AS MannschaftID, Mannschaft.Name AS Mannschaftname,
            CASE 
              WHEN Mannschaft_Match.GastmannschaftID = Mannschaft.MannschaftID AND regexp_substr(MATCH.Tore_Stand,'[^/]+',2) > regexp_substr(MATCH.Tore_Stand,'[^/]+',1) THEN 'W'
              WHEN Mannschaft_Match.GastmannschaftID = Mannschaft.MannschaftID AND regexp_substr(MATCH.Tore_Stand,'[^/]+',2) = regexp_substr(MATCH.Tore_Stand,'[^/]+',1) THEN 'D'
              WHEN Mannschaft_Match.GastmannschaftID = Mannschaft.MannschaftID AND regexp_substr(MATCH.Tore_Stand,'[^/]+',2) < regexp_substr(MATCH.Tore_Stand,'[^/]+',1) THEN 'L'
              ELSE 'U'
           END AS Ergebniss,
           Mannschaft.VereinID AS VereinID FROM LIGA 
      
    JOIN MATCH USING (LigaID)
    JOIN Mannschaft_Match USING (MatchID)
    JOIN Mannschaft ON Mannschaft_Match.GastmannschaftID = MannschaftID) tmp USING (VereinID)
GROUP BY 1,2
ORDER BY 1,7;

SELECT LIGA.name AS Liganame, MatchID AS MatchID, Mannschaft.MannschaftID AS MannschaftID, Mannschaft.Name AS Mannschaftname,
        CASE 
          WHEN Mannschaft_Match.Heimmannschaftid = Mannschaft.MannschaftID AND regexp_substr(MATCH.Tore_Stand,'[^/]+',1) > regexp_substr(MATCH.Tore_Stand,'[^/]+',2) THEN 'W'
          WHEN Mannschaft_Match.Heimmannschaftid = Mannschaft.MannschaftID AND regexp_substr(MATCH.Tore_Stand,'[^/]+',1) = regexp_substr(MATCH.Tore_Stand,'[^/]+',2) THEN 'D'
          WHEN Mannschaft_Match.Heimmannschaftid = Mannschaft.MannschaftID AND regexp_substr(MATCH.Tore_Stand,'[^/]+',1) < regexp_substr(MATCH.Tore_Stand,'[^/]+',2) THEN 'L'
       END AS Ergebniss,
       Mannschaft.VereinID AS VereinID FROM LIGA 
    
JOIN MATCH USING (LigaID)
JOIN Mannschaft_Match USING (MatchID)
JOIN Mannschaft ON Mannschaft_Match.Heimmannschaftid = Mannschaft.MannschaftID


UNION


SELECT LIGA.name AS Liganame, MatchID AS MatchID, Mannschaft.MannschaftID AS MannschaftID, Mannschaft.Name AS Mannschaftname,
        CASE 
          WHEN Mannschaft_Match.GastmannschaftID = Mannschaft.MannschaftID AND regexp_substr(MATCH.Tore_Stand,'[^/]+',2) > regexp_substr(MATCH.Tore_Stand,'[^/]+',1) THEN 'W'
          WHEN Mannschaft_Match.GastmannschaftID = Mannschaft.MannschaftID AND regexp_substr(MATCH.Tore_Stand,'[^/]+',2) = regexp_substr(MATCH.Tore_Stand,'[^/]+',1) THEN 'D'
          WHEN Mannschaft_Match.GastmannschaftID = Mannschaft.MannschaftID AND regexp_substr(MATCH.Tore_Stand,'[^/]+',2) < regexp_substr(MATCH.Tore_Stand,'[^/]+',1) THEN 'L'
          ELSE 'U'
       END AS Ergebniss,
       Mannschaft.VereinID AS VereinID FROM LIGA 
      
JOIN MATCH USING (LigaID)
JOIN Mannschaft_Match USING (MatchID)
JOIN Mannschaft ON Mannschaft_Match.GastmannschaftID = MannschaftID;

SELECT LIGA.Name, LigaID, MatchID, MATCH.Tore_Stand, 'HEIM' AS SPIELT_ALS,
        CASE 
          WHEN Mannschaft_Match.Heimmannschaftid = Mannschaft.MannschaftID AND regexp_substr(MATCH.Tore_Stand,'[^/]+',1) > regexp_substr(MATCH.Tore_Stand,'[^/]+',2) THEN 'W'
          WHEN Mannschaft_Match.Heimmannschaftid = Mannschaft.MannschaftID AND regexp_substr(MATCH.Tore_Stand,'[^/]+',1) = regexp_substr(MATCH.Tore_Stand,'[^/]+',2) THEN 'D'
          WHEN Mannschaft_Match.Heimmannschaftid = Mannschaft.MannschaftID AND regexp_substr(MATCH.Tore_Stand,'[^/]+',1) < regexp_substr(MATCH.Tore_Stand,'[^/]+',2) THEN 'L'
       END AS ergebniss,
      Mannschaft.MannschaftID, Mannschaft.Name, Mannschaft.VereinID FROM LIGA 
    
JOIN MATCH USING (LigaID)
JOIN Mannschaft_Match USING (MatchID)
JOIN Mannschaft ON Mannschaft_Match.Heimmannschaftid = Mannschaft.MannschaftID


UNION


SELECT LIGA.Name, LigaID, MatchID, MATCH.Tore_Stand, 'GAST' AS SPIELT_ALS,
        CASE 
          WHEN Mannschaft_Match.GastmannschaftID = Mannschaft.MannschaftID AND regexp_substr(MATCH.Tore_Stand,'[^/]+',2) > regexp_substr(MATCH.Tore_Stand,'[^/]+',1) THEN 'W'
          WHEN Mannschaft_Match.GastmannschaftID = Mannschaft.MannschaftID AND regexp_substr(MATCH.Tore_Stand,'[^/]+',2) = regexp_substr(MATCH.Tore_Stand,'[^/]+',1) THEN 'D'
          WHEN Mannschaft_Match.GastmannschaftID = Mannschaft.MannschaftID AND regexp_substr(MATCH.Tore_Stand,'[^/]+',2) < regexp_substr(MATCH.Tore_Stand,'[^/]+',1) THEN 'L'
          ELSE 'U'
       END AS ergebniss,
      Mannschaft.MannschaftID, Mannschaft.Name, Mannschaft.VereinID FROM LIGA
      
JOIN MATCH USING (LigaID)
JOIN Mannschaft_Match USING (MatchID)
JOIN Mannschaft ON Mannschaft_Match.GastmannschaftID = MannschaftID
ORDER BY 1;


/*
SELECT LIGA.Name, LigaID, MatchID, MATCH.Tore_Stand,
        CASE 
          WHEN regexp_substr(MATCH.Tore_Stand,'[^/]+',1) > regexp_substr(MATCH.Tore_Stand,'[^/]+',2) THEN 'W'
          WHEN regexp_substr(MATCH.Tore_Stand,'[^/]+',1) = regexp_substr(MATCH.Tore_Stand,'[^/]+',2) THEN 'D'
          WHEN regexp_substr(MATCH.Tore_Stand,'[^/]+',1) < regexp_substr(MATCH.Tore_Stand,'[^/]+',2) THEN 'L'
          ELSE 'U'
       END AS ergebniss,
      Mannschaft.MannschaftID, Mannschaft.Name, Mannschaft.VereinID FROM LIGA 
      
JOIN MATCH USING (LigaID)
JOIN Mannschaft_Match USING (MatchID)
JOIN Mannschaft ON Mannschaft_Match.Heimmannschaftid = Mannschaft.MannschaftID;
*/


 
DROP VIEW show_current_ranking;
CREATE OR REPLACE VIEW show_current_ranking AS

