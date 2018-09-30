--Kolekcje w Oracle
--a) 2 zadania na użycie tablic asocjacyjnych

--Wyświetl nazwy następujących potraw: Polędwiczki wieprzowe w cieście francuskim,
--Sałatka włoska z makaronem, Tagiatelle z cukini z mięsem mielonym, Marynowana 
--pieczeń wołowa z sosem duński z tablicy asocjacyjnej typu VARCHAR2
SET SERVEROUTPUT ON
DECLARE
  TYPE t_potrawy IS TABLE OF VARCHAR2(80) INDEX BY VARCHAR2(15);
  v_potrawy t_potrawy;
  v_czas t_czas;
  v_indeks VARCHAR2(15);
BEGIN
  v_potrawy('potrawa_1'):='Polędwiczki wieprzowe w cieście francuskim';
  v_potrawy('potrawa_2'):='Sałatka włoska z makaronem';
  v_potrawy('potrawa_3'):='Tagiatelle z cukini z mięsem mielonym';  
  v_potrawy('potrawa_4'):='Marynowana pieczeń wołowa z sosem duńskim';
    
  FOR v_i IN 1..v_potrawy.COUNT LOOP
    IF v_i=1 THEN v_indeks:=v_potrawy.FIRST; 
      ELSE v_indeks:=v_potrawy.NEXT(v_indeks); 
    END IF;
      DBMS_OUTPUT.PUT_LINE(v_potrawy(v_indeks));
  END LOOP;  
END;
/

--Stwórz tabelę deser z kolumnami nazwa i cena. Dodaj do niej kilka 
--przykładowych rekordów. Korzystając z tablic asocjacyjnych 
--z rekordami wypisz na ekranie nazwy deserów wraz z cenami oraz
--liczbę dostępnych w tabeli deserów.
CREATE TABLE deser(
  id_deser NUMERIC,
  nazwa VARCHAR(20),
  cena NUMBER(4,2)
);
/
INSERT INTO deser(id_deser,nazwa,cena) VALUES(1,'tort piernikowy',8.50);
INSERT INTO deser(id_deser,nazwa,cena) VALUES(2,'babka jogurtowa',7);
INSERT INTO deser(id_deser,nazwa,cena) VALUES(3,'jabecznik',7.75);
INSERT INTO deser(id_deser,nazwa,cena) VALUES(4,'ciasteczka owsiane',6.50);
INSERT INTO deser(id_deser,nazwa,cena) VALUES(5,'makowiec',6.90);
/
SET SERVEROUTPUT ON
DECLARE
  TYPE t_desery IS TABLE OF deser%ROWTYPE INDEX BY PLS_INTEGER;
  v_desery t_desery;
BEGIN
  FOR v_i IN 1..5 LOOP
    SELECT * INTO v_desery(v_i) FROM deser WHERE id_deser = v_i;
  END LOOP;

  FOR v_i IN v_desery.FIRST..v_desery.LAST LOOP
    DBMS_OUTPUT.PUT_LINE(v_desery(v_i).nazwa || ', cena: ' ||v_desery(v_i).cena||' zl');
  END LOOP;

  DBMS_OUTPUT.PUT_LINE('Liczba dostępnych deserów: '||v_desery.COUNT);  
END;
/
DROP TABLE deser;

--b) 2 zadania na użycie tablic VARRAY

--Stwórz tabelę deser(id_deser,nazwa,cena,rabaty), gdzie rabaty jest typem
--kolumny VARRAY. Dodaj do niej kilka przykładowych rekordów. Posłóż się
--kursorem pobierz_rabaty(v_id INTEGER) do pobrania rekordów. Zmodyfikuj 
--tablicę rabaty dla wybranych deserów
CREATE OR REPLACE TYPE t_rabaty AS VARRAY(2) OF INTEGER;
/
DROP TABLE deser;
CREATE TABLE deser(
  id_deser NUMBER(3),
  nazwa VARCHAR(20),
  cena NUMBER(4,2),
  rabaty t_rabaty
);
/
INSERT INTO deser VALUES(1,'tort piernikowy',8.50,t_rabaty(10,15));
INSERT INTO deser VALUES(2,'babka jogurtowa',7,t_rabaty(5,10));
INSERT INTO deser VALUES(3,'jabecznik',7.75,t_rabaty(5,10));
INSERT INTO deser VALUES(4,'ciasteczka owsiane',6.50,t_rabaty(5,10));
INSERT INTO deser VALUES(5,'makowiec',6.90,t_rabaty(10,15));
/

