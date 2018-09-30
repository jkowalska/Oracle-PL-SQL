--5) W pewnej firmie powstała inicjatywa przyznania dodatku 
--motywacyjnego dla jej pracowników. Dodatek jest przyznawany 
--procentowo w stosunku do pensji podstawowej każdego pracownika.
--Wszystkie dodatki się sumują i są przyznawane w podanej kolejności, 
--jednak w sumie nie mogą być wyższe niż 60% pensji podstawowej 
--pracownika. Wyliczone kwoty dodatków dla pracowników należy 
--zapisać w kolumnie dodatek w tabeli pracownicy
SET SERVEROUTPUT ON
DECLARE
v_i PLS_INTEGER := 1;
v_count NUMBER(4);
v_dodatek NUMBER(22,2);
v_data_1 NUMBER(4); 
v_data_2 NUMBER(4); 

CURSOR cur_pracownik IS SELECT * FROM pracownicy;
v_rekord pracownicy%ROWTYPE;

BEGIN
  SELECT COUNT(*) INTO v_count FROM pracownicy;
  OPEN cur_pracownik;
  
  FOR v_i IN 1..v_count LOOP 
  EXIT WHEN cur_pracownik%NOTFOUND;
  FETCH cur_pracownik INTO v_rekord;

    IF (v_rekord.pensja < 3000) THEN
      v_dodatek := 3000-v_rekord.pensja;
    END IF;

    IF (SYSDATE-v_rekord.data_zatrudnienia > 0) THEN
      SELECT EXTRACT(YEAR FROM SYSDATE) INTO v_data_1 FROM dual;
      SELECT EXTRACT(YEAR FROM v_rekord.data_zatrudnienia) INTO v_data_2 FROM dual;
      v_dodatek := v_dodatek+v_rekord.pensja*((v_data_1-v_data_2)*0.01); 
    END IF;

    CASE v_rekord.stanowisko
      WHEN 'dyrektor' THEN v_dodatek := v_dodatek+0.2*v_rekord.pensja;
      WHEN 'kierownik' THEN v_dodatek := v_dodatek+0.1*v_rekord.pensja;
      WHEN 'brygadzista' THEN v_dodatek := v_dodatek+0.05*v_rekord.pensja; 
      ELSE NULL;
    END CASE;

    IF (SUBSTR(v_rekord.imie, -1, 1) = 'a') THEN
      v_dodatek := v_dodatek+0.05*v_rekord.pensja; 
    END IF; 

    IF (v_dodatek > 0.6*v_rekord.pensja) THEN
      v_dodatek := 0.6*v_rekord.pensja;
    END IF; 

    dbms_output.put_line(v_rekord.imie||' '||v_rekord.nazwisko||' '||v_rekord.stanowisko||' '||v_dodatek); 
  END LOOP;
  CLOSE cur_pracownik;
END;
/

--6) Dana jest tabela CREATE TABLE punkt(x INT, y INT); Po wykonaniu 
--zapytania SELECT x, y, count(*) AS ile FROM punkt GROUP BY x, y 
--ORDER BY ile DESC; zauważono, że niektóre wartości współrzędnych 
--punktów się powtarzają. Napisz program, który pozostawi w tabeli 
--punkt unikatowe współrzędne punktów (x,y).
CREATE TABLE punkt(x INT, y INT);
BEGIN
 FOR v_i IN 1..1000 LOOP
 INSERT INTO punkt(x,y) VALUES (MOD(123*v_i,MOD(127*v_i,27)),MOD(147*v_i,37));
 END LOOP;
END;
/
--SELECT x, y, count(*) AS ile FROM punkt GROUP BY x, y ORDER BY ile DESC;
SET SERVEROUTPUT ON
DECLARE
v_licznik NUMBER(5) := 0;
v_count NUMBER(5);
v_ile NUMBER(5);
v_rekord punkt%ROWTYPE;
CURSOR cur_punkt IS SELECT x, y, COUNT(*) AS ile FROM punkt GROUP BY x, y ORDER BY ile DESC;

BEGIN
  OPEN cur_punkt;
  SELECT COUNT(*) INTO v_count FROM punkt;
  
  FOR v_licznik IN 1..v_count LOOP  
    FETCH cur_punkt into v_rekord.x,v_rekord.y,v_ile;    
    IF(v_ile > 1) THEN
      DELETE FROM punkt WHERE (x = v_rekord.x AND y = v_rekord.y);
      INSERT INTO punkt(x,y) VALUES(v_rekord.x, v_rekord.y);
    END IF;   
    EXIT WHEN cur_punkt%NOTFOUND;  
  END LOOP;
  CLOSE cur_punkt;
