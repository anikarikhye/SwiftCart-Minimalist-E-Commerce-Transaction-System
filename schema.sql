DROP TABLE IF EXISTS order_items CASCADE; 
DROP TABLE IF EXISTS orders CASCADE; 
DROP TABLE IF EXISTS inventory CASCADE; 
DROP TABLE IF EXISTS products CASCADE; 
DROP TABLE IF EXISTS users CASCADE;

CREATE TABLE users (
    user_id SERIAL PRIMARY KEY, 
    email VARCHAR(255) UNIQUE NOT NULL, 
    password_hash VARCHAR(255) NOT NULL
);

CREATE TABLE products (
    product_id SERIAL PRIMARY KEY, 
    name VARCHAR(255) NOT NULL, 
    price DECIMAL(10, 2) NOT NULL CHECK (price >= 0)
);

CREATE TABLE inventory (
    product_id INT PRIMARY KEY REFERENCES products(product_id) ON DELETE CASCADE, 
    stock_quantity INT NOT NULL CHECK (stock_quantity >= 0)
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY, 
    user_id INT REFERENCES users(user_id), 
    total_amount DECIMAL(10,2) NOT NULL DEFAULT 0.00, 
    status VARCHAR(50) DEFAULT 'PENDING'
);

CREATE TABLE order_items (
    order_item_id SERIAL PRIMARY KEY, 
    order_id INT REFERENCES orders(order_id), 
    product_id INT REFERENCES products(product_id), 
    quantity INT NOT NULL CHECK (quantity > 0)
);

CREATE INDEX idx_orders_user_id ON orders(user_id);

INSERT INTO users (email, password_hash) VALUES ('test@example.com', 'hash123');
INSERT INTO products (name, price) VALUES ('Mouse', 25.00);
INSERT INTO inventory (product_id, stock_quantity) VALUES (1, 50);