SET SERVEROUTPUT ON

SELECT rabaty FROM deser;
DECLARE
  TYPE t_deser IS RECORD (
    id_deser NUMBER(3), 
    nazwa VARCHAR(20), 
    cena NUMBER(4,2), 
    rabaty t_rabaty);
    
  v_deser t_deser;  
  CURSOR pobierz_rabaty(v_id INTEGER) IS SELECT * FROM deser WHERE id_deser = v_id;

BEGIN
  OPEN pobierz_rabaty(1);
  FETCH pobierz_rabaty INTO v_deser;
  CLOSE pobierz_rabaty;

  v_deser.rabaty(2):=20;
  UPDATE deser SET rabaty=v_deser.rabaty WHERE id_deser=1;
  v_deser.rabaty(1):=30;
  v_deser.rabaty(2):=40;
  UPDATE deser SET rabaty=v_deser.rabaty WHERE id_deser=3;
  v_deser.rabaty(1):=5;
  UPDATE deser SET rabaty=v_deser.rabaty WHERE id_deser=5;
END;
/
SELECT rabaty FROM deser;

--Stwórz tabelę klient(id_klient,imie,nazwisko) i dodaj do niej kilka 
--przykładowych rekordów. Posłóż się kursorem do pobrania imion i nazwisk
--klintów. Stwórz tablicę typu VARRAY z danymi klientów. Wypisz wszystkich
--klientów z tablicy.
CREATE TABLE klient(
  id_klient INTEGER PRIMARY KEY,
  imie VARCHAR(20),
  nazwisko VARCHAR(20)
);
/
INSERT INTO klient VALUES(1,'Anna','Nowak');
INSERT INTO klient VALUES(2,'Halina','Lis');
INSERT INTO klient VALUES(3,'Jerzy','Kos');
INSERT INTO klient VALUES(4,'Antoni','Sikora');
INSERT INTO klient VALUES(5,'Beata','Niebo');
/
SET SERVEROUTPUT ON

DECLARE
CURSOR cur_klienci IS SELECT * FROM klient ORDER BY nazwisko,imie;
TYPE t_klienci IS VARRAY(100) OF klient%ROWTYPE;
v_klienci t_klienci;
indeks_1 PLS_INTEGER;
indeks_2 PLS_INTEGER;

BEGIN
  indeks_1 := 0;
  v_klienci := t_klienci();

  FOR klienci IN cur_klienci LOOP
    indeks_1 := indeks_1 + 1;
    v_klienci.EXTEND();
    v_klienci(indeks_1).imie := klienci.imie;
    v_klienci(indeks_1).nazwisko := klienci.nazwisko;
  END LOOP;

  FOR indeks_2 IN 1..v_klienci.COUNT LOOP
    DBMS_OUTPUT.PUT_LINE (v_klienci(indeks_2).imie ||' ' || v_klienci(indeks_2).nazwisko);
  END LOOP;
END;
/
DROP TABLE klient;

--c) 2 zadania na użycie tablic zagnieżdżonych.

--Stwórz tabelę klient(id_klient,imie,nazwisko,zamowienia), gdzie zamowienia 
--jest tablicą zagnieżdżoną. Dodaj do niej przykładowe rekordy. Wypisz
--wszystkie zamówienia klientów oraz obecne zamówienie klienta 1. Zmień 
--zamówienie klienta 1. Dodatkowo w sekcji wykonawczej dodaj jeszcze jeden 
--przedmiot do zmówienia klienta 3. Wypisz wszystkie zamówienia klientów.
CREATE OR REPLACE TYPE t_zamowienia AS TABLE OF VARCHAR2(15);
/
CREATE TABLE klient(
  id_klient INTEGER PRIMARY KEY,
  imie VARCHAR(20),
  nazwisko VARCHAR(20),
  zamowienia t_zamowienia)

NESTED TABLE zamowienia
STORE AS zamowienia_tab;

