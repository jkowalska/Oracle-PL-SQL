--1) Zdefiniuj pakiet bez ciała zawierający wartości dwóch stałych 
--fizycznych: prędkość światła w próżni i standardowe przyśpieszenie 
--ziemskie. Przetestuj działanie utworzonego pakietu.
--Wskazówka: prędkość światła w próżni to c = 299 792 458 m/s, 
--standardowe przyśpieszenie ziemskie to g = 9,80665 m/s2.
CREATE OR REPLACE PACKAGE stale_fizyczne IS
  c_predkosc_swiatla CONSTANT NUMBER(9) := 299792458;
  c_standard_przyspiesz CONSTANT NUMBER(6,5) := 9.80665;
END stale_fizyczne;
/
SET SERVEROUTPUT ON

BEGIN
  DBMS_OUTPUT.PUT_LINE('Prędkość światla w próżni: '|| stale_fizyczne.c_predkosc_swiatla);
  DBMS_OUTPUT.PUT_LINE('Przyśpieszenie ziemskie: '|| stale_fizyczne.c_standard_przyspiesz);
END;
----------
--2) a) Utwórz tabelę osoba(id,imie,nazwisko) z kilkoma przykładowymi 
--rekordami. b) Utwórz pakiet o nazwie statystyki i zaimplementuj w nim 
--trzy funkcje: b1) LiczbaOsob – funkcja zwraca liczbę wszystkich osób 
--występujących w tabeli osoba, b2) LiczbaUnikatowychImion – funkcja 
--zwraca liczbę unikatowych imion występujących w tabeli osoba,
--b3) LiczbaUnikatowychNazwisk – funkcja zwraca liczbę unikatowych 
--nazwisk występujących w tabeli osoba, c) Przetestuj działanie funkcji 
--z implementowanego pakietu. 
CREATE TABLE osoba(
  id_osoba NUMBER(8),
  imie VARCHAR2(15),
  nazwisko VARCHAR2(20)
);
INSERT INTO osoba(id_osoba,imie,nazwisko) VALUES(1,'Zofia','Kos');
INSERT INTO osoba(id_osoba,imie,nazwisko) VALUES(2,'Adam','Lis');
INSERT INTO osoba(id_osoba,imie,nazwisko) VALUES(3,'Zofia','Lis');
INSERT INTO osoba(id_osoba,imie,nazwisko) VALUES(4,'Szymon','Mak');
INSERT INTO osoba(id_osoba,imie,nazwisko) VALUES(5,'Filip','Lis');

CREATE OR REPLACE PACKAGE statystyki AS
  FUNCTION LiczbaOsob RETURN NUMBER;
  FUNCTION LiczbaUnikatowychImion RETURN NUMBER;
  FUNCTION LiczbaUnikatowychNazwisk RETURN NUMBER;
END statystyki;
/

CREATE OR REPLACE PACKAGE BODY statystyki AS
  FUNCTION LiczbaOsob RETURN NUMBER AS v_liczba NUMBER;
  BEGIN
    SELECT count(*) INTO v_liczba FROM osoba;
    RETURN v_liczba;
  END LiczbaOsob;

  FUNCTION LiczbaUnikatowychImion RETURN NUMBER AS v_liczba NUMBER;
  BEGIN
    SELECT count(*) INTO v_liczba FROM (SELECT DISTINCT imie FROM osoba) t;
    RETURN v_liczba;
  END LiczbaUnikatowychImion;

  FUNCTION LiczbaUnikatowychNazwisk RETURN NUMBER AS v_liczba NUMBER;
  BEGIN
    SELECT count(*) INTO v_liczba FROM (SELECT DISTINCT nazwisko FROM osoba) t;
    RETURN v_liczba;
  END LiczbaUnikatowychNazwisk;
END statystyki;
/

SET SERVEROUTPUT ON
BEGIN
  DBMS_OUTPUT.PUT_LINE('Liczba osób: '||statystyki.LiczbaOsob);
  DBMS_OUTPUT.PUT_LINE('Unikatowe imiona: '||statystyki.LiczbaUnikatowychImion);
  DBMS_OUTPUT.PUT_LINE('Unikatowe nazwiska: '||statystyki.LiczbaUnikatowychNazwisk);
