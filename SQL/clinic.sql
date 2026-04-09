-- Clinic Schema
CREATE TABLE clinic_sales (
    sale_id INT PRIMARY KEY,
    sales_channel VARCHAR(20),
    amount DECIMAL(10,2),
    sale_date DATE
);

CREATE TABLE expenses (
    expense_id INT PRIMARY KEY,
    month VARCHAR(20),
    amount DECIMAL(10,2)
);

-- Sample Data
INSERT INTO clinic_sales VALUES 
(1, 'Online', 2000, '2021-11-05'),
(2, 'Offline', 1500, '2021-11-10');

INSERT INTO expenses VALUES 
(1, 'Nov-2021', 1000),
(2, 'Dec-2021', 1200);

-- Q1: Revenue by channel
SELECT sales_channel, SUM(amount) AS revenue
FROM clinic_sales
GROUP BY sales_channel;

-- Q3: Profit/Loss by month
SELECT s.month, s.revenue - e.amount AS profit_loss
FROM (
    SELECT DATE_FORMAT(sale_date, '%b-%Y') AS month, SUM(amount) AS revenue
    FROM clinic_sales
    GROUP BY month
) s
JOIN expenses e ON s.month = e.month;
