--Stworzenie tabeli pracownicy
CREATE TABLE pracownicy(
id_pracownik NUMBER(11),
imie VARCHAR(15),
nazwisko VARCHAR2(20),
plec CHAR(1),
data_urodzenia DATE,
data_zatrudnienia DATE,
stanowisko VARCHAR2(20),
pensja NUMBER(22,2),
dodatek NUMBER(22,2)
);

INSERT INTO pracownicy VALUES (1,'Anna','Kowalska','K','1975-01-20','2001-03-01',
'dyrektor',2300,500);
INSERT INTO pracownicy VALUES (2,'Jerzy','Nowak','M','1970-02-21','2001-04-01',
'kierownik',1800,300);
INSERT INTO pracownicy VALUES (3,'Adam','Lis','K','1973-03-22','2002-05-01',
'księgowy',1800,400);
INSERT INTO pracownicy VALUES (4,'Justyna','Kos','K','1978-04-23','2002-06-01',
'brygadzista',1800,300);
INSERT INTO pracownicy VALUES (5,'Filip','Kwiatek','K','1972-05-24','2003-07-01',
'kierownik',2200,600);
INSERT INTO pracownicy VALUES (6,'Szymon','Dąb','K','1977-06-25','2003-08-01',
'specjalista',2200,500);
INSERT INTO pracownicy VALUES (7,'Halina','Mak','K','1979-07-26','2004-09-01',
'kierownik',2200,600);
INSERT INTO pracownicy VALUES (8,'Maria','Baran','K','1974-08-27','2004-10-01',
'księgowy',2000,200);
INSERT INTO pracownicy VALUES (9,'Zofia','Kot','K','1978-09-28','2005-11-01',
'kierownik',2000,300);
INSERT INTO pracownicy VALUES (10,'Marcin','Liść','K','1977-10-29','2005-12-01',
'specjalista',2100,200);

--Zadanie 1
SET SERVEROUTPUT ON

DECLARE
v_rekord pracownicy%rowtype;
v_i PLS_INTEGER := 0;
CURSOR cur_pracownik IS SELECT * FROM pracownicy ORDER BY nazwisko,imie ASC;

BEGIN
OPEN cur_pracownik;

  LOOP 
  FETCH cur_pracownik INTO v_rekord;  
  IF (v_i MOD 2 = 0) THEN
    DELETE FROM pracownicy WHERE id_pracownik=v_i;
  END IF;
  v_i:=v_i+1;
  EXIT WHEN cur_pracownik%NOTFOUND;
  END LOOP;

CLOSE cur_pracownik;
END;
/
SELECT * FROM pracownicy;

--Zadanie 2
SET SERVEROUTPUT ON

DECLARE
CURSOR cur_pracownik IS SELECT * FROM pracownicy WHERE stanowisko='kierownik';
v_rekord pracownicy%rowtype;

BEGIN
OPEN cur_pracownik;
FETCH cur_pracownik INTO v_rekord;

  WHILE cur_pracownik%FOUND LOOP
  SYS.DBMS_OUTPUT.PUT_LINE('pracownik '||v_rekord.imie||' '||v_rekord.nazwisko||' pracuje na stanowisku kierownika od '||v_rekord.data_zatrudnienia);
  FETCH cur_pracownik INTO v_rekord;
  END LOOP;

CLOSE cur_pracownik;
END;
/

--Zadanie 3
SET SERVEROUTPUT ON

DECLARE
CURSOR cur_zarobki IS SELECT * FROM pracownicy ORDER BY pensja DESC;
v_rekord pracownicy%rowtype;
v_i PLS_INTEGER := 0;
v_ilosc NUMBER(3);

BEGIN
OPEN cur_zarobki;
FETCH cur_zarobki INTO v_rekord;
SELECT COUNT(*) INTO v_ilosc FROM pracownicy WHERE rownum <= 3 ORDER BY pensja DESC;

  FOR v_i IN 0..v_ilosc LOOP
  SYS.DBMS_OUTPUT.PUT_LINE('pracownik '||v_rekord.imie||' '||v_rekord.nazwisko||' pensja '||v_rekord.pensja);
  FETCH cur_zarobki INTO v_rekord;
  END LOOP;

CLOSE cur_zarobki;
END;
/

--Zadanie 4
SET SERVEROUTPUT ON
ACCEPT nazwa_stanowiska PROMPT 'Podaj nazwę stanowiska: ';

DECLARE
v_stanowisko pracownicy.stanowisko%TYPE:='&nazwa_stanowiska';
v_rekord pracownicy%rowtype;
v_licznik NUMBER(3);
v_i PLS_INTEGER := 0;
CURSOR cur_stanowisko IS SELECT * FROM pracownicy WHERE v_stanowisko=stanowisko ORDER BY nazwisko,imie ASC;

BEGIN
SELECT COUNT(*) INTO v_licznik FROM pracownicy;
OPEN cur_stanowisko;

  FOR v_i IN 1..v_licznik LOOP 
  EXIT WHEN cur_stanowisko%NOTFOUND;
  FETCH cur_stanowisko INTO v_rekord; 
  SYS.dbms_output.put_line(v_rekord.imie||' '||v_rekord.nazwisko||' '||v_rekord.stanowisko); 
  END LOOP;

CLOSE cur_stanowisko;
END;
/

--Zadanie 5

--Zadanie 6

--Zadanie 7