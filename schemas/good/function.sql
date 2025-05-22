CREATE OR REPLACE FUNCTION add_to_inventory()
  RETURNS TRIGGER AS
$$
BEGIN
  INSERT INTO inventory_items (item_id, good_id, warehouse_id, quantity, last_updated)
  VALUES (NEW.item_id, NEW.id, NEW.warehouse_id, NEW.quantity, CURRENT_TIMESTAMP);

  -- Добавление записи в stock_transactions
  INSERT INTO stock_transactions (item_id, quantity, transaction_type, warehouse_id, transaction_date)
  VALUES (NEW.item_id, NEW.quantity, 'receipt', NEW.warehouse_id, CURRENT_TIMESTAMP);

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;
