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

CREATE SEQUENCE adres_id_adres_seq START WITH 10 INCREMENT BY 1 NOCACHE ORDER;

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

CREATE SEQUENCE atrakcja_id_atrakcja_seq START WITH 10 INCREMENT BY 1 NOCACHE ORDER;

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

CREATE SEQUENCE autokar_id_autokar_seq START WITH 4 INCREMENT BY 1 NOCACHE ORDER;

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

CREATE SEQUENCE faktura_id_faktura_seq START WITH 7 INCREMENT BY 1 NOCACHE ORDER;

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

CREATE SEQUENCE hotel_id_hotel_seq START WITH 7 INCREMENT BY 1 NOCACHE ORDER;

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

CREATE SEQUENCE klient_id_klient_seq START WITH 7 INCREMENT BY 1 NOCACHE ORDER;

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

CREATE SEQUENCE kraj_id_kraj_seq START WITH 4 INCREMENT BY 1 NOCACHE ORDER;

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

CREATE SEQUENCE linie_lotnicze_id_linie_lotnic START WITH 4 INCREMENT BY 1 NOCACHE ORDER;

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

CREATE SEQUENCE miasto_id_miasto_seq START WITH 4 INCREMENT BY 1 NOCACHE ORDER;

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

CREATE SEQUENCE muzeum_id_muzeum_seq START WITH 7 INCREMENT BY 1 NOCACHE ORDER;

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

CREATE SEQUENCE oferta_id_oferta_seq START WITH 7 INCREMENT BY 1 NOCACHE ORDER;

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

CREATE SEQUENCE pracownik_id_pracownik_seq START WITH 4 INCREMENT BY 1 NOCACHE ORDER;

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

CREATE SEQUENCE przewodnik_id_przewodnik_seq START WITH 4 INCREMENT BY 1 NOCACHE ORDER;

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

CREATE SEQUENCE restauracja_id_restauracja_seq START WITH 7 INCREMENT BY 1 NOCACHE ORDER;

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

CREATE SEQUENCE typ_wycieczki_id_typ_wycieczki START WITH 4 INCREMENT BY 1 NOCACHE ORDER;

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

CREATE SEQUENCE ubezpieczyciel_id_ubezpieczyci START WITH 4 INCREMENT BY 1 NOCACHE ORDER;

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

CREATE SEQUENCE umowa_id_umowa_seq START WITH 7 INCREMENT BY 1 NOCACHE ORDER;

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

CREATE SEQUENCE wycieczka_id_wycieczka_seq START WITH 7 INCREMENT BY 1 NOCACHE ORDER;

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

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';

--INSERT INTO adres(id_adres,ulica,nr_domu,kod_pocztowy,miasto,wojewodztwo)
INSERT INTO adres VALUES(1,'Akacjowa','55 c','80-285','Sopot','pomorskie');
INSERT INTO adres VALUES(2,'Letniskowa','162','85-375','Gdańsk','pomorskie');
INSERT INTO adres VALUES(3,'Kwiatkowa','45/65','81-232','Gdynia','pomorskie');
INSERT INTO adres VALUES(4,'Babeczkowa','17 d','83-285','Gdańsk','pomorskie');
INSERT INTO adres VALUES(5,'Trawnikowa','21','87-724','Rumia','pomorskie');
INSERT INTO adres VALUES(6,'Zimowa','86/3','81-351','Gdynia','pomorskie');
INSERT INTO adres VALUES(7,'Dyniowa','3','81-351','Gdynia','pomorskie');
INSERT INTO adres VALUES(8,'Zimowa','27/12','81-351','Gdynia','pomorskie');
INSERT INTO adres VALUES(9,'Zimowa','40','81-351','Gdynia','pomorskie');

