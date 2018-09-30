/* 1) Zadeklaruj zmienn¹ powi¹zan¹ o nazwie v_wynik.
Utwórz etykietê dla bloku zewnêtrznego o nazwie etykieta_zewnetrzna oraz zadeklaruj zmienn¹ o
nazwie v_liczba. Nastêpnie dla bloku wewnêtrznego zadeklaruj zmienn¹ o identycznej nazwie
v_liczba. (Mamy dwie zmienne o nazwie v_liczba – w bloku zewnêtrznym i wewnêtrznym.)
Wykonaj mno¿enie obu zmiennych v_liczba w bloku wewnêtrznym z przypisaniem wyniku do
zmiennej powi¹zanej v_wynik. Zakoñcz dzia³anie bloku anonimowego. Wyœwietl na ekranie
wartoœæ zmiennej v_wynik. Wartoœci obu zmiennych v_liczba pobierz od u¿ytkownika. */
SET SERVEROUTPUT ON

ACCEPT podaj_liczbe1 PROMPT 'Podaj wartoœæ pierwszej liczby: ';
ACCEPT podaj_liczbe2 PROMPT 'Podaj wartoœæ drugiej liczby: ';
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

/* 2) Dana jest tabela z przyk³adowymi rekordami.
Wczytaj od u¿ytkownika rozmiar buta, sprawdŸ czy taki rozmiar buta jest dostêpny i wypisz na
ekranie odpowiedni¹ informacjê "Posiadamy buty w twoim rozmiarze, zapraszamy." lub "Nie
posiadamy butów w twoim rozmiarze, przykro nam.". */ 
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
  SYS.DBMS_OUTPUT.PUT_LINE('Nie posiadamy butów w twoim rozmiarze, przykro nam.');
 END IF;
END;
/

/* 3) Pobierz od u¿ytkownika numer miesi¹ca i wypisz na ekranie jego nazwê lub komunikat "nie ma
takiego miesi¹ca". U¿yj instrukcji CASE z wyra¿eniem. */
SET SERVEROUTPUT ON
ACCEPT podaj_miesiac PROMPT 'Podaj numer miesi¹ca: ';

DECLARE
v_miesiac NUMBER(3) := &podaj_miesiac;
v_miesiac_slownie VARCHAR2(30);

BEGIN
 CASE v_miesiac
  WHEN 1 THEN v_miesiac_slownie := 'styczeñ';
  WHEN 2 THEN v_miesiac_slownie := 'luty';
  WHEN 3 THEN v_miesiac_slownie := 'marzec';
  WHEN 4 THEN v_miesiac_slownie := 'kwiecieñ';
  WHEN 5 THEN v_miesiac_slownie := 'maj';
  WHEN 6 THEN v_miesiac_slownie := 'czerwiec';
  WHEN 7 THEN v_miesiac_slownie := 'lipiec';
  WHEN 8 THEN v_miesiac_slownie := 'sierpieñ';
  WHEN 9 THEN v_miesiac_slownie := 'wrzesieñ';
  WHEN 10 THEN v_miesiac_slownie := 'paŸdziernik';
  WHEN 11 THEN v_miesiac_slownie := 'listopad';
  WHEN 12 THEN v_miesiac_slownie := 'grudzieñ';
  ELSE v_miesiac_slownie := 'nie ma takiego miesi¹ca';
 END CASE;
 SYS.DBMS_OUTPUT.PUT_LINE(v_miesiac_slownie);
END;
/

/* 4) Dana jest tabela i przyk³adowe rekordy. Wczytaj identyfikator studenta.
Odczytaj wysokoœæ stypendium wskazanego studenta i wypisz na ekranie komunikat:
a) jeœli stypendium jest najwy¿sze: "Najwy¿sze stypendium",
b) jeœli stypendium jest najni¿sze: "Najni¿sze stypendium",
c) jeœli nie jest to ani najwy¿sze ani najni¿sze stypendium to wypisz jeden z pasuj¹cych
poni¿szych komunikatów:
c1) "Stypendium powy¿ej œredniej",
c2) "Stypendium poni¿ej œredniej",
c3) "Stypendium równe œredniej".
U¿yj instrukcji IF. */
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
  SYS.DBMS_OUTPUT.PUT_LINE('Najwy¿sze stypendium');
 ELSIF v_stypendium > avg_stypendium AND v_stypendium < max_stypendium THEN
  SYS.DBMS_OUTPUT.PUT_LINE('Stypendium powy¿ej œredniej');
 ELSIF v_stypendium > min_stypendium AND v_stypendium < avg_stypendium THEN
  SYS.DBMS_OUTPUT.PUT_LINE('Stypendium poni¿ej œredniej');
 ELSIF v_stypendium = avg_stypendium THEN
  SYS.DBMS_OUTPUT.PUT_LINE('Stypendium równe œredniej');
 ELSIF v_stypendium = min_stypendium THEN
  SYS.DBMS_OUTPUT.PUT_LINE('Najni¿sze stypendium');
 END IF;
