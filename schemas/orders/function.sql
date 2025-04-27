CREATE OR REPLACE FUNCTION update_order_sum()
RETURNS TRIGGER AS $$
BEGIN
    -- Пересчет суммы заказа
    UPDATE orders
    SET sum = (
        SELECT COALESCE(SUM(quantity * price), 0)
        FROM order_items
        WHERE order_id = NEW.order_id
    )
    WHERE id = NEW.order_id;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;