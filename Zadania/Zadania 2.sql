/* 1) Zadeklaruj zmienn� powi�zan� o nazwie v_wynik.
Utw�rz etykiet� dla bloku zewn�trznego o nazwie etykieta_zewnetrzna oraz zadeklaruj zmienn� o
nazwie v_liczba. Nast�pnie dla bloku wewn�trznego zadeklaruj zmienn� o identycznej nazwie
v_liczba. (Mamy dwie zmienne o nazwie v_liczba � w bloku zewn�trznym i wewn�trznym.)
Wykonaj mno�enie obu zmiennych v_liczba w bloku wewn�trznym z przypisaniem wyniku do
zmiennej powi�zanej v_wynik. Zako�cz dzia�anie bloku anonimowego. Wy�wietl na ekranie
warto�� zmiennej v_wynik. Warto�ci obu zmiennych v_liczba pobierz od u�ytkownika. */
SET SERVEROUTPUT ON

ACCEPT podaj_liczbe1 PROMPT 'Podaj warto�� pierwszej liczby: ';
ACCEPT podaj_liczbe2 PROMPT 'Podaj warto�� drugiej liczby: ';
VARIABLE v_wynik NUMBER;
<<l_etykieta_zewnetrzna>>

DECLARE
v_liczba NUMBER(3) := &podaj_liczbe1;

BEGIN

  DECLARE
   v_liczba NUMBER(3) := &podaj_liczbe2;
   BEGIN
    :v_wynik := (l_etykieta_zewnetrzna.v_liczba) * v_liczba;
   END;
  
END;
/
PRINT :v_wynik;

/* 2) Dana jest tabela z przyk�adowymi rekordami.
Wczytaj od u�ytkownika rozmiar buta, sprawd� czy taki rozmiar buta jest dost�pny i wypisz na
ekranie odpowiedni� informacj� "Posiadamy buty w twoim rozmiarze, zapraszamy." lub "Nie
posiadamy but�w w twoim rozmiarze, przykro nam.". */ 
SET SERVEROUTPUT ON
ACCEPT podaj_rozmiar PROMPT 'Podaj rozmiar buta: ';

create table buty(
id_buty INT,
typ VARCHAR2(20),
marka VARCHAR2(20),
rozmiar NUMBER(8,2));
insert into buty(id_buty,typ,marka,rozmiar) values(1,'sportowe','nike',44);
insert into buty(id_buty,typ,marka,rozmiar) values(2,'sportowe','reebok',45);
insert into buty(id_buty,typ,marka,rozmiar) values(3,'pantofle','fly-high',46);

DECLARE
v_rozmiar buty.rozmiar%TYPE := &podaj_rozmiar;
v_wynik NUMBER(3);

BEGIN
SELECT COUNT(*) INTO v_wynik FROM buty WHERE rozmiar=v_rozmiar;
 IF v_wynik>0 THEN
  SYS.DBMS_OUTPUT.PUT_LINE('Posiadamy buty w twoim rozmiarze, zapraszamy.');
 ELSE
  SYS.DBMS_OUTPUT.PUT_LINE('Nie posiadamy but�w w twoim rozmiarze, przykro nam.');
 END IF;
END;
/

/* 3) Pobierz od u�ytkownika numer miesi�ca i wypisz na ekranie jego nazw� lub komunikat "nie ma
takiego miesi�ca". U�yj instrukcji CASE z wyra�eniem. */
SET SERVEROUTPUT ON
ACCEPT podaj_miesiac PROMPT 'Podaj numer miesi�ca: ';

DECLARE
v_miesiac NUMBER(3) := &podaj_miesiac;
v_miesiac_slownie VARCHAR2(30);

