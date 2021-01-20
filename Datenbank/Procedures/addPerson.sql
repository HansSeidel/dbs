/*************************************************************
Developer: Lucian-Valentin Caraba
status: abgeschlossen
************************************************************/
select * from schiedsrichter;
select * from spieler;
select * from person;
select * from mitarbeiter;
select * from trainer;

set serveroutput on;
/

create or replace procedure addPerson(
	i_vorname Varchar2,
	i_nachname Varchar2,
	i_geburtsdatum Date,
	i_geschlecht Varchar2,
	i_eintrittsdatum Date default null,
	i_isA Number,
	i_funktionStatus Varchar2 default 'n/a',
	i_VereinMannschaftID Number default 0)
as
	v_max Number;
	v_zeit timestamp;
	v_persID Number;
begin
	if i_eintrittsdatum is null then
		select systimestamp into v_zeit from dual;
	end if;
	
	select max(personid) into v_max from person;
	v_persID := v_max + 1;
	
	if i_isA = 1 then
		insert into person(personid, vorname, nachname, geburtsdatum, geschlecht) values(v_persID, i_vorname, i_nachname, i_geburtsdatum, i_geschlecht);
		insert into mitarbeiter(personid, vereinid, funktion, eintrittsdatum) values(v_persID, i_VereinMannschaftID, i_funktionStatus, i_eintrittsdatum);
	elsif i_isA = 2 then
		insert into person(personid, vorname, nachname, geburtsdatum, geschlecht) values(v_persID, i_vorname, i_nachname, i_geburtsdatum, i_geschlecht);
		insert into spieler(personid, mannschaftid, status, eintrittsdatum) values (v_persID, i_VereinMannschaftID, 'NOTKA', i_eintrittsdatum);
	elsif i_isA = 3 then
		insert into person(personid, vorname, nachname, geburtsdatum, geschlecht) values(v_persID, i_vorname, i_nachname, i_geburtsdatum, i_geschlecht);
		insert into trainer(personid, eintrittsdatum) values(v_persID, i_eintrittsdatum);
	elsif i_isA = 4 then
		insert into person(personid, vorname, nachname, geburtsdatum, geschlecht) values(v_persID, i_vorname, i_nachname, i_geburtsdatum, i_geschlecht);
		insert into schiedsrichter(personid, eintrittsdatum) values(v_persID, i_eintrittsdatum);
	end if;
end;
/

exec addPerson('Lucian', 'Caraba', date '1992-10-12', 'M', date '2014-01-02', 1, 'Putzfrau', 2);
exec addPerson('Sarah', 'Ettl', date '1992-05-11', 'F', date '2017-11-03', 4);
