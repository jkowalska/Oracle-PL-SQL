/* 1) Zadeklaruj dwie zmienne o nazwach v_tekst, v_liczba i  warto�ciach odpowiednio 
�Baza danych to uporz�dkowany zbi�r danych� oraz 2,7182. Wy�wietl warto�ci 
tych zmiennych na ekranie. */
SET SERVEROUTPUT ON

DECLARE
v_tekst VARCHAR2(50) := 'Baza danych to uporzadkowany zbi�r danych';
v_liczba NUMBER(5,4) := 2.7182;

BEGIN
 SYS.DBMS_OUTPUT.PUT_LINE(v_tekst);
 SYS.DBMS_OUTPUT.PUT_LINE(v_liczba);
END;
/

/* 2) Napisz program obliczaj�cy iloczyn dw�ch liczb ca�kowitych. Liczby powinny 
by� podane z konsoli przez u�ytkownika. */ 
SET SERVEROUTPUT ON

ACCEPT podaj_liczbe1 PROMPT 'Podaj warto�� pierwszej liczby: ';
ACCEPT podaj_liczbe2 PROMPT 'Podaj warto�� drugiej liczby: ';

DECLARE
v_liczba1 NUMBER(5) := &podaj_liczbe1;
v_liczba2 NUMBER(5) := &podaj_liczbe2;

BEGIN
 SYS.DBMS_OUTPUT.PUT_LINE('Wynik mno�enia to: ' || (v_liczba1 * v_liczba2));
END;
/

/* 3) Napisa� program obliczaj�cy pole powierzchni ca�kowitej i obj�to�� kuli.  
W programie pos�u� si� zdefiniowan� przez siebie sta�� c_pi=3,14159265.
Wczytaj promie� kuli od u�ytkownika i wy�wietl wyniki na ekranie. */
SET SERVEROUTPUT ON

ACCEPT podaj_promien PROMPT 'Podaj promie� kuli: ';

DECLARE
v_promien NUMBER(5) := &podaj_promien;
c_pi CONSTANT NUMBER(9,8) := 3.14159265;
v_wynik_pole NUMBER(6,2);
v_wynik_obj NUMBER(6,2);

BEGIN
 v_wynik_pole := 4 * c_pi * v_promien * v_promien;
 v_wynik_obj := 4/3 * c_pi * v_promien * v_promien * v_promien;
 SYS.DBMS_OUTPUT.PUT_LINE('Pole = ' || v_wynik_pole);
 SYS.DBMS_OUTPUT.PUT_LINE('Obj�to�� = ' || v_wynik_obj);
END;
/

/* 4) Utw�rz tabele pracownik z przyk�adowymi rekordami. Zadeklaruj zmienn� 
v_ilosc, oblicz ilo�� rekord�w w tabeli pracownik i otrzymany wynik zapisz do 
zmiennej v_ilosc. U�ywaj�c zmiennej v_ilosc wypisz na ekranie komunikat 
w formacie: �W tabeli pracownik jest <ilo��> rekord�w�. */
SET SERVEROUTPUT ON

create table pracownik(
id_pracownik NUMBER(3) NOT NULL PRIMARY KEY,
imie VARCHAR2(15) NOT NULL,
nazwisko VARCHAR(20) NOT NULL
);
insert into pracownik(id_pracownik,imie,nazwisko) values(1,'Jan','Kowalski');
insert into pracownik(id_pracownik,imie,nazwisko) values(2,'Jerzy','Nowak');
insert into pracownik(id_pracownik,imie,nazwisko) values(3,'Anna','Galka');
insert into pracownik(id_pracownik,imie,nazwisko) values(4,'Hanna','Mialka');

DECLARE
v_ilosc NUMBER(5);

BEGIN
 SELECT COUNT(*) INTO v_ilosc FROM pracownik;
 sys.DBMS_OUTPUT.PUT_LINE('W tabeli pracownik jest ' || v_ilosc || ' rekord�w');
END;
/

/* 5) U�ywaj�c typu zakotwiczonego zadeklaruj zmienne v_imie i v_nazwisko 
o tych samych typach co typy kolumn imie i nazwisko z tabeli pracownik. 
Nast�pnie wczytaj do nich imi� i nazwisko pracownika o identyfikatorze 
r�wnym 3. Wy�wietl na ekranie wczytane imi� i nazwisko. */
SET SERVEROUTPUT ON

/*create table pracownik(
id_pracownik NUMBER(3) NOT NULL PRIMARY KEY,
imie VARCHAR2(15) NOT NULL,
nazwisko VARCHAR(20) NOT NULL
);
insert into pracownik(id_pracownik,imie,nazwisko) values(1,'Jan','Kowalski');
insert into pracownik(id_pracownik,imie,nazwisko) values(2,'Jerzy','Nowak');
insert into pracownik(id_pracownik,imie,nazwisko) values(3,'Anna','Galka');
insert into pracownik(id_pracownik,imie,nazwisko) values(4,'Hanna','Mialka');*/

DECLARE
v_imie pracownik.imie%TYPE;
v_nazwisko pracownik.nazwisko%TYPE;

BEGIN
 SELECT imie, nazwisko INTO v_imie, v_nazwisko FROM pracownik WHERE id_pracownik=3;
 sys.DBMS_OUTPUT.PUT_LINE(v_imie || ' ' || v_nazwisko);
END;
/

