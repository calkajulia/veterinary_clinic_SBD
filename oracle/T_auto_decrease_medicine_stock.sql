CREATE OR REPLACE TRIGGER auto_decrease_medicine_stock
AFTER INSERT ON visit_procedure_medicine
FOR EACH ROW
DECLARE
    v_current_stock NUMBER;
    v_medicine_name NVARCHAR2(100);
    v_expiry_date DATE;
BEGIN
    SELECT mb.stock_quantity, m.name, mb.expiry_date
    INTO v_current_stock, v_medicine_name, v_expiry_date
    FROM medicine_batch mb
    JOIN medicine m ON mb.medicine_ID = m.medicine_ID
    WHERE mb.medicine_batch_ID = :NEW.medicine_batch_ID;
    
    IF v_current_stock <= 0 THEN
        RAISE_APPLICATION_ERROR(-20020, 'brak leku "' || v_medicine_name || '" w magazynie');
    END IF;
    
    UPDATE medicine_batch 
    SET stock_quantity = stock_quantity - 1
    WHERE medicine_batch_ID = :NEW.medicine_batch_ID;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20021, 'nie znaleziono partii leku o ID: ' || :NEW.medicine_batch_ID);
    WHEN OTHERS THEN
        RAISE;
END auto_decrease_medicine_stock;