CREATE OR REPLACE PACKAGE biuro_turystyczne IS
	FUNCTION czy_przyznac_rabat(
    v_id_klient klient.id_klient%TYPE) RETURN BOOLEAN;
	FUNCTION popularnosc_wycieczki(
		v_id_wycieczka wycieczka.id_wycieczka%TYPE) RETURN BOOLEAN;
  FUNCTION srednia_cena(
    v_standard wycieczka.standard%TYPE) RETURN NUMBER;
  FUNCTION srednia_cena(
    v_standard wycieczka.standard%TYPE, v_wyzywienie wycieczka.wyzywienie%TYPE) RETURN NUMBER;
 	FUNCTION cena_wycieczki(
		v_id_wycieczka wycieczka.id_wycieczka%TYPE) RETURN BOOLEAN;
  FUNCTION czy_przyznac_dodatek(
  	v_id_pracownik pracownik.id_pracownik%TYPE) RETURN BOOLEAN;
  FUNCTION czy_z_wyzywieniem(
    v_id_wycieczka wycieczka.id_wycieczka%TYPE) RETURN BOOLEAN;
  PROCEDURE uaktualnienie_cen(
  		v_id_faktura faktura.id_faktura%TYPE, 
  		v_id_umowa umowa.id_umowa%TYPE,
  		v_procent IN NUMBER);
	PROCEDURE dodaj_rabat(
    v_id_klient klient.id_klient%TYPE,v_rabat IN NUMBER); 
	PROCEDURE podwyzka_pensji(
    v_procent IN NUMBER);
  PROCEDURE podwyzka_pensji(
    v_id_pracownik pracownik.id_pracownik%TYPE,v_procent IN NUMBER);
  PROCEDURE zmiana_liczby_miejsc(
		v_id_wycieczka wycieczka.id_wycieczka%TYPE,
		v_liczba_miejsc wycieczka.liczba_miejsc%TYPE);
  PROCEDURE wyswietl_przewodnika(
	   p_id_przewodnik IN przewodnik.id_przewodnik%TYPE,
	   o_imie OUT przewodnik.imie%TYPE,
	   o_nazwisko OUT przewodnik.nazwisko%TYPE,
	   o_znajomosc_jezyka OUT przewodnik.znajomosc_jezyka%TYPE);
END biuro_turystyczne;
/

CREATE OR REPLACE PACKAGE BODY biuro_turystyczne IS

FUNCTION czy_przyznac_rabat(v_id_klient klient.id_klient%TYPE) 
RETURN BOOLEAN IS
v_wiek NUMBER(3);
v_czy_student CHAR(3);
BEGIN
  SELECT ROUND(((sysdate - data_urodzenia) / 365),0) INTO v_wiek FROM klient WHERE id_klient=v_id_klient;
  SELECT czy_student INTO v_czy_student FROM klient WHERE id_klient=v_id_klient;
  IF v_wiek > 65 OR v_czy_student='TAK' THEN
    RETURN TRUE;
  ELSE
    RETURN FALSE;
  END IF;  
END czy_przyznac_rabat;

FUNCTION popularnosc_wycieczki(v_id_wycieczka wycieczka.id_wycieczka%TYPE)
RETURN BOOLEAN IS
  v_liczba_miejsc NUMBER(3);
  v_dostepne_miejsca NUMBER(3);
BEGIN
  SELECT dostepne_miejsca,liczba_miejsc INTO v_dostepne_miejsca,v_liczba_miejsc FROM wycieczka WHERE id_wycieczka = v_id_wycieczka;
   IF v_liczba_miejsc - v_dostepne_miejsca >= 8 THEN
    RETURN TRUE;
  ELSE
    RETURN FALSE;
  END IF;
END popularnosc_wycieczki;

FUNCTION srednia_cena(v_standard wycieczka.standard%TYPE) RETURN NUMBER IS
srednia NUMBER;
BEGIN
SELECT ROUND(AVG(cena_od_os),2) INTO srednia FROM wycieczka WHERE standard=v_standard;
  RETURN srednia;
END srednia_cena;

