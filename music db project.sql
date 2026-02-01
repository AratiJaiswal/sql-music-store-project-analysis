---Q1. Who is seniour most employee based on job title?
select * from employee
order by levels desc 
limit 1

---Q2. Which country has the most invoices ?
select billing_country, count(*) as c
from invoice 
group by billing_country
order by c desc;
---Q3. what are top 3 values of total invoice?
select * from invoice 
order by total desc
limit 3

---Q4. Which city has the best customers? we would like to throw a music festival in the city we made the most money . write a query that 
---returns one city that has the highest sum of invoices totals 
----return both the city name & sum of all invoice total.
select sum(total) as invoice_total, billing_city
from invoice
group by billing_city
order by invoice_total desc

--Q5. Who is the best customer? The customer who has spent the most money will be declared the best customer .
select  customer.customer_id, customer.first_name, customer.last_name, sum(invoice.total) as total
from customer
join invoice on customer.customer_id = invoice.customer_id
group by  customer.customer_id
order by total desc
limit 1

--Q6. Write a query to return the email, ffirst name, last name, & genre of all rock music listeners,
--     return your list ordered alphanumeric by email writing with A .

select distinct email,first_name, last_name
from customer
join invoice on customer.customer_id =  invoice.customer_id
join invoice_line on invoice.invoice_id = invoice_line.invoice_id 
where track_id in(
 select track_id from track
 join genre on track.genre_id = genre.genre_id
 where genre.name like 'Rock'
)
order by email;
--Q6. Let's invite the artist who have written the most rock music in our dataset . 
---- write a query that returns the artist name and total track count of the top 10 rock bands .
select artist.artist_id, artist.name, count(artist.artist_id) as number_of_songs
from track
join album on album.album_id = track.album_id
join artist on artist.artist_id = album.artist_id
join genre on genre.genre_id = track.genre_id
where genre.name like 'Rock'
 group by artist.artist_id
 order by number_of_songs desc
 limit 10;

 --Q7. Return all the track names that have a song length longer than the average song length 
 --Return the name and millisecond for each track. order by the song length with the longest songs listed
 --first.
 select name, milliseconds
 from track
 where milliseconds > (
select AVG(milliseconds) as avg_track_length
from track
 )
order by milliseconds desc;

--
