CREATE TRIGGER trigger_add_to_inventory
  AFTER INSERT
  ON good
  FOR EACH ROW
EXECUTE FUNCTION add_to_inventory();
