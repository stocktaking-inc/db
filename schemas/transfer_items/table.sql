CREATE TABLE transfer_items (
    item_id SERIAL PRIMARY KEY,
    transfer_id INT NOT NULL REFERENCES transfers(transfer_id) ON DELETE CASCADE,
    product_id INT NOT NULL REFERENCES products(product_id),
    quantity NUMERIC(10,3) NOT NULL CHECK (quantity > 0)
);