CREATE TABLE stock_transactions
(
    id               SERIAL PRIMARY KEY,
    item_id          INTEGER          NOT NULL,
    quantity         INTEGER          NOT NULL,
    transaction_type transaction_type NOT NULL,
    warehouse_id     INTEGER          NOT NULL,
    transaction_date TIMESTAMP        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (item_id) REFERENCES items (id) ON DELETE RESTRICT,
    FOREIGN KEY (warehouse_id) REFERENCES warehouse (id) ON DELETE RESTRICT
);
