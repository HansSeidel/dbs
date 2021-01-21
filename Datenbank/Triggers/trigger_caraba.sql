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

create table trigger_log (
		log_id number primary key,
		username varchar(255),
		action varchar(1),
		zeit timestamp
);

create sequence seq_id;

create or replace procedure write_trigger_log(
	i_username varchar,
	i_action varchar)
as
  PRAGMA AUTONOMOUS_TRANSACTION;
  v_zeit timestamp;
  v_seq_id number;
 begin
 	select systimestamp into v_zeit from dual;
 	select seq_id.nextval into v_seq_id from dual;
 	
  insert into trigger_log values(v_seq_id, i_username, i_action, v_zeit);
  commit;
end;
/

create or replace trigger trigger_caraba_person
before insert or update or delete on person
for each row
begin
	if INSERTING then
		write_trigger_log('caraba', 'I');
	end if;
	if UPDATING then
		write_trigger_log('caraba', 'U');
	end if;
	if DELETING then
		write_trigger_log('caraba', 'D');
	end if;
end;
/


select * from trigger_log;
rollback;
drop table trigger_log;
drop trigger trigger_caraba_person;

insert into person values(800, 1, 'Dean', 'Henderson',date '1987-11-11', 'M');
