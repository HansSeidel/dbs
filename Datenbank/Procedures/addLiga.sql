create or replace procedure addLiga(
	v_name Varchar,
	v_begin_d Date,
	v_end_d Date,
	v_altersgruppe Number,
	v_geschlecht Varchar,
	t_matches ownArr)
as
	v_Ligaid Number;
begin
	if t_matches.count < 5 then
		raise_application_error(-20001,'Minimum rows for matches: 5');
	else
  	SELECT max(Liga.ligaid)+1 INTO v_Ligaid FROM Liga;
  
  	INSERT INTO liga(ligaid, datum_begonnen, datum_geendet, name, altersgruppe, geschlechts_gruppe) VALUES (v_Ligaid, v_begin_d,v_end_d,v_name,v_altersgruppe,v_geschlecht);
	
    FOR i IN 1..t_matches.count
    LOOP
      INSERT INTO Match (Matchid,Anschriftid,Ligaid) VALUES (t_matches(i),-1,v_Ligaid);
    END LOOP;
	end if;
end;
/
INSERT INTO Land (Landid) VALUES (-1);
INSERT INTO ORT (PLZ,Landid) VALUES (-1,-1);
INSERT INTO Anschrift (AnschriftID,PLZ) VALUES (-1,-1);

DECLARE
    v_na ownArr;
begin
  v_na := ownArr();
  v_na.EXTEND(5);
  v_na(1) := 110;
  v_na(2) := 111;
  v_na(3) := 112;
  v_na(4) := 113;
  v_na(5) := 114;
  addLiga('test',TO_DATE('05/11/2020','DD-MM-YYYY'),TO_DATE('22/01/2021','DD-MM-YYYY'),15,'M',v_na);
end;
/
SELECT * FROM Liga;
