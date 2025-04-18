CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    article VARCHAR(50) UNIQUE,
    barcode VARCHAR(50) UNIQUE,
    category_id INT REFERENCES categories(category_id) ON DELETE SET NULL,
    quantity NUMERIC(10,3) NOT NULL DEFAULT 0 CHECK (quantity >= 0),
    unit unit_type NOT NULL,
    cost_price NUMERIC(10,2) NOT NULL CHECK (cost_price >= 0),
    selling_price NUMERIC(10,2) NOT NULL CHECK (selling_price >= 0),
    min_stock_level NUMERIC(10,3) DEFAULT 0 CHECK (min_stock_level >= 0),
    description TEXT,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);