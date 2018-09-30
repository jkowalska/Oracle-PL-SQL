--Sprowokuj wyjątek w sekcji wykonawczej i go obsłuż
SET SERVEROUTPUT ON
ACCEPT podaj_liczbe1 PROMPT 'Podaj wartość pierwszej liczby: ';
ACCEPT podaj_liczbe2 PROMPT 'Podaj wartość drugiej liczby: ';

DECLARE
v_liczba1 NUMBER(5) := &podaj_liczbe1;
v_liczba2 NUMBER(5) := &podaj_liczbe2;

BEGIN
 SYS.DBMS_OUTPUT.PUT_LINE('Wynik dzielenia to: ' || (v_liczba1 / v_liczba2));

EXCEPTION
  WHEN ZERO_DIVIDE THEN
    SYS.DBMS_OUTPUT.PUT_LINE('Wyjątek: Dzielenie przez zero');
  WHEN OTHERS THEN
    SYS.DBMS_OUTPUT.PUT_LINE('Bląd numer='||SQLCODE||', komunikat='||SQLERRM);
END;
/

--Sprowokuj wyjątek w sekcji deklaracyjnej i go obsłuż
SET SERVEROUTPUT ON

BEGIN
  DECLARE
    v_tekst VARCHAR2(20) := 'Baza danych to uporzadkowany zbiór danych';

  BEGIN
    SYS.DBMS_OUTPUT.PUT_LINE(v_tekst);
    
  EXCEPTION
    WHEN VALUE_ERROR THEN
      SYS.DBMS_OUTPUT.PUT_LINE('Zgloszenie wyjątku');
    WHEN OTHERS THEN
      SYS.DBMS_OUTPUT.PUT_LINE('Wystąpil inny bląd');
  END;

EXCEPTION
  WHEN VALUE_ERROR THEN
    SYS.DBMS_OUTPUT.PUT_LINE('Wyjątek: Błąd przepełnienia bufora');
  WHEN OTHERS THEN
    SYS.DBMS_OUTPUT.PUT_LINE('Bląd numer='||SQLCODE||', komunikat='||SQLERRM);
END;
/

--Sprowokuj wyjątek w sekcji obsługi wyjątków i go obsłuż
SET SERVEROUTPUT ON
create table pracownik(
id_pracownik NUMBER(3) NOT NULL PRIMARY KEY,
imie VARCHAR2(15) NOT NULL,
nazwisko VARCHAR(20) NOT NULL);
insert into pracownik(id_pracownik,imie,nazwisko) values(1,'Jan','Kowalski');
insert into pracownik(id_pracownik,imie,nazwisko) values(2,'Jerzy','Nowak');
insert into pracownik(id_pracownik,imie,nazwisko) values(3,'Anna','Galka');

BEGIN
  DECLARE
    NIEPRAWIDŁOWY_NUMER EXCEPTION;

  BEGIN
    RAISE NIEPRAWIDŁOWY_NUMER;
    
  EXCEPTION
    WHEN NIEPRAWIDŁOWY_NUMER THEN
      INSERT INTO pracownik(id_pracownik,imie,nazwisko) VALUES(1,'Ala','Kos');
      --RAISE DUP_VAL_ON_INDEX;
    WHEN DUP_VAL_ON_INDEX THEN
      SYS.DBMS_OUTPUT.PUT_LINE('Zgloszenie wyjątku');
    WHEN OTHERS THEN
      SYS.DBMS_OUTPUT.PUT_LINE('Bląd numer='||SQLCODE||', komunikat='||SQLERRM);
    END;
    
EXCEPTION
WHEN INVALID_NUMBER THEN
  INSERT INTO pracownik(id_pracownik,imie,nazwisko) VALUES(1,'Ala','Kos');
  --RAISE DUP_VAL_ON_INDEX;
WHEN DUP_VAL_ON_INDEX THEN
  SYS.DBMS_OUTPUT.PUT_LINE('Wyjątek: Naruszenie klucza głównego');
WHEN OTHERS THEN
  SYS.DBMS_OUTPUT.PUT_LINE('Bląd numer='||SQLCODE||', komunikat='||SQLERRM);
END;
/

--Dodatkowe
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

BEGIN
  DECLARE
    E_BRAK_W_MAGAZYNIE EXCEPTION;
    E_ZA_MALY_ROZMIAR EXCEPTION;
    E_ZA_DUZY_ROZMIAR EXCEPTION;
    v_rozmiar buty.rozmiar%TYPE := &podaj_rozmiar;
    v_wynik NUMBER(3);

  BEGIN
    SELECT COUNT(*) INTO v_wynik FROM buty WHERE rozmiar=v_rozmiar;
    IF v_wynik>0 THEN
      SYS.DBMS_OUTPUT.PUT_LINE('Posiadamy buty w twoim rozmiarze, zapraszamy.');
    ELSIF v_rozmiar < 35 THEN
      RAISE E_ZA_MALY_ROZMIAR;
    ELSIF v_rozmiar > 50 THEN
      RAISE E_ZA_DUZY_ROZMIAR;
    ELSE
      RAISE E_BRAK_W_MAGAZYNIE;
    END IF;
    
    EXCEPTION
    WHEN E_ZA_MALY_ROZMIAR THEN
      SYS.DBMS_OUTPUT.PUT_LINE('Wyjątek: Za maly rozmiar');
    WHEN E_ZA_DUZY_ROZMIAR THEN
      SYS.DBMS_OUTPUT.PUT_LINE('Wyjątek: Za duzy rozmiar');
    WHEN E_BRAK_W_MAGAZYNIE THEN
      SYS.DBMS_OUTPUT.PUT_LINE('Wyjątek: Brak butów w magazynie');
    WHEN OTHERS THEN
      SYS.DBMS_OUTPUT.PUT_LINE('Bląd numer='||SQLCODE||', komunikat='||SQLERRM);
    END;
END;
/
