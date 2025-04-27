CREATE TRIGGER trigger_low_inventory_check
AFTER UPDATE ON inventory_items
FOR EACH ROW
EXECUTE FUNCTION trigger_check_low_inventory();