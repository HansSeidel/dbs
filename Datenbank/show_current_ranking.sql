-- VIEW
/**
  Aufgabenstellung: 
  Es wird ein Ranking eines Matches ausgegeben. Es zeigt an, welche Mannschaft im Moment am besten ist und die meisten Punkte hat. 
  Die Punkte werden in dieser View als zusätzliche Spalte ausgegeben und nach den gewonnen Spielen und dem Tore-Stand berechnet.
  Diese View soll so gestaltet sein, dass eine neue Mannschaft einem Verein hinzugefügt werden kann.
**/
SELECT   Mannschaft.MannschaftID, Mannschaft.Name, Mannschaft.VereinID FROM Mannschaft;

CREATE OR REPLACE VIEW show_current_ranking AS
SELECT tmp.liganame AS "Liganame", tmp.Mannschaft AS "Mannschaft",
  COUNT(tmp.ergebniss) AS "Gespielt", 
  COUNT(CASE WHEN tmp.ergebniss = 'W' THEN 1 END) AS "Gewonnen", 
  COUNT(CASE WHEN tmp.ergebniss = 'D' THEN 1 END) AS "Unnentschieden",  
  COUNT(CASE WHEN tmp.ergebniss = 'L' THEN 1 END) AS "Verloren", 
  SUM(CASE WHEN tmp.ergebniss = 'W' THEN 3 WHEN tmp.ergebniss = 'D' THEN 1 WHEN tmp.ergebniss = 'L' THEN 0 ELSE 0 END) AS "Punkte" FROM (
  
          SELECT LIGA.name AS Liganame, (VEREIN.Name||' - '||Mannschaft.Name) AS Mannschaft,
                  CASE 
                    WHEN Mannschaft_Match.Heimmannschaftid = Mannschaft.MannschaftID AND regexp_substr(MATCH.Tore_Stand,'[^/]+',1) > regexp_substr(MATCH.Tore_Stand,'[^/]+',2) THEN 'W'
                    WHEN Mannschaft_Match.Heimmannschaftid = Mannschaft.MannschaftID AND regexp_substr(MATCH.Tore_Stand,'[^/]+',1) = regexp_substr(MATCH.Tore_Stand,'[^/]+',2) THEN 'D'
                    WHEN Mannschaft_Match.Heimmannschaftid = Mannschaft.MannschaftID AND regexp_substr(MATCH.Tore_Stand,'[^/]+',1) < regexp_substr(MATCH.Tore_Stand,'[^/]+',2) THEN 'L'
                 END AS Ergebniss FROM LIGA 
    
          JOIN MATCH USING (LigaID)
          JOIN Mannschaft_Match USING (MatchID)
          JOIN Mannschaft ON Mannschaft_Match.Heimmannschaftid = Mannschaft.MannschaftID
          JOIN VEREIN USING (VereinID)
          UNION
          SELECT LIGA.name AS Liganame, (VEREIN.Name||' - '||Mannschaft.Name) AS Mannschaftname,
                  CASE 
                    WHEN Mannschaft_Match.GastmannschaftID = Mannschaft.MannschaftID AND regexp_substr(MATCH.Tore_Stand,'[^/]+',2) > regexp_substr(MATCH.Tore_Stand,'[^/]+',1) THEN 'W'
                    WHEN Mannschaft_Match.GastmannschaftID = Mannschaft.MannschaftID AND regexp_substr(MATCH.Tore_Stand,'[^/]+',2) = regexp_substr(MATCH.Tore_Stand,'[^/]+',1) THEN 'D'
                    WHEN Mannschaft_Match.GastmannschaftID = Mannschaft.MannschaftID AND regexp_substr(MATCH.Tore_Stand,'[^/]+',2) < regexp_substr(MATCH.Tore_Stand,'[^/]+',1) THEN 'L'
                    ELSE 'U'
                 END AS Ergebniss FROM LIGA 
          JOIN MATCH USING (LigaID)
          JOIN Mannschaft_Match USING (MatchID)
          JOIN Mannschaft ON Mannschaft_Match.GastmannschaftID = MannschaftID
          JOIN VEREIN USING (VereinID)
) tmp
GROUP BY tmp.liganame,tmp.Mannschaft
ORDER BY 1,7 DESC;

SELECT * FROM show_current_ranking;
 
DROP VIEW show_current_ranking;


