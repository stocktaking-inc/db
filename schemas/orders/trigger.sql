CREATE TRIGGER trigger_update_order_sum_on_insert
  AFTER INSERT
  ON order_items
  FOR EACH ROW
EXECUTE FUNCTION update_order_sum();

CREATE TRIGGER trigger_update_order_sum_on_update
  AFTER UPDATE
  ON order_items
  FOR EACH ROW
EXECUTE FUNCTION update_order_sum();

CREATE TRIGGER trigger_update_order_sum_on_delete
  AFTER DELETE
  ON order_items
  FOR EACH ROW
EXECUTE FUNCTION update_order_sum();
