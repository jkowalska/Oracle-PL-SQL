--trigger kopiuje dane każdej modyfikowanej lub usuwanej umowy do archiwum,
--oraz podaje powód kopiowania (UPDATE lub DELETE), datę modyfikacji lub usunięcia
--umowy oraz który użytkownik tego dokonał
CREATE TABLE umowa_archiwum (
    id_umowa             NUMBER(11) NOT NULL,
    data_zawarcia        DATE NOT NULL,
    liczba_osob          NUMBER(3) NOT NULL,
    cena_suma            NUMBER(8,2) NOT NULL,
    wycieczka_id         NUMBER(11) NOT NULL,
    pracownik_id         NUMBER(11) NOT NULL,
    klient_id            NUMBER(11) NOT NULL,
    faktura_id           NUMBER NOT NULL,
    data_zarchiwizowania DATE,
    rodzaj_zmiany        CHAR(6),
    osoba_archiwizujaca  VARCHAR(30)
);
CREATE OR REPLACE TRIGGER umowa_do_arch BEFORE UPDATE OR DELETE ON umowa FOR EACH ROW
DECLARE
  v_data_zarchiwizowania umowa_archiwum.data_zarchiwizowania%TYPE;
  v_rodzaj_zmiany umowa_archiwum.rodzaj_zmiany%TYPE;
  v_osoba_archiwizujaca umowa_archiwum.osoba_archiwizujaca%TYPE;
BEGIN
  IF UPDATING THEN 
    SELECT user,trunc(SYSDATE) INTO v_osoba_archiwizujaca,v_data_zarchiwizowania FROM DUAL;
    v_rodzaj_zmiany := 'UPDATE';
  ELSIF DELETING THEN 
    SELECT user,trunc(SYSDATE) INTO v_osoba_archiwizujaca,v_data_zarchiwizowania FROM DUAL;
    v_rodzaj_zmiany := 'DELETE';
  END IF;
  INSERT INTO umowa_archiwum(
  id_umowa,data_zawarcia,liczba_osob,cena_suma,wycieczka_id,pracownik_id,klient_id,
  faktura_id,data_zarchiwizowania,rodzaj_zmiany,osoba_archiwizujaca) 
  VALUES(:old.id_umowa,:old.data_zawarcia,:old.liczba_osob,:old.cena_suma,
  :old.wycieczka_id,:old.pracownik_id,:old.klient_id,:old.faktura_id,
  v_data_zarchiwizowania,v_rodzaj_zmiany,v_osoba_archiwizujaca);
END;
/
--testowanie wyzwalacza
INSERT INTO faktura VALUES(7,'faktura',1258,0.23,1548,'2016-08-10');
INSERT INTO umowa VALUES(7,'2016-08-10',3,1548.57,4,2,3,7);
UPDATE umowa SET cena_suma=4000 WHERE id_umowa=7;
DELETE FROM umowa WHERE id_umowa=7;
DELETE FROM faktura WHERE id_faktura=7;
SELECT * FROM umowa;
SELECT * FROM faktura;
SELECT * FROM umowa_archiwum;
DROP TABLE umowa_archiwum;
DROP TRIGGER umowa_do_arch;
----------

--trigger podaje nazwę starej oferty oraz nowej nazwy po modyfikacji rekordu
CREATE OR REPLACE TRIGGER zmiana_nazwy_oferty
AFTER UPDATE ON oferta FOR EACH ROW
BEGIN 
IF UPDATING THEN
  --:new.nazwa := :old.nazwa;
  DBMS_OUTPUT.PUT_LINE('Nazwa oferty <'||:old.nazwa
    ||'> zostala zmieniona na <'||:new.nazwa||'>');
END IF;
END;
/
--testowanie wyzwalacza
INSERT INTO oferta VALUES(7,'Marzenia torreadorów',2);
SELECT * FROM oferta;
UPDATE oferta SET nazwa='I ty zostaniesz torreadorem' 
WHERE nazwa='Marzenia torreadorów';
SELECT * FROM oferta;
DELETE FROM oferta WHERE id_oferta=7;
DROP TRIGGER zmiana_nazwy_oferty;
----------

--trigger po zmianie ceny na podaną kwotę podaje informację o starej i nowej
--cenie oraz czy jest to obniżka o ponad 15%
CREATE OR REPLACE TRIGGER obnizka_ceny BEFORE UPDATE OF cena_od_os ON wycieczka
FOR EACH ROW 
BEGIN
IF (:new.cena_od_os < :old.cena_od_os * 0.85) THEN
  IF UPDATING THEN
    dbms_output.put_line('Stara cena = ' || :old.cena_od_os);
    dbms_output.put_line('Nowa cena = ' || :new.cena_od_os);
    dbms_output.put_line('Obniżka ceny ponad 15%!');
  END IF;
END IF;
END;
/
--testowanie wyzwalacza
SELECT * FROM wycieczka;
UPDATE wycieczka SET cena_od_os = 80 where id_wycieczka=4;
DROP TRIGGER obnizka_ceny;
----------

--trigger wyświetli informację w przypadku gdy liczba dostępnych miejsc na wycieczce 
--zmaleje do 3 lub mniej
CREATE OR REPLACE TRIGGER niewiele_miejsc BEFORE UPDATE OF dostepne_miejsca ON wycieczka
FOR EACH ROW 
BEGIN
IF (:new.dostepne_miejsca <= 3) THEN
    dbms_output.put_line('Na tej wycieczce zostalo już niewiele miejsc!');
END IF;
END;
/
--testowanie wyzwalacza
SELECT * FROM wycieczka;
UPDATE wycieczka SET dostepne_miejsca = 2 WHERE id_wycieczka = 1;
DROP TRIGGER niewiele_miejsc;
----------

--trigger podaje o ile zmieniła się nowa pensja pracownika w porównaniu 
--do starej pensji
CREATE OR REPLACE TRIGGER roznica_w_pensji BEFORE UPDATE OF pensja ON pracownik FOR EACH ROW
DECLARE
v_roznica NUMBER(8,2);
BEGIN
  v_roznica := ABS(:new.pensja-:old.pensja);
  dbms_output.put_line('Pensja zmienia się o: '||v_roznica||' zl.');
END;
/
--testowanie wyzwalacza
SELECT * FROM pracownik;
UPDATE pracownik SET pensja=3000 WHERE id_pracownik=3;
DROP TRIGGER roznica_w_pensji;
