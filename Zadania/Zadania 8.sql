--1) Zaimplementuj funkcję o nazwie odleglosc(x1,y1,x2,y2) obliczającą 
--odległość na płaszczyźnie pomiędzy punktami (x1,y1) oraz (x2,y2). 
--Przetestuj działanie zaimplementowanej funkcji.
CREATE OR REPLACE FUNCTION odleglosc(x1 NUMBER,y1 NUMBER,x2 NUMBER,y2 NUMBER) 
RETURN NUMBER IS
v_odleglosc NUMBER(6,4); 
BEGIN
  v_odleglosc := SQRT(POWER(x2-x1,2)+POWER(y2-y1,2)); 
  RETURN v_odleglosc;
END;
/

SET SERVEROUTPUT ON;
BEGIN
  dbms_output.put_line(odleglosc(1,2,4,5));
END;
/
DROP FUNCTION odleglosc;

--2) Utwórz tabelę produkt(id,nazwa,cena) i dodaj przykładowe rekordy.
--Napisz procedurę o nazwie aktualizacja_ceny(p_id_produkt,p_procent), 
--która ma zaktualizować cenę zadanego produktu o podany przez parametr 
--procent. Przetestuj działanie procedury. 
CREATE TABLE produkt(
id_produkt INT,
nazwa VARCHAR2(30),
cena NUMBER(6,2)
);
INSERT INTO produkt VALUES(1,'telewizor',3800);
INSERT INTO produkt VALUES(2,'radio',150);
INSERT INTO produkt VALUES(3,'pralka',1200);
SELECT * FROM produkt;

CREATE OR REPLACE PROCEDURE aktualizacja_ceny(
  v_id_produkt produkt.id_produkt%TYPE, v_procent IN NUMBER) IS 
  
BEGIN
  UPDATE produkt SET cena=cena*(1+v_procent/100) WHERE id_produkt=v_id_produkt;
END;
/

EXECUTE aktualizacja_ceny(1,10);
SELECT * FROM produkt;
/
DROP PROCEDURE aktualizacja_ceny;
DROP TABLE produkt;

--3) Napisz funkcję o nazwie wiek(p_data_ur), która dla podanej przez parametr 
--wartości daty urodzenia obliczy wiek osoby. Przetestuj działanie napisanej funkcji. 
CREATE OR REPLACE FUNCTION wiek(p_data_ur IN DATE) 
RETURN NUMBER IS
v_wiek NUMBER;

BEGIN
  v_wiek := ROUND((SYSDATE - p_data_ur)/365);
  RETURN v_wiek;
END;
/

SET SERVEROUTPUT ON;
BEGIN
  dbms_output.put_line(wiek('1996-05-07'));
END;
/
DROP FUNCTION wiek;

--4) Dana jest tabela: CREATE TABLE l_pierwsze(liczba INT); Napisać 
--procedurę o nazwie wpisz_liczby_pierwsze(p_od,p_do), która wpisze do tabeli
--l_pierwsze wszystkie liczby pierwsze z przedziału <p_od,p_do>.
--Napisać instrukcję testującą działanie utworzonej procedury. 
CREATE TABLE l_pierwsze(liczba INT);

CREATE OR REPLACE PROCEDURE wpisz_liczby_pierwsze(p_od NUMBER,p_do NUMBER) IS
non BOOLEAN;
BEGIN 
  FOR p IN p_od .. p_do LOOP
    non := FALSE;
    FOR f IN 2..FLOOR(SQRT(p)) LOOP
      non := (MOD(p, f) = 0);
      EXIT WHEN non;
    END LOOP;
    IF (NOT non) THEN 
      INSERT INTO l_pierwsze VALUES (p);
    END IF; 
    END LOOP;
END;
/
BEGIN
wpisz_liczby_pierwsze(0, 20);
END;
/
SELECT * FROM l_pierwsze;
DROP PROCEDURE wpisz_liczby_pierwsze;
DROP TABLE l_pierwsze;

--5) a) Napisać funkcję o nazwie czy_piatek_trzynastego(p_data) zwracającą prawdę, 
--gdy zadana przez parametr p_data jest piątkiem trzynastego lub fałsz, gdy nie 
--jest to piątek trzynastego. b) Utworzyć tabelę urodziny(id_osoba,imie,nazwisko,
--data_ur) i dodać do niej kilka rekordów. c) Użyj funkcji czy_piatek_trzynastego
--i z tabeli urodziny wypisz wszystkie osoby, które urodziły się w piątek trzynastego.
--d) Napisać procedurę o nazwie wypisz_piatki_trzynastego(p_data_od,p_data_do), 
--która wpisze na ekranie wszystkie piątki trzynastego z zakresu dat <data_od,data_do>. 
--Użyj funkcji czy_piatek_trzynastego. Przetestuj działanie utworzonej procedury. 
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
--DROP FUNCTION czy_piatek_trzynastego;

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
--DROP TABLE urodziny;

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
