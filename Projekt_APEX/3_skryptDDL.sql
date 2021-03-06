-- Generated by Oracle SQL Developer Data Modeler 4.2.0.921
--   at:        2017-01-10 16:10:41 CET
--   site:      Oracle Database 11g
--   type:      Oracle Database 11g



CREATE TABLE adres (
    id_adres       NUMBER(11) NOT NULL,
    ulica          VARCHAR2(50) NOT NULL,
    nr_domu        VARCHAR2(10) NOT NULL,
    kod_pocztowy   CHAR(6) NOT NULL,
    miasto         VARCHAR2(30) NOT NULL,
    wojewodztwo    VARCHAR2(20) NOT NULL
);

CREATE INDEX adres__idx ON
    adres ( id_adres ASC );

ALTER TABLE adres ADD CONSTRAINT adres_pk PRIMARY KEY ( id_adres );

CREATE TABLE atrakcja (
    id_atrakcja   NUMBER(11) NOT NULL,
    nazwa         VARCHAR2(30) NOT NULL,
    opis          VARCHAR2(50)
);

CREATE INDEX atrakcja__idx ON
    atrakcja ( nazwa ASC );

ALTER TABLE atrakcja ADD CONSTRAINT atrakcja_pk PRIMARY KEY ( id_atrakcja );

CREATE TABLE autokar (
    id_autokar          NUMBER(11) NOT NULL,
    nazwa_przewoznika   VARCHAR2(30) NOT NULL
);

CREATE INDEX autokar__idx ON
    autokar ( nazwa_przewoznika ASC );

ALTER TABLE autokar ADD CONSTRAINT autokar_pk PRIMARY KEY ( id_autokar );

CREATE TABLE faktura (
    id_faktura    NUMBER(11) NOT NULL,
    nazwa         VARCHAR2(30) NOT NULL,
    cena_netto    NUMBER(8,2) NOT NULL,
    podatek       NUMBER(3,2) NOT NULL,
    cena_brutto   NUMBER(8,2) NOT NULL,
    data          DATE NOT NULL
);

CREATE UNIQUE INDEX faktura__idx ON
    faktura ( id_faktura ASC );

ALTER TABLE faktura ADD CONSTRAINT faktura_pk PRIMARY KEY ( id_faktura );

CREATE TABLE hotel (
    id_hotel    NUMBER(11) NOT NULL,
    nazwa       VARCHAR2(30) NOT NULL,
    standard    NUMBER(1) NOT NULL,
    miasto_id   NUMBER(11) NOT NULL
);

CREATE INDEX hotel__idx ON
    hotel ( id_hotel ASC );

ALTER TABLE hotel ADD CONSTRAINT hotel_pk PRIMARY KEY ( id_hotel );

CREATE TABLE klient (
    id_klient        NUMBER(11) NOT NULL,
    imie             VARCHAR2(20) NOT NULL,
    nazwisko         VARCHAR2(30) NOT NULL,
    data_urodzenia   DATE NOT NULL,
    telefon          VARCHAR2(12) NOT NULL,
    rabat            NUMBER(2),
    czy_student      CHAR(3),
    adres_id         NUMBER(11) NOT NULL
);

CREATE INDEX klient__idx ON
    klient ( id_klient ASC );

ALTER TABLE klient ADD CONSTRAINT klient_pk PRIMARY KEY ( id_klient );

CREATE TABLE kraj (
    id_kraj     NUMBER(11) NOT NULL,
    nazwa       VARCHAR2(30) NOT NULL,
    kontynent   VARCHAR2(30) NOT NULL
);

ALTER TABLE kraj ADD CONSTRAINT kraj_pk PRIMARY KEY ( id_kraj );

ALTER TABLE kraj ADD CONSTRAINT kraj__un UNIQUE ( nazwa );

CREATE TABLE linie_lotnicze (
    id_linie_lotnicze   NUMBER(11) NOT NULL,
    nazwa_linii         VARCHAR2(30) NOT NULL
);

