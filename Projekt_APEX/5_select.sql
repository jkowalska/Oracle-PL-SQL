--widok 1

SELECT
    miasto.nazwa AS nazwa_miasta,
    typ_wycieczki.nazwa AS nazwa_typu,
    oferta.nazwa AS nazwa_oferty,
    wycieczka.wyzywienie,
    wycieczka.standard,
    wycieczka.dostepne_miejsca,
    wycieczka.data_wyjazdu,
    wycieczka.data_powrotu,
    COUNT(oferta.id_oferta)
FROM
    miasto
    INNER JOIN oferta_miasto ON miasto.id_miasto = oferta_miasto.miasto_id
    INNER JOIN oferta ON oferta.id_oferta = oferta_miasto.oferta_id
    INNER JOIN typ_wycieczki ON typ_wycieczki.id_typ_wycieczki = oferta.typ_wycieczki_id
    INNER JOIN wycieczka ON oferta.id_oferta = wycieczka.oferta_id
GROUP BY
    miasto.nazwa,
    typ_wycieczki.nazwa,
    oferta.nazwa,
    wycieczka.wyzywienie,
    wycieczka.standard,
    wycieczka.dostepne_miejsca,
    wycieczka.data_wyjazdu,
    wycieczka.data_powrotu
HAVING (
    miasto.nazwa = 'Paryż'
) OR (
    miasto.nazwa = 'Saint Tropez'
) ORDER BY nazwa_miasta

----------
--widok 2

SELECT
    kraj.nazwa AS nazwa_kraju,
    miasto.nazwa AS nazwa_miasta,
    oferta.nazwa AS nazwa_oferty,
    atrakcja.nazwa AS nazwa_atrakcji,
    atrakcja.opis AS opis_atrakcji,
    COUNT(atrakcja.id_atrakcja) AS count_id_atrakcja
FROM
    kraj
    INNER JOIN miasto ON kraj.id_kraj = miasto.kraj_id
    INNER JOIN oferta_miasto ON miasto.id_miasto = oferta_miasto.miasto_id
    INNER JOIN oferta ON oferta.id_oferta = oferta_miasto.oferta_id
    INNER JOIN oferta_atrakcja ON oferta.id_oferta = oferta_atrakcja.oferta_id
    INNER JOIN atrakcja ON atrakcja.id_atrakcja = oferta_atrakcja.atrakcja_id
GROUP BY
    kraj.nazwa,
    miasto.nazwa,
    oferta.nazwa,
    atrakcja.nazwa,
    atrakcja.opis
HAVING (
    kraj.nazwa = 'Hiszpania'
) OR (
    kraj.nazwa = 'Włochy'
) ORDER BY nazwa_kraju,nazwa_miasta,nazwa_oferty
