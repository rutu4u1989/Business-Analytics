-- Create database
CREATE DATABASE spotify_db;
USE spotify_db;
-- Create Users
CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    user_name VARCHAR(50),
    country VARCHAR(50),
    plan VARCHAR(20)
);
-- Create Artists
CREATE TABLE Artists (
    artist_id INT PRIMARY KEY,
    artist_name VARCHAR(100),
    genre VARCHAR(50)
);
-- Create Tracks
CREATE TABLE Tracks (
    track_id INT PRIMARY KEY,
    track_name VARCHAR(100),
    artist_id INT,
    duration_sec INT,
    FOREIGN KEY (artist_id) REFERENCES Artists(artist_id)
);
-- Create Listening_History
CREATE TABLE Listening_History (
    play_id INT PRIMARY KEY,
    user_id INT,
    track_id INT,
    minutes_played INT,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (track_id) REFERENCES Tracks(track_id)
);
-- Insert Users
INSERT INTO Users (user_id, user_name, country, plan) VALUES
(1, 'Aditi', 'India', 'Premium'),
(2, 'Rahul', 'India', 'Free'),
(3, 'Emma', 'UK', 'Premium'),
(4, 'Noah', 'USA', 'Free'),
(5, 'Sofia', 'Spain', 'Premium'),
(6, 'Arjun', 'India', 'Free');
-- Insert Artists
INSERT INTO Artists (artist_id, artist_name, genre) VALUES
(101, 'Arijit Singh', 'Bollywood'),
(102, 'Taylor Swift', 'Pop'),
(103, 'The Weeknd', 'Pop'),
(104, 'A. R. Rahman', 'Bollywood'),
(105, 'Ed Sheeran', 'Pop'),
(106, 'Imagine Dragons', 'Rock');
-- Insert Tracks
INSERT INTO Tracks (track_id, track_name, artist_id, duration_sec) VALUES
(201, 'Kesariya', 101, 268),
(202, 'Anti-Hero', 102, 200),
(203, 'Blinding Lights', 103, 200),
(204, 'Jai Ho', 104, 210),
(205, 'Shape of You', 105, 234),
(206, 'Believer', 106, 204),
(207, 'Perfect', 105, 263),
(208, 'Channa Mereya', 101, 290);
-- Insert Listening_History
INSERT INTO Listening_History (play_id, user_id, track_id, minutes_played) VALUES
(1001, 1, 201, 4),
(1002, 1, 202, 3),
(1003, 2, 201, 4),
(1004, 2, 203, 3),
(1005, 3, 205, 4),
(1006, 3, 207, 4),
(1007, 4, 206, 3),
(1008, 4, 203, 3),
(1009, 5, 202, 3),
(1010, 5, 205, 4),
(1011, 6, 208, 5),
(1012, 6, 201, 4),
(1013, 1, 208, 5),
(1014, 2, 206, 3),
(1015, 3, 202, 3);
-- Verify the dataset
SELECT * FROM Users;
SELECT * FROM Artists;
SELECT * FROM Tracks;
SELECT * FROM Listening_History;

-- 1. List all available tracks along with their durations.
Select track_name, duration_sec
From Tracks;

-- 2. Show all users who are subscribed to the Premium plan.
Select * from users where plan = "premium";

-- 3. Find all tracks whose names contain the word “Lights”.
Select * from tracks where track_name Like "%Light%";

-- 4. Find all tracks whose names start with the letter “B”.
select * from Tracks where Track_name like "B%";

-- 5. Display track names and durations using meaningful column aliases.
select track_name As TRACK_NAME, duration_sec AS DURATION_SECONDS From Tracks;
-- 6. List all artists in alphabetical order.
Select * From Artists Order by artist_name asc;
-- 7. Show all users from India who are on the Free plan.
Select * from users where country ="India" and plan = "Free";

-- 8. Calculate the number of tracks available in each genre.
select a.genre, count(t.track_id)
from Artists a
Join track t
On a.artist_id = t.artist_id
Group By a.genre; 

-- 9. Find the total number of plays for each song.
select t.tracks_name, count(m.play_id)
from Tracks t
Join Listening_History m
On t.track_id = m.track_id
Group By t.tracks_name;
-- 10. Identify the top 5 most-played songs.
select t.track_name, count(m.play_id)
from tracks t
join Listening_history m
on t.track_id = m.track_id
group by t.track_name
order by t.track_name Desc Limit 5;

-- 11. Calculate the total listening minutes for each user.
select u.user_name, sum(m.minutes_played) 
from users u
join Listening_history m
on u.user_id = m.user_id
group by u.user_name;

-- 12. Find artists whose songs have been played more than twice.
select a.artist_name, count(m.play_id)
from artists a
join tracks t
on a.artist_id = t.artist_id
join listening_history m
on t.track_id = m.track_id
group by a.artist_name
having count(m.play_id)>2;
-- 13. Calculate the total listening minutes for each country.
select u.country, sum(m.minutes_played)
from users u
join Listening_History m
on u.user_id = m.user_id
group by u.country;
-- 14. Find genres that contain more than one track.
select a.genre, count(t.track_id)
from artists a
join tracks t
on a.artist_id = t.artist_id
group by a.genre 
having count(t.track_id)>1;
-- 15. Display each user's listening history along with the song title and artist name.
select m.minutes_played, u.user_name, t.track_name, a.artist_name
from users u
join Listening_history m
on u.user_id = m.user_id
join tracks t
on m.track_id = t.track_id
join artists a 
on t.artist_id = a.artist_id;




