CREATE OR REPLACE FUNCTION update_inventory_on_order()
  RETURNS TRIGGER AS
$$
DECLARE
  current_quantity INTEGER;
BEGIN
  -- Проверка текущего количества на складе
  SELECT quantity
  INTO current_quantity
  FROM inventory_items
  WHERE item_id = NEW.item_id
    AND warehouse_id = (SELECT warehouse_id
                        FROM good
                        WHERE id = (SELECT good_id
                                    FROM inventory_items
                                    WHERE item_id = NEW.item_id
                                    LIMIT 1))
  LIMIT 1;

  -- Если товара недостаточно, выбросить исключение
  IF current_quantity < NEW.quantity THEN
    RAISE EXCEPTION 'Not enough items in inventory for item_id %, required: %, available: %',
      NEW.item_id, NEW.quantity, current_quantity;
  END IF;

  -- Обновление количества в inventory_items
  UPDATE inventory_items
  SET quantity     = quantity - NEW.quantity,
      last_updated = CURRENT_TIMESTAMP
  WHERE item_id = NEW.item_id
    AND warehouse_id = (SELECT warehouse_id
                        FROM good
                        WHERE id = (SELECT good_id
                                    FROM inventory_items
                                    WHERE item_id = NEW.item_id
                                    LIMIT 1));

  -- Добавление записи в stock_transactions
  INSERT INTO stock_transactions (item_id, quantity, transaction_type, warehouse_id, transaction_date)
  VALUES (NEW.item_id, NEW.quantity, 'shipment', (SELECT warehouse_id
                                                  FROM good
                                                  WHERE id = (SELECT good_id
                                                              FROM inventory_items
                                                              WHERE item_id = NEW.item_id
                                                              LIMIT 1)), CURRENT_TIMESTAMP);

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;
