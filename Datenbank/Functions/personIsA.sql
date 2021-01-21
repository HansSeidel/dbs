/*************************************************************
Developer: Lucian-Valentin Caraba
status: abgeschlossen
************************************************************/
select * from schiedsrichter;
select * from spieler;
select * from person;
select * from mitarbeiter;
select * from trainer;


create or replace function personIsA(i_personID in Number)
return Number
is
	v_count_per Number;
	v_count_mit Number;
	v_count_spi Number;
	v_count_tra Number;
	v_count_sch Number;
begin
	select count(*) into v_count_per from person where personID = i_personID;
	select count(*) into v_count_mit from mitarbeiter where personID = i_personID;
	select count(*) into v_count_spi from spieler where personID = i_personID;
	select count(*) into v_count_tra from trainer where personID = i_personID;
	select count(*) into v_count_sch from schiedsrichter where personID = i_personID;
	if v_count_per = 0 then
		return -1;
	elsif v_count_per = 1 then
		if v_count_mit = 0 and v_count_spi = 0 and v_count_tra = 0 and v_count_sch = 0 then
			return 0;
		elsif v_count_mit = 1 then
			return 1;
		elsif v_count_spi = 1 then
			return 2;
		elsif v_count_tra = 1 then
			return 3;
		elsif v_count_sch = 1 then
			return 4;
		end if;
	else
		return -2;
	end if;
end;
/


create or replace function personIsA(i_vorname in varchar2, i_nachname in varchar2)
return Number
is
	v_count_per Number;
	v_count_mit Number;
	v_count_spi Number;
	v_count_tra Number;
	v_count_sch Number;
	v_personID Number;
begin
	v_personID := getPersonID(i_vorname, i_nachname);
	if v_personID = -2 then
		return -2;
	elsif v_personID = -1 then
		return -1;
	else
		select count(*) into v_count_mit from mitarbeiter where personID = v_personID;
		select count(*) into v_count_spi from spieler where personID = v_personID;
		select count(*) into v_count_tra from trainer where personID = v_personID;
		select count(*) into v_count_sch from schiedsrichter where personID = v_personID;
		if v_count_mit = 0 and v_count_spi = 0 and v_count_tra = 0 and v_count_sch = 0 then
			return 0;
		elsif v_count_mit = 1 then
			return 1;
		elsif v_count_spi = 1 then
			return 2;
		elsif v_count_tra = 1 then
			return 3;
		elsif v_count_sch = 1 then
			return 4;
		end if;
	end if;
end;
/


select personIsA(1) from dual;
select personIsA('Armand', 'Olsen') from dual;



select personIsA(631) from dual;
