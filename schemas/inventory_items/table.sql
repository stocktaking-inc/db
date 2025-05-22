CREATE TABLE inventory_items
(
  id           SERIAL PRIMARY KEY,
  item_id      INTEGER   NOT NULL,
  good_id      INTEGER   NOT NULL,
  warehouse_id INTEGER   NOT NULL,
  quantity     INTEGER   NOT NULL CHECK (quantity >= 0),
  last_updated TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (item_id) REFERENCES items (id) ON DELETE RESTRICT,
  FOREIGN KEY (good_id) REFERENCES good (id) ON DELETE RESTRICT,
  FOREIGN KEY (warehouse_id) REFERENCES warehouse (id) ON DELETE RESTRICT
);
