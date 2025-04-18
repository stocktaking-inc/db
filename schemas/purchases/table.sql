CREATE TABLE purchases (
    purchase_id SERIAL PRIMARY KEY,
    invoice_number VARCHAR(50),
    supplier_id INT NOT NULL REFERENCES suppliers(supplier_id),
    warehouse_id INT NOT NULL REFERENCES warehouses(warehouse_id),
    purchase_date DATE NOT NULL,
    total_amount NUMERIC(12,2) NOT NULL CHECK (total_amount >= 0),
    status status_type NOT NULL DEFAULT 'draft',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    notes TEXT
);