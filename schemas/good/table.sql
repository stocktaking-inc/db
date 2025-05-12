CREATE TABLE good
(
    id             SERIAL PRIMARY KEY,
    supplier_id    INTEGER        NOT NULL,
    item_id        INTEGER        NOT NULL,
    warehouse_id   INTEGER        NOT NULL,
    quantity       INTEGER        NOT NULL CHECK (quantity >= 0),
    purchase_price DECIMAL(10, 2) NOT NULL,
    received_date  DATE           NOT NULL DEFAULT CURRENT_DATE,
    FOREIGN KEY (supplier_id) REFERENCES suppliers (supplier_id) ON DELETE RESTRICT,
    FOREIGN KEY (item_id) REFERENCES items (id) ON DELETE RESTRICT,
    FOREIGN KEY (warehouse_id) REFERENCES warehouse (id) ON DELETE RESTRICT
);
