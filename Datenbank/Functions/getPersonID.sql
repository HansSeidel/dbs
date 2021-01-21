/*************************************************************
Developer: Lucian-Valentin Caraba
status: abgeschlossen
************************************************************/
select * from schiedsrichter;
select * from spieler;
select * from person;
select * from mitarbeiter;
select * from trainer;



create or replace function getPersonID(i_vorname in varchar2, i_nachname in varchar2)
return Number
is
	v_count_pers Number;
	v_persid Number;
begin
	select count(*) into v_count_pers from person where vorname = i_vorname and nachname = i_nachname;
	if v_count_pers > 1 then
		return -2;
	elsif v_count_pers < 1 then
		return -1;
	else
		select personid into v_persid from person where vorname = i_vorname and nachname = i_nachname;
		return v_persid;
	end if;
end;
/

select getPersonID('Tanek', 'Lucas') from dual;
select getPersonID('Valentin', 'Caraba') from dual;