CREATE INDEX linie_lotnicze__idx ON
    linie_lotnicze ( nazwa_linii ASC );

ALTER TABLE linie_lotnicze ADD CONSTRAINT linie_lotnicze_pk PRIMARY KEY ( id_linie_lotnicze );

CREATE TABLE miasto (
    id_miasto   NUMBER(11) NOT NULL,
    nazwa       VARCHAR2(30) NOT NULL,
    kraj_id     NUMBER(11) NOT NULL
);

ALTER TABLE miasto ADD CONSTRAINT miasto_pk PRIMARY KEY ( id_miasto );

ALTER TABLE miasto ADD CONSTRAINT miasto__un UNIQUE ( nazwa );

CREATE TABLE muzeum (
    id_muzeum   NUMBER(11) NOT NULL,
    nazwa       VARCHAR2(30) NOT NULL,
    miasto_id   NUMBER(11) NOT NULL
);

CREATE INDEX muzeum__idx ON
    muzeum ( id_muzeum ASC );

ALTER TABLE muzeum ADD CONSTRAINT muzeum_pk PRIMARY KEY ( id_muzeum );

CREATE TABLE oferta (
    id_oferta          NUMBER(11) NOT NULL,
    nazwa              VARCHAR2(30) NOT NULL,
    typ_wycieczki_id   NUMBER(11) NOT NULL
);

CREATE UNIQUE INDEX oferta__idx ON
    oferta ( nazwa ASC );

ALTER TABLE oferta ADD CONSTRAINT oferta_pk PRIMARY KEY ( id_oferta );

ALTER TABLE oferta ADD CONSTRAINT oferta__un UNIQUE ( nazwa );

CREATE TABLE oferta_atrakcja (
    oferta_id     NUMBER(11) NOT NULL,
    atrakcja_id   NUMBER(11) NOT NULL
);

ALTER TABLE oferta_atrakcja ADD CONSTRAINT oferta_atrakcja_fk_pk PRIMARY KEY ( oferta_id,atrakcja_id );

CREATE TABLE oferta_hotel (
    oferta_id   NUMBER(11) NOT NULL,
    hotel_id    NUMBER(11) NOT NULL
);

ALTER TABLE oferta_hotel ADD CONSTRAINT oferta_hotel_fk_pk PRIMARY KEY ( oferta_id,hotel_id );

CREATE TABLE oferta_miasto (
    oferta_id   NUMBER(11) NOT NULL,
    miasto_id   NUMBER(11) NOT NULL
);

ALTER TABLE oferta_miasto ADD CONSTRAINT oferta_miasto_fk_pk PRIMARY KEY ( oferta_id,miasto_id );

CREATE TABLE oferta_muzeum (
    oferta_id   NUMBER(11) NOT NULL,
    muzeum_id   NUMBER(11) NOT NULL
);

ALTER TABLE oferta_muzeum ADD CONSTRAINT oferta_muzeum_fk_pk PRIMARY KEY ( oferta_id,muzeum_id );

CREATE TABLE oferta_restauracja (
    oferta_id        NUMBER(11) NOT NULL,
    restauracja_id   NUMBER(11) NOT NULL
);

ALTER TABLE oferta_restauracja ADD CONSTRAINT oferta_restauracja_fk_pk PRIMARY KEY ( oferta_id,restauracja_id );

CREATE TABLE pracownik (
    id_pracownik        NUMBER(11) NOT NULL,
    imie                VARCHAR2(20) NOT NULL,
    nazwisko            VARCHAR2(30) NOT NULL,
    stanowisko          VARCHAR2(25) NOT NULL,
    pensja              NUMBER(8,2) NOT NULL,
    dodatek             NUMBER(8,2),
    data_urodzenia      DATE NOT NULL,
    data_zatrudnienia   DATE NOT NULL,
    pesel               NUMBER(11) NOT NULL,
    telefon             VARCHAR2(12) NOT NULL,
    adres_id            NUMBER(11) NOT NULL
);