FUNCTION srednia_cena(v_standard wycieczka.standard%TYPE, v_wyzywienie wycieczka.wyzywienie%TYPE) RETURN NUMBER IS
srednia NUMBER;
BEGIN
SELECT ROUND(AVG(cena_od_os),2) INTO srednia FROM wycieczka WHERE standard=v_standard AND wyzywienie=v_wyzywienie;
  RETURN srednia;
END srednia_cena;

FUNCTION cena_wycieczki(
v_id_wycieczka wycieczka.id_wycieczka%TYPE) RETURN BOOLEAN IS
v_cena_od_os NUMBER(8,2);  
BEGIN
  SELECT cena_od_os INTO v_cena_od_os FROM wycieczka WHERE id_wycieczka = v_id_wycieczka;
  IF v_cena_od_os > 2500 THEN
    RETURN TRUE;
  ELSIF v_cena_od_os <= 2500 THEN
    RETURN FALSE;
  END IF;
END cena_wycieczki;

FUNCTION czy_przyznac_dodatek(v_id_pracownik pracownik.id_pracownik%TYPE)
RETURN BOOLEAN IS
v_data_1 NUMBER(4);
v_data_2 NUMBER(4);
v_rok NUMBER(2);
BEGIN
  SELECT extract(year from SYSDATE) INTO v_data_1 FROM dual;
  SELECT extract(year from data_zatrudnienia) INTO v_data_2 FROM pracownik WHERE id_pracownik = v_id_pracownik;
  v_rok := v_data_1-v_data_2;
  IF v_rok >= 1 THEN
    RETURN TRUE;
  ELSE
    RETURN FALSE;
  END IF; 
END czy_przyznac_dodatek;

FUNCTION czy_z_wyzywieniem(v_id_wycieczka wycieczka.id_wycieczka%TYPE)
RETURN BOOLEAN IS
  v_wyzywienie CHAR(3);
BEGIN
  SELECT wyzywienie INTO v_wyzywienie FROM wycieczka WHERE id_wycieczka = v_id_wycieczka;
  IF v_wyzywienie='TAK' THEN
    RETURN TRUE;
  ELSE
    RETURN FALSE;
  END IF;
END czy_z_wyzywieniem;

PROCEDURE uaktualnienie_cen(
  v_id_faktura faktura.id_faktura%TYPE, 
  v_id_umowa umowa.id_umowa%TYPE,
  v_procent IN NUMBER) IS 
BEGIN
  UPDATE faktura SET cena_brutto=ROUND(cena_brutto*(1+v_procent/100),0) WHERE id_faktura=v_id_faktura;
  UPDATE faktura SET cena_netto=(cena_brutto/1.23) WHERE id_faktura=v_id_faktura;
  UPDATE faktura SET data=TRUNC(SYSDATE) WHERE id_faktura=v_id_faktura;  
  UPDATE umowa SET cena_suma=ROUND(cena_suma*(1+v_procent/100),0) WHERE id_umowa=v_id_umowa;
END uaktualnienie_cen;

PROCEDURE dodaj_rabat(v_id_klient klient.id_klient%TYPE,v_rabat IN NUMBER) IS
BEGIN
  IF czy_przyznac_rabat(v_id_klient) THEN
    UPDATE klient SET rabat=v_rabat WHERE id_klient=v_id_klient;
  END IF;
END dodaj_rabat;

PROCEDURE podwyzka_pensji(v_procent IN NUMBER) IS 
BEGIN
  UPDATE pracownik SET pensja = pensja * (1 + v_procent/100);
END podwyzka_pensji;

PROCEDURE podwyzka_pensji(v_id_pracownik pracownik.id_pracownik%TYPE,v_procent IN NUMBER) IS 
BEGIN
  UPDATE pracownik SET pensja = pensja * (1 + v_procent/100) WHERE id_pracownik=v_id_pracownik;
END podwyzka_pensji;

PROCEDURE zmiana_liczby_miejsc(
v_id_wycieczka wycieczka.id_wycieczka%TYPE,
v_liczba_miejsc wycieczka.liczba_miejsc%TYPE) IS
BEGIN
  UPDATE wycieczka SET liczba_miejsc=v_liczba_miejsc WHERE id_wycieczka=v_id_wycieczka;