BEGIN
 CASE v_miesiac
  WHEN 1 THEN v_miesiac_slownie := 'stycze�';
  WHEN 2 THEN v_miesiac_slownie := 'luty';
  WHEN 3 THEN v_miesiac_slownie := 'marzec';
  WHEN 4 THEN v_miesiac_slownie := 'kwiecie�';
  WHEN 5 THEN v_miesiac_slownie := 'maj';
  WHEN 6 THEN v_miesiac_slownie := 'czerwiec';
  WHEN 7 THEN v_miesiac_slownie := 'lipiec';
  WHEN 8 THEN v_miesiac_slownie := 'sierpie�';
  WHEN 9 THEN v_miesiac_slownie := 'wrzesie�';
  WHEN 10 THEN v_miesiac_slownie := 'pa�dziernik';
  WHEN 11 THEN v_miesiac_slownie := 'listopad';
  WHEN 12 THEN v_miesiac_slownie := 'grudzie�';
  ELSE v_miesiac_slownie := 'nie ma takiego miesi�ca';
 END CASE;
 SYS.DBMS_OUTPUT.PUT_LINE(v_miesiac_slownie);
END;
/

/* 4) Dana jest tabela i przyk�adowe rekordy. Wczytaj identyfikator studenta.
Odczytaj wysoko�� stypendium wskazanego studenta i wypisz na ekranie komunikat:
a) je�li stypendium jest najwy�sze: "Najwy�sze stypendium",
b) je�li stypendium jest najni�sze: "Najni�sze stypendium",
c) je�li nie jest to ani najwy�sze ani najni�sze stypendium to wypisz jeden z pasuj�cych
poni�szych komunikat�w:
c1) "Stypendium powy�ej �redniej",
c2) "Stypendium poni�ej �redniej",
c3) "Stypendium r�wne �redniej".
U�yj instrukcji IF. */
SET SERVEROUTPUT ON
ACCEPT podaj_numer PROMPT 'Podaj numer studenta: ';

create table student(
id_student NUMBER(11),
imie VARCHAR2(15),
nazwisko VARCHAR2(20),
srednia NUMBER(4,2),
stypendium NUMBER(8,2));
INSERT INTO student(id_student,imie,nazwisko,srednia,stypendium) VALUES (1,'Jan','Kowalski',5, 2000);
INSERT INTO student(id_student,imie,nazwisko,srednia,stypendium) VALUES (2,'Anna','Zdolna',4, 1000);
INSERT INTO student(id_student,imie,nazwisko,srednia,stypendium) VALUES (3,'Agata','Muza',3.5, 100);
INSERT INTO student(id_student,imie,nazwisko,srednia,stypendium) VALUES (4,'Anna','Kula',3, 1);
INSERT INTO student(id_student,imie,nazwisko,srednia,stypendium) VALUES (5,'Kacper','Adamek',2, 0);

DECLARE
v_numer NUMBER := &podaj_numer;
v_stypendium student.stypendium%TYPE;
max_stypendium NUMBER(8,2);
min_stypendium NUMBER(8,2);
avg_stypendium NUMBER(8,2);

BEGIN
SELECT DISTINCT stypendium INTO v_stypendium FROM student WHERE id_student=v_numer;
SELECT max(stypendium),min(stypendium),avg(stypendium) INTO max_stypendium,min_stypendium,avg_stypendium FROM student;
 IF v_stypendium = max_stypendium THEN
  SYS.DBMS_OUTPUT.PUT_LINE('Najwy�sze stypendium');
 ELSIF v_stypendium > avg_stypendium AND v_stypendium < max_stypendium THEN
  SYS.DBMS_OUTPUT.PUT_LINE('Stypendium powy�ej �redniej');
 ELSIF v_stypendium > min_stypendium AND v_stypendium < avg_stypendium THEN
  SYS.DBMS_OUTPUT.PUT_LINE('Stypendium poni�ej �redniej');
 ELSIF v_stypendium = avg_stypendium THEN
  SYS.DBMS_OUTPUT.PUT_LINE('Stypendium r�wne �redniej');
 ELSIF v_stypendium = min_stypendium THEN
  SYS.DBMS_OUTPUT.PUT_LINE('Najni�sze stypendium');
 END IF;
