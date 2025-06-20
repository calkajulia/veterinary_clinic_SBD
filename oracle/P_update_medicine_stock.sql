CREATE OR REPLACE PROCEDURE update_medicine_stock (
    p_medicine_batch_ID IN NUMBER,
    p_quantity_to_decrease IN NUMBER
)
IS
    v_current_stock NUMBER;
    v_medicine_name NVARCHAR2(100);
BEGIN
    IF p_medicine_batch_ID IS NULL OR p_quantity_to_decrease IS NULL OR p_quantity_to_decrease <= 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'nieprawidlowe parametry procedury.');
    END IF;

    BEGIN
        SELECT mb.stock_quantity, m.name
        INTO v_current_stock, v_medicine_name
        FROM medicine_batch mb
        JOIN medicine m ON mb.medicine_ID = m.medicine_ID
        WHERE mb.medicine_batch_ID = p_medicine_batch_ID;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20002, 'brak partii leku o id: ' || p_medicine_batch_ID);
    END;

    IF v_current_stock < p_quantity_to_decrease THEN
        RAISE_APPLICATION_ERROR(-20003, 'niewystarczajaca ilosc leku. dostepne: ' || v_current_stock);
    END IF;

    UPDATE medicine_batch
    SET stock_quantity = stock_quantity - p_quantity_to_decrease
    WHERE medicine_batch_ID = p_medicine_batch_ID;

    DBMS_OUTPUT.PUT_LINE('zaktualizowano lek: ' || v_medicine_name);
    DBMS_OUTPUT.PUT_LINE('		nowy stan: ' || (v_current_stock - p_quantity_to_decrease));
    
    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END update_medicine_stock;