END;
/
DROP TABLE osoba;
----------
--3) a) Utwórz tabelę produkt(id_produkt,nazwa,cena) i dodaj do niej kilka 
--przykładowych rekordów. b) Utwórz pakiet o nazwie ceny posiadający dwie 
--przeciążone procedury: b1) podwyzka(p_procent INTEGER) – procedura 
--powinna podwyższyć cenę wszystkich produktów w tabeli produkt o zadany 
--procent, b2) podwyzka(p_procent INTEGER, p_id_produkt INTEGER) -
--procedura powinna zwiększyć cenę zadanego produktu w tabeli produkt 
--o zadany procent. c) Przetestuj działanie utworzonego pakietu. 
CREATE TABLE produkt(
  id_produkt INTEGER,
  nazwa VARCHAR2(30),
  cena NUMBER(5,2)
);
INSERT INTO produkt(id_produkt,nazwa,cena) VALUES(1,'Koszula',120.80);
INSERT INTO produkt(id_produkt,nazwa,cena) VALUES(2,'Spodnie',230.50);
INSERT INTO produkt(id_produkt,nazwa,cena) VALUES(3,'Sukienka',160.30);
/
CREATE OR REPLACE PACKAGE ceny IS
  PROCEDURE podwyzka(p_procent INTEGER);
  PROCEDURE podwyzka(p_procent INTEGER, p_id_produkt INTEGER);
END ceny;
/
CREATE OR REPLACE PACKAGE BODY ceny IS
  PROCEDURE podwyzka(p_procent INTEGER) IS
  BEGIN
    UPDATE produkt SET cena = cena * (1 + p_procent/100);
  END podwyzka;

  PROCEDURE podwyzka(p_procent INTEGER, p_id_produkt INTEGER) IS
  BEGIN
    UPDATE produkt SET cena = cena * (1 + p_procent/100) WHERE id_produkt = p_id_produkt;
  END podwyzka;
END ceny;
/
SET SERVEROUTPUT ON
SELECT * FROM produkt;
BEGIN
  ceny.podwyzka(5);
  ceny.podwyzka(3,1);
  ceny.podwyzka(8,2);
  ceny.podwyzka(10,3);
END;
/
SELECT * FROM produkt;
DROP TABLE produkt;
----------
--4) Dana jest specyfikacja pakietu operującego na liczbach zespolonych. Utwórz 
--ciało pakietu dla zadanej specyfikacji: a) Zmienna zespolona zero powinna 
--być zainicjowana wartościami re=0 i im=0, a zmienna zespolona jeden 
--wartościami re=1 i im=1. b) Procedura wypisz powinna wypisywać liczbę 
--zespoloną w formacie: (re,im). c) Funkcje suma i roznica powinny obliczać 
--i zwracać odpowiednio sumę i różnicę dwóch liczb zespolonych. d) Dla kodu 
--testowego powinien zostać zwrócony wynik: (4,5).
CREATE OR REPLACE PACKAGE liczby_zespolone IS
  TYPE t_lzesp IS RECORD (re NUMBER, im NUMBER);
  PROCEDURE wypisz(liczba t_lzesp);
  FUNCTION suma(liczba_1 t_lzesp, liczba_2 t_lzesp) RETURN t_lzesp;
  FUNCTION roznica(liczba_1 t_lzesp, liczba_2 t_lzesp) RETURN t_lzesp;
  v_zero t_lzesp;
  v_jeden t_lzesp;
END liczby_zespolone;
/

CREATE OR REPLACE PACKAGE BODY liczby_zespolone IS
  PROCEDURE wypisz(liczba t_lzesp) IS
  BEGIN
    DBMS_OUTPUT.PUT_LINE(' ( ' || liczba.re || ', ' || liczba.im || ' ) ');
  END;

  FUNCTION suma(liczba_1 t_lzesp, liczba_2 t_lzesp) RETURN t_lzesp IS
    v_liczba t_lzesp;
  BEGIN
    v_liczba.re := liczba_1.re + liczba_2.re;
    v_liczba.im := liczba_1.im + liczba_2.im;
    RETURN v_liczba;
  END;

  FUNCTION roznica(liczba_1 t_lzesp, liczba_2 t_lzesp) RETURN t_lzesp IS
    v_liczba t_lzesp;
  BEGIN
    v_liczba.re := liczba_1.re - liczba_2.re;
    v_liczba.im := liczba_1.im - liczba_2.im;
    RETURN v_liczba;
  END;

BEGIN
  v_zero.re := 0;
  v_zero.im := 0;
  v_jeden.re := 1;
  v_jeden.im := 1;
END liczby_zespolone;
/

SET SERVEROUTPUT ON
DECLARE
  v_wynik1 liczby_zespolone.t_lzesp;
  v_wynik2 liczby_zespolone.t_lzesp;
BEGIN
  v_wynik1.re := 5; 
  v_wynik1.im := 6;
  v_wynik2 := liczby_zespolone.suma(liczby_zespolone.roznica(liczby_zespolone.v_zero,liczby_zespolone.v_jeden), v_wynik1);
  liczby_zespolone.wypisz(v_wynik2);
END;