CREATE INDEX pracownik__idx ON
    pracownik ( id_pracownik ASC );

ALTER TABLE pracownik ADD CONSTRAINT pracownik_ck_1 CHECK (
    pensja > 0
);

ALTER TABLE pracownik ADD CONSTRAINT pracownik_pk PRIMARY KEY ( id_pracownik );

ALTER TABLE pracownik ADD CONSTRAINT pracownik__un UNIQUE ( pesel );

CREATE TABLE przewodnik (
    id_przewodnik      NUMBER(11) NOT NULL,
    imie               VARCHAR2(20) NOT NULL,
    nazwisko           VARCHAR2(30) NOT NULL,
    pesel              NUMBER(11) NOT NULL,
    telefon            VARCHAR2(12) NOT NULL,
    znajomosc_jezyka   VARCHAR2(30) NOT NULL
);

CREATE UNIQUE INDEX przewodnik__idx ON
    przewodnik ( id_przewodnik ASC );

ALTER TABLE przewodnik ADD CONSTRAINT przewodnik_pk PRIMARY KEY ( id_przewodnik );

ALTER TABLE przewodnik ADD CONSTRAINT przewodnik__un UNIQUE ( pesel );

CREATE TABLE restauracja (
    id_restauracja   NUMBER(11) NOT NULL,
    nazwa            VARCHAR2(30) NOT NULL,
    standard         NUMBER(1) NOT NULL,
    typ              VARCHAR2(30),
    miasto_id        NUMBER(11) NOT NULL
);

CREATE INDEX restauracja__idx ON
    restauracja ( id_restauracja ASC );

ALTER TABLE restauracja ADD CONSTRAINT restauracja_pk PRIMARY KEY ( id_restauracja );

CREATE TABLE typ_wycieczki (
    id_typ_wycieczki   NUMBER(11) NOT NULL,
    nazwa              VARCHAR2(30) NOT NULL
);

CREATE UNIQUE INDEX typ_wycieczki__idx ON
    typ_wycieczki ( nazwa ASC );

ALTER TABLE typ_wycieczki ADD CONSTRAINT typ_wycieczki_pk PRIMARY KEY ( id_typ_wycieczki );

ALTER TABLE typ_wycieczki ADD CONSTRAINT typ_wycieczki__un UNIQUE ( nazwa );

CREATE TABLE ubezpieczyciel (
    id_ubezpieczyciel   NUMBER(11) NOT NULL,
    nazwa               VARCHAR2(30) NOT NULL
);

CREATE INDEX ubezpieczyciel__idx ON
    ubezpieczyciel ( nazwa ASC );

ALTER TABLE ubezpieczyciel ADD CONSTRAINT ubezpieczyciel_pk PRIMARY KEY ( id_ubezpieczyciel );

CREATE TABLE umowa (
    id_umowa        NUMBER(11) NOT NULL,
    data_zawarcia   DATE NOT NULL,
    liczba_osob     NUMBER(3) NOT NULL,
    cena_suma       NUMBER(8,2) NOT NULL,
    wycieczka_id    NUMBER(11) NOT NULL,
    pracownik_id    NUMBER(11) NOT NULL,
    klient_id       NUMBER(11) NOT NULL,
    faktura_id      NUMBER(11) NOT NULL
);

CREATE UNIQUE INDEX umowa__idx ON
    umowa ( id_umowa ASC );

ALTER TABLE umowa ADD CONSTRAINT umowa_ck_1 CHECK (
    cena_suma > 0
);

ALTER TABLE umowa ADD CONSTRAINT umowa_pk PRIMARY KEY ( id_umowa );