END;
/

/* 5) Wykonaj ponownie powy¿sze zadanie u¿ywaj¹c instrukcji CASE z wyszukiwaniem, nie u¿ywaj
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
  WHEN v_stypendium = max_stypendium THEN v_slownie := 'Najwy¿sze stypendium';
  WHEN v_stypendium > avg_stypendium AND v_stypendium < max_stypendium THEN v_slownie := 'Stypendium powy¿ej œredniej';
  WHEN v_stypendium > min_stypendium AND v_stypendium < avg_stypendium THEN v_slownie := 'Stypendium poni¿ej œredniej';
  WHEN v_stypendium = avg_stypendium THEN v_slownie := 'Stypendium równe œredniej';
  WHEN v_stypendium = min_stypendium THEN v_slownie := 'Najni¿sze stypendium';
  ELSE v_slownie := 'Nie ma takiego studenta';
 END CASE;
SYS.DBMS_OUTPUT.PUT_LINE(v_slownie);
END;
/

/* 6) Utwórz tabelê osoba(id_osoba,imie,nazwisko,pensja) zawieraj¹c¹ rekordy
Wczytaj od u¿ytkownika identyfikator osoby. Jeœli osoba o wczytanym identyfikatorze nie istnieje
to wyœwietl na ekranie komunikat "Osoba o id_osoba = <id_osoba> nie istnieje!", jeœli istnieje
wiêcej ni¿ jedna taka osoba, to wtedy wyœwietl komunikat "Identyfikator id_osoba = <id_osoba>
nie jest unikatowy!", jeœli istnieje dok³adnie jedna taka osoba to wyœwietl na ekranie wielkoœæ
pensji tej osoby oraz
a) w przypadku gdy ona posiada pensjê mniejsz¹ ni¿ 2000 z³, to podwy¿sz jej pensjê o 10%,
odczytaj pensjê po podwy¿ce i wyœwietl komunikat "Pensja po podwy¿szeniu wynosi <pensja>
z³",
b) w przypadku gdy ona posiada pensjê wy¿sz¹ ni¿ 3000 z³, to obni¿ jej pensjê o 2%, odczytaj
pensjê po obni¿ce i wyœwietl komunikat "Pensja po obni¿ce wynosi <pensja> z³",
c) w przeciwnym przypadku wyœwietl komunikat "Pensja pomiêdzy 2000 z³ a 3000 z³". */
SET SERVEROUTPUT ON
ACCEPT podaj_id PROMPT 'Podaj identyfikator osoby: ';

create table osoba(
id_osoba NUMBER(3) NOT NULL,
imie VARCHAR2(15) NOT NULL,
nazwisko VARCHAR(20) NOT NULL,
pensja DECIMAL(18,2) NOT NULL);
insert into osoba(id_osoba,imie,nazwisko,pensja) values(1,'Jan','Kowalski',1900);
insert into osoba(id_osoba,imie,nazwisko,pensja) values(2,'Anna','Marurat',2100);
insert into osoba(id_osoba,imie,nazwisko,pensja) values(3,'Jerzy','Loœ',2300);
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
    SYS.DBMS_OUTPUT.PUT_LINE('Pensja po obni¿ce wynosi =  '|| v_pensja|| ' zl');
  end if;
  if v_pensja<2000 then 
    SYS.DBMS_OUTPUT.PUT_LINE('Pensja =  '|| v_pensja);
    v_pensja2:=v_pensja*1.1;
    update osoba set PENSJA=v_pensja2 where v_id = id_osoba;
    select pensja into v_pensja from osoba WHERE v_id = id_osoba;
    SYS.DBMS_OUTPUT.PUT_LINE('Pensja po podwy¿szeniu wynosi = ' || v_pensja || ' zl');
  end if; 
end if;
END;
/

/* 7) Napisz program, który bêdzie wyœwietla³, w zale¿noœci od wyboru u¿ytkownika, bie¿¹c¹ datê
systemow¹ (wybór 'D') lub bie¿¹cy czas systemowy (wybór 'C'). */
SET SERVEROUTPUT ON
ACCEPT wybor PROMPT 'Bie¿¹ca data systemowa (wpisz "d") czy czas systemowy (wpisz "c")';

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