/* 6) Do zmiennej v_rekord wczytaj rekord z danymi pracownika o identyfikatorze 
r�wnym 2. Wy�wietl wczytane dane na ekranie w formacie: �Pracownik o identyfikatorze 
r�wnym <numer> to <imie> <nazwisko>�. Nast�pnie w zmiennej v_rekord zmie� warto�� pola 
id_pracownik na 10 i do tabeli pracownik dodaj nowy rekord o warto�ci zmiennej v_rekord. 
Wy�wietl na ekranie zawarto�� tabeli pracownik. */

SET SERVEROUTPUT ON
SELECT * FROM pracownik;
create table pracownik(
id_pracownik NUMBER(3) NOT NULL PRIMARY KEY,
imie VARCHAR2(15) NOT NULL,
nazwisko VARCHAR(20) NOT NULL);
insert into pracownik(id_pracownik,imie,nazwisko) values(1,'Jan','Kowalski');
insert into pracownik(id_pracownik,imie,nazwisko) values(2,'Jerzy','Nowak');
insert into pracownik(id_pracownik,imie,nazwisko) values(3,'Anna','Galka');
insert into pracownik(id_pracownik,imie,nazwisko) values(4,'Hanna','Mialka');

DECLARE
v_imie pracownik.imie%TYPE;
v_nazwisko pracownik.nazwisko%TYPE;
v_id_pracownik pracownik.id_pracownik%TYPE;
v_tekst VARCHAR2(50);
v_rekord NUMBER(3);

BEGIN
v_rekord := 2;
SELECT imie,nazwisko,id_pracownik INTO v_imie,v_nazwisko,v_id_pracownik FROM pracownik WHERE id_pracownik=v_rekord;
v_tekst := 'Pracownik o id r�wnym ' || v_rekord || ' to ' || v_imie || ' ' || v_nazwisko;
SYS.DBMS_OUTPUT.PUT_LINE(v_tekst);
v_rekord := 10;
insert into pracownik(id_pracownik,imie,nazwisko) values(v_rekord,'Ala','Kos');
END;
/
SELECT * FROM pracownik;

/* 7) Zosta�a utworzona tabela: CREATE TABLE info(nazwa VARCHAR(50) NOT NULL, ilosc INT);
Dodaj do niej trzy rekordy, dla kt�rych kolumna nazwa przyjmuje odpowiednio warto�ci: 
tabele, widoki, ograniczenia (ang. constraints). Nast�pnie zadeklaruj trzy zmienne 
i przypisz do nich odpowiednio warto�ci oblicze� ile zalogowany u�ytkownik ma tabel, 
widok�w i ogranicze� w bazie danych. Zaktualizuj rekordy w tabeli info poprzez 
uaktualnienie warto�ci kolumny ilosc wpisuj�c obliczon� wcze�niej ilo�� tabel, widok�w 
i ogranicze�. */

SET SERVEROUTPUT ON
create table info(
nazwa VARCHAR(50) NOT NULL,
ilosc INT);
insert into info(nazwa,ilosc) values('tabele',NULL);
insert into info(nazwa,ilosc) values('widoki',NULL);
insert into info(nazwa,ilosc) values('ograniczenia',NULL);

DECLARE
v_tabele info.ilosc%TYPE;
v_widoki info.ilosc%TYPE;
v_ograniczenia info.ilosc%TYPE;

BEGIN
SELECT COUNT(*) INTO v_tabele FROM USER_TABLES;
SELECT COUNT(*) INTO v_widoki FROM USER_VIEWS;
SELECT COUNT(*) INTO v_ograniczenia FROM USER_CONSTRAINTS;

 SYS.DBMS_OUTPUT.PUT_LINE('tabel: ' || v_tabele);
 SYS.DBMS_OUTPUT.PUT_LINE('widok�w: ' || v_widoki);
 SYS.DBMS_OUTPUT.PUT_LINE('ogranicze�: ' || v_ograniczenia);
 
UPDATE info SET ilosc=v_tabele WHERE nazwa = 'tabele';
UPDATE info SET ilosc=v_widoki WHERE nazwa = 'widoki';
UPDATE info SET ilosc=v_ograniczenia WHERE nazwa = 'ograniczenia';
END;
/
select * from info;

/* 8) Utw�rz tabel� osoba(id_osoba, imie, nazwisko, roczne_zarobki) oraz dodaj do niej 
rekordy: 1 Jan Kowalski 8765,12; 2 Anna Nowak 6543,11; 3 Ewa Nowak 5555,55. Zdefiniuj 
w oparciu o typ NUMBER w�asny typ pochodny o nazwie KASA i zadeklaruj zmienn� tego typu. 
Wczytaj do niej roczne zarobki Jana Kowalskiego i wypisz je na ekranie. */

SET SERVEROUTPUT ON
create table osoba(
id_osoba NUMBER(3) NOT NULL PRIMARY KEY,
imie VARCHAR2(15) NOT NULL,
nazwisko VARCHAR(20) NOT NULL,
roczne_zarobki DECIMAL(18,2) NOT NULL);
insert into osoba(id_osoba,imie,nazwisko,roczne_zarobki) values(1,'Jan','Kowalski',8765.12);
insert into osoba(id_osoba,imie,nazwisko,roczne_zarobki) values(2,'Anna','Nowak',6543.11);
insert into osoba(id_osoba,imie,nazwisko,roczne_zarobki) values(3,'Ewa','Nowak',5555.55);

DECLARE
SUBTYPE s_kasa IS NUMBER(18,2); 
v_zarobki s_kasa;

BEGIN
 SELECT roczne_zarobki INTO v_zarobki FROM osoba WHERE imie='Jan' AND nazwisko='Kowalski';
 SYS.DBMS_OUTPUT.PUT_LINE('Roczne zarobki Jana Kowalskiego: ' || v_zarobki);
END;
/
select * from osoba;