CREATE TABLE wycieczka (
    id_wycieczka        NUMBER(11) NOT NULL,
    standard            NUMBER(1) NOT NULL,
    wyzywienie          CHAR(3) NOT NULL,
    data_wyjazdu        DATE NOT NULL,
    data_powrotu        DATE NOT NULL,
    liczba_miejsc       NUMBER(3) NOT NULL,
    dostepne_miejsca    NUMBER(3) NOT NULL,
    cena_od_os          NUMBER(8,2) NOT NULL,
    ubezpieczyciel_id   NUMBER(11) NOT NULL,
    linie_lotnicze_id   NUMBER(11) NOT NULL,
    autokar_id          NUMBER(11) NOT NULL,
    oferta_id           NUMBER(11) NOT NULL,
    przewodnik_id       NUMBER(11) NOT NULL
);

CREATE UNIQUE INDEX wycieczka__idx ON
    wycieczka ( id_wycieczka ASC );

ALTER TABLE wycieczka ADD CONSTRAINT wycieczka_pk PRIMARY KEY ( id_wycieczka );

ALTER TABLE hotel ADD CONSTRAINT hotel_miasto_fk FOREIGN KEY ( miasto_id )
    REFERENCES miasto ( id_miasto );

ALTER TABLE klient ADD CONSTRAINT klient_adres_fk FOREIGN KEY ( adres_id )
    REFERENCES adres ( id_adres );

ALTER TABLE miasto ADD CONSTRAINT miasto_kraj_fk FOREIGN KEY ( kraj_id )
    REFERENCES kraj ( id_kraj );

ALTER TABLE muzeum ADD CONSTRAINT muzeum_miasto_fk FOREIGN KEY ( miasto_id )
    REFERENCES miasto ( id_miasto );

ALTER TABLE oferta_atrakcja ADD CONSTRAINT oferta_atrakcja_fk_atrakcja_fk FOREIGN KEY ( atrakcja_id )
    REFERENCES atrakcja ( id_atrakcja );

ALTER TABLE oferta_atrakcja ADD CONSTRAINT oferta_atrakcja_fk_oferta_fk FOREIGN KEY ( oferta_id )
    REFERENCES oferta ( id_oferta );

ALTER TABLE oferta_hotel ADD CONSTRAINT oferta_hotel_fk_hotel_fk FOREIGN KEY ( hotel_id )
    REFERENCES hotel ( id_hotel );

ALTER TABLE oferta_hotel ADD CONSTRAINT oferta_hotel_fk_oferta_fk FOREIGN KEY ( oferta_id )
    REFERENCES oferta ( id_oferta );

ALTER TABLE oferta_miasto ADD CONSTRAINT oferta_miasto_fk_miasto_fk FOREIGN KEY ( miasto_id )
    REFERENCES miasto ( id_miasto );

ALTER TABLE oferta_miasto ADD CONSTRAINT oferta_miasto_fk_oferta_fk FOREIGN KEY ( oferta_id )
    REFERENCES oferta ( id_oferta );

ALTER TABLE oferta_muzeum ADD CONSTRAINT oferta_muzeum_fk_muzeum_fk FOREIGN KEY ( muzeum_id )
    REFERENCES muzeum ( id_muzeum );

ALTER TABLE oferta_muzeum ADD CONSTRAINT oferta_muzeum_fk_oferta_fk FOREIGN KEY ( oferta_id )
    REFERENCES oferta ( id_oferta );

ALTER TABLE oferta_restauracja ADD CONSTRAINT oferta_rest_fk_oferta_fk FOREIGN KEY ( oferta_id )
    REFERENCES oferta ( id_oferta );

ALTER TABLE oferta_restauracja ADD CONSTRAINT oferta_rest_fk_restauracja_fk FOREIGN KEY ( restauracja_id )
    REFERENCES restauracja ( id_restauracja );

ALTER TABLE oferta ADD CONSTRAINT oferta_typ_wycieczki_fk FOREIGN KEY ( typ_wycieczki_id )
    REFERENCES typ_wycieczki ( id_typ_wycieczki );

ALTER TABLE pracownik ADD CONSTRAINT pracownik_adres_fk FOREIGN KEY ( adres_id )
    REFERENCES adres ( id_adres );