--INSERT INTO atrakcja(id_atrakcja,nazwa,opis)
INSERT INTO atrakcja VALUES(1,'basen','basen na powietrzu z barem'); 
INSERT INTO atrakcja VALUES(2,'park wodny','rozrywka dla całej rodziny');
INSERT INTO atrakcja VALUES(3,'masaż i sauna','ekskluzywne spa');
INSERT INTO atrakcja VALUES(4,'rejs statkiem','zwiedź miasto płynąc rzeką');
INSERT INTO atrakcja VALUES(5,'siłownia','nabierz masy');
INSERT INTO atrakcja VALUES(6,'kort tenisowy','weź udział w lekcji gry w tenisa');
INSERT INTO atrakcja VALUES(7,'wycieczka rowerowa','ruch na świeżym powietrzu');
INSERT INTO atrakcja VALUES(8,'dyskoteka','zespół, dj i najwieksze przeboje');
INSERT INTO atrakcja VALUES(9,'Sylwester pod Wieżą Eiffla','pokaz sztucznych ogni');

--INSERT INTO autokar(id_autokar,nazwa_przewoznika)
INSERT INTO autokar VALUES(1,'Max-Bus');
INSERT INTO autokar VALUES(2,'Travel Transport');
INSERT INTO autokar VALUES(3,'EkspresBus24');

--INSERT INTO klient(id_klient,imie,nazwisko,data_urodzenia,telefon,rabat,czy_student,adres_id)
INSERT INTO klient VALUES(1,'Jerzy','Nowak','1974-05-17','123456789',NULL,'NIE',4);
INSERT INTO klient VALUES(2,'Grzegorz','Kos','1945-04-18','123123789',NULL,'NIE',5);
INSERT INTO klient VALUES(3,'Anna','Wilk','1992-02-19','123456123',NULL,'TAK',6);
INSERT INTO klient VALUES(4,'Adam','Bukiet','1983-03-20','132465798',NULL,'TAK',7);
INSERT INTO klient VALUES(5,'Halina','Kot','1950-07-21','465456789',NULL,'NIE',8);
INSERT INTO klient VALUES(6,'Jerzy','Lis','1978-09-22','123456465',NULL,'NIE',9);

--INSERT INTO kraj(id_kraj,nazwa,kontynent)
INSERT INTO kraj VALUES(1,'Francja','Europa');
INSERT INTO kraj VALUES(2,'Hiszpania','Europa');
INSERT INTO kraj VALUES(3,'Włochy','Europa');

--INSERT INTO linie_lotnicze(id_linie_lotnicze,nazwa_linii)
INSERT INTO linie_lotnicze VALUES(1,'LOT');
INSERT INTO linie_lotnicze VALUES(2,'Ryanair');
INSERT INTO linie_lotnicze VALUES(3,'Wizzair');

--INSERT INTO miasto(id_miasto,nazwa,kraj_id)
INSERT INTO miasto VALUES(1,'Paryż',1);
INSERT INTO miasto VALUES(2,'Saint Tropez',1);
INSERT INTO miasto VALUES(3,'Costa del Sol',2);
INSERT INTO miasto VALUES(4,'Costa Brava',2);
INSERT INTO miasto VALUES(5,'Wenecja',3);
INSERT INTO miasto VALUES(6,'Mediolan',3);

--INSERT INTO muzeum(id_muzeum,nazwa,miasto_id)
INSERT INTO muzeum VALUES(1,'Luwr',1);
INSERT INTO muzeum VALUES(2,'Centre Pompidou',1);
INSERT INTO muzeum VALUES(3,'Grand Palais',1);
INSERT INTO muzeum VALUES(4,'Pałac Dożów',5);
INSERT INTO muzeum VALUES(5,'Museo Correr',5);
INSERT INTO muzeum VALUES(6,'Muzeum Leonarda da Vinci',6);

--INSERT INTO pracownik(id_pracownik,imie,nazwisko,stanowisko,pensja,dodatek,data_urodzenia,data_zatrudnienia,pesel,telefon,adres_id)
INSERT INTO pracownik VALUES(1,'Cezary','Waga','prezes',5650,NULL,'1967-01-23','2015-05-17','67012304830','111456789',1);
INSERT INTO pracownik VALUES(2,'Liliana','Fiołek','księgowa',3500,NULL,'1970-05-25','2015-05-17','70052517186','222456789',2);
INSERT INTO pracownik VALUES(3,'Aneta','Lipińska','sekretarka',2200,NULL,'1985-10-27','2015-05-17','85102715487','333123456789',3);

