use firma;

create schema przychodnia;

CREATE TABLE przychodnia.pracownicy (
    IDPracownika VARCHAR(10) PRIMARY KEY,
    NazwaLekarza VARCHAR(100)
);

CREATE TABLE przychodnia.pacjenci (
    IDPacjenta VARCHAR(10) PRIMARY KEY,
    NazwaPacjenta VARCHAR(100)
);

CREATE TABLE przychodnia.wizyty (
    IDPracownika VARCHAR(10),
    IDPacjenta VARCHAR(10),
    DataGodzinaWizyty DATETIME,
    IDZabiegu VARCHAR(10),
    PRIMARY KEY (IDPracownika, IDPacjenta, DataGodzinaWizyty),
    FOREIGN KEY (IDPracownika) REFERENCES Pracownicy(IDPracownika),
    FOREIGN KEY (IDPacjenta) REFERENCES Pacjenci(IDPacjenta),
    FOREIGN KEY (IDZabiegu) REFERENCES Zabiegi(IDZabiegu)
);


CREATE TABLE przychodnia.zabiegi (
    IDZabiegu VARCHAR(10) PRIMARY KEY,
    NazwaZabiegu VARCHAR(100)
);

drop table Pracownicy;
drop table Pacjenci;
drop table Zabiegi;

INSERT INTO przychodnia.pracownicy (IDPracownika, NazwaLekarza) VALUES
('S1011', 'Maria Nowak'),
('S1024', 'Jan Kowalski'),
('S1045', 'Anna Jabłońska'),
('S1034', 'Marek Potocki');

INSERT INTO przychodnia.pacjenci (IDPacjenta, NazwaPacjenta) VALUES
('P100', 'Anna Jeleń'),
('P105', 'Jarosław Nicpoń'),
('P108', 'Joanna Nosek'),
('P120', 'Jan Kałuża'),
('P123', 'Olga Nowacka'),
('P130', 'Jerzy Lis');

INSERT INTO przychodnia.zabiegi (IDZabiegu, NazwaZabiegu) VALUES
('Z500', 'Borowanie'),
('Z496', 'Lakowanie'),
('Z503', 'Usuwanie kamienia');

INSERT INTO przychodnia.wizyty (IDPracownika, IDPacjenta, DataGodzinaWizyty, IDZabiegu) VALUES
('S1011', 'P100', '2020-03-12 10:00:00', 'Z500'),
('S1011', 'P105', '2020-03-12 13:00:00', 'Z496'),
('S1011', 'P108', '2020-03-14 10:00:00', 'Z496'),
('S1024', 'P108', '2020-03-16 17:00:00', 'Z500'),
('S1045', 'P120', '2020-03-18 09:00:00', 'Z500'),
('S1034', 'P130', '2020-03-20 08:00:00', 'Z496'),
('S1034', 'P123', '2020-03-12 15:00:00', 'Z503');

create schema sklep;

CREATE TABLE sklep.produkty (
    ProduktID INT PRIMARY KEY AUTO_INCREMENT,
    NazwaProduktu VARCHAR(255)
);


INSERT INTO sklep.produkty (NazwaProduktu) VALUES
('Usuwanie kamienia'),
('Makaron Nitki'),
('Makarony Polskie'),
('Makaron Lubelski'),
('Makaron Turystyczna'),
('Keczup pikantny'),
('Przetwory pomidorowe Polskie'),
('Sos pomidorowy Polskie przetwory'),
('Małopolskie smaki'),
('Rolnicza');

CREATE TABLE sklep.dostawcy (
    DostawcaID INT PRIMARY KEY AUTO_INCREMENT,
    NazwaDostawcy VARCHAR(255),
    Adres VARCHAR(255)
);

INSERT INTO sklep.dostawcy (NazwaDostawcy, Adres) VALUES
('Polskie Lubelski', 'Turystyczna 40, 31-435 Kraków Piłsudskiego'),
('Polskie przetwory', 'Wojska Polskiego 44a, 31-342 Kraków'),
('Małopolskie smaki', 'Wojska Polskiego 44a, 31-342 Kraków'),
('Małopolskie smaki', 'Rolnicza 22/4, 30-243 Tarnów'),
('Polskie przetwory', 'Mickiewicza 223/77, 35-434 Nowy Targ');

CREATE TABLE sklep.ceny (
    CenaID INT PRIMARY KEY AUTO_INCREMENT,
    ProduktID INT,
    DostawcaID INT,
    CenaNetto DECIMAL(10, 2),
    CenaBrutto DECIMAL(10, 2),
    FOREIGN KEY (ProduktID) REFERENCES Produkty(ProduktID),
    FOREIGN KEY (DostawcaID) REFERENCES Dostawcy(DostawcaID)
);

INSERT INTO sklep.ceny (ProduktID, DostawcaID, CenaNetto, CenaBrutto) VALUES
(1, 1, 130.00, 150.00),
(2, 1, 130.00, 150.00),
(3, 1, 130.00, 150.00),
(4, 1, 130.00, 150.00),
(5, 1, 130.00, 150.00),
(6, 2, 200.00, 220.00),
(7, 2, 200.00, 220.00),
(8, 3, 89.00, 110.00),
(9, 3, 89.00, 110.00),
(10, 4, 89.00, 110.00);



