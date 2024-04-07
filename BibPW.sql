CREATE DATABASE LibraryPW;

USE LibraryPW;

CREATE TABLE Genre (
    GenreId INT PRIMARY KEY,
    ShowHide BOOLEAN NOT NULL
);

CREATE TABLE Author (
    AuthorId INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Pseudonym VARCHAR(50)
);

CREATE TABLE Publisher (
    PublisherId INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Status VARCHAR(50)
);

CREATE TABLE Review (
    ReviewId INT PRIMARY KEY,
    Rating FLOAT NOT NULL,
    Content TEXT,
    UserName VARCHAR(100),
    Hide BOOLEAN NOT NULL
);

CREATE TABLE Book (
    BookId INT PRIMARY KEY,
    AuthorId INT,
    GenreId INT,
    Description TEXT,
    ReviewId INT,
    PublicationYear INT,
    PublisherId INT,
    Status VARCHAR(50),
    FOREIGN KEY (AuthorId) REFERENCES Author(AuthorId),
    FOREIGN KEY (GenreId) REFERENCES Genre(GenreId),
    FOREIGN KEY (ReviewId) REFERENCES Review(ReviewId),
    FOREIGN KEY (PublisherId) REFERENCES Publisher(PublisherId)
);

CREATE TABLE Copy (
    CopyId INT PRIMARY KEY,
    BookId INT NOT NULL,
    Status VARCHAR(50),
    LibraryId INT,
    Usage FLOAT,
    FOREIGN KEY (BookId) REFERENCES Book(BookId)
);

CREATE TABLE User (
    UserId INT PRIMARY KEY,
    Status VARCHAR(50) NOT NULL,
    Login VARCHAR(100) NOT NULL,
    Type VARCHAR(50) NOT NULL,
    LastName VARCHAR(50),
    FirstName VARCHAR(50),
    PWIndex VARCHAR(10),
    Sms VARCHAR(9),
    Email VARCHAR(50)
);

CREATE TABLE Library (
    LibraryId INT PRIMARY KEY,
    LocationId INT,
    OpeningHoursId INT,
    Name VARCHAR(100) NOT NULL,
    KeyField VARCHAR(100),
    FOREIGN KEY (LocationId) REFERENCES Location(LocationId),
    FOREIGN KEY (OpeningHoursId) REFERENCES OpeningHours(OpeningHoursId)
);

CREATE TABLE Location (
    LocationId INT PRIMARY KEY,
    City VARCHAR(100) NOT NULL,
    PostalCode VARCHAR(20) NOT NULL,
    Province VARCHAR(100) NOT NULL
);

CREATE TABLE OpeningHours (
    OpeningHoursId INT PRIMARY KEY,
    LibraryId INT,
    DayOfWeek VARCHAR(20) NOT NULL,
    Hours VARCHAR(100) NOT NULL,
    Status VARCHAR(50),
    FOREIGN KEY (LibraryId) REFERENCES Library(LibraryId)
);

CREATE TABLE Order (
    OrderId INT PRIMARY KEY,
    CopyId INT NOT NULL,
    UserId INT NOT NULL,
    Rental BOOLEAN,
    Date DATE,
    PickupTime TIME,
    FOREIGN KEY (CopyId) REFERENCES Copy(CopyId),
    FOREIGN KEY (UserId) REFERENCES User(UserId)
);

CREATE TABLE Extension (
    ExtensionId INT PRIMARY KEY,
    RentalId INT NOT NULL,
    Type VARCHAR(50),
    ExtensionTime INT,
    FOREIGN KEY (RentalId) REFERENCES Rental(RentalId)
);

CREATE TABLE Notification (
    NotificationId INT PRIMARY KEY,
    ExtensionId INT NOT NULL,
    Content TEXT,
    Type VARCHAR(50),
    UserId INT,
    FOREIGN KEY (ExtensionId) REFERENCES Extension(ExtensionId),
    FOREIGN KEY (UserId) REFERENCES User(UserId)
);

CREATE TABLE Rental (
    RentalId INT PRIMARY KEY,
    OrderId INT NOT NULL,
    CopyId INT NOT NULL,
    RentalDate DATE NOT NULL,
    RentalTime TIME NOT NULL,
    ReturnDate DATE,
    ExtensionId INT,
    FOREIGN KEY (OrderId) REFERENCES Order(OrderId),
    FOREIGN KEY (CopyId) REFERENCES Copy(CopyId),
    FOREIGN KEY (ExtensionId) REFERENCES Extension(ExtensionId)
);

CREATE TABLE Config (
    ConfigId INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Value VARCHAR(100),
    ModificationDate DATETIME,
    CreationDate DATETIME
);
