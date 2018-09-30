--1) Napisać program, który dla i=0,1,2,…,100 wypisze 2^i (2 do potęgi i). 
--Użyj pętli LOOP
SET SERVEROUTPUT ON

DECLARE
v_licznik PLS_INTEGER := 0;
v_potega INTEGER(38) := 0;

BEGIN
  LOOP
    SYS.DBMS_OUTPUT.PUT_LINE('i = ' || v_licznik || ' potęga 2^'||v_licznik||' = ' || v_potega);
    v_potega := POWER(2,v_licznik);
    v_licznik := v_licznik+1;  
    EXIT WHEN v_licznik=101;
  END LOOP;
END;

--2) Napisać program, który dla podanego przez użytkownika n obliczy wartość 
--wyrażenia n!=1*2*3*…*n (liczymy silnię z liczby n). Użyj pętli for.
SET SERVEROUTPUT ON
ACCEPT podaj_n PROMPT 'Podaj n: ';

DECLARE
v_liczba_n NUMBER(2) := &podaj_n;
v_i PLS_INTEGER := 1;
v_wynik INTEGER(38) := 1;

BEGIN
  FOR v_i IN 1..v_liczba_n LOOP
    v_wynik := v_wynik * v_i;
  END LOOP;
  SYS.DBMS_OUTPUT.PUT_LINE(v_liczba_n || '! = ' || v_wynik);
END;

--3) Napisać program wypisujący na ekranie pięć losowych ocen w skali 2-5. 
--Użyj pętli while
SET SERVEROUTPUT ON

DECLARE
v_i PLS_INTEGER := 0;
v_ocena NUMBER(1);

BEGIN
SYS.DBMS_RANDOM.SEED(TO_CHAR(SYSDATE,'MM-DD-YYYY HH24:MI:SS'));
  WHILE v_i < 5 LOOP
    SELECT ROUND(DBMS_RANDOM.VALUE(2, 5)) INTO v_ocena FROM dual;
    SYS.DBMS_OUTPUT.PUT_LINE('i = ' || v_i || ' liczba = ' || v_ocena);
    v_i := v_i + 1;
  END LOOP;
END;

--4) Stwórz tabelę o nazwie nowa z jedną kolumną o nazwie liczba będącą 
--typu VARCHAR2(10), a następnie wpisz do niej za pomocą dowolnej pętli 
--kolejne liczby całkowite od 1 do 113 z pominięciem liczb: 5, 7, 55, 77.
SET SERVEROUTPUT ON
CREATE TABLE nowa(
liczba VARCHAR2(10)
);

DECLARE
v_i PLS_INTEGER := 1;

BEGIN
  WHILE v_i < 114 LOOP
    IF v_i=5 OR v_i=7 OR v_i=55 OR v_i=77 THEN
      GOTO etykieta;
    END IF;
  INSERT INTO nowa(liczba) VALUES(v_i);
  <<etykieta>>
  v_i := v_i+1;
  END LOOP;
END;
/
SELECT * FROM nowa;

--5) Stwórz tabelę nagroda(id_nagroda, nazwa, kwota). Dodaj 1000 rekordów 
--do tabeli nagroda takich, że: id_nagroda to liczby całkowite od 1 do 1000, 
--nazwa to łańcuchy znaków odpowiednio nazwa0001, nazwa0002, ..., nazwa0999, 
--nazwa1000, kwota to wynik wyrażenia (id_nagroda*123 modulo 10000)/3 
--zaokrąglony do dwóch miejsc po przecinku.

SET SERVEROUTPUT ON
CREATE TABLE nagroda(
id_nagroda NUMBER(11) PRIMARY KEY,
nazwa VARCHAR(15),
kwota NUMBER(22,2)
);

DECLARE
v_i PLS_INTEGER := 1;
v_nazwa nagroda.nazwa%TYPE;
v_kwota nagroda.kwota%TYPE;

BEGIN
  WHILE v_i < 1001 LOOP
    v_nazwa := concat('nazwa',to_char(v_i,'fm0000'));
    v_kwota := ROUND(MOD(v_i*123, 10000)/3, 2);
    INSERT INTO nagroda(id_nagroda,nazwa,kwota) VALUES(v_i,v_nazwa,v_kwota);
    v_i := v_i+1;
  END LOOP;
END;
/
select * from nagroda;

--6) Należy wyliczyć kwotę wynagrodzenia i zapisać jej wartość do kolumny kwota 
--w tabeli wyplata. Zakładamy, że dniówka pracownika za pierwszy dzień pracy 
--wynosi 1 grosz, a każda następna dniówka jest dwa razy większa niż dniówka 
--z dnia poprzedniego. Przykładowo po czterech dniach pracy taki pracownik 
--zarobi 1 gr + 2 gr + 4 gr + 8 gr = 15 gr. Dodatkowo przyjmijmy, że
--identyfikatory wypłaty nie posiadają „dziur”.
SET SERVEROUTPUT ON
CREATE TABLE wyplata(
id_wyplata NUMBER(11) PRIMARY KEY,
imie VARCHAR(15),
nazwisko VARCHAR2(20),
ile_dni INT,
kwota NUMBER(22,2)
);
INSERT INTO wyplata(id_wyplata,imie,nazwisko,ile_dni) VALUES(1,'Jan','Kowalski',1);
INSERT INTO wyplata(id_wyplata,imie,nazwisko,ile_dni) VALUES(2,'Jerzy','Nowak',5);
INSERT INTO wyplata(id_wyplata,imie,nazwisko,ile_dni) VALUES(3,'Anna','Mak',7);
INSERT INTO wyplata(id_wyplata,imie,nazwisko,ile_dni) VALUES(4,'Ewa','Hak',11);
INSERT INTO wyplata(id_wyplata,imie,nazwisko,ile_dni) VALUES(5,'Joanna','Blondi',14);
INSERT INTO wyplata(id_wyplata,imie,nazwisko,ile_dni) VALUES(6,'Adam','Mocny',15);
INSERT INTO wyplata(id_wyplata,imie,nazwisko,ile_dni) VALUES(7,'Krzysztof','Gacek',18);
INSERT INTO wyplata(id_wyplata,imie,nazwisko,ile_dni) VALUES(8,'Jolanta','Fajna',21);
INSERT INTO wyplata(id_wyplata,imie,nazwisko,ile_dni) VALUES(9,'Anzelm','Agryf',26);
INSERT INTO wyplata(id_wyplata,imie,nazwisko,ile_dni) VALUES(10,'Wioletta','Markowska',30);

DECLARE
v_i PLS_INTEGER := 1;

BEGIN
  WHILE v_i<=10 LOOP
      UPDATE wyplata SET kwota = ile_dni*(ile_dni+1)/2;
    v_i:=v_i+1;
  END LOOP;
END;
/
select * from wyplata;
