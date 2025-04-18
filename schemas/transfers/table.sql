CREATE TABLE transfers (
    transfer_id SERIAL PRIMARY KEY,
    from_warehouse_id INT NOT NULL REFERENCES warehouses(warehouse_id),
    to_warehouse_id INT NOT NULL REFERENCES warehouses(warehouse_id),
    transfer_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status status_type NOT NULL DEFAULT 'draft',
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CHECK (from_warehouse_id <> to_warehouse_id)
);