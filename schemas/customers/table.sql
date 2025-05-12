CREATE TABLE customers
(
    id     SERIAL PRIMARY KEY,
    name   VARCHAR(100) NOT NULL,
    email  VARCHAR(100),
    phone  VARCHAR(20),
    status entity_status DEFAULT 'active'
);