END;
/

/* 5) Wykonaj ponownie powy�sze zadanie u�ywaj�c instrukcji CASE z wyszukiwaniem, nie u�ywaj
instrukcji IF. */
SET SERVEROUTPUT ON
ACCEPT podaj_numer PROMPT 'Podaj numer studenta: ';

create table student(
id_student NUMBER(11),
imie VARCHAR2(15),
nazwisko VARCHAR2(20),
srednia NUMBER(4,2),
stypendium NUMBER(8,2));
INSERT INTO student(id_student,imie,nazwisko,srednia,stypendium) VALUES (1,'Jan','Kowalski',5, 2000);
INSERT INTO student(id_student,imie,nazwisko,srednia,stypendium) VALUES (2,'Anna','Zdolna',4, 1000);
INSERT INTO student(id_student,imie,nazwisko,srednia,stypendium) VALUES (3,'Agata','Muza',3.5, 100);
INSERT INTO student(id_student,imie,nazwisko,srednia,stypendium) VALUES (4,'Anna','Kula',3, 1);
INSERT INTO student(id_student,imie,nazwisko,srednia,stypendium) VALUES (5,'Kacper','Adamek',2, 0);

DECLARE
v_numer NUMBER := &podaj_numer;
v_slownie VARCHAR2(30);
v_stypendium student.stypendium%TYPE;
max_stypendium NUMBER(8,2);
min_stypendium NUMBER(8,2);
avg_stypendium NUMBER(8,2);

BEGIN
SELECT DISTINCT stypendium INTO v_stypendium FROM student WHERE id_student=v_numer;
SELECT max(stypendium),min(stypendium),avg(stypendium) INTO max_stypendium,min_stypendium,avg_stypendium FROM student;
CASE 
  WHEN v_stypendium = max_stypendium THEN v_slownie := 'Najwy�sze stypendium';
  WHEN v_stypendium > avg_stypendium AND v_stypendium < max_stypendium THEN v_slownie := 'Stypendium powy�ej �redniej';
  WHEN v_stypendium > min_stypendium AND v_stypendium < avg_stypendium THEN v_slownie := 'Stypendium poni�ej �redniej';
  WHEN v_stypendium = avg_stypendium THEN v_slownie := 'Stypendium r�wne �redniej';
  WHEN v_stypendium = min_stypendium THEN v_slownie := 'Najni�sze stypendium';
  ELSE v_slownie := 'Nie ma takiego studenta';
 END CASE;
SYS.DBMS_OUTPUT.PUT_LINE(v_slownie);
END;
/

/* 6) Utw�rz tabel� osoba(id_osoba,imie,nazwisko,pensja) zawieraj�c� rekordy
Wczytaj od u�ytkownika identyfikator osoby. Je�li osoba o wczytanym identyfikatorze nie istnieje
to wy�wietl na ekranie komunikat "Osoba o id_osoba = <id_osoba> nie istnieje!", je�li istnieje
wi�cej ni� jedna taka osoba, to wtedy wy�wietl komunikat "Identyfikator id_osoba = <id_osoba>
nie jest unikatowy!", je�li istnieje dok�adnie jedna taka osoba to wy�wietl na ekranie wielko��
pensji tej osoby oraz
a) w przypadku gdy ona posiada pensj� mniejsz� ni� 2000 z�, to podwy�sz jej pensj� o 10%,
odczytaj pensj� po podwy�ce i wy�wietl komunikat "Pensja po podwy�szeniu wynosi <pensja>
z�",
b) w przypadku gdy ona posiada pensj� wy�sz� ni� 3000 z�, to obni� jej pensj� o 2%, odczytaj
pensj� po obni�ce i wy�wietl komunikat "Pensja po obni�ce wynosi <pensja> z�",
c) w przeciwnym przypadku wy�wietl komunikat "Pensja pomi�dzy 2000 z� a 3000 z�". */
SET SERVEROUTPUT ON
ACCEPT podaj_id PROMPT 'Podaj identyfikator osoby: ';

