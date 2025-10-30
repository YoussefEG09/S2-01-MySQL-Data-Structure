DROP DATABASE IF EXISTS youtube_db;
CREATE DATABASE youtube_db;
USE youtube_db;

CREATE TABLE IF NOT EXISTS users (
id INT AUTO_INCREMENT PRIMARY KEY,
email VARCHAR(50) NOT NULL UNIQUE,
password VARCHAR(255) NOT NULL,
username VARCHAR(20) NOT NULL UNIQUE,
birthdate DATE,
gender ENUM('male', 'female', 'other'),
country VARCHAR(50),
postal_code VARCHAR(10)
);

CREATE TABLE videos (
id INT AUTO_INCREMENT PRIMARY KEY,
title VARCHAR(200) NOT NULL,
description TEXT,
size BIGINT,
filename VARCHAR(200) NOT NULL,
duration INT NOT NULL,
thumbnail VARCHAR(300),
views INT DEFAULT 0,
likes INT DEFAULT 0,
dislikes INT DEFAULT 0,
status ENUM('public', 'hidden', 'private'),
user_id INT ,
upload_date DATETIME,
FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE tags (
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE video_tags (
video_id INT,
tag_id INT,
PRIMARY KEY(video_id, tag_id),
FOREIGN KEY (video_id) REFERENCES videos(id),
FOREIGN KEY (tag_id) REFERENCES tags(id)
);

CREATE TABLE channels (
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(50) NOT NULL UNIQUE,
description TEXT,
creation_date DATETIME,
user_id INT,
FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE subscriptions (
user_id INT,
channel_id INT,
subscription_date DATETIME,
PRIMARY KEY (user_id, channel_id),
FOREIGN KEY (user_id) REFERENCES users(id),
FOREIGN KEY (channel_id) REFERENCES channels(id)
);

CREATE TABLE video_likes_dislikes (
    video_id INT,
    user_id INT,
    reaction ENUM('like', 'dislike'),
    timestamp DATETIME,
    PRIMARY KEY (video_id, user_id),
    FOREIGN KEY (video_id) REFERENCES videos(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE playlists (
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(50) NOT NULL,
creation_date DATETIME,
status ENUM('public', 'private'),
user_id INT,
FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE playlist_videos (
playlist_id INT,
video_id INT,
PRIMARY KEY (playlist_id, video_id),
FOREIGN KEY (playlist_id) REFERENCES playlists(id),
FOREIGN KEY (video_id) REFERENCES videos(id)
);

CREATE TABLE comments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    text TEXT NOT NULL,
    timestamp DATETIME NOT NULL,
    video_id INT,
    user_id INT,
    FOREIGN KEY (video_id) REFERENCES videos(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
    );
    
    CREATE TABLE comment_likes_dislikes (
    comment_id INT,
    user_id INT,
    reaction ENUM('like', 'dislike'),
    timestamp DATETIME,
    PRIMARY KEY (comment_id, user_id),
    FOREIGN KEY (comment_id) REFERENCES comments(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO users (email, password, username, birthdate, gender, country, postal_code) VALUES
('alice@example.com', 'hashed_pwd1', 'AliceW', '1995-05-20', 'female', 'USA', '90210'),
('bob@example.com', 'hashed_pwd2', 'Bobby99', '1990-02-11', 'male', 'UK', 'SW1A1AA'),
('carla@example.com', 'hashed_pwd3', 'CarlaTech', '1998-09-03', 'female', 'Spain', '08001'),
('david@example.com', 'hashed_pwd4', 'DavidVlogs', '1987-07-19', 'male', 'France', '75001');


INSERT INTO channels (name, description, creation_date, user_id) VALUES
('Alice World', 'Lifestyle, travel and fun content.', '2022-06-01 10:00:00', 1),
('Tech By Carla', 'Tech reviews, tutorials, and news.', '2023-01-15 14:30:00', 3),
('David Daily', 'Daily vlogs and life updates.', '2021-03-10 09:00:00', 4);


INSERT INTO videos (title, description, size, filename, duration, thumbnail, views, status, user_id, upload_date) VALUES
('A Day in Barcelona', 'Exploring Barcelona city center.', 500000000, 'barcelona.mp4', 480, 'barcelona.jpg', 1200, 'public', 1, '2023-05-01 11:00:00'),
('Unboxing the Latest Smartphone', 'Full review of the new smartphone release.', 800000000, 'smartphone_review.mp4', 720, 'phone_thumb.jpg', 25000, 'public', 3, '2023-06-12 15:00:00'),
('Morning Routine 2023', 'My productive morning routine for 2023.', 300000000, 'morning_routine.mp4', 300, 'morning_thumb.jpg', 900, 'public', 1, '2023-03-08 09:30:00'),
('Funny Moments Compilation', 'A funny collection of clips and moments.', 600000000, 'funny_moments.mp4', 600, 'funny_thumb.jpg', 8000, 'public', 4, '2022-12-20 18:00:00');

INSERT INTO tags (name) VALUES
('travel'),
('tech'),
('funny'),
('vlog'),
('review'),
('morning');


INSERT INTO video_tags (video_id, tag_id) VALUES
(1, 1), -- Barcelona → travel
(1, 4), -- Barcelona → vlog
(2, 2), -- Smartphone → tech
(2, 5), -- Smartphone → review
(3, 6), -- Morning → morning
(4, 3); -- Funny Moments → funny

INSERT INTO subscriptions (user_id, channel_id, subscription_date) VALUES
(2, 1, '2023-06-15 10:00:00'), -- Bob subscribes to Alice
(1, 2, '2023-07-01 12:30:00'), -- Alice subscribes to Carla
(4, 2, '2023-07-10 09:45:00'), -- David subscribes to Carla
(3, 1, '2023-08-05 16:20:00'); -- Carla subscribes to Alice

INSERT INTO playlists (name, creation_date, status, user_id) VALUES
('Travel Vlogs', '2023-07-02 10:00:00', 'public', 1),
('Tech Reviews', '2023-08-10 12:00:00', 'public', 3),
('Funny Stuff', '2023-09-01 18:00:00', 'private', 4);

INSERT INTO playlist_videos (playlist_id, video_id) VALUES
(1, 1),
(1, 3),
(2, 2),
(3, 4);

INSERT INTO comments (text, timestamp, video_id, user_id) VALUES
('Amazing video! I love Barcelona!', '2023-05-02 09:00:00', 1, 2),
('This phone looks awesome!', '2023-06-13 18:30:00', 2, 1),
('Very inspiring morning routine!', '2023-03-09 10:00:00', 3, 3),
('So funny, I can’t stop laughing!', '2022-12-21 20:00:00', 4, 1);

INSERT INTO video_likes_dislikes (video_id, user_id, reaction, timestamp) VALUES
(1, 2, 'like', '2023-05-02 09:05:00'),
(2, 1, 'like', '2023-06-13 19:00:00'),
(2, 4, 'dislike', '2023-06-14 11:00:00'),
(3, 3, 'like', '2023-03-09 10:10:00'),
(4, 2, 'like', '2022-12-22 12:00:00');

INSERT INTO comment_likes_dislikes (comment_id, user_id, reaction, timestamp) VALUES
(1, 3, 'like', '2023-05-02 10:00:00'),
(2, 4, 'like', '2023-06-13 20:00:00'),
(3, 1, 'like', '2023-03-09 10:15:00'),
(4, 3, 'dislike', '2022-12-22 10:00:00');