END zmiana_liczby_miejsc;

PROCEDURE wyswietl_przewodnika(
  p_id_przewodnik IN przewodnik.id_przewodnik%TYPE,
  o_imie OUT przewodnik.imie%TYPE,
  o_nazwisko OUT przewodnik.nazwisko%TYPE,
  o_znajomosc_jezyka OUT przewodnik.znajomosc_jezyka%TYPE) IS
BEGIN
  SELECT imie,nazwisko,znajomosc_jezyka
  INTO o_imie,o_nazwisko,o_znajomosc_jezyka
  from przewodnik WHERE id_przewodnik = p_id_przewodnik;
END wyswietl_przewodnika;

END biuro_turystyczne;
/

SET SERVEROUTPUT ON
DECLARE
o_imie przewodnik.imie%TYPE;
o_nazwisko przewodnik.nazwisko%TYPE;
o_znajomosc_jezyka przewodnik.znajomosc_jezyka%TYPE;
BEGIN
  IF(czy_przyznac_rabat(1)) THEN
    dbms_output.put_line('Klientowi należy się rabat');
  ELSE
    dbms_output.put_line('Klientowi nie należy się rabat');
  END IF;
  IF(czy_przyznac_rabat(5)) THEN
    dbms_output.put_line('Klientowi należy się rabat');
  ELSE
    dbms_output.put_line('Klientowi nie należy się rabat');
  END IF;

  IF(popularnosc_wycieczki(6)) THEN
    dbms_output.put_line('Podana wycieczka jest popularna');
  ELSE
    dbms_output.put_line('Podana wycieczka nie jest popularna');
  END IF;

  IF(czy_z_wyzywieniem(5)) THEN
    dbms_output.put_line('Ta wycieczka oferuje wyzywienie');
  ELSE
    dbms_output.put_line('Ta wycieczka nie oferuje wyzywienia');
  END IF;
  IF(czy_z_wyzywieniem(6)) THEN
    dbms_output.put_line('Ta wycieczka oferuje wyzywienie');
  ELSE
    dbms_output.put_line('Ta wycieczka nie oferuje wyzywienia');
  END IF;

  IF(cena_wycieczki(3)) THEN
    dbms_output.put_line('Droższa wycieczka o podwyższonym standardzie');
  ELSE
    dbms_output.put_line('Tańsza wycieczka na każdą kieszeń');
  END IF;
  IF(cena_wycieczki(5)) THEN
    dbms_output.put_line('Droższa wycieczka o podwyższonym standardzie');
  ELSE
    dbms_output.put_line('Tańsza wycieczka na każdą kieszeń');
  END IF;

  IF(czy_przyznac_dodatek(2)) THEN
    dbms_output.put_line('Dodatek należy się');
  ELSE
    dbms_output.put_line('Dodatek sie nie należy');
  END IF;

  wyswietl_przewodnika(1,o_imie,o_nazwisko,o_znajomosc_jezyka);
   DBMS_OUTPUT.PUT_LINE('Imie: '||o_imie);
   DBMS_OUTPUT.PUT_LINE('Nazwisko: '||o_nazwisko);
   DBMS_OUTPUT.PUT_LINE('Znajomosc jezyka: '||o_znajomosc_jezyka);
END;
/
  SELECT biuro_turystyczne.srednia_cena(5) FROM dual;
  SELECT biuro_turystyczne.srednia_cena(4,'TAK') FROM dual;
	EXECUTE biuro_turystyczne.uaktualnienie_cen(5,5,5);
	EXECUTE biuro_turystyczne.dodaj_rabat(2,10);
  EXECUTE biuro_turystyczne.dodaj_rabat(3,5);
  EXECUTE biuro_turystyczne.podwyzka_pensji(5);
	EXECUTE biuro_turystyczne.podwyzka_pensji(1,8);
  EXECUTE biuro_turystyczne.zmiana_liczby_miejsc(1,15);

DROP PACKAGE biuro_turystyczne;
