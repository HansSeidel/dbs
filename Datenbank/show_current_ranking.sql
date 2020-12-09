-- VIEW
/**
  Aufgabenstellung: 
  Es wird ein Ranking eines Matches ausgegeben. Es zeigt an, welche Mannschaft im Moment am besten ist und die meisten Punkte hat. 
  Die Punkte werden in dieser View als zusätzliche Spalte ausgegeben und nach den gewonnen Spielen und dem Tore-Stand berechnet.
  Diese View soll so gestaltet sein, dass eine neue Mannschaft einem Verein hinzugefügt werden kann.
**/

CREATE OR REPLACE VIEW show_current_ranking AS
SELECT VereinID, Verein.Name, Mannschaft.Name,
