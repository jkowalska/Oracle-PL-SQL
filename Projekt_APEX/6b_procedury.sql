--procedura uaktualnia cenę brutto wycieczki w podanej fakturze i umowie o podany procent.
--W fakturze wylicza zaokrągloną wartość nowej cenybrutto i wylicza nową cenę netto
--wraz z podatkiem. Dodatkowo uaktualnia datę w fakturze na datę wprowadzenia zmiany.
--W umowie również wylicza nową cenę brutto (cena suma).
CREATE OR REPLACE PROCEDURE uaktualnienie_cen(
  v_id_faktura faktura.id_faktura%TYPE, 
  v_id_umowa umowa.id_umowa%TYPE,
  v_procent IN NUMBER) IS 
BEGIN
  UPDATE faktura SET cena_brutto=ROUND(cena_brutto*(1+v_procent/100),0) WHERE id_faktura=v_id_faktura;
  UPDATE faktura SET cena_netto=(cena_brutto/1.23) WHERE id_faktura=v_id_faktura;
  UPDATE faktura SET data=TRUNC(SYSDATE) WHERE id_faktura=v_id_faktura;  
  UPDATE umowa SET cena_suma=ROUND(cena_suma*(1+v_procent/100),0) WHERE id_umowa=v_id_umowa;
END;
/
--testowanie procedury
EXECUTE uaktualnienie_cen(5,5,5);
SELECT * FROM faktura;
SELECT * FROM umowa;
/
--DROP PROCEDURE uaktualnienie_cen;
----------

--procedura dodaje rabat w podanej wysokości danemu klientowi w przypadku gdy mu on
--przysługuje (jest on studentem lub osobą w wieku powyżej 65 lat). Poniższa procedura 
--wykorzystuje funkcję czy_przyznac_rabat(v_id_klient klient.id_klient%TYPE) 
CREATE OR REPLACE PROCEDURE dodaj_rabat(v_id_klient klient.id_klient%TYPE,v_rabat IN NUMBER) IS
BEGIN
  IF czy_przyznac_rabat(v_id_klient) THEN
    UPDATE klient SET rabat=v_rabat WHERE id_klient=v_id_klient;
  END IF;
END;
/
--testowanie procedury
EXECUTE dodaj_rabat(2,10);
EXECUTE dodaj_rabat(3,5);
SELECT * FROM klient;
/
--DROP PROCEDURE dodaj_rabat;
----------

--procedura podwyższa pensję pracownika o podanym id o dany procent
CREATE OR REPLACE PROCEDURE podwyzka_pensji(v_id_pracownik pracownik.id_pracownik%TYPE,v_procent IN NUMBER) IS 
BEGIN
  UPDATE pracownik SET pensja = pensja * (1 + v_procent/100) WHERE id_pracownik=v_id_pracownik;
END;
/
--testowanie procedury
EXECUTE podwyzka_pensji(1,8);
SELECT * FROM pracownik;
/
--DROP PROCEDURE podwyzka_pensji;
----------

--procedura zmienia liczbę dostępnych miejsc danej wycieczki
CREATE OR REPLACE PROCEDURE zmiana_liczby_miejsc(
v_id_wycieczka wycieczka.id_wycieczka%TYPE,
v_liczba_miejsc wycieczka.liczba_miejsc%TYPE) IS
BEGIN
  UPDATE wycieczka SET liczba_miejsc=v_liczba_miejsc WHERE id_wycieczka=v_id_wycieczka;
END;
/
--testowanie procedury
EXECUTE zmiana_liczby_miejsc(1,15);
SELECT * FROM wycieczka;
/
--DROP PROCEDURE zmiana_liczby_miejsc;
----------

--procedura wyświetla informację o podanym przewodniku: jego imię, nazwisko 
--oraz jaki zna język 
CREATE OR REPLACE PROCEDURE wyswietl_przewodnika(
	p_id_przewodnik IN przewodnik.id_przewodnik%TYPE,
	o_imie OUT przewodnik.imie%TYPE,
	o_nazwisko OUT przewodnik.nazwisko%TYPE,
	o_znajomosc_jezyka OUT przewodnik.znajomosc_jezyka%TYPE) IS
BEGIN
  SELECT imie,nazwisko,znajomosc_jezyka
  INTO o_imie,o_nazwisko,o_znajomosc_jezyka
  from przewodnik WHERE id_przewodnik = p_id_przewodnik;
END;
/
--testowanie procedury
DECLARE
o_imie przewodnik.imie%TYPE;
o_nazwisko przewodnik.nazwisko%TYPE;
o_znajomosc_jezyka przewodnik.znajomosc_jezyka%TYPE;
BEGIN
   wyswietl_przewodnika(1,o_imie,o_nazwisko,o_znajomosc_jezyka);
   DBMS_OUTPUT.PUT_LINE('Imie: '||o_imie);
   DBMS_OUTPUT.PUT_LINE('Nazwisko: '||o_nazwisko);
   DBMS_OUTPUT.PUT_LINE('Znajomosc jezyka: '||o_znajomosc_jezyka);
END;
/
--DROP PROCEDURE wyswietl_przewodnika;
