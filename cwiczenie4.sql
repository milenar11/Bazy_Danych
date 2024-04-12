create database firma;

use firma;
create schema rozliczenia;

create table rozliczenia.pracownicy (
    id_pracownika INT PRIMARY KEY,
    imie VARCHAR(15) NOT NULL,
    nazwisko VARCHAR(20) NOT NULL,
    adres VARCHAR(40),
    telefon VARCHAR(20)
);

create table rozliczenia.godziny(
    id_godziny int primary key,
    data date not null,
    liczba_godzin float not null,
    id_pracownika int not null
);


create table rozliczenia.pensje (
    id_pensji int primary key,
    stanowisko varchar(30),
    kwota double not null,
    id_premii int
);

create table rozliczenia.premie (	
    id_premii INT PRIMARY KEY,
    rodzaj VARCHAR(50),
    kwota DOUBLE NOT NULL
);

ALTER TABLE rozliczenia.godziny
ADD CONSTRAINT fk_pracownik
FOREGIN KEY (id_pracownika)
REFERENCES rozliczenia.pracownicy(id_pracownika);

ALTER TABLE rozliczenia.pensje
ADD CONTSTRAINT fk_premia
FOREGIN KEY (id_premii)
REFERENCES rozliczenia.premie(id_premii);

INSERT INTO rozliczenia.pracownicy(id_pracownika, imie, nazwisko, adres, telefon)
VALUES
(1, 'Adam', 'Kowalski', 'ul. Kwiatowa 1, Warszawa', '123-456-789'),
(2, 'Ewa', 'Nowak', 'ul. Leśna 5, Kraków', '987-654-321'),
(3, 'Jan', 'Wiśniewski', 'ul. Polna 10, Gdańsk', '555-666-777'),
(4, 'Alicja', 'Kaczmarek', 'ul. Słoneczna 3, Poznań', '111-222-333'),
(5, 'Piotr', 'Lewandowski', 'ul. Radosna 8, Wrocław', '444-555-666'),
(6, 'Magdalena', 'Dąbrowska', 'ul. Jesienna 12, Łódź', '777-888-999'),
(7, 'Kamil', 'Wójcik', 'ul. Nadmorska 7, Gdynia', '999-888-777'),
(8, 'Karolina', 'Jankowska', 'ul. Zielona 14, Szczecin', '222-333-444'),
(9, 'Michał', 'Wojciechowski', 'ul. Wiejska 2, Lublin', '666-555-444'),
(10, 'Anna', 'Kowalczyk', 'ul. Przemysłowa 6, Katowice', '333-222-111');

-- Wypełnienie tabeli godziny danymi losowymi dla 10 pracowników
INSERT INTO rozliczenia.godziny (id_godziny, data, liczba_godzin, id_pracownika)
VALUES
    (1, '2024-04-01', 8, 1),
    (2, '2024-04-01', 7, 2),
    (3, '2024-04-02', 9, 3),
    (4, '2024-04-02', 8, 4),
    (5, '2024-04-03', 7, 5),
    (6, '2024-04-03', 9, 6),
    (7, '2024-04-04', 8, 7),
    (8, '2024-04-04', 7, 8),
    (9, '2024-04-05', 9, 9),
    (10, '2024-04-05', 8, 10);

-- Wypełnienie tabeli pensje danymi losowymi dla 10 pracowników
INSERT INTO rozliczenia.pensje (id_pensji, stanowisko, kwota_brutto, id_premii)
VALUES
    (1, 'Kierownik', 5000, 1),
    (2, 'Pracownik', 4000, 2),
    (3, 'Pracownik', 3500, 3),
    (4, 'Kierownik', 4800, 4),
    (5, 'Pracownik', 4200, 5),
    (6, 'Kierownik', 5300, 6),
    (7, 'Pracownik', 3800, 7),
    (8, 'Pracownik', 3700, 8),
    (9, 'Kierownik', 5100, 9),
    (10, 'Pracownik', 3900, 10);

-- Wypełnienie tabeli premie danymi losowymi dla 10 pracowników
INSERT INTO rozliczenia.premie (id_premii, rodzaj, kwota)
VALUES
    (1, 'Premia za wyniki', 1000),
    (2, 'Premia kwartalna', 500),
    (3, 'Premia za staż', 300),
    (4, 'Premia za wyniki', 1200),
    (5, 'Premia kwartalna', 600),
    (6, 'Premia za staż', 400),
    (7, 'Premia za wyniki', 1100),
    (8, 'Premia kwartalna', 550),
    (9, 'Premia za staż', 330),
    (10, 'Premia za wyniki', 1300);




SELECT nazwisko, adres
FROM rozliczenia.pracownicy;


SELECT id_godziny, DATA, liczba_godzin, id_pracownika
    DATEPART(dw, data) AS dzien_tygodnia, 
    DATEPART(month, data) AS miesiac
FROM 
    rozliczenia.godziny;


#Zmiana nazwy kolumny kwota na kwota_brutto 
ALTER TABLE rozliczenia.pensje
RENAME COLUMN kwota TO kwota_brutto;

#Dodanie nowej kolumny kwota_netto
ALTER TABLE rozliczenia.pensje
ADD COLUMN kwota_netto DECIMAL(10,2);

#Obliczenie i aktualizacja wartości kwoty netto
UPDATE rozliczenia.pensje
SET kwota_netto = kwota_brutto * 0.8; 


