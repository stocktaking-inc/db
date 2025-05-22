CREATE TABLE items
(
  id          SERIAL PRIMARY KEY,
  name        VARCHAR(100)       NOT NULL,
  article     VARCHAR(50) UNIQUE NOT NULL,
  category_id INTEGER            NOT NULL,
  FOREIGN KEY (category_id) REFERENCES categories (id) ON DELETE RESTRICT
);