ALTER TABLE restauracja ADD CONSTRAINT restauracja_miasto_fk FOREIGN KEY ( miasto_id )
    REFERENCES miasto ( id_miasto );

ALTER TABLE umowa ADD CONSTRAINT umowa_faktura_fk FOREIGN KEY ( faktura_id )
    REFERENCES faktura ( id_faktura );

ALTER TABLE umowa ADD CONSTRAINT umowa_klient_fk FOREIGN KEY ( klient_id )
    REFERENCES klient ( id_klient );

ALTER TABLE umowa ADD CONSTRAINT umowa_pracownik_fk FOREIGN KEY ( pracownik_id )
    REFERENCES pracownik ( id_pracownik );

ALTER TABLE umowa ADD CONSTRAINT umowa_wycieczka_fk FOREIGN KEY ( wycieczka_id )
    REFERENCES wycieczka ( id_wycieczka );

ALTER TABLE wycieczka ADD CONSTRAINT wycieczka_autokar_fk FOREIGN KEY ( autokar_id )
    REFERENCES autokar ( id_autokar );

ALTER TABLE wycieczka ADD CONSTRAINT wycieczka_linie_lotnicze_fk FOREIGN KEY ( linie_lotnicze_id )
    REFERENCES linie_lotnicze ( id_linie_lotnicze );

ALTER TABLE wycieczka ADD CONSTRAINT wycieczka_oferta_fk FOREIGN KEY ( oferta_id )
    REFERENCES oferta ( id_oferta );

ALTER TABLE wycieczka ADD CONSTRAINT wycieczka_przewodnik_fk FOREIGN KEY ( przewodnik_id )
    REFERENCES przewodnik ( id_przewodnik );

ALTER TABLE wycieczka ADD CONSTRAINT wycieczka_ubezpieczyciel_fk FOREIGN KEY ( ubezpieczyciel_id )
    REFERENCES ubezpieczyciel ( id_ubezpieczyciel );

CREATE SEQUENCE adres_id_adres_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER adres_id_adres_trg BEFORE
    INSERT ON adres
    FOR EACH ROW
    WHEN (
        new.id_adres IS NULL
    )
BEGIN
    :new.id_adres := adres_id_adres_seq.nextval;
END;
/

CREATE SEQUENCE atrakcja_id_atrakcja_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER atrakcja_id_atrakcja_trg BEFORE
    INSERT ON atrakcja
    FOR EACH ROW
    WHEN (
        new.id_atrakcja IS NULL
    )
BEGIN
    :new.id_atrakcja := atrakcja_id_atrakcja_seq.nextval;
END;
/

CREATE SEQUENCE autokar_id_autokar_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER autokar_id_autokar_trg BEFORE
    INSERT ON autokar
    FOR EACH ROW
    WHEN (
        new.id_autokar IS NULL
    )
BEGIN
    :new.id_autokar := autokar_id_autokar_seq.nextval;
END;
/

CREATE SEQUENCE faktura_id_faktura_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER faktura_id_faktura_trg BEFORE
    INSERT ON faktura
    FOR EACH ROW
    WHEN (
        new.id_faktura IS NULL
    )
BEGIN
    :new.id_faktura := faktura_id_faktura_seq.nextval;
END;
/

CREATE SEQUENCE hotel_id_hotel_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER hotel_id_hotel_trg BEFORE
    INSERT ON hotel
    FOR EACH ROW
    WHEN (
        new.id_hotel IS NULL
    )
BEGIN
    :new.id_hotel := hotel_id_hotel_seq.nextval;
END;
/

CREATE SEQUENCE klient_id_klient_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER klient_id_klient_trg BEFORE
    INSERT ON klient
    FOR EACH ROW
    WHEN (
        new.id_klient IS NULL
    )
BEGIN
    :new.id_klient := klient_id_klient_seq.nextval;
END;
/

CREATE SEQUENCE kraj_id_kraj_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER kraj_id_kraj_trg BEFORE
    INSERT ON kraj
    FOR EACH ROW
    WHEN (
        new.id_kraj IS NULL
    )
