-- Создаём базу данных
CREATE DATABASE IMDB_DB;
GO

USE IMDB_DB;
GO

-- Таблица режиссёров
CREATE TABLE Directors (
    DirectorID INT PRIMARY KEY IDENTITY,
    DirectorName NVARCHAR(100) NOT NULL
);

-- Таблица актёров
CREATE TABLE Actors (
    ActorID INT PRIMARY KEY IDENTITY,
    ActorName NVARCHAR(100) NOT NULL
);

-- Таблица жанров
CREATE TABLE Genres (
    GenreID INT PRIMARY KEY IDENTITY,
    GenreName NVARCHAR(50) NOT NULL
);

-- Таблица фильмов
CREATE TABLE Movies (
    MovieID INT PRIMARY KEY IDENTITY,
    Title NVARCHAR(150) NOT NULL,
    IMDB_Rating DECIMAL(3,1),
    Duration INT, -- продолжительность в минутах
    GenreID INT,
    DirectorID INT,
    ActorID INT,
    FOREIGN KEY (GenreID) REFERENCES Genres(GenreID),
    FOREIGN KEY (DirectorID) REFERENCES Directors(DirectorID),
    FOREIGN KEY (ActorID) REFERENCES Actors(ActorID)
);

-- Добавляем режиссёров
INSERT INTO Directors (DirectorName)
VALUES ('Christopher Nolan'), ('Steven Spielberg'), ('Martin Scorsese');

-- Добавляем актёров
INSERT INTO Actors (ActorName)
VALUES ('Christian Bale'), ('Heath Ledger'), ('Leonardo DiCaprio');

-- Добавляем жанры
INSERT INTO Genres (GenreName)
VALUES ('Action'), ('Drama'), ('Thriller');

-- Добавляем фильмы
INSERT INTO Movies (Title, IMDB_Rating, Duration, GenreID, DirectorID, ActorID)
VALUES 
('The Dark Knight', 9.0, 152, 1, 1, 2),
('Inception', 8.8, 148, 3, 1, 3),
('The Departed', 8.5, 151, 2, 3, 3),
('Memento', 8.4, 113, 3, 1, 1),
('Tenet', 7.4, 150, 1, 1, 1);

--1 task 
SELECT 
    m.Title AS MovieName,
    m.IMDB_Rating,
    g.GenreName,
    d.DirectorName,
    a.ActorName
FROM Movies m
JOIN Genres g ON m.GenreID = g.GenreID
JOIN Directors d ON m.DirectorID = d.DirectorID
JOIN Actors a ON m.ActorID = a.ActorID
WHERE m.IMDB_Rating > 6;

--2 task
SELECT 
    m.Title AS MovieName,
    m.IMDB_Rating,
    g.GenreName
FROM Movies m
JOIN Genres g ON m.GenreID = g.GenreID
WHERE g.GenreName LIKE '%a%';

--3 task
SELECT 
    m.Title,
    m.IMDB_Rating,
    m.Duration,
    g.GenreName
FROM Movies m
JOIN Genres g ON m.GenreID = g.GenreID
WHERE LEN(m.Title) > 10 AND m.Title LIKE '%t';

--4 task
SELECT 
    m.Title,
    m.IMDB_Rating,
    g.GenreName,
    d.DirectorName,
    a.ActorName
FROM Movies m
JOIN Genres g ON m.GenreID = g.GenreID
JOIN Directors d ON m.DirectorID = d.DirectorID
JOIN Actors a ON m.ActorID = a.ActorID
WHERE m.IMDB_Rating > (SELECT AVG(IMDB_Rating) FROM Movies)
ORDER BY m.IMDB_Rating DESC;

SELECT * FROM Movies


----2 taskim

-- Создаём базу данных
CREATE DATABASE SpotifyDB;
GO

USE SpotifyDB;
GO

-- Таблица исполнителей
CREATE TABLE Artists (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,
    Country NVARCHAR(50)
);

-- Таблица альбомов
CREATE TABLE Albums (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,
    ReleaseDate DATE,
    ArtistId INT FOREIGN KEY REFERENCES Artists(Id)
);

-- Таблица песен
CREATE TABLE Musics (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,
    TotalSeconds INT NOT NULL,
    AlbumId INT FOREIGN KEY REFERENCES Albums(Id),
    ArtistId INT FOREIGN KEY REFERENCES Artists(Id)
);

-- Добавим артистов
INSERT INTO Artists (Name, Country)
VALUES ('Eminem', 'USA'),
       ('Rihanna', 'Barbados');

-- Добавим альбомы
INSERT INTO Albums (Name, ReleaseDate, ArtistId)
VALUES ('Curtain Call 2', '2022-08-05', 1),
       ('The Eminem Show', '2002-05-26', 1);

-- Добавим песни
INSERT INTO Musics (Name, TotalSeconds, AlbumId, ArtistId)
VALUES ('Mockingbird', 251, 1, 1),
       ('Without Me', 290, 2, 1),
       ('Cleanin Out My Closet', 297, 2, 1);



--1query
SELECT 
    m.Name AS MusicName,
    m.TotalSeconds,
    a.Name AS ArtistName,
    al.Name AS AlbumName
FROM Musics m
JOIN Artists a ON m.ArtistId = a.Id
JOIN Albums al ON m.AlbumId = al.Id;

--2query
SELECT 
    al.Name AS AlbumName,
    COUNT(m.Id) AS MusicCount
FROM Albums al
LEFT JOIN Musics m ON al.Id = m.AlbumId
GROUP BY al.Name;
