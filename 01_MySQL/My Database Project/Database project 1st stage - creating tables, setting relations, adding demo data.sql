CREATE DATABASE cafe_bakery;
USE cafe_bakery;

-- KURIU LENTELES:

CREATE TABLE products (
	product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(50) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(8,2) NOT NULL,
    is_active TINYINT(1) DEFAULT 1,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
    );
    
CREATE TABLE suppliers (
	supplier_id INT AUTO_INCREMENT PRIMARY KEY,
	supplier_name VARCHAR(100) NOT NULL,
	contact_info VARCHAR(200)
	);
    
ALTER TABLE suppliers
ADD CONSTRAINT uq_suppliers_name UNIQUE (supplier_name);
    
CREATE TABLE product_costs (
    product_id INT PRIMARY KEY,
    cost_per_unit DECIMAL(8,2) NOT NULL,
    supplier_id INT,

    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id)
);

CREATE TABLE customers (
	customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(100),
    email VARCHAR (100),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
    );
    
ALTER TABLE customers
ADD CONSTRAINT uq_customers_email UNIQUE (email);
    
CREATE TABLE employees (
	employee_id INT AUTO_INCREMENT PRIMARY KEY,
	first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    position VARCHAR(50),
	hire_date DATE
    );
    
CREATE TABLE orders (
	order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    employee_id INT,
    order_datetime DATETIME,
    channel VARCHAR(30),
    total_amount DECIMAL(10,2),
    
FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);
    
CREATE TABLE order_items (
	order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(8,2) NOT NULL,
    
FOREIGN KEY (order_id) REFERENCES orders(order_id),
FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE payments (
	payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    payment_method VARCHAR(30),
    paid_amount DECIMAL(10,2),
    payment_datetime DATETIME,

FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

CREATE TABLE wastage (
	wastage_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    wastage_datetime DATETIME,
    quantity DECIMAL(8,2),
    reason VARCHAR(30),
    
FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- DUOMENU ITERPIMAS:

INSERT INTO suppliers (supplier_name, contact_info) VALUES
('Baltic Tea Co.', 'info@baltictea.lt'),
('Green Leaf Import', 'sales@greenleaf.eu'),
('Local Bakery Supplies', 'contact@lbs.lt'),
('Organic Farm Ltd.', 'orders@organicfarm.lt'),
('Coffee & Tea Wholesale', 'support@ctw.eu');

INSERT INTO products (product_name, category, price, is_active) VALUES
('Earl Grey', 'Tea', 2.50, 1),
('Green Tea', 'Tea', 2.60, 1),
('Chamomile Tea', 'Tea', 2.30, 1),
('Rooibos Tea', 'Tea', 2.50, 0),
('Pistachio slice', 'Cake', 4.50, 1),
('Goat Milk Cheesecake', 'Cake', 5.00, 1),
('Cinnamon Roll', 'Pastry', 3.50, 1),
('Matcha White Choc Cookie', 'Pastry', 2.70, 1);

INSERT INTO product_costs (product_id, supplier_id, cost_per_unit) VALUES
(1, 1, 0.80),
(2, 1, 0.89),
(3, 2, 0.70),
(4, 2, 0.80),
(5, 3, 2.10),
(6, 3, 2.45),
(7, 4, 1.83),
(8, 5, 0.99);

INSERT INTO customers (first_name, last_name, email) VALUES
('Allesia', 'Cigoli', 'allesia.c@email.com'),
('Jorge', 'Gallardo', 'jorge.g@email.com'),
('Carmen', 'Calderon', 'carmen.c@email.com'),
('Vytaute', 'Povilanskaite', 'vytaute.p@email.com'),
('Egle', 'Serenaite', 'egle.s@email.com');

INSERT INTO employees (first_name, last_name, position, hire_date) VALUES
('Kelley', 'Himalay', 'Barista', '2023-01-15'),
('Debra', 'Pelegrino', 'Barista', '2023-03-10'),
('Nicolas', 'Barnie', 'Baker', '2022-11-01'),
('Silverio', 'Hardworker', 'Shift Manager', '2022-06-20'),
('Ulrike', 'Petrauskiene', 'Barista', '2023-07-05');

INSERT INTO orders (customer_id, employee_id, order_datetime, channel, total_amount) VALUES
(1, 1, '2024-01-05 09:15:00', 'Onsite', 6.00),
(2, 2, '2024-01-05 10:30:00', 'Takeaway', 4.50),
(3, 1, '2024-01-06 14:10:00', 'Onsite', 8.20),
(4, 3, '2024-01-06 16:45:00', 'Onsite', 5.00),
(5, 2, '2024-01-07 11:00:00', 'Online', 12.00),
(2, 4, '2024-01-07 13:20:00', 'Onsite', 7.30);

SELECT * FROM orders;

INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(1, 1, 1, 2.50),   -- Earl Grey
(1, 7, 1, 3.50),   -- Cinnamon Roll

(2, 5, 1, 4.50),   -- Pistachio slice

(3, 2, 1, 2.60),   -- Green Tea
(3, 8, 2, 2.70),   -- Matcha cookies x2

(4, 6, 1, 5.00),   -- Cheesecake

(5, 1, 2, 2.50),   -- Earl Grey x2
(5, 6, 1, 5.00),
(5, 7, 1, 3.50),

(6, 3, 1, 2.30),
(6, 7, 1, 3.50);

SELECT * FROM order_items;

INSERT INTO payments (order_id, payment_method, paid_amount, payment_datetime) VALUES
(1, 'Card', 6.00, '2024-01-05 09:16:00'),
(2, 'Cash', 4.50, '2024-01-05 10:31:00'),
(3, 'Card', 8.20, '2024-01-06 14:12:00'),
(4, 'Card', 5.00, '2024-01-06 16:47:00'),
(5, 'Online', 12.00, '2024-01-07 11:02:00'),
(6, 'Card', 7.30, '2024-01-07 13:22:00');

SELECT * FROM payments;

INSERT INTO wastage (product_id, wastage_datetime, quantity, reason) VALUES
(1, '2024-01-04 18:00:00', 0.20, 'Expired tea'),
(7, '2024-01-05 20:30:00', 1.00, 'Dropped'),
(8, '2024-01-06 21:00:00', 2.00, 'Overbaked'),
(5, '2024-01-07 17:45:00', 1.00, 'Unsold'),
(2, '2024-01-07 19:00:00', 0.15, 'Expired tea');

SELECT * FROM wastage;
