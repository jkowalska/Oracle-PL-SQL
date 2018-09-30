--5) a) Napisać funkcję o nazwie czy_piatek_trzynastego(p_data) zwracającą prawdę, 
--gdy zadana przez parametr p_data jest piątkiem trzynastego lub fałsz, gdy nie 
--jest to piątek trzynastego. 

--DROP FUNCTION czy_piatek_trzynastego;
CREATE OR REPLACE FUNCTION czy_piatek_trzynastego(p_data DATE) RETURN BOOLEAN IS
v_piatek VARCHAR(15);
v_number NUMBER(2);

BEGIN
  v_number:=(EXTRACT(DAY FROM p_data));
  SELECT TO_CHAR(p_data, 'DAY') d INTO v_piatek FROM dual;
  
  IF ((v_piatek LIKE 'PI%') AND (v_number = 13)) THEN
    RETURN TRUE;
  ELSE
    RETURN FALSE;
  END IF;    
END;
/

SET SERVEROUTPUT ON;
BEGIN 
  IF(czy_piatek_trzynastego('2010-08-13')) THEN 
    DBMS_OUTPUT.PUT_LINE('Jest to piątek trzynastego');
  ELSE 
    DBMS_OUTPUT.PUT_LINE('Nie jest to piątek trzynastego');
  END IF;
END;
/

--b) Utworzyć tabelę urodziny(id_osoba,imie,nazwisko,data_ur) i dodać 
--do niej kilka rekordów. 

--DROP TABLE urodziny;
CREATE TABLE urodziny(
id_osoba INTEGER,
imie VARCHAR(15),
nazwisko VARCHAR2(20),
data_ur date
);
/
INSERT INTO urodziny(id_osoba,imie,nazwisko,data_ur) VALUES (1,'Anna','Kowalska','1989/01/13');
INSERT INTO urodziny(id_osoba,imie,nazwisko,data_ur) VALUES (2,'Jerzy','Nowak','1991/03/13');
INSERT INTO urodziny(id_osoba,imie,nazwisko,data_ur) VALUES (3,'Adam','Lis','1993/08/13');
INSERT INTO urodziny(id_osoba,imie,nazwisko,data_ur) VALUES (4,'Justyna','Kos','1977/01/22');
INSERT INTO urodziny(id_osoba,imie,nazwisko,data_ur) VALUES (5,'Filip','Kwiatek','1990/10/13');
INSERT INTO urodziny(id_osoba,imie,nazwisko,data_ur) VALUES (6,'Halina','Mak','1984/04/13');
/
select * from urodziny;
/

--c) Użyj funkcji czy_piatek_trzynastego i z tabeli urodziny wypisz wszystkie 
--osoby, które urodziły się w piątek trzynastego.

SET SERVEROUTPUT ON;
DECLARE
v_imie urodziny.imie%TYPE;
v_nazwisko urodziny.nazwisko%TYPE;
v_date urodziny.data_ur%TYPE;
v_licznik PLS_INTEGER := 1;
v_count NUMBER;

BEGIN 
  SELECT COUNT(*) INTO v_count FROM urodziny;
  
  LOOP
    SELECT data_ur,imie,nazwisko INTO v_date,v_imie,v_nazwisko FROM urodziny 
    WHERE v_licznik = id_osoba;
    v_licznik := v_licznik + 1;

    IF(czy_piatek_trzynastego(v_date)) THEN
      DBMS_OUTPUT.PUT_LINE(v_imie||' '||v_nazwisko||': w piątek trzynastego');
    ELSE 
      DBMS_OUTPUT.PUT_LINE(v_imie||' '||v_nazwisko||': NIE w piątek trzynastego');
    END IF; 
    
    EXIT WHEN v_licznik > v_count;
  END LOOP;
END;
/

--d) Napisać procedurę o nazwie wypisz_piatki_trzynastego(p_data_od,p_data_do), 
--która wpisze na ekranie wszystkie piątki trzynastego z zakresu dat <data_od,data_do>. 
--Użyj funkcji czy_piatek_trzynastego. Przetestuj działanie utworzonej procedury. 

CREATE OR REPLACE PROCEDURE wypisz_piatki_trzynastego(p_data_od IN DATE, p_data_do IN DATE) IS
v_data_od DATE;
v_data_do DATE;
BEGIN
v_data_od := p_data_od;
v_data_do := p_data_do;
  LOOP 
    IF (czy_piatek_trzynastego(v_data_od)) THEN 
      DBMS_OUTPUT.PUT_LINE(v_data_od);
    END IF; 
    v_data_od := TO_DATE(v_data_od) + 1;
    EXIT WHEN v_data_od > v_data_do;
  END LOOP;
END;
/
BEGIN
  wypisz_piatki_trzynastego('2000-01-01','2010-01-01');
END;
/
