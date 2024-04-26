ALTER TABLE ksiegowosc.pracownicy MODIFY COLUMN telefon VARCHAR(30);

#a
UPDATE ksiegowosc.pracownicy
SET telefon = CONCAT('(+48) ', telefon)
WHERE telefon IS NOT NULL;

#b
UPDATE ksiegowosc.pracownicy
SET telefon = CONCAT(
    SUBSTRING(telefon, 1, 3),
    '-',
    SUBSTRING(telefon, 4, 3),
    '-',
    SUBSTRING(telefon, 7)
)
WHERE telefon IS NOT NULL;

#c
SELECT UPPER(imie) AS imie, UPPER(nazwisko) AS nazwisko
FROM ksiegowosc.pracownicy
ORDER BY LENGTH(nazwisko) DESC
LIMIT 1;

#d
SELECT CONCAT(imie, ' ', nazwisko) AS pracownik, MD5(CONCAT(imie, nazwisko)) AS pensja_md5
FROM ksiegowosc.pracownicy;

#e
SELECT p.imie, p.nazwisko, pen.kwota AS pensja, pr.kwota AS premia
FROM ksiegowosc.pracownicy p
LEFT JOIN ksiegowosc.wynagrodzenie w ON p.id_pracownika = w.id_pracownika
LEFT JOIN ksiegowosc.pensja pen ON w.id_pensji = pen.id_pensji
LEFT JOIN ksiegowosc.premia pr ON w.id_premii = pr.id_premii;

#f bez nadgodzin!!!!
SELECT CONCAT('Pracownik ', p.imie, ' ', p.nazwisko, ', w dniu ', DATE_FORMAT(w.data, '%d.%m.%Y'),
              ' otrzymał pensję całkowitą na kwotę ', pen.kwota, ' zł, gdzie wynagrodzenie zasadnicze wynosiło: ',
              pen.kwota, ' zł, premia: ', prm.kwota) AS raport
FROM ksiegowosc.pracownicy p
LEFT JOIN ksiegowosc.wynagrodzenie w ON p.id_pracownika = w.id_pracownika
LEFT JOIN ksiegowosc.pensja pen ON w.id_pensji = pen.id_pensji
LEFT JOIN ksiegowosc.premia prm ON w.id_premii = prm.id_premii;




