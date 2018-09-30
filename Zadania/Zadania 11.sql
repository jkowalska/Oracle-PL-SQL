--Utworzyć trzy skrypty SQL demonstrujące możliwości zastosowania pakietów:

--a) pakiet UTL_FILE: testowanie zapisu i odczytu pliku tekstowego
CREATE TABLE produkt (
  id_osoba INTEGER,
  nazwa VARCHAR2(20)
);
INSERT INTO produkt VALUES (1, 'koszula');
INSERT INTO produkt VALUES (2, 'spodnie');
INSERT INTO produkt VALUES (3, 'sukienka');

SET SERVEROUTPUT ON
DECLARE
  v_plik utl_file.file_type;
  v_rekord produkt%ROWTYPE;
  v_wiersz VARCHAR2(500);
BEGIN
  v_plik := utl_file.fopen('DANE','produkt1.txt','w');
  FOR v_rekord IN (SELECT nazwa FROM produkt) LOOP
    utl_file.put_line(v_plik, v_rekord.nazwa);
  END LOOP;
  utl_file.fclose(v_plik);

  v_plik:=utl_file.fopen('DANE','produkt1.txt','r');
  LOOP
    utl_file.get_line(v_plik,v_wiersz);
    dbms_output.put_line(v_wiersz);
  END LOOP;
END;
/

--b) dowolnie wybranego pakietu różnego od UTL_FILE i DBMS_OUTPUT:
--testowanie pakietu DBMS_RANDOM: 
--rzut dwoma kostkami i losowanie trzech dużych liter (A-Z)

SET SERVEROUTPUT ON
DECLARE
  v_tekst VARCHAR2(15) := 'Twój rzut: ';
  v_rzuty_dwoma_kostkami NUMBER(2);
  v_litery CHAR(3);
BEGIN
  SELECT dbms_random.value(1,12) num INTO v_rzuty_dwoma_kostkami FROM dual;
  SELECT UPPER(dbms_random.string('A', 3)) INTO v_litery FROM dual;
  dbms_output.put_line(v_tekst || v_rzuty_dwoma_kostkami);
  dbms_output.put_line(v_litery);
END;

--c) dowolnie wybranego pakietu różnego od UTL_FILE, DBMS_OUTPUT i z pkt b):
--testowanie pakietu UTL_MAIL:

--SQL> @?/rdbms/admin/utlmail.sql
--SQL> @?/rdbms/admin/prvtmail.plb
--GRANT EXECUTE ON utl_mail TO student;
--ALTER SYSTEM SET smtp_out_server = '127.0.0.1';

--skrypt.sql
/*BEGIN
  DBMS_NETWORK_ACL_ADMIN.CREATE_ACL(acl         => 'stud.xml',
                                    description => 'HTTP Access',
                                    principal   => 'STUDENT',
                                    is_grant    => true,
                                    privilege   => 'connect',
                                    start_date  => null,
                                    end_date => null
                                    );
  DBMS_NETWORK_ACL_ADMIN.ADD_PRIVILEGE(acl      => 'stud.xml',
                                    principal   => 'STUDENT',
                                    is_grant    => true,
                                    privilege   => 'resolve'
                                    );
END;
/
COMMIT;*/

BEGIN
  utl_mail.send(
  nadawca    => 'jkowalska@sigma.ug.edu.pl',
  odbiorca   => 'jkowalska@sigma.ug.edu.pl',
  temat      => 'Test',
  wiadomosc  => 'Pierwszy mail testowy'
  );
END;
/
COMMIT;
