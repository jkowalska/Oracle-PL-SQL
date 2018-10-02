CREATE OR REPLACE FORCE VIEW "KALENDARZ_WYCIECZEK" ("NAZWA", "STANDARD", "ID_WYCIECZKA", "WYZYWIENIE", "DATA_WYJAZDU", "DATA_POWROTU", "LICZBA_MIEJSC", "DOSTEPNE_MIEJSCA", "CENA_OD_OS") AS 
  select OFERTA.NAZWA as NAZWA,
    WYCIECZKA.STANDARD as STANDARD,
    WYCIECZKA.ID_WYCIECZKA as ID_WYCIECZKA,
    WYCIECZKA.WYZYWIENIE as WYZYWIENIE,
    WYCIECZKA.DATA_WYJAZDU as DATA_WYJAZDU,
    WYCIECZKA.DATA_POWROTU as DATA_POWROTU,
    WYCIECZKA.LICZBA_MIEJSC as LICZBA_MIEJSC,
    WYCIECZKA.DOSTEPNE_MIEJSCA as DOSTEPNE_MIEJSCA,
    WYCIECZKA.CENA_OD_OS as CENA_OD_OS 
 from WYCIECZKA WYCIECZKA,
    OFERTA OFERTA 
 where WYCIECZKA.OFERTA_ID=OFERTA.ID_OFERTA
/

CREATE OR REPLACE FORCE VIEW "V_KLIENCI_WYCIECZKI" ("Imie", "Nazwisko", "Nazwa oferty", "Liczba osób", "Cena od os.", "Cena suma", "Data zawarcia umowy", "Data wyjazdu", "Data powrotu", "Data urodzenia", "Czy student") AS 
  select KLIENT.IMIE as "Imie",
    KLIENT.NAZWISKO as "Nazwisko",
    OFERTA.NAZWA as "Nazwa oferty",
    UMOWA.LICZBA_OSOB as "Liczba osób",
    WYCIECZKA.CENA_OD_OS as "Cena od os.",
    UMOWA.CENA_SUMA as "Cena suma",
    UMOWA.DATA_ZAWARCIA as "Data zawarcia umowy",
    WYCIECZKA.DATA_WYJAZDU as "Data wyjazdu",
    WYCIECZKA.DATA_POWROTU as "Data powrotu",
    KLIENT.DATA_URODZENIA as "Data urodzenia",
    KLIENT.CZY_STUDENT as "Czy student" 
 from OFERTA OFERTA,
    WYCIECZKA WYCIECZKA,
    UMOWA UMOWA,
    KLIENT KLIENT 
 where UMOWA.KLIENT_ID=KLIENT.ID_KLIENT
    and UMOWA.WYCIECZKA_ID=WYCIECZKA.ID_WYCIECZKA
    and OFERTA.ID_OFERTA=WYCIECZKA.OFERTA_ID
/

CREATE OR REPLACE FORCE VIEW "V_OFERTY_WYCIECZEK" ("Nazwa kraju", "Nazwa miasta", "Nazwa oferty", "Standard", "Nazwa atrakcji", "Opis atrakcji", "Data wyjazdu", "Data powrotu", "Wyżywienie", "Liczba miejsc", "Dostępne miejsca", "Cena od osoby") AS 
  select KRAJ.NAZWA as "Nazwa kraju",
    MIASTO.NAZWA as "Nazwa miasta",
    OFERTA.NAZWA as "Nazwa oferty",
    WYCIECZKA.STANDARD as "Standard",
    ATRAKCJA.NAZWA as "Nazwa atrakcji",
    ATRAKCJA.OPIS as "Opis atrakcji",
    WYCIECZKA.DATA_WYJAZDU as "Data wyjazdu",
    WYCIECZKA.DATA_POWROTU as "Data powrotu",
    WYCIECZKA.WYZYWIENIE as "Wyżywienie",
    WYCIECZKA.LICZBA_MIEJSC as "Liczba miejsc",
    WYCIECZKA.DOSTEPNE_MIEJSCA as "Dostępne miejsca",
    WYCIECZKA.CENA_OD_OS as "Cena od osoby" 
 from WYCIECZKA WYCIECZKA,
    KRAJ KRAJ,
    ATRAKCJA ATRAKCJA,
    OFERTA_MIASTO OFERTA_MIASTO,
    MIASTO MIASTO,
    OFERTA_ATRAKCJA OFERTA_ATRAKCJA,
    OFERTA OFERTA 
 where OFERTA.ID_OFERTA=OFERTA_MIASTO.OFERTA_ID
    and OFERTA_MIASTO.MIASTO_ID=MIASTO.ID_MIASTO
    and OFERTA_ATRAKCJA.OFERTA_ID=OFERTA.ID_OFERTA
    and ATRAKCJA.ID_ATRAKCJA=OFERTA_ATRAKCJA.ATRAKCJA_ID
    and MIASTO.KRAJ_ID=KRAJ.ID_KRAJ
    and WYCIECZKA.OFERTA_ID=OFERTA.ID_OFERTA
/