BEGIN
    :new.id_kraj := kraj_id_kraj_seq.nextval;
END;
/

CREATE SEQUENCE linie_lotnicze_id_linie_lotnic START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER linie_lotnicze_id_linie_lotnic BEFORE
    INSERT ON linie_lotnicze
    FOR EACH ROW
    WHEN (
        new.id_linie_lotnicze IS NULL
    )
BEGIN
    :new.id_linie_lotnicze := linie_lotnicze_id_linie_lotnic.nextval;
END;
/

CREATE SEQUENCE miasto_id_miasto_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER miasto_id_miasto_trg BEFORE
    INSERT ON miasto
    FOR EACH ROW
    WHEN (
        new.id_miasto IS NULL
    )
BEGIN
    :new.id_miasto := miasto_id_miasto_seq.nextval;
END;
/

CREATE SEQUENCE muzeum_id_muzeum_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER muzeum_id_muzeum_trg BEFORE
    INSERT ON muzeum
    FOR EACH ROW
    WHEN (
        new.id_muzeum IS NULL
    )
BEGIN
    :new.id_muzeum := muzeum_id_muzeum_seq.nextval;
END;
/

CREATE SEQUENCE oferta_id_oferta_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER oferta_id_oferta_trg BEFORE
    INSERT ON oferta
    FOR EACH ROW
    WHEN (
        new.id_oferta IS NULL
    )
BEGIN
    :new.id_oferta := oferta_id_oferta_seq.nextval;
END;
/

CREATE SEQUENCE oferta_atrakcja_oferta_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER oferta_atrakcja_oferta_id_trg BEFORE
    INSERT ON oferta_atrakcja
    FOR EACH ROW
    WHEN (
        new.oferta_id IS NULL
    )
BEGIN
    :new.oferta_id := oferta_atrakcja_oferta_id_seq.nextval;
END;
/

CREATE SEQUENCE oferta_atrakcja_atrakcja_id START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER oferta_atrakcja_atrakcja_id BEFORE
    INSERT ON oferta_atrakcja
    FOR EACH ROW
    WHEN (
        new.atrakcja_id IS NULL
    )
BEGIN
    :new.atrakcja_id := oferta_atrakcja_atrakcja_id.nextval;
END;
/

CREATE SEQUENCE oferta_hotel_oferta_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER oferta_hotel_oferta_id_trg BEFORE
    INSERT ON oferta_hotel
    FOR EACH ROW
    WHEN (
        new.oferta_id IS NULL
    )
BEGIN
    :new.oferta_id := oferta_hotel_oferta_id_seq.nextval;
END;
/

CREATE SEQUENCE oferta_hotel_hotel_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER oferta_hotel_hotel_id_trg BEFORE
    INSERT ON oferta_hotel
    FOR EACH ROW
    WHEN (
        new.hotel_id IS NULL
    )
BEGIN
    :new.hotel_id := oferta_hotel_hotel_id_seq.nextval;
END;
/

CREATE SEQUENCE oferta_miasto_oferta_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER oferta_miasto_oferta_id_trg BEFORE
    INSERT ON oferta_miasto
    FOR EACH ROW
    WHEN (
        new.oferta_id IS NULL
    )
BEGIN
    :new.oferta_id := oferta_miasto_oferta_id_seq.nextval;
END;
/

CREATE SEQUENCE oferta_miasto_miasto_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER oferta_miasto_miasto_id_trg BEFORE
    INSERT ON oferta_miasto
    FOR EACH ROW
    WHEN (
        new.miasto_id IS NULL
    )
BEGIN
    :new.miasto_id := oferta_miasto_miasto_id_seq.nextval;
END;
/

CREATE SEQUENCE oferta_muzeum_oferta_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER oferta_muzeum_oferta_id_trg BEFORE
    INSERT ON oferta_muzeum
    FOR EACH ROW
    WHEN (
        new.oferta_id IS NULL
    )
