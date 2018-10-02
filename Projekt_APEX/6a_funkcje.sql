--funkcja oblicza wiek podanego klienta z jego daty urodzenia oraz wyciąga z bazy
--informację czy klient jest studentem. W przypadku gdy klient jest studentem lub
--w wieku powyżej 65 lat, wyświetlana jest informacja o tym, że należy mu się rabat.
--funkcja ta wykorzystana jest dla procedury dodaj_rabat przy udzielaniu rabatu
CREATE OR REPLACE FUNCTION czy_przyznac_rabat(v_id_klient klient.id_klient%TYPE) 
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
END;
/
--testowanie funkcji
SET SERVEROUTPUT ON
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
END;
/
--SELECT * FROM klient;
--DROP FUNCTION czy_przyznac_rabat;
----------

--funkcja pobiera liczbę dostępnych i wykorzystanych miejsc na danej wycieczce
--i podaje informację czy dana wycieczka cieszy się popularnością (zapisanych
--na nią jest równo lub więcej niż 12 osób)
CREATE OR REPLACE FUNCTION popularnosc_wycieczki(v_id_wycieczka wycieczka.id_wycieczka%TYPE)
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
END;
/
--testowanie funkcji
SET SERVEROUTPUT ON
BEGIN
  IF(popularnosc_wycieczki(6)) THEN
    dbms_output.put_line('Podana wycieczka jest popularna');
  ELSE
    dbms_output.put_line('Podana wycieczka nie jest popularna');
  END IF;
END;
/
--SELECT * FROM wycieczka;
--DROP FUNCTION popularnosc_wycieczki;
----------

--funkcja wylicza średnią cenę wycieczki dla podanego standardu
CREATE OR REPLACE FUNCTION srednia_cena(v_standard wycieczka.standard%TYPE) RETURN NUMBER IS
srednia NUMBER;
BEGIN
SELECT ROUND(AVG(cena_od_os),2) INTO srednia FROM wycieczka WHERE standard=v_standard;
  RETURN srednia;
END;
/
--testowanie funkcji
SELECT srednia_cena(5) FROM dual;
DROP FUNCTION srednia_cena;
----------

--funkcja pobiera z tabeli wysokość ceny wycieczki. W przypadku wycieczki droższej 
--niż 2500 podaje, że jest to droższa wycieczka o podwyższonym standardzie,
--w przeciwnym wypadku podaje, że jest to tańsza wycieczka na każdą kieszeń
CREATE OR REPLACE FUNCTION cena_wycieczki(
v_id_wycieczka wycieczka.id_wycieczka%TYPE) RETURN BOOLEAN IS
v_cena_od_os NUMBER(8,2);  
BEGIN
  SELECT cena_od_os INTO v_cena_od_os FROM wycieczka WHERE id_wycieczka = v_id_wycieczka;
  IF v_cena_od_os > 2500 THEN
    RETURN TRUE;
  ELSIF v_cena_od_os <= 2500 THEN
    RETURN FALSE;
  END IF;
END;
/
--testowanie funkcji
SET SERVEROUTPUT ON
BEGIN
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
END;
/
--SELECT * FROM wycieczka;
--DROP FUNCTION cena_wycieczki;
----------

--funkcja pobiera z tabeli datę zatrudnienia proacownika i podaje informację
--o uprawnieniu do dodatku dla pracowników, którzy pracują w biurze dłużej niż rok
CREATE OR REPLACE FUNCTION czy_przyznac_dodatek(v_id_pracownik pracownik.id_pracownik%TYPE)
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
END;
/
--testowanie funkcji
SET SERVEROUTPUT ON
BEGIN
  IF(czy_przyznac_dodatek(2)) THEN
    dbms_output.put_line('Dodatek należy się');
  ELSE
    dbms_output.put_line('Dodatek sie nie należy');
  END IF;
END;
/
--SELECT * FROM pracownik;
--DROP FUNCTION cena_wycieczki;
----------

--funkcja pobiera z tabeli rekord dotyczący tego czy na danej wycieczce oferowane jest 
--w cenie wyżywienie (TAK lub NIE), następnie podaje informację na ten temat
CREATE OR REPLACE FUNCTION czy_z_wyzywieniem(v_id_wycieczka wycieczka.id_wycieczka%TYPE)
RETURN BOOLEAN IS
  v_wyzywienie CHAR(3);
BEGIN
  SELECT wyzywienie INTO v_wyzywienie FROM wycieczka WHERE id_wycieczka = v_id_wycieczka;
  IF v_wyzywienie='TAK' THEN
    RETURN TRUE;
  ELSE
    RETURN FALSE;
  END IF;
END;
/
--testowanie funkcji
SET SERVEROUTPUT ON
BEGIN
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
END;
/
--SELECT * FROM wycieczka;
--DROP FUNCTION czy_z_wyzywieniem;