create table osoba(
id_osoba NUMBER(3) NOT NULL,
imie VARCHAR2(15) NOT NULL,
nazwisko VARCHAR(20) NOT NULL,
pensja DECIMAL(18,2) NOT NULL);
insert into osoba(id_osoba,imie,nazwisko,pensja) values(1,'Jan','Kowalski',1900);
insert into osoba(id_osoba,imie,nazwisko,pensja) values(2,'Anna','Marurat',2100);
insert into osoba(id_osoba,imie,nazwisko,pensja) values(3,'Jerzy','Lo�',2300);
insert into osoba(id_osoba,imie,nazwisko,pensja) values(4,'Ewa1','Kot1',2601);
insert into osoba(id_osoba,imie,nazwisko,pensja) values(4,'Ewa2','Kot2',2602);

DECLARE
v_id number(2):= &podaj_id;
v_pensja number(8,2);
v_pensja2 number(8,2);
v_licznik number(4);

BEGIN
select count(*) into v_licznik from osoba where v_id =ID_OSOBA;
if v_licznik=0 then SYS.DBMS_OUTPUT.PUT_LINE('Osoba o id_osoba = ' || v_id || ' nie istnieje!'); end if;
if v_licznik>1 then SYS.DBMS_OUTPUT.PUT_LINE('Identyfikator id_osoba = ' || v_id || ' nie jest unikatowy!'); end if;

if v_licznik=1 then 
  select pensja into v_pensja from osoba WHERE v_id = id_osoba;
  if v_pensja>3000 then 
    SYS.DBMS_OUTPUT.PUT_LINE('Pensja =  '|| v_pensja);
    v_pensja2:=v_pensja/1.02;
    update osoba set PENSJA=v_pensja2 where v_id = id_osoba;
    select pensja into v_pensja from osoba WHERE v_id = id_osoba;
    SYS.DBMS_OUTPUT.PUT_LINE('Pensja po obni�ce wynosi =  '|| v_pensja|| ' zl');
  end if;
  if v_pensja<2000 then 
    SYS.DBMS_OUTPUT.PUT_LINE('Pensja =  '|| v_pensja);
    v_pensja2:=v_pensja*1.1;
    update osoba set PENSJA=v_pensja2 where v_id = id_osoba;
    select pensja into v_pensja from osoba WHERE v_id = id_osoba;
    SYS.DBMS_OUTPUT.PUT_LINE('Pensja po podwy�szeniu wynosi = ' || v_pensja || ' zl');
  end if; 
end if;
END;
/

/* 7) Napisz program, kt�ry b�dzie wy�wietla�, w zale�no�ci od wyboru u�ytkownika, bie��c� dat�
systemow� (wyb�r 'D') lub bie��cy czas systemowy (wyb�r 'C'). */
SET SERVEROUTPUT ON
ACCEPT wybor PROMPT 'Bie��ca data systemowa (wpisz "d") czy czas systemowy (wpisz "c")';

DECLARE
v_wybor varchar2(1):= '&wybor';
v_data DATE := trunc(SYSDATE);
v_czas varchar(20);

BEGIN
SELECT TO_CHAR(CURRENT_DATE, 'HH:MI:SS') into v_czas FROM DUAL;
IF v_wybor='d' THEN 
  SYS.DBMS_OUTPUT.PUT_LINE(v_data);
ELSIF
  v_wybor='c' then SYS.DBMS_OUTPUT.PUT_LINE(v_czas); 
ELSE 
  SYS.DBMS_OUTPUT.PUT_LINE('Wpisz "d" dla daty systemowej lub "c" dla czasu systemowego');
END IF;

END;
/
