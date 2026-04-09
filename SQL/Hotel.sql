-- Hotel Schema
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE bookings (
    booking_id INT PRIMARY KEY,
    user_id INT,
    booking_date DATE,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE items (
    item_id INT PRIMARY KEY,
    booking_id INT,
    item_name VARCHAR(50),
    quantity INT,
    rate DECIMAL(10,2),
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id)
);

-- Sample Data
INSERT INTO users VALUES (1, 'Alice'), (2, 'Bob');
INSERT INTO bookings VALUES (101, 1, '2021-11-10'), (102, 2, '2021-11-15');
INSERT INTO items VALUES 
(1, 101, 'Room Service', 2, 500),
(2, 101, 'Dinner', 1, 300),
(3, 102, 'Room Service', 1, 500);

-- Q1: Last booked room
SELECT MAX(booking_date) AS last_booking FROM bookings;

-- Q2: Billing in Nov 2021
SELECT b.booking_id, SUM(i.quantity * i.rate) AS total_bill
FROM bookings b
JOIN items i ON b.booking_id = i.booking_id
WHERE MONTH(b.booking_date) = 11 AND YEAR(b.booking_date) = 2021
GROUP BY b.booking_id;

-- Q3: Bills > 1000
SELECT b.booking_id, SUM(i.quantity * i.rate) AS total_bill
FROM bookings b
JOIN items i ON b.booking_id = i.booking_id
GROUP BY b.booking_id
HAVING SUM(i.quantity * i.rate) > 1000;

-- Q4: Most ordered item per month
SELECT MONTH(b.booking_date) AS month, i.item_name, SUM(i.quantity) AS total_qty
FROM bookings b
JOIN items i ON b.booking_id = i.booking_id
GROUP BY month, i.item_name
ORDER BY month, total_qty DESC;

-- Q5: 2nd highest bill
SELECT booking_id, total_bill
FROM (
    SELECT b.booking_id, SUM(i.quantity * i.rate) AS total_bill,
           RANK() OVER (ORDER BY SUM(i.quantity * i.rate) DESC) AS rnk
    FROM bookings b
    JOIN items i ON b.booking_id = i.booking_id
    GROUP BY b.booking_id
) t
WHERE rnk = 2;
