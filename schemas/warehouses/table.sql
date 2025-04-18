CREATE TABLE warehouses (
  address VARCHAR(100) NOT NULL,
  name VARCHAR(50) NOT NULL,
  warehouse_id SERIAL PRIMARY KEY,
  is_active boolean DEFAULT true,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);