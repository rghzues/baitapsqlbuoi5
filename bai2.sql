CREATE DATABASE Music_LAB1;

USE Music_LAB1;

CREATE TABLE Albums (
    AlbumID INT PRIMARY KEY,
    AlbumName NVARCHAR(100) NOT NULL,
    CreateDate SMALLDATETIME NOT NULL,
    Price MONEY NOT NULL
);

CREATE TABLE Artists (
    ArtistID INT PRIMARY KEY,
    ArtistName NVARCHAR(100) NOT NULL
);

CREATE TABLE Songs (
    SongID INT PRIMARY KEY,
    SongName NVARCHAR(100) NOT NULL,
    ArtistID INT NOT NULL
);

CREATE TABLE AlbumSong (
    AlbumID INT NOT NULL,
    SongID INT NOT NULL,
    PRIMARY KEY (AlbumID, SongID)
);

ALTER TABLE Songs
ADD CONSTRAINT FK_Songs_Artists
FOREIGN KEY (ArtistID) REFERENCES Artists(ArtistID);

ALTER TABLE AlbumSong
ADD CONSTRAINT FK_AlbumSong_Songs
FOREIGN KEY (SongID) REFERENCES Songs(SongID);

ALTER TABLE AlbumSong
ADD CONSTRAINT FK_AlbumSong_Albums
FOREIGN KEY (AlbumID) REFERENCES Albums(AlbumID);

ALTER TABLE Albums
ADD CONSTRAINT CK_Albums_CreateDate
CHECK (CreateDate >= '1990-01-01' AND CreateDate <= GETDATE());

ALTER TABLE Artists
ADD CONSTRAINT UQ_Artists_ArtistName
UNIQUE (ArtistName);

INSERT INTO Artists VALUES
(1, N'Trong Tan'),
(2, N'Dang Duong'),
(3, N'Anh Tho'),
(4, N'Viet Hoan'),
(5, N'Lan Anh');

INSERT INTO Songs VALUES
(1, N'Bai ca Ha Noi', 1),
(2, N'Hat ve cay lua hom nay', 1),
(3, N'Gui em chiec non bai tho', 1),
(4, N'Ho Bien', 2),
(5, N'Tinh ca', 2),
(6, N'Me yeu con', 3),
(7, N'Dau chan trong rung', 3),
(8, N'Tinh ca', 4),
(9, N'Tinh em', 4),
(10, N'Tinh ta bien bac dong xanh', 4),
(11, N'Me yeu con', 5),
(12, N'Trang chieu', 5);

INSERT INTO Albums VALUES
(1, N'Viet Nam que huong toi', '2001-02-01', 10),
(2, N'Tinh ca', '2001-12-03', 15),
(3, N'Tuyen chon nua cay', '2003-12-04', 20);

INSERT INTO AlbumSong VALUES
(1,1),(1,2),(1,4),(1,10),
(2,3),(2,5),(2,6),(2,8),(2,9),
(3,11),(3,7),(3,12);

UPDATE Songs
SET SongName = N'Giai dieu to quoc'
WHERE SongName = N'Tinh ca';

UPDATE AlbumSong
SET AlbumID = 1
WHERE SongID IN (
    SELECT SongID FROM Songs WHERE SongName = N'Giai dieu to quoc'
);

UPDATE Albums
SET Price = Price * 0.9
WHERE YEAR(CreateDate) < 2002;

DELETE FROM AlbumSong
WHERE SongID IN (
    SELECT SongID FROM Songs WHERE ArtistID = 5
);

DELETE FROM Songs
WHERE ArtistID = 5;

DELETE FROM Artists
WHERE ArtistName = N'Lan Anh';
