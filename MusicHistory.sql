--1. Query all of the entries in the Genre table
SELECT * FROM Genre;

--2. Query all the entries in the Artist table and order by the artist's name. HINT: use the ORDER BY keywords
SELECT * FROM Artist;

--3. Write a SELECT query that lists all the songs in the Song table and include the Artist name
SELECT 
	a.ArtistName,
	s.Title
FROM Song s
JOIN Artist a on s.ArtistId = a.Id
	

--4. Write a SELECT query that lists all the Artists that have a Soul Album
SELECT DISTINCT ar.ArtistName
FROM Artist ar
JOIN Album al ON al.ArtistId = ar.Id
WHERE al.GenreId = 1;

--5. Write a SELECT query that lists all the Artists that have a Jazz or Rock Album
SELECT DISTINCT ar.ArtistName
FROM Artist ar
JOIN Album al ON al.ArtistId = ar.Id
WHERE al.GenreId = 4 or al.GenreId = 2;

--6. Write a SELECT statement that lists the Albums with no songs
SELECT al.Title 'Album', s.Title
FROM Album al
LEFT JOIN Song s 
ON s.AlbumId = al.Id
WHERE s.Title IS NULL;

--7. Using the INSERT statement, add one of your favorite artists to the Artist table.
INSERT INTO 
	Artist (ArtistName, YearEstablished) 
VALUES
	('Kanye West', 1996);

--8. Using the INSERT statement, add one, or more, albums by your artist to the Album table.
INSERT INTO 
	Album (Title, ReleaseDate, AlbumLength, Label, ArtistId, GenreId) 
VALUES
	('Watch the Throne', '08/08/2011', 689, 'Def Jam', 28, 13);

--9. Using the INSERT statement, add some songs that are on that album to the Song table.
INSERT INTO 
	Song (Title, SongLength, ReleaseDate, GenreId, ArtistId, AlbumId) 
VALUES 
	('Otis', 196, '08/08/2011', 13, 28, 23);

SELECT * FROM Song

--10. Write a SELECT query that provides the song titles, 
--	album title, and artist name for all of the data you just entered in.
--	Use the LEFT JOIN keyword sequence to connect the tables, 
--	and the WHERE keyword to filter the results to the album and 
--	artist you added.
SELECT
	s.Title Song, al.Title Album, ar.ArtistName
FROM
	Album al
LEFT JOIN Song s ON s.AlbumId = al.Id
LEFT JOIN Artist ar ON s.ArtistId = ar.Id
WHERE s.Title = 'Otis'

--11. Write a SELECT statement to display how many songs exist for each album. You'll need to use the COUNT() function and the GROUP BY keyword sequence.
SELECT COUNT(s.id) AS NumOfSongs, a.Title
FROM Song s
JOIN Album a ON s.AlbumId = a.Id
GROUP BY a.Title

--12. Write a SELECT statement to display how many songs exist for each artist. You'll need to use the COUNT() function and the GROUP BY keyword sequence.
SELECT COUNT(s.id) AS NumOfSongs, a.ArtistName
FROM Song s
JOIN Artist a ON s.ArtistId = a.Id
GROUP BY a.ArtistName

--13. Write a SELECT statement to display how many songs exist for each genre. You'll need to use the COUNT() function and the GROUP BY keyword sequence.
SELECT COUNT(s.id) AS NumOfSongs, g.Name
FROM Song s
JOIN Genre g ON s.GenreId = g.Id
GROUP BY g.Name

--14. Write a SELECT query that lists the Artists that have put out records on more than one record label. Hint: When using GROUP BY instead of using a WHERE clause, use the HAVING keyword
Select Artist.ArtistName, Count(Distinct Album.Label)
From Artist 
Join Album On Artist.Id = Album.ArtistId
Group By Artist.ArtistName
Having Count(Distinct Album.Label) > 1


--15. Using MAX() function, write a select statement to find the album with the longest duration. The result should display the album title and the duration.
SELECT Title, AlbumLength
FROM Album
WHERE AlbumLength = (SELECT MAX(AlbumLength) FROM Album)


--16. Using MAX() function, write a select statement to find the song with the longest duration. The result should display the song title and the duration.
SELECT Title, SongLength
FROM Song
WHERE SongLength = (SELECT MAX(SongLength) FROM Song)

--17. Modify the previous query to also display the title of the album.
SELECT s.Title AS Song, s.SongLength, a.Title AS Album
FROM Song s
LEFT JOIN Album a ON s.AlbumId = a.Id
WHERE s.SongLength = (SELECT MAX(s.SongLength) FROM Song s)