BEGIN
    :new.oferta_id := oferta_muzeum_oferta_id_seq.nextval;
END;
/

CREATE SEQUENCE oferta_muzeum_muzeum_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER oferta_muzeum_muzeum_id_trg BEFORE
    INSERT ON oferta_muzeum
    FOR EACH ROW
    WHEN (
        new.muzeum_id IS NULL
    )
BEGIN
    :new.muzeum_id := oferta_muzeum_muzeum_id_seq.nextval;
END;
/

CREATE SEQUENCE oferta_restauracja_oferta_id START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER oferta_restauracja_oferta_id BEFORE
    INSERT ON oferta_restauracja
    FOR EACH ROW
    WHEN (
        new.oferta_id IS NULL
    )
BEGIN
    :new.oferta_id := oferta_restauracja_oferta_id.nextval;
END;
/

CREATE SEQUENCE oferta_restauracja_restauracja START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER oferta_restauracja_restauracja BEFORE
    INSERT ON oferta_restauracja
    FOR EACH ROW
    WHEN (
        new.restauracja_id IS NULL
    )
BEGIN
    :new.restauracja_id := oferta_restauracja_restauracja.nextval;
END;
/

CREATE SEQUENCE pracownik_id_pracownik_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER pracownik_id_pracownik_trg BEFORE
    INSERT ON pracownik
    FOR EACH ROW
    WHEN (
        new.id_pracownik IS NULL
    )
BEGIN
    :new.id_pracownik := pracownik_id_pracownik_seq.nextval;
END;
/

CREATE SEQUENCE przewodnik_id_przewodnik_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER przewodnik_id_przewodnik_trg BEFORE
    INSERT ON przewodnik
    FOR EACH ROW
    WHEN (
        new.id_przewodnik IS NULL
    )
BEGIN
    :new.id_przewodnik := przewodnik_id_przewodnik_seq.nextval;
END;
/

CREATE SEQUENCE restauracja_id_restauracja_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER restauracja_id_restauracja_trg BEFORE
    INSERT ON restauracja
    FOR EACH ROW
    WHEN (
        new.id_restauracja IS NULL
    )
BEGIN
    :new.id_restauracja := restauracja_id_restauracja_seq.nextval;
END;
/

CREATE SEQUENCE typ_wycieczki_id_typ_wycieczki START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER typ_wycieczki_id_typ_wycieczki BEFORE
    INSERT ON typ_wycieczki
    FOR EACH ROW
    WHEN (
        new.id_typ_wycieczki IS NULL
    )
BEGIN
    :new.id_typ_wycieczki := typ_wycieczki_id_typ_wycieczki.nextval;
END;
/

CREATE SEQUENCE ubezpieczyciel_id_ubezpieczyci START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER ubezpieczyciel_id_ubezpieczyci BEFORE
    INSERT ON ubezpieczyciel
    FOR EACH ROW
    WHEN (
        new.id_ubezpieczyciel IS NULL
    )
BEGIN
    :new.id_ubezpieczyciel := ubezpieczyciel_id_ubezpieczyci.nextval;
END;
/

CREATE SEQUENCE umowa_id_umowa_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER umowa_id_umowa_trg BEFORE
    INSERT ON umowa
    FOR EACH ROW
    WHEN (
        new.id_umowa IS NULL
    )
BEGIN
    :new.id_umowa := umowa_id_umowa_seq.nextval;
END;
/

CREATE SEQUENCE wycieczka_id_wycieczka_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER wycieczka_id_wycieczka_trg BEFORE
    INSERT ON wycieczka
    FOR EACH ROW
    WHEN (
        new.id_wycieczka IS NULL
    )
BEGIN
    :new.id_wycieczka := wycieczka_id_wycieczka_seq.nextval;
END;
/



-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                            23
-- CREATE INDEX                            16
-- ALTER TABLE                             57
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                          28
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                         28
-- CREATE MATERIALIZED VIEW                 0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
