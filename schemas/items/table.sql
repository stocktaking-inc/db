CREATE TABLE items (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    article VARCHAR(50) UNIQUE NOT NULL,
    category VARCHAR(50) NOT NULL,
    quantity INTEGER NOT NULL DEFAULT 0,
    location INTEGER REFERENCES warehouse(id),
    status status_type DEFAULT 'Out of Stock',
    supplier INTEGER REFERENCES suppliers(id)
);
