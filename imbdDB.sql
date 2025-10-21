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