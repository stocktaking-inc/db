CREATE TABLE purchase_items (
    item_id SERIAL PRIMARY KEY,
    purchase_id INT NOT NULL REFERENCES purchases(purchase_id) ON DELETE CASCADE,
    product_id INT NOT NULL REFERENCES products(product_id),
    batch_number VARCHAR(50),
    quantity NUMERIC(10,3) NOT NULL CHECK (quantity > 0),
    price NUMERIC(10,2) NOT NULL CHECK (price >= 0),
    total_price NUMERIC(12,2) GENERATED ALWAYS AS (quantity * price) STORED
);