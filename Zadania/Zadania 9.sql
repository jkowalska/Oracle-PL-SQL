--1) Dana jest tabela ciastko(id_ciastko,nazwa,cena). Zdefiniuj wyzwalacz, 
--który dla każdego dodawanego ciastka będzie automatycznie przydzielał
--kolejny wolny identyfikator id_ciastko. Przykładowo instrukcja:
--INSERT INTO ciastko(nazwa,cena) VALUES ('Beza',3.15);
--powinna poprawnie dodać ciastko, a kolumna id_ciastko nie może mieć 
--wartości NULL. Przetestuj działanie utworzonego wyzwalacza.
CREATE TABLE ciastko(
id_ciastko INT,
nazwa VARCHAR(20),
cena NUMBER(4,2)
);
/
CREATE SEQUENCE ciastko_sek START WITH 1 INCREMENT BY 1 NOMAXVALUE;
/
CREATE TRIGGER insert_ciastko BEFORE INSERT ON ciastko FOR EACH ROW

BEGIN
  SELECT ciastko_sek.NEXTVAL INTO :new.id_ciastko FROM dual;
END;
/
INSERT INTO ciastko(nazwa,cena) VALUES ('Beza',3.15);
INSERT INTO ciastko(nazwa,cena) VALUES ('Babeczka',2.50);
INSERT INTO ciastko(nazwa,cena) VALUES ('Tarta',4.75);
/
SELECT * FROM ciastko;
DROP SEQUENCE ciastko_sek;
DROP TRIGGER insert_ciastko;
DROP TABLE ciastko;

--2) Dana jest tabela dane(id_dane,imie,nazwisko,pesel,data_ur,plec). 
--Po wykonaniu instrukcji: INSERT INTO dane(imie,nazwisko,pesel) 
--VALUES ('Jan','Kowalski','75052503553'); a) Wyzwalacz powinien 
--automatycznie zdefiniować kolejny numer id_dane. b) Wyzwalacz 
--powinien z numeru pesel wyciągnąć datę urodzenia i wpisać ją do 
--kolumny data_ur. c) Wyzwalacz powinien z numeru pesel odczytać płeć 
--i wpisać wartości 'K' lub 'M' do kolumny plec. Przetestuj działanie 
--utworzonego wyzwalacza.
CREATE TABLE dane(
id_dane INT,
imie VARCHAR(20),
nazwisko VARCHAR2(30),
pesel VARCHAR(11),
data_ur DATE,
plec CHAR(1)
);
/
CREATE SEQUENCE dane_sek START WITH 1 INCREMENT BY 1 NOMAXVALUE;
/
CREATE TRIGGER insert_dane BEFORE INSERT ON dane FOR EACH ROW

BEGIN
  SELECT dane_sek.NEXTVAL INTO :new.id_dane FROM dual;
  :new.data_ur := SUBSTR(:new.pesel,1,2)||'/'||SUBSTR(:new.pesel,3,2)||'/'||
    SUBSTR(:new.pesel,5,2);
  IF MOD (SUBSTR(:new.pesel,11), 2) = 0 THEN 
    :new.plec := 'K';
  ELSE :new.plec := 'M';
  END IF;
END;
/
INSERT INTO dane(imie,nazwisko,pesel) VALUES ('Jan','Kowalski','75052503553');
/
SELECT * FROM dane;
DROP SEQUENCE dane_sek;
DROP TRIGGER insert_dane;
DROP TABLE dane;

