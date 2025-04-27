-- Функция для проверки низкого уровня запасов и отправки уведомлений
CREATE OR REPLACE FUNCTION check_low_inventory()
RETURNS VOID AS $$
DECLARE
    rec RECORD;
BEGIN
    FOR rec IN (
        SELECT ii.item_id, ii.quantity, ii.warehouse_id, i.name
        FROM inventory_items ii
        JOIN items i ON ii.item_id = i.id
        WHERE ii.quantity < 10 -- Пороговое значение, можно настроить
    ) LOOP
        -- Добавление уведомления в notifications
        INSERT INTO notifications (type, message, created_at)
        VALUES (
            'inventory_messages',
            FORMAT('Low inventory for item %s (ID: %s) at warehouse %s: only %s units left', 
                   rec.name, rec.item_id, rec.warehouse_id, rec.quantity),
            CURRENT_TIMESTAMP
        );
    END LOOP;
END;
$$ LANGUAGE plpgsql;

-- Функция для триггера проверки низкого уровня запасов
CREATE OR REPLACE FUNCTION trigger_check_low_inventory()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.quantity < 10 THEN
        PERFORM check_low_inventory();
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;