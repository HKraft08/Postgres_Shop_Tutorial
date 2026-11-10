CREATE DATABASE brightmart;

CREATE TABLE customers (
	customer_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	email VARCHAR(150) NOT NULL UNIQUE,
	phone VARCHAR(20) NOT NULL,
	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE products (
	product_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	product_name VARCHAR(100) NOT NULL,
	description TEXT NOT NULL,
	price NUMERIC (10, 2) NOT NULL CHECK (price >= 0),
	stock_quantity INTEGER NOT NULL DEFAULT 0 CHECK (stock_quantity >= 0),
	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE orders (
	order_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	customer_id INTEGER NOT NULL,
	order_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	status VARCHAR(20) NOT NULL DEFAULT 'PENDING',
	
	CONSTRAINT fk_orders_customer
		FOREIGN KEY (customer_id)
		REFERENCES customers(customer_id),
		
	CONSTRAINT chk_orders_status
		CHECK (status IN ('PENDING', 'PAID', 'SHIPPED', 'CANCELLED'))
);

CREATE TABLE order_items (
	order_item_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	order_id INTEGER NOT NULL,
	product_id INTEGER NOT NULL,
	quantity INTEGER NOT NULL CHECK (quantity >= 0),
	unit_price NUMERIC(10, 2) NOT NULL CHECK (unit_price >= 0),

	CONSTRAINT fk_order_items_order
		FOREIGN KEY (order_id)
		REFERENCES orders (order_id),

	CONSTRAINT fk_order_items_product
		FOREIGN KEY (product_id)
		REFERENCES products (product_id),

	CONSTRAINT uq_order_product
		UNIQUE (order_id, product_id)
);

INSERT INTO customers (first_name, last_name, email, phone) 
VALUES
	('Aisha', 'Khumalo', 'aisha@example.com', '0710000001'),
	('Daniel', 'Mokoena', 'daniel@example.com', '0720000002');

INSERT INTO products (product_name, description, price, stock_quantity)
VALUES
	('Wireless mouse', 'Wireless computer mouse', 249.99, 30),
	('Mechanical keyboard', 'USB mechanical keyboard', 899, 15),
	('USB-C cable', 'One meter USB-C cable', 99.50, 50);
	

INSERT INTO orders (customer_id, status)
VALUES
	(1, 'PAID'),
	(2, 'PENDING');

INSERT INTO order_items (order_id, product_id, quantity, unit_price)
VALUES 
	(1, 1, 2 , 249.99),
	(1, 3, 1, 99.50),
	(2, 2, 1, 899.00);


INSERT INTO customers (first_name, last_name, email, phone)
VALUES
	('Makwa', 'Netshimboni', 'makwa@example.com', '0730000003'),
	('Thabang', 'Ngoetjana', 'thabang@example.com', '0740000004'),
	('Lona', 'Hans', 'lona@example.com', '0750000005'),
	('Hishaam', 'Kraft', 'hishaam@example.com', '0760000006');

INSERT INTO products (product_name, description, price, stock_quantity)
VALUES
	('Speaker', 'Wireless speaker', 500.85, 10),
	('PS5', 'Playstation 5', 12000.99, 20),
	('Screen protector', 'Glass privacy screen protector', 250.50, 40);

INSERT INTO orders (customer_id, status)
VALUES
	(3, 'PAID'),
	(4, 'CANCELLED'),
	(5, 'SHIPPED'),
	(6, 'PENDING');

INSERT INTO order_items (order_id, product_id, quantity, unit_price)
VALUES 
	(3, 6, 3, 250.50),
	(4, 5, 1, 12000.99),
	(5, 4, 2, 500.85),
	(6, 3, 2, 99.50);