END;
/

SELECT x, y, COUNT(*) AS ile FROM punkt GROUP BY x, y ORDER BY ile DESC;

--7) Dane są tabele i przykładowe rekordy:
--a) Napisać instrukcje SQL, które utworzą przedstawioną strukturę tabel 
--i dodadzą przykładowe rekordy.

CREATE TABLE w_egzamin
  (
    id_egzamin     NUMBER (11) NOT NULL ,
    data           DATE NOT NULL ,
    ocena          NUMBER (2,1) NOT NULL ,
    nr_terminu     NUMBER (1) ,
    w_przedmiot_id NUMBER (11) NOT NULL ,
    w_student_id   NUMBER (11) NOT NULL
  ) ;
ALTER TABLE w_egzamin ADD CONSTRAINT w_egzamin_PK PRIMARY KEY ( id_egzamin ) ;


CREATE TABLE w_przedmiot
  (
    id_przedmiot NUMBER (11) NOT NULL ,
    nazwa        VARCHAR2 (50) NOT NULL ,
    ilosc_godz   NUMBER (2) NOT NULL
  ) ;
ALTER TABLE w_przedmiot ADD CONSTRAINT w_przedmiot_PK PRIMARY KEY ( id_przedmiot ) ;


CREATE TABLE w_student
  (
    id_student NUMBER (11) NOT NULL ,
    imie       VARCHAR2 (30) NOT NULL ,
    nazwisko   VARCHAR2 (40) NOT NULL
  ) ;
ALTER TABLE w_student ADD CONSTRAINT w_student_PK PRIMARY KEY ( id_student ) ;


ALTER TABLE w_egzamin ADD CONSTRAINT w_egzamin_w_przedmiot_FK FOREIGN KEY ( w_przedmiot_id ) REFERENCES w_przedmiot ( id_przedmiot ) ;

ALTER TABLE w_egzamin ADD CONSTRAINT w_egzamin_w_student_FK FOREIGN KEY ( w_student_id ) REFERENCES w_student ( id_student ) ;

INSERT INTO w_student VALUES(1,'Jan','Kowalski');
INSERT INTO w_student VALUES(2,'Anna','Komar');
INSERT INTO w_student VALUES(3,'Jerzy','Nowak');
INSERT INTO w_student VALUES(4,'Sebastian','Rybicki');

INSERT INTO w_przedmiot VALUES(1,'Bazy danych',60);
INSERT INTO w_przedmiot VALUES(2,'Analiza matematyczna',45);
INSERT INTO w_przedmiot VALUES(3,'Rachunek prawdopodobieństwa',30);

INSERT INTO w_egzamin VALUES(1,'14/11/03',2,1,1,3);
INSERT INTO w_egzamin VALUES(2,'14/11/03',2,1,2,3);
INSERT INTO w_egzamin VALUES(3,'14/11/03',2,1,3,3);
INSERT INTO w_egzamin VALUES(4,'14/11/04',4,1,1,1);
INSERT INTO w_egzamin VALUES(5,'14/11/04',4.5,1,2,1);
INSERT INTO w_egzamin VALUES(6,'14/11/04',5,1,4,1);
INSERT INTO w_egzamin VALUES(7,'14/11/11',3,2,1,3);
INSERT INTO w_egzamin VALUES(8,'14/11/11',2,2,2,3);
INSERT INTO w_egzamin VALUES(9,'14/11/12',2,1,3,2);

--b) Stworzyć tabelę w_warunek(id,w_student_id, w_przedmiot_id, kwota), 
--gdzie kolumna id powinna być automatycznie autoinkrementowana.

CREATE TABLE w_warunek(
id_warunek NUMBER (11) NOT NULL,
w_student_id NUMBER (11) NOT NULL, 
w_przedmiot_id NUMBER (11) NOT NULL, 
kwota NUMBER(6,2) 
);
/
CREATE SEQUENCE w_warunek_sek START WITH 1 INCREMENT BY 1 NOMAXVALUE;
/
CREATE TRIGGER insert_w_warunek BEFORE INSERT ON w_warunek FOR EACH ROW
BEGIN
  SELECT w_warunek_sek.NEXTVAL INTO :new.id_warunek FROM dual;
END;
/ 
