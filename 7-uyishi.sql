CREATE TABLE IF NOT EXISTS books (
    book_id SERIAL PRIMARY KEY,  
    book_name VARCHAR(255) NOT NULL,  
    genre VARCHAR(100), 
    price DECIMAL(10, 2)
);


CREATE TABLE authors (
    author_id SERIAL PRIMARY KEY, 
    author_name VARCHAR(255) NOT NULL, 
    birth_date DATE, 
    country VARCHAR(100)  
);

CREATE TABLE publishers (
    publisher_id SERIAL PRIMARY KEY,  
    publisher_name VARCHAR(255) NOT NULL,  
    city VARCHAR(100), 
    founded_year INT  
);


CREATE TABLE book_reviews (
    review_id SERIAL PRIMARY KEY,  
    book_id INT, 
    review_text TEXT,  
    rating INT CHECK (rating >= 1 AND rating <= 5),  
    review_date DATE, 
    FOREIGN KEY (book_id) REFERENCES books(book_id)  
);

INSERT INTO authors (author_name, birth_date, country)
VALUES
('Abdulla Qodiriy', '1894-04-10', 'Uzbekistan'),
('Chinghiz Aytmatov', '1928-12-12', 'Kyrgyzstan'),
('Erkin Vohidov', '1936-03-06', 'Uzbekistan'),
('O‘tkanlar', '1965-09-15', 'Uzbekistan'),
('Zulfiyaxonim', '1911-11-05', 'Uzbekistan');

INSERT INTO publishers (publisher_name, city, founded_year)
VALUES
('Sharq', 'Tashkent', 1994),
('Yangi Nashr', 'Tashkent', 2000),
('O‘zbekiston Kitob Nashriyoti', 'Tashkent', 1950),
('Adabiyot', 'Tashkent', 1985),
('Milliy Kitob Dunyosi', 'Tashkent', 2005);

INSERT INTO books (book_name, genre, price)
VALUES
('O‘tkanlar', 'Roman',  25.99),
('Jamila', 'Roman', 18.50),
('Ishq va Intiqom', 'Poema', 12.99),
('Yulduzli Tunlar', 'Poema', 16.00),
('Doʻstlikning Qadrini Bilmagan', 'She’r',8.99),
('Alisher Navoiy', 'Poema', 15.00),
('Shoir va Murabbi', 'Biografiya', 20.50),
('Cholponning Ashulalari', 'She’rlar', 10.99),
('Qizil Gul', 'Roman', 22.50),
('Yurakning Qayg‘usi', 'Dastan',30.00);


INSERT INTO book_reviews (book_id, review_text, rating, review_date)
VALUES
(1, 'Kitobning hikoyasi juda ta’sirli va chuqur.', 5, '2024-10-10'),
(2, 'Chinghiz Aytmatovning ushbu asari haqiqatan ham yurakni titratadi.', 4, '2024-10-12'),
(3, 'Erkin Vohidovning she’rlari o‘zbek adabiyotining buyuk merosi hisoblanadi.', 5, '2024-10-14'),
(4, 'Yulduzli Tunlar asari haqiqatan ham romantik va dardli.', 4, '2024-10-15'),
(5, 'Zulfiyaxonimning she’rlarida sevgi va dardni juda chuqur his qilasiz.', 5, '2024-10-16');


SELECT * FROM books;
SELECT * FROM authors;
SELECT * FROM publishers;
SELECT * FROM book_reviews;

SELECT book_name AS "Kitob Nomi", genre AS "Janr", price AS "Narx" FROM books;
SELECT author_name AS "Muallif", birth_date AS "Tug'ilgan Sana", country AS "Mamlakat" FROM authors;
SELECT publisher_name AS "Nashriyot", city AS "Shahar", founded_year AS "Asos Solingan Yil" FROM publishers;
SELECT review_text AS "Sharh", rating AS "Baho", review_date AS "Sharh Sanasi" FROM book_reviews;

SELECT * FROM books ORDER BY price DESC;  
SELECT * FROM authors ORDER BY author_name ASC; 

SELECT * FROM books WHERE genre = 'Dastan';
SELECT * FROM authors WHERE country = 'Kyrgyzstan';
SELECT * FROM publishers WHERE founded_year > 1900;

SELECT * FROM books LIMIT 5;
SELECT * FROM authors FETCH FIRST 3 ROWS ONLY;

SELECT * FROM books WHERE genre IN ('Dastan', 'Roman');
SELECT * FROM authors WHERE country IN ('Kyrgyzstan', 'Russia');

SELECT * FROM books WHERE price BETWEEN 15 AND 30;
SELECT * FROM publishers WHERE founded_year BETWEEN 1800 AND 1980;

SELECT * FROM books WHERE book_name LIKE '%va%';
SELECT * FROM authors WHERE author_name LIKE 'Z%';

SELECT * FROM book_reviews WHERE review_text IS NULL;
SELECT * FROM books WHERE price IS NULL;

SELECT genre, COUNT(*) AS book_count FROM books GROUP BY genre;
SELECT a.country, AVG(b.price) AS avg_price
FROM books b
JOIN authors a ON b.book_id = a.author_id
GROUP BY a.country;

ALTER TABLE books ADD COLUMN author_id INT;
ALTER TABLE books ADD COLUMN publisher_id INT;
ALTER TABLE books ADD CONSTRAINT fk_author FOREIGN KEY (author_id) REFERENCES authors(author_id);
ALTER TABLE books ADD CONSTRAINT fk_publisher FOREIGN KEY (publisher_id) REFERENCES publishers(publisher_id);

SELECT b.book_name, a.author_name, p.publisher_name, b.genre, b.price
FROM books b
JOIN authors a ON b.author_id = a.author_id
JOIN publishers p ON b.publisher_id = p.publisher_id;

SELECT COUNT(*) AS total_books FROM books;
SELECT AVG(price) AS avg_book_price FROM books;
SELECT SUM(price) AS total_value FROM books;


