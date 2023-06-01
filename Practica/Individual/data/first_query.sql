--1ª PARTE
--Ej. 1
SELECT DISTINCT country
FROM customers;

SELECT *
FROM customers
    WHERE Country="Brazil";
    


-- Ej. 2
SELECT FirstName, LastName, Title
FROM employees
    WHERE Title="Sales Support Agent";
    
--Ej. 3
SELECT tracks.*
FROM tracks
INNER JOIN albums ON tracks.AlbumId = albums.AlbumId
INNER JOIN artists ON albums.ArtistId = artists.ArtistId
WHERE artists.Name = "AC/DC";
    

--Ej. 4
SELECT CustomerId, FirstName || " " || LastName AS Nombre_completo, Country
FROM customers
WHERE NOT Country = "USA";

--Ej. 5
SELECT FirstName || " " || LastName AS Nombre_completo,
City || ", " || State || ", " || Country AS city_state_country,
Email
FROM employees
WHERE title = "Sales Support Agent";

--Ej. 6
SELECT DISTINCT BillingCountry
FROM invoices
ORDER BY 1 ASC;
    
--Ej. 7
SELECT state, COUNT(*)
FROM customers
WHERE country="USA"
GROUP BY state;

--Ej. 8
SELECT COUNT(*), invoiceId
FROM invoice_items
INNER JOIN invoices ON invoice_items.InvoiceId = invoices.InvoiceId
WHERE invoices.invoiceId = 37;

--Ej. 9
SELECT *
FROM albums
INNER JOIN artists ON albums.ArtistId = artists.ArtistId
WHERE artists.name = "AC/DC";

SELECT COUNT(TrackId) AS Track_Id, artists.name AS Nombre_artista
FROM tracks
INNER JOIN albums ON tracks.albumId = albums.albumId
INNER JOIN artists ON albums.ArtistId = artists.ArtistId
WHERE artists.name = "AC/DC";

--Ej. 10
SELECT invoices.InvoiceId, invoices.CustomerId, COUNT(invoice_items.Quantity)
FROM invoices
INNER JOIN invoice_items ON invoices.InvoiceId = invoice_items.InvoiceId
GROUP BY invoices.InvoiceId;

--Ej. 11
SELECT BillingCountry, COUNT(invoiceId)
FROM invoices
GROUP BY BillingCountry;

--Ej. 12
SELECT COUNT(invoiceDate) AS number_of_invoices_in_2009_and_2011
FROM invoices
WHERE invoiceDate LIKE "2009%" OR invoiceDate LIKE "2011%";

--Ej. 13
SELECT COUNT(invoiceDate) AS number_of_invoices_between_2009_2011
FROM invoices
WHERE invoiceDate BETWEEN "2009%" AND "2011%";

--Ej. 14
SELECT COUNT(country) AS number_of_clients_from_Brazil_and_Spain
FROM customers
WHERE country="Spain" OR country="Brazil";

--Ej. 15
SELECT Name
FROM tracks
WHERE name LIKE "You%";

--2ª PARTE
--Ej. 1
SELECT 
    customers.FirstName || customers.LastName AS customers_full_name, 
    invoices.InvoiceId, 
    invoices.InvoiceDate, 
    invoices.BillingCountry
FROM invoices
INNER JOIN customers ON invoices.CustomerId = customers.CustomerId
WHERE customers.Country = "Brazil";

--Ej. 2
SELECT 
    invoices.InvoiceId, 
    employees.FirstName || " " || employees.LastName AS employee_full_name
FROM invoices
INNER JOIN customers ON invoices.CustomerId = customers.CustomerId
INNER JOIN employees ON customers.SupportRepId = employees.EmployeeId
WHERE employees.title = "Sales Support Agent";

--Ej. 3
SELECT 
    c.FirstName || " " || c.LastName AS customers_full_name, 
    c.Country, 
    e.FirstName || " " || e.LastName AS employees_full_name, 
    SUM(i.Total) AS total_sum
FROM invoices AS i
INNER JOIN customers AS c ON i.CustomerId = c.CustomerId
INNER JOIN employees AS e ON c.SupportRepId = e.EmployeeId
WHERE e.Title = "Sales Support Agent"
GROUP BY 1,2,3
ORDER BY 4 DESC;

--Ej. 4
SELECT 
    ii.invoiceId, 
    ii.TrackId,
    t.Name
FROM invoice_items AS ii
INNER JOIN tracks AS t ON ii.TrackId = t.TrackId;

--EJ. 5
SELECT DISTINCT
    t.Name AS song_name, 
    m.Name AS format_name, 
    a.Title AS album_title, 
    g.Name AS genre_name
FROM tracks AS t
INNER JOIN media_types AS m ON t.MediaTypeId = m.MediaTypeId
INNER JOIN albums AS a ON t.AlbumId = a.AlbumId
INNER JOIN genres AS g ON t.GenreId = g.GenreId
ORDER BY album_title;

--Ej. 6
SELECT playlists.Name, COUNT(playlists.playlistId) AS number_of_songs_per_playlist
FROM tracks
INNER JOIN playlist_track ON tracks.TrackId = playlist_track.TrackId
INNER JOIN playlists ON playlist_track.PlaylistId = playlists.PlaylistId
GROUP BY playlists.name;

--Ej. 7
SELECT employees.EmployeeId, employees.FirstName, SUM(invoices.Total)
FROM invoices
INNER JOIN customers ON invoices.CustomerId = customers.CustomerId
INNER JOIN employees ON customers.SupportRepId = employees.EmployeeId
GROUP BY employees.EmployeeId;

--Ej. 8


--Ej. 9
SELECT
ar.artistId,
ar.name,
ROUND(SUM(i.total),2) AS total
FROM invoices AS i
INNER JOIN invoice_items as ii ON i.InvoiceId = ii.InvoiceId
INNER JOIN tracks as t ON ii.TrackId = t.TrackId
INNER JOIN albums as a ON t.AlbumId = a.albumId
INNER JOIN artists as ar ON a.artistId = ar.artistId
GROUP BY 1,2
ORDER BY 3 DESC
LIMIT 3