CREATE TABLE suppliers
(
  supplier_id    SERIAL PRIMARY KEY,
  name           VARCHAR(100) NOT NULL,
  contact_person VARCHAR(100),
  email          VARCHAR(100),
  phone          VARCHAR(20),
  status         entity_status DEFAULT 'active'
);
