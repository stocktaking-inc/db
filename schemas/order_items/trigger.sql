CREATE TRIGGER trigger_update_inventory_on_order
    AFTER INSERT
    ON order_items
    FOR EACH ROW
    EXECUTE FUNCTION update_inventory_on_order();