--INSERT INTO przewodnik(id_przewodnik,imie,nazwisko,pesel,telefon,znajomosc_jezyka,wycieczka_id)
INSERT INTO przewodnik VALUES(1,'Filip','Mak','78031710515','123444789','francuski');
INSERT INTO przewodnik VALUES(2,'Justyna','Nowak','94070705925','123454789','włoski');
INSERT INTO przewodnik VALUES(3,'Zofia','Miła','88060514785','123343789','hiszpański');

--INSERT INTO restauracja(id_restauracja,nazwa,standard,typ,miasto_id)
INSERT INTO restauracja VALUES(1,'La Petit Rose',3,'francuska',1);
INSERT INTO restauracja VALUES(2,'Pizza Julia',3,'pizzeria',1);
INSERT INTO restauracja VALUES(3,'Boutary',5,'francuska',2);
INSERT INTO restauracja VALUES(4,'La Candela',4,'śródziemnomorska',3);
INSERT INTO restauracja VALUES(5,'Trattoria',3,'włoska',5);
INSERT INTO restauracja VALUES(6,'Tre Orsi',4,'pizzeria',6);

--INSERT INTO typ_wycieczki(id_typ_wycieczki,nazwa)
INSERT INTO typ_wycieczki VALUES(1,'relaks i wypoczynek');
INSERT INTO typ_wycieczki VALUES(2,'wakacje w ruchu');
INSERT INTO typ_wycieczki VALUES(3,'Sylwester');

--INSERT INTO ubezpieczyciel(id_ubezpieczyciel,nazwa)
INSERT INTO ubezpieczyciel VALUES(1,'Arriva');
INSERT INTO ubezpieczyciel VALUES(2,'ABB Ubezpieczenia');
INSERT INTO ubezpieczyciel VALUES(3,'Liberia');

--INSERT INTO hotel(id_hotel,nazwa,standard,miasto_id)
INSERT INTO hotel VALUES(1,'Valloire',5,1);
INSERT INTO hotel VALUES(2,'Hilton',4,2);
INSERT INTO hotel VALUES(3,'Celeste',3,3);
INSERT INTO hotel VALUES(4,'Coral',4,4);
INSERT INTO hotel VALUES(5,'Saluti',3,5);
INSERT INTO hotel VALUES(6,'Bellacosta',3,6);

--INSERT INTO oferta(id_oferta,nazwa,typ_wycieczki_id)
INSERT INTO oferta VALUES(1,'Wypoczynek w Paryżu',2);
INSERT INTO oferta VALUES(2,'Lazurowe wybrzeże',1);
INSERT INTO oferta VALUES(3,'Paryż w Sylwestra',3);
INSERT INTO oferta VALUES(4,'Hiszpania w słońcu',1);
INSERT INTO oferta VALUES(5,'Włochy w ruchu',2);
INSERT INTO oferta VALUES(6,'Hiszpania dla rodziny',1);

--INSERT INTO oferta_atrakcja(oferta_id,atrakcja_id)
INSERT INTO oferta_atrakcja VALUES(1,4);
INSERT INTO oferta_atrakcja VALUES(2,2);
INSERT INTO oferta_atrakcja VALUES(2,3);
INSERT INTO oferta_atrakcja VALUES(3,9);
INSERT INTO oferta_atrakcja VALUES(4,1);
INSERT INTO oferta_atrakcja VALUES(4,8);
INSERT INTO oferta_atrakcja VALUES(5,7);
INSERT INTO oferta_atrakcja VALUES(5,6);
INSERT INTO oferta_atrakcja VALUES(6,1);
INSERT INTO oferta_atrakcja VALUES(6,5);

--INSERT INTO oferta_hotel(oferta_id,hotel_id)
INSERT INTO oferta_hotel VALUES(1,1);
INSERT INTO oferta_hotel VALUES(2,2);
INSERT INTO oferta_hotel VALUES(3,1);
INSERT INTO oferta_hotel VALUES(4,3);
INSERT INTO oferta_hotel VALUES(5,5);
INSERT INTO oferta_hotel VALUES(5,6);
INSERT INTO oferta_hotel VALUES(6,4);

