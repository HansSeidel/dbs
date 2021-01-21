CREATE VIEW show_matches 
	AS SELECT match.matchid as "MatchID", match.datum as "Date", liga.name as "Liga"
FROM match JOIN liga ON match.ligaID = liga.ligaID ORDER BY liga.name;

select * from show_matches;

SELECT * FROM Match;
drop view show_matches;
