CREATE DATABASE SpotifyDB;
GO
USE SpotifyDB;
GO

CREATE TABLE Artists (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    [Name] NVARCHAR(100) NOT NULL,
    Country NVARCHAR(100)
);

CREATE TABLE Albums (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    [Name] NVARCHAR(100) NOT NULL,
    ReleaseDate DATE,
    ArtistId INT FOREIGN KEY REFERENCES Artists(Id)
);

CREATE TABLE Musics (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    [Name] NVARCHAR(100) NOT NULL,
    TotalSecond INT,
    ListenerCount INT,
    AlbumId INT FOREIGN KEY REFERENCES Albums(Id)
);

INSERT INTO Artists ([Name], Country) VALUES
('Eminem', 'USA'),
('Adele', 'UK');

INSERT INTO Albums ([Name], ReleaseDate, ArtistId) VALUES
('Revival', '2017-12-15', 1),
('25', '2015-11-20', 2);

INSERT INTO Musics ([Name], TotalSecond, ListenerCount, AlbumId) VALUES
('Walk on Water', 305, 1200000, 1),
('River', 240, 980000, 1),
('Hello', 300, 2000000, 2);

CREATE VIEW V_MusicInfo AS
SELECT 
 Musics.[Name] AS MusicsName,
 Musics.TotalSecond AS MusicDuration,
 Artists.[Name] AS ArtistsName,
 Albums.[Name] AS AlbumsName
 FROM Musics
 Join Albums ON Musics.AlbumId = AlbumId
 Join Artists ON Albums.ArtistId = ArtistId

 CREATE VIEW V_AlbumMusicCount AS 
 SELECT 
 Albums.[Name] AS AlbumName,
 COUNT(Musics.AlbumId) AS SongCount
 FROM Albums
 LEFT JOIN  Musics ON Albums.Id=Musics.AlbumId
 GROUP BY Albums.[Name];

 CREATE PROCEDURE GetMusicByListenerAndAlbum
    @ListenerCount INT,
    @Search NVARCHAR(100)
AS
BEGIN
    SELECT 
        M.Name AS MusicName,
        M.ListenerCount,
        AL.Name AS AlbumName
    FROM Musics M
    JOIN Albums AL ON M.AlbumId = AL.Id
    WHERE 
        M.ListenerCount > @ListenerCount
        AND AL.Name LIKE '%' + @Search + '%';
END;

EXEC GetMusicByListenerAndAlbum @ListenerCount = 1000000, @Search = '25'; 