--3. Dana jest tabela: CREATE TABLE lista(id_slowo INT, slowo VARCHAR2(20));
--i przykładowe rekordy. Napisać wyzwalacz, który uniemożliwi usuwanie 
--i modyfikację rekordów w tabeli lista. Przetestuj działanie wyzwalacza.
CREATE TABLE lista(
id_slowo INT, 
slowo VARCHAR2(20)
); 
INSERT INTO lista(id_slowo,slowo) VALUES(1,'red'); 
INSERT INTO lista(id_slowo,slowo) VALUES(2,'blue');
INSERT INTO lista(id_slowo,slowo) VALUES(3,'green'); 
/
CREATE OR REPLACE TRIGGER zakaz_trigger BEFORE UPDATE OR DELETE ON lista FOR EACH ROW
DECLARE
  E_ZAKAZ_MODYFIKACJI EXCEPTION;
  E_ZAKAZ_USUWANIA EXCEPTION;
BEGIN
  IF UPDATING THEN 
    :new.id_slowo := :old.id_slowo;
    :new.slowo := :old.slowo;
    RAISE E_ZAKAZ_MODYFIKACJI;    
  ELSIF DELETING THEN 
    :new.id_slowo := NULL;
    RAISE E_ZAKAZ_USUWANIA;
  END IF;
  
  EXCEPTION
    WHEN E_ZAKAZ_MODYFIKACJI THEN
      DBMS_OUTPUT.PUT_LINE('  Wyjątek: Zakaz modyfikacji');
      ROLLBACK;
    WHEN E_ZAKAZ_USUWANIA THEN
      DBMS_OUTPUT.PUT_LINE('  Wyjątek: Zakaz zmian');
      ROLLBACK;
    WHEN OTHERS THEN 
      DBMS_OUTPUT.PUT_LINE('  Inny wyjątek');
END;
/
SELECT * FROM lista;
UPDATE lista SET slowo='blue' WHERE id_slowo=1;
DELETE FROM lista WHERE id_slowo=3;
INSERT INTO lista(id_slowo,slowo) VALUES(4,'yellow'); 
SELECT * FROM lista;
DROP TRIGGER zakaz_trigger;
DROP TABLE lista;

--4) Dane są tabele imiona(id,imie) oraz imiona_historia(id,imie,data_zmiany,zmiana).
--Napisać wyzwalacz, który będzie archiwizował modyfikowane i usuwane 
--rekordy z tabeli imiona do tabeli imiona_historia. Dodatkowo w tabeli 
--imiona_historia powinna być zapisana data zmiany i rodzaj zmiany: 
--'U' (od update), 'D' (od delete). Przetestuj działanie wyzwalacza.
CREATE TABLE imiona(
id_imiona NUMBER(3),
imie VARCHAR(20)
); 
INSERT INTO imiona VALUES(1,'Anna');
INSERT INTO imiona VALUES(2,'Ola');
INSERT INTO imiona VALUES(3,'Zofia');
SELECT * FROM imiona;
/
CREATE TABLE imiona_historia(
id_i_h NUMBER(3),
imie VARCHAR(20),
data_zmiany DATE,
zmiana CHAR(1)
);
SELECT * FROM imiona_historia;
/
CREATE OR REPLACE TRIGGER imiona_arch BEFORE UPDATE OR DELETE ON imiona FOR EACH ROW
DECLARE
  v_zmiana imiona_historia.zmiana%TYPE;
  v_data_zmiany imiona_historia.data_zmiany%TYPE;
  
BEGIN
  IF UPDATING THEN 
    v_zmiana := 'U';
    SELECT trunc(SYSDATE) INTO v_data_zmiany FROM DUAL;
  ELSIF DELETING THEN 
    v_zmiana := 'D';
    SELECT trunc(SYSDATE) INTO v_data_zmiany FROM DUAL;
  END IF;
  INSERT INTO imiona_historia(id_i_h,imie,data_zmiany,zmiana) VALUES(:old.id_imiona,:old.imie,v_data_zmiany,v_zmiana);
END;
/
UPDATE imiona SET imie='Irena' WHERE id_imiona=2;
DELETE FROM imiona WHERE imie='Zofia';
SELECT * FROM imiona;
SELECT * FROM imiona_historia;
DROP TRIGGER imiona_arch;
DROP TABLE imiona;
DROP TABLE imiona_historia;
