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

/*DROP TABLE adres CASCADE CONSTRAINTS;
DROP TABLE atrakcja CASCADE CONSTRAINTS;
DROP TABLE autokar CASCADE CONSTRAINTS;
DROP TABLE faktura CASCADE CONSTRAINTS;
DROP TABLE hotel CASCADE CONSTRAINTS;
DROP TABLE klient CASCADE CONSTRAINTS;
DROP TABLE kraj CASCADE CONSTRAINTS;
DROP TABLE linie_lotnicze CASCADE CONSTRAINTS;
DROP TABLE miasto CASCADE CONSTRAINTS;
DROP TABLE muzeum CASCADE CONSTRAINTS;
DROP TABLE oferta CASCADE CONSTRAINTS;
DROP TABLE oferta_atrakcja;
DROP TABLE oferta_hotel;
DROP TABLE oferta_miasto;
DROP TABLE oferta_muzeum;
DROP TABLE oferta_restauracja;
DROP TABLE pracownik CASCADE CONSTRAINTS;
DROP TABLE przewodnik CASCADE CONSTRAINTS;
DROP TABLE restauracja CASCADE CONSTRAINTS;
DROP TABLE typ_wycieczki CASCADE CONSTRAINTS;
DROP TABLE ubezpieczyciel CASCADE CONSTRAINTS;
DROP TABLE umowa CASCADE CONSTRAINTS;
DROP TABLE wycieczka CASCADE CONSTRAINTS;

DROP SEQUENCE adres_id_adres_seq;
DROP SEQUENCE atrakcja_id_atrakcja_seq;
DROP SEQUENCE autokar_id_autokar_seq;
DROP SEQUENCE faktura_id_faktura_seq;
DROP SEQUENCE hotel_id_hotel_seq;
DROP SEQUENCE klient_id_klient_seq;
DROP SEQUENCE kraj_id_kraj_seq;
DROP SEQUENCE linie_lotnicze_id_linie_lotnic;
DROP SEQUENCE miasto_id_miasto_seq;
DROP SEQUENCE muzeum_id_muzeum_seq;
DROP SEQUENCE oferta_id_oferta_seq;
DROP SEQUENCE pracownik_id_pracownik_seq;
DROP SEQUENCE przewodnik_id_przewodnik_seq; 
DROP SEQUENCE restauracja_id_restauracja_seq;
DROP SEQUENCE typ_wycieczki_id_typ_wycieczki;
DROP SEQUENCE ubezpieczyciel_id_ubezpieczyci;
DROP SEQUENCE umowa_id_umowa_seq;
DROP SEQUENCE wycieczka_id_wycieczka_seq;
DROP SEQUENCE oferta_atrakcja_oferta_id_seq;
DROP SEQUENCE oferta_atrakcja_atrakcja_id;
DROP SEQUENCE oferta_hotel_oferta_id_seq;
DROP SEQUENCE oferta_hotel_hotel_id_seq;
DROP SEQUENCE oferta_miasto_oferta_id_seq;
DROP SEQUENCE oferta_miasto_miasto_id_seq;
DROP SEQUENCE oferta_muzeum_oferta_id_seq;
DROP SEQUENCE oferta_muzeum_muzeum_id_seq;
DROP SEQUENCE oferta_restauracja_oferta_id;
DROP SEQUENCE oferta_restauracja_restauracja*/
