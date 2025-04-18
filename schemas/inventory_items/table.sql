CREATE TABLE inventory_items (
    item_id SERIAL PRIMARY KEY,
    inventory_id INT NOT NULL REFERENCES inventory(inventory_id) ON DELETE CASCADE,
    product_id INT NOT NULL REFERENCES products(product_id),
    system_quantity NUMERIC(10,3) NOT NULL,
    actual_quantity NUMERIC(10,3) NOT NULL,
    difference NUMERIC(10,3) GENERATED ALWAYS AS (actual_quantity - system_quantity) STORED,
    notes TEXT,
    UNIQUE (inventory_id, product_id)
);