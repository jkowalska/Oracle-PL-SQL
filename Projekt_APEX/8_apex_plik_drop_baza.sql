DROP TABLE adres CASCADE CONSTRAINTS;
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
DROP SEQUENCE oferta_restauracja_restauracja;