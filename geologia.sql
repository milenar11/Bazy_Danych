create database projekt;
use projekt;
-- Tabela dla Eon
CREATE TABLE GeoEon (
    id_eon INT PRIMARY KEY,
    nazwa_eon VARCHAR(50) NOT NULL
);

-- Tabela dla Era
CREATE TABLE GeoEra (
    id_era INT PRIMARY KEY,
    id_eon INT,
    nazwa_era VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_eon) REFERENCES GeoEon(id_eon)
);

-- Tabela dla Okres
CREATE TABLE GeoOkres (
    id_okres INT PRIMARY KEY,
    id_era INT,
    nazwa_okres VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_era) REFERENCES GeoEra(id_era)
);

-- Tabela dla Epoka
CREATE TABLE GeoEpoka (
    id_epoka INT PRIMARY KEY,
    id_okres INT,
    nazwa_epoka VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_okres) REFERENCES GeoOkres(id_okres)
);

-- Tabela dla Piętro
CREATE TABLE GeoPietro (
    id_pietro INT PRIMARY KEY,
    id_epoka INT,
    nazwa_pietro VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_epoka) REFERENCES GeoEpoka(id_epoka)
);

INSERT INTO GeoEon (id_eon, nazwa_eon) VALUES
(1, 'Fanerozoik');

INSERT INTO GeoEra (id_era, id_eon, nazwa_era) VALUES
(1, 1, 'Kenozoik'),
(2, 1, 'Mezozoik'),
(3, 1, 'Paleozoik');

INSERT INTO GeoOkres (id_okres, id_era, nazwa_okres) VALUES
(1, 1, 'Trzeciorzęd'),
(2, 1, 'Czwartorzęd'),
(3, 2, 'Kreda'),
(4, 2, 'Jura'),
(5, 2, 'Trias'),
(6, 3, 'Perm'),
(7, 3, 'Karbon'),
(8, 3, 'Dewon');

INSERT INTO GeoEpoka (id_epoka, id_okres, nazwa_epoka) VALUES
(1, 2, 'Holocen'),
(2, 2, 'Plejstocen'),
(3, 1, 'Pliocen'),
(4, 1, 'Miocen'),
(5, 1, 'Oligocen'),
(6, 1, 'Eocen'),
(7, 1, 'Paleocen'),
(8, 3, 'Górna'),
(9, 3, 'Dolna'),
(10, 4, 'Górna'),
(11, 4, 'Środkowa'),
(12, 4, 'Dolna'),
(13, 5, 'Górna'),
(14, 5, 'Środkowa'),
(15, 5, 'Dolna'),
(16, 6, 'Górny'),
(17, 6, 'Dolny'),
(18, 7, 'Górny'),
(19, 7, 'Dolny'),
(20, 8, 'Górny'),
(21, 8, 'Środkowy'),
(22, 8, 'Dolny');

INSERT INTO geoPietro (id_pietro, id_epoka, nazwa_pietro) VALUES
(1, 1, '1'),
(2, 2, '2'),
(3, 3, '3'),
(4, 4, '4'),
(5, 5, '5'),
(6, 6, '6'),
(7, 7, '7'),
(8, 8, '8'),
(9, 9, '9'),
(10, 10, '10'),
(11, 11, '11'),
(12, 12, '12'),
(13, 13, '13'),
(14, 14, '14'),
(15, 15, '15'),
(16, 16, '16'),
(17, 17, '17'),
(18, 18, '18'),
(19, 19, '19'),
(20, 20, '20'),
(21, 21, '21'),
(22, 1, '22'),
(23, 2, '23'),
(24, 3, '24'),
(25, 4, '25'),
(26, 5, '26'),
(27, 6, '27'),
(28, 7, '28'),
(29, 8, '29'),
(30, 9, '30'),
(31, 10, '31'),
(32, 11, '32'),
(33, 12, '33'),
(34, 13, '34'),
(35, 14, '35'),
(36, 15, '36'),
(37, 16, '37'),
(38, 17, '38'),
(39, 18, '39'),
(40, 19, '40'),
(41, 20, '41'),
(42, 21, '42'),
(43, 1, '43'),
(44, 2, '44'),
(45, 3, '45'),
(46, 4, '46'),
(47, 5, '47'),
(48, 6, '48'),
(49, 7, '49'),
(50, 8, '50'),
(51, 9, '51'),
(52, 10, '52'),
(53, 11, '53'),
(54, 12, '54'),
(55, 13, '55'),
(56, 14, '56'),
(57, 15, '57'),
(58, 16, '58'),
(59, 17, '59'),
(60, 18, '60'),
(61, 19, '61'),
(62, 20, '62'),
(63, 21, '63'),
(64, 1, '64'),
(65, 2, '65'),
(66, 3, '66'),
(67, 4, '67'),
(68, 5, '68');

CREATE TABLE GeoTabela AS (SELECT * FROM GeoPietro NATURAL JOIN GeoEpoka NATURAL
JOIN GeoOkres NATURAL JOIN GeoEra NATURAL JOIN GeoEon );

CREATE TABLE Milion(cyfra int,liczba int, bit int);

INSERT INTO Dziesiec (cyfra)
VALUES
    (0), (1), (2), (3), (4), (5), (6), (7), (8), (9);

INSERT INTO  Milion SELECT a1.cyfra +10* a2.cyfra +100*a3.cyfra + 1000*a4.cyfra
+ 10000*a5.cyfra + 10000*a6.cyfra AS liczba , a1.cyfra AS cyfra, a1.bit AS bit
FROM Dziesiec a1, Dziesiec a2, Dziesiec a3, Dziesiec a4, Dziesiec a5, Dziesiec
a6 ;

drop table milion;
drop table dziesiec;

CREATE TABLE Dziesiec(cyfra int, bit int);

#1Zl
SELECT COUNT(*) FROM Milion INNER JOIN GeoTabela ON
(mod(Milion.liczba,68)=(GeoTabela.id_pietro));

#2zl
SELECT COUNT(*) FROM Milion INNER JOIN  GeoPietro  ON
(mod(Milion.liczba,68)=GeoPietro.id_pietro) NATURAL JOIN GeoEpoka NATURAL JOIN
GeoOkres NATURAL JOIN GeoEra NATURAL JOIN GeoEon;

#3zl
SELECT COUNT(*) FROM Milion WHERE mod(Milion.liczba,68)=
(SELECT id_pietro FROM GeoTabela   WHERE mod(Milion.liczba,68)=(id_pietro));

#4zl
SELECT COUNT(*) FROM Milion WHERE mod(Milion.liczba,68) IN
(SELECT GeoPietro.id_pietro FROM GeoPietro NATURAL JOIN GeoEpoka NATURAL JOIN
GeoOkres NATURAL JOIN GeoEra NATURAL JOIN GeoEon);

CREATE INDEX idx_GeoTabela ON GeoTabela (
    id_eon,
    id_era,
    id_okres,
    id_epoka,
    id_pietro,
    nazwa_pietro,
    nazwa_epoka,
    nazwa_okres,
    nazwa_era,
    nazwa_eon
);

CREATE INDEX idxGeoEon ON GeoEon (
    id_eon,
    nazwa_eon
);

CREATE INDEX idxGeoEpoka ON GeoEpoka (
    id_epoka,
    nazwa_epoka
);

CREATE INDEX idxGeoOkres ON GeoOkres (
    id_okres,
    nazwa_okres
);

CREATE INDEX idxGeoEra ON GeoEra (
    id_era,
    nazwa_era
);

CREATE INDEX idxGeoPietro ON GeoPietro (
    id_pietro,
    nazwa_pietro
);