/
INSERT INTO klient VALUES(1,'Anna','Nowak',t_zamowienia('pralka','sokowirówka'));
INSERT INTO klient VALUES(2,'Halina','Lis',t_zamowienia('radio','telewizor','pralka'));
INSERT INTO klient VALUES(3,'Jerzy','Kos',t_zamowienia('lodówka','radio'));
INSERT INTO klient VALUES(4,'Antoni','Sikora',t_zamowienia('telewizor','mikser','lampa'));
INSERT INTO klient VALUES(5,'Beata','Niebo',t_zamowienia('lodówka','pralka','budzik'));
/
SELECT zamowienia FROM klient;
/
SELECT column_value AS zamowienie_1 FROM
THE (SELECT zamowienia FROM klient WHERE id_klient=1);
/
UPDATE klient
SET zamowienia=t_zamowienia('budzik','lodówka','radio')
WHERE id_klient=1;
/

SET SERVEROUTPUT ON
DECLARE
    v_zamowienia t_zamowienia := t_zamowienia();
BEGIN
    SELECT zamowienia INTO v_zamowienia FROM klient WHERE id_klient=3;
    v_zamowienia.EXTEND;
    v_zamowienia(v_zamowienia.COUNT):='telewizor';
    UPDATE klient SET zamowienia=v_zamowienia WHERE id_klient=3;
END;
/
SELECT * FROM klient;
/
DROP TABLE klient;

--Stwórz tabelę rodzina(nazwisko,imiona_rodzicow,imiona_dzieci), gdzie 
--imiona_rodzicow i imiona_dzieci to tablice zagnieżdżone. Wpisz do obu
--tablic imiona rodziców i dzieci. Wpisz do tablicy rodzina wszystkie 
--imiona oraz nazwisko rodziny.
CREATE OR REPLACE TYPE t_imiona_rodzicow IS TABLE OF VARCHAR2(30);
/
CREATE OR REPLACE TYPE t_imiona_dzieci IS TABLE OF VARCHAR2(30);
/
CREATE TABLE rodzina(
nazwisko VARCHAR2(30),
imiona_rodzicow t_imiona_rodzicow,
imiona_dzieci t_imiona_dzieci)
NESTED TABLE imiona_rodzicow STORE AS imiona_rodzicow_tab
NESTED TABLE imiona_dzieci STORE AS imiona_dzieci_tab
/
SET SERVEROUTPUT ON
DECLARE
  rodzice t_imiona_rodzicow := t_imiona_rodzicow('Wanda','Wincenty');
  dzieci t_imiona_dzieci := t_imiona_dzieci('Aniela','Antek');  
BEGIN
  INSERT INTO rodzina(nazwisko,imiona_rodzicow,imiona_dzieci) VALUES('Nowak',rodzice,dzieci);
END;
/
SELECT * FROM rodzina;
DROP TYPE t_imiona_rodzicow FORCE;
DROP TYPE t_imiona_dzieci FORCE;
DROP TABLE rodzina;
----------
--Odpowiedz na pytanie: Kiedy warto używać poszczególne rodzaje tablic?
----TABLICE ASOCJACYJNE
--Można w nich trzymać kolekcje pojedynczych atrybutów. Indeksuje się je 
--liczbami lub łańcuchami znaków. Można np. sprawdzić liczbę elementów 
--aktualnie zapisanych w tablicy, sprawdzić ich istnienie oraz wypisać 
--pierwszy i ostatni element kolekcji. Rozmiar tablicy jest dynamiczny.
--Nadają się do małych tabel, których rozmiar nie jest wcześniej znany.
----TABLICE VARRAY
--Mają stały rozmiar. Gwarantują, że elementy zostaną wydobyte w tej samej
--kolejności, w której zostały do niej włożone. Najlepiej używać ich gdy
--znamy wcześniej rozmiar tablicy i chcemy aby elementy były dostępne 
--w określonej kolejności.
----TABLICE ZAGNIEŻDŻONE
--Można w nich trzymać więcej niż jedno wystąpienie czegoś (np. rekord
--z bazy danych). Można poruszać się w pętli w przód, w tył, przejść 
--na początek lub na koniec tablicy. Można w nich również przechowywać
--typy zadeklarowane przez użytkownika. Można używać ich gdy wartości 
--indeksów nie są kolejnymi liczbami lub chcemy mieć możliwość modywikowania
--lub usuwania pojedynczych elementów.
