CREATE USER admin
    IDENTIFIED BY ganz_geheim
    DEFAULT TABLESPACE data_ts
    QUOTA 100M ON test_ts
    QUOTA 500K ON data_ts
    TEMPORARY TABLESPACE temp_ts
    PROFILE admin;
    
GRANT CONNECT TO admin;
GRANT CREATE SESSION TO admin;
GRANT CREATE TABLE TO admin;
GRANT CREATE PROCEDURE TO admin;
GRANT CREATE TRIGGER TO admin;
GRANT CREATE VIEW TO admin;
GRANT CREATE SEQUENCE TO admin;

GRANT ALTER ANY TABLE TO admin;
GRANT ALTER ANY PROCEDURE TO admin;
GRANT ALTER ANY TRIGGER TO admin;

GRANT DELETE ANY TABLE TO admin;

GRANT DROP ANY TABLE TO admin;
GRANT DROP ANY PROCEDURE TO admin;
GRANT DROP ANY TRIGGER TO admin;
GRANT DROP ANY VIEW TO admin;
