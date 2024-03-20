CREATE DATABASE BibliotekaPW;

USE BibliotekaPW;

CREATE TABLE Gatunek (
    IdGatunek INT PRIMARY KEY,
    PokazUkryj BOOLEAN NOT NULL
);

CREATE TABLE Autor (
    IdAutor INT PRIMARY KEY,
    Imie VARCHAR(50) NOT NULL,
    Nazwisko VARCHAR(50) NOT NULL,
    Pseudonim VARCHAR(50)
);

CREATE TABLE Wydawnictwo (
    IdWydawnictwo INT PRIMARY KEY,
    Nazwa VARCHAR(100) NOT NULL,
    Status VARCHAR(50)
);

CREATE TABLE Recenzja (
    IdRecenzja INT PRIMARY KEY,
    Ocena FLOAT NOT NULL,
    Tresc TEXT,
    UserName VARCHAR(100),
    Ukryj BOOLEAN NOT NULL
);

CREATE TABLE Ksiazka (
    IdBook INT PRIMARY KEY,
    IdAutor INT,
    IdGatunek INT,
    Opis TEXT,
    IdRecenzja INT,
    RokWydania INT,
    IdWydawnictwo INT,
    Status VARCHAR(50),
    FOREIGN KEY (IdAutor) REFERENCES Autor(IdAutor),
    FOREIGN KEY (IdGatunek) REFERENCES Gatunek(IdGatunek),
    FOREIGN KEY (IdRecenzja) REFERENCES Recenzja(IdRecenzja),
    FOREIGN KEY (IdWydawnictwo) REFERENCES Wydawnictwo(IdWydawnictwo)
);

CREATE TABLE Egzemplarz (
    IdEgzemplarz INT PRIMARY KEY,
    IdBook INT NOT NULL,
    Status VARCHAR(50),
    IdBiblioteka INT,
    Zuzycie FLOAT,
    FOREIGN KEY (IdBook) REFERENCES Ksiazka(IdBook)
);

CREATE TABLE Uzytkownik (
    IdUzytkownik INT PRIMARY KEY,
    Status VARCHAR(50) NOT NULL,
    Login VARCHAR(100) NOT NULL,
    Typ VARCHAR(50) NOT NULL,
    Nazwisko VARCHAR(50),
    Imie VARCHAR(50),
    IndeksPW VARCHAR(10),
    Sms VARCHAR(9),
    Mail VARCHAR(50)
);

CREATE TABLE Biblioteka (
    IdBiblioteka INT PRIMARY KEY,
    IdLokalizacja INT,
    IdGodzinyOtwarcia INT,
    Nazwa VARCHAR(100) NOT NULL,
    KeyField VARCHAR(100),
    FOREIGN KEY (IdLokalizacja) REFERENCES Lokalizacja(IdLokalozacja),
    FOREIGN KEY (IdGodzinyOtwarcia) REFERENCES GodzinyOtwarcia(IdGodzinyOtwarcia)
);

CREATE TABLE Lokalizacja (
    IdLokalozacja INT PRIMARY KEY,
    Miasto VARCHAR(100) NOT NULL,
    KodPocztowy VARCHAR(20) NOT NULL,
    Wojewodztwo VARCHAR(100) NOT NULL
);

CREATE TABLE GodzinyOtwarcia (
    IdGodzinyOtwarcia INT PRIMARY KEY,
    IdBiblioteka INT,
    DzienTygodnia VARCHAR(20) NOT NULL,
    Godziny VARCHAR(100) NOT NULL,
    Status VARCHAR(50),
    FOREIGN KEY (IdBiblioteka) REFERENCES Biblioteka(IdBiblioteka)
);

CREATE TABLE Zamowienie (
    IdZamowienie INT PRIMARY KEY,
    IdEgzemplarz INT NOT NULL,
    IdUzytkownik INT NOT NULL,
    Wypozyczenie BOOLEAN,
    Data DATE,
    CzasOdbioru TIME,
    FOREIGN KEY (IdEgzemplarz) REFERENCES Egzemplarz(IdEgzemplarz),
    FOREIGN KEY (IdUzytkownik) REFERENCES Uzytkownik(IdUzytkownik)
);

CREATE TABLE Przedluzenie (
    IdPrzedluzenie INT PRIMARY KEY,
    IdWypozyczenie INT NOT NULL,
    Typ VARCHAR(50),
    CzasPrzedluzenia INT,
    FOREIGN KEY (IdWypozyczenie) REFERENCES Wypozyczenie(IdWypozyczenie)
);

CREATE TABLE Notyfikacja (
    IdNotyfikacja INT PRIMARY KEY,
    IdPrzedluzenie INT NOT NULL,
    Tresc TEXT,
    Typ VARCHAR(50),
    IdUzytkownik INT,
    FOREIGN KEY (IdPrzedluzenie) REFERENCES Przedluzenie(IdPrzedluzenie),
    FOREIGN KEY (IdUzytkownik) REFERENCES Uzytkownik(IdUzytkownik)
);

CREATE TABLE Wypozyczenie (
    IdWypozyczenie INT PRIMARY KEY,
    IdZamowienie INT NOT NULL,
    IdEgzemplarz INT NOT NULL,
    DataWypozyczenia DATE NOT NULL,
    CzasWypozyczenia TIME NOT NULL,
    DataZwrotu DATE,
    IdPrzedluzenie INT,
    FOREIGN KEY (IdZamowienie) REFERENCES Zamowienie(IdZamowienie),
    FOREIGN KEY (IdEgzemplarz) REFERENCES Egzemplarz(IdEgzemplarz),
    FOREIGN KEY (IdPrzedluzenie) REFERENCES Przedluzenie(IdPrzedluzenie)
);

CREATE TABLE Config (
    IdConfig INT PRIMARY KEY,
    Nazwa VARCHAR(100) NOT NULL,
    Wartosc VARCHAR(100),
    DataModyfikacji DATETIME,
    DataDodania DATETIME
);