--INSERT INTO oferta_miasto(oferta_id,miasto_id)
INSERT INTO oferta_miasto VALUES(1,1);
INSERT INTO oferta_miasto VALUES(2,2);
INSERT INTO oferta_miasto VALUES(3,1);
INSERT INTO oferta_miasto VALUES(4,3);
INSERT INTO oferta_miasto VALUES(5,5);
INSERT INTO oferta_miasto VALUES(5,6);
INSERT INTO oferta_miasto VALUES(6,4);

--INSERT INTO oferta_muzeum(oferta_id,miasto_id)
INSERT INTO oferta_muzeum VALUES(1,1);
INSERT INTO oferta_muzeum VALUES(1,2);
INSERT INTO oferta_muzeum VALUES(1,3);
INSERT INTO oferta_muzeum VALUES(5,4);
INSERT INTO oferta_muzeum VALUES(5,5);
INSERT INTO oferta_muzeum VALUES(5,6);

--INSERT INTO oferta_restauracja(oferta_id,restauracja_id)
INSERT INTO oferta_restauracja VALUES(1,1);
INSERT INTO oferta_restauracja VALUES(1,2);
INSERT INTO oferta_restauracja VALUES(2,3);
INSERT INTO oferta_restauracja VALUES(3,3);
INSERT INTO oferta_restauracja VALUES(4,4);
INSERT INTO oferta_restauracja VALUES(5,5);
INSERT INTO oferta_restauracja VALUES(6,4);

--INSERT INTO wycieczka(id_wycieczka,standard,wyzywienie,data_wyjazdu,data_powrotu,
--liczba_miejsc,dostepne_miejsca,cena_od_os,ubezpieczyciel_id,linie_lotnicze_id,autokar_id,
--oferta_id,przewodnik_id)
INSERT INTO wycieczka VALUES(1,5,'TAK','2016-12-05','2016-12-10',20,19,5656.77, 1,1,1,1,1);
INSERT INTO wycieczka VALUES(2,4,'TAK','2016-12-12','2016-12-20',20,18,2901.57, 2,1,2,2,1);
INSERT INTO wycieczka VALUES(3,4,'TAK','2016-12-31','2017-01-02',20,19,1966.77, 3,2,3,3,2);
INSERT INTO wycieczka VALUES(4,3,'TAK','2017-01-07','2017-01-15',20,17,1548.57, 1,2,1,4,3);
INSERT INTO wycieczka VALUES(5,3,'NIE','2017-01-10','2017-01-18',20,18,3196.77, 2,3,2,5,2);
INSERT INTO wycieczka VALUES(6,5,'TAK','2017-01-20','2017-01-25',20,14,4771.17, 3,3,3,6,3);

--INSERT INTO faktura(id_faktura,nazwa,cena_netto,podatek,cena_brutto,data)
INSERT INTO faktura VALUES(1,'faktura',4599,0.23,5656.77,'2016-10-17');
INSERT INTO faktura VALUES(2,'faktura',4718,0.23,5803.14,'2016-10-28');
INSERT INTO faktura VALUES(3,'faktura',1599,0.23,1966.77,'2016-11-20');
INSERT INTO faktura VALUES(4,'faktura',3777,0.23,4645.71,'2016-12-18');
INSERT INTO faktura VALUES(5,'faktura',5198,0.23,6393.54,'2016-12-21');
INSERT INTO faktura VALUES(6,'faktura',23274,0.23,28627.02,'2016-01-22');

--INSERT INTO umowa(id_umowa,data_zawarcia,liczba_osob,cena_suma,wycieczka_id,pracownik_id,klient_id,faktura_id)
INSERT INTO umowa VALUES(1,'2016-10-17',1,5656.77,1,2,1,1);
INSERT INTO umowa VALUES(2,'2016-10-28',2,5803.14,2,2,2,2);
INSERT INTO umowa VALUES(3,'2016-11-20',1,1966.77,3,2,2,3);
INSERT INTO umowa VALUES(4,'2016-12-18',3,4645.71,4,2,3,4);
INSERT INTO umowa VALUES(5,'2016-12-21',2,6393.54,5,3,4,5);
INSERT INTO umowa VALUES(6,'2016-01-22',6,28627.02,6,3,5,6);