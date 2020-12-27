SET SERVEROUTPUT ON;
--type
CREATE OR REPLACE TYPE ownArr AS VARRAY(50) OF NUMBER;
/
-- USAGE:
DECLARE
    v_na ownArr;
BEGIN
  v_na := ownArr();
  v_na.EXTEND(3);
  v_na(1) := 64;
  v_na(2) := 65;
  v_na(3) := 66;
  -- Other possibility to fill:
  -- v_na := (64,65,66);
  FOR i IN 1..v_na.count
  LOOP
    DBMS_OUTPUT.PUT_LINE('Part of v_na:'||v_na(i));
  END LOOP;
END;
/
