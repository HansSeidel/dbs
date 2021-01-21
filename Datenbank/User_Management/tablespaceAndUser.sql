create tablespace fussballverein
            datafile '/usr/lib/oracle/xe/oradata/XE/fussballverein.dbf' 
            size 10M
            autoextend on;
         
create user admin identified by pw20fv;

alter user admin default tablespace fussballverein;

grant connect, resource, create view, create synonym, create trigger to admin;

alter user admin quota unlimited on fussballverein;

