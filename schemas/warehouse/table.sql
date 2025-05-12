CREATE TABLE warehouse
(
    id        SERIAL PRIMARY KEY,
    name      VARCHAR(100) NOT NULL,
    address   TEXT,
    is_active BOOLEAN DEFAULT TRUE
);
