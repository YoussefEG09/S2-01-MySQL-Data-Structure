🧠 MySQL Data Modeling Exercises

This repository contains several database modeling and SQL structure exercises developed in MySQL, focused on understanding data normalization, relationships, and real-world database design.

📁 Projects Overview
🕶️ Exercise 1 — Optical Store

Goal:
Design a database for an optical store that manages customers, employees, suppliers, glasses, and sales.

Key Features:

Customers can recommend other customers.

Each sale involves one employee, one client, and a pair of glasses.

Glasses are linked to suppliers.

Relational integrity enforced with foreign keys and indexes.

Main Tables:

clients

employees

supplier

glasses

sales

🍕 Exercise 2 — Pizzeria

Goal:
Create a complete system for managing pizza orders, employees, stores, and deliveries.

Key Features:

Customers linked to cities and provinces.

Products divided into categories: pizzas, burgers, and drinks.

Orders contain multiple products and can be delivered or picked up.

Employees can work as cooks or delivery drivers.

Includes delivery tracking and timestamps.

Main Tables:

provinces, locations, customers

stores, employees

category, product

orders, order_details, deliveries

Highlights:

Proper use of ENUM, CHECK constraints, and FK dependencies.

INSERT examples with realistic product data (in English).

▶️ Exercise 3 — YouTube Database

Goal:
Model a simplified version of YouTube to store users, videos, comments, and interactions.

Key Features:

Users can create channels, upload videos, and interact via likes/dislikes.

Each video can have multiple tags and belong to playlists.

Users can subscribe to channels and comment on videos.

Full tracking of actions with timestamps.

Main Tables:

users, channels, videos

tags, video_tags

playlists, playlist_videos

comments, comment_likes_dislikes

video_likes_dislikes, subscriptions

Highlights:

Strong use of many-to-many relationships with associative tables.

Includes fields for status (public, hidden, private) and metadata (views, thumbnail, etc.).

⚙️ Technologies Used

MySQL 8.0

Docker (for containerized database environments)

Git / GitHub for version control

🚀 How to Run

Clone this repository:

git clone https://github.com/YoussefEG09/S2-01-MySQL-Data-Structure.git


Navigate to the project folder:

cd S2-01-MySQL-Data-Structure


Open MySQL and execute the corresponding .sql file from each exercise folder.
