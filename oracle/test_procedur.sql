-- Oracle Test Procedur

SET SERVEROUTPUT ON;

BEGIN
    DBMS_OUTPUT.PUT_LINE('===============================================');
    DBMS_OUTPUT.PUT_LINE('           PROCEDURE TESTING SUITE');
    DBMS_OUTPUT.PUT_LINE('===============================================');
    DBMS_OUTPUT.PUT_LINE('');

    DBMS_OUTPUT.PUT_LINE('--- Cleaning previous test data ---');
    DELETE FROM animal WHERE name IN ('Azor', 'Mruczek', 'Starszy', 'Za mlody', 'Z przyszlosci', 'Nieprawidlowy', 'Bezdomny', 'Test NULL');
    UPDATE medicine_batch SET stock_quantity = 100 WHERE medicine_batch_ID = 1;
    UPDATE medicine_batch SET stock_quantity = 200 WHERE medicine_batch_ID = 2;
    UPDATE medicine_batch SET stock_quantity = 30 WHERE medicine_batch_ID = 5;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Previous test data cleaned');
    DBMS_OUTPUT.PUT_LINE('');

    DBMS_OUTPUT.PUT_LINE('===============================================');
    DBMS_OUTPUT.PUT_LINE('      TESTING: update_medicine_stock');
    DBMS_OUTPUT.PUT_LINE('===============================================');
    DBMS_OUTPUT.PUT_LINE('');

    DBMS_OUTPUT.PUT_LINE('--- Initial Medicine Stock ---');
    FOR rec IN (
        SELECT mb.medicine_batch_ID as BatchID,
               m.name as Medicine,
               mb.stock_quantity as Stock
        FROM medicine_batch mb
        JOIN medicine m ON mb.medicine_ID = m.medicine_ID
        WHERE mb.medicine_batch_ID IN (1, 2, 5)
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('BatchID: ' || rec.BatchID || ', Medicine: ' || rec.Medicine || ', Stock: ' || rec.Stock);
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('');

    DBMS_OUTPUT.PUT_LINE('--- Test 1: Valid stock reduction (Batch 1, reduce by 10) ---');
    BEGIN
        update_medicine_stock(1, 10);
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    END;
    DBMS_OUTPUT.PUT_LINE('');

    DBMS_OUTPUT.PUT_LINE('--- Test 2: Insufficient stock (Batch 2, reduce by 250) ---');
    BEGIN
        update_medicine_stock(2, 250);
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    END;
    DBMS_OUTPUT.PUT_LINE('');

    DBMS_OUTPUT.PUT_LINE('--- Test 3: Invalid parameters (NULL batch) ---');
    BEGIN
        update_medicine_stock(NULL, 10);
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    END;
    DBMS_OUTPUT.PUT_LINE('');

    DBMS_OUTPUT.PUT_LINE('--- Test 4: Non-existent batch (ID 999) ---');
    BEGIN
        update_medicine_stock(999, 5);
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    END;
    DBMS_OUTPUT.PUT_LINE('');

    DBMS_OUTPUT.PUT_LINE('--- Final Medicine Stock ---');
    FOR rec IN (
        SELECT mb.medicine_batch_ID as BatchID,
               m.name as Medicine,
               mb.stock_quantity as Stock
        FROM medicine_batch mb
        JOIN medicine m ON mb.medicine_ID = m.medicine_ID
        WHERE mb.medicine_batch_ID IN (1, 2, 5)
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('BatchID: ' || rec.BatchID || ', Medicine: ' || rec.Medicine || ', Stock: ' || rec.Stock);
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('');

    DBMS_OUTPUT.PUT_LINE('===============================================');
    DBMS_OUTPUT.PUT_LINE('      TESTING: register_new_animal');
    DBMS_OUTPUT.PUT_LINE('===============================================');
    DBMS_OUTPUT.PUT_LINE('');

    DBMS_OUTPUT.PUT_LINE('--- Available Owners ---');
    FOR rec IN (SELECT owner_ID, first_name, last_name FROM owner WHERE owner_ID IN (1, 2, 3)) LOOP
        DBMS_OUTPUT.PUT_LINE('ID: ' || rec.owner_ID || ', Name: ' || rec.first_name || ' ' || rec.last_name);
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('');

    DBMS_OUTPUT.PUT_LINE('--- Test 1: Valid animal registration ---');
    BEGIN
        register_new_animal(1, 'Azor', 'Dog', 'German Shepherd', DATE '2022-05-15', 'M', 0);
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    END;
    DBMS_OUTPUT.PUT_LINE('');

    DBMS_OUTPUT.PUT_LINE('--- Test 2: Animal with default breed (NULL) ---');
    BEGIN
        register_new_animal(2, 'Mruczek', 'Cat', NULL, DATE '2023-01-10', 'F');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    END;
    DBMS_OUTPUT.PUT_LINE('');

    DBMS_OUTPUT.PUT_LINE('--- Test 3: Invalid gender (X) ---');
    BEGIN
        register_new_animal(1, 'Nieprawidlowy', 'Dog', 'Labrador', DATE '2023-01-01', 'X', 0);
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    END;
    DBMS_OUTPUT.PUT_LINE('');

    DBMS_OUTPUT.PUT_LINE('--- Test 4: Non-existent owner (ID 999) ---');
    BEGIN
        register_new_animal(999, 'Bezdomny', 'Cat', 'Persian', DATE '2023-01-01', 'F', 0);
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    END;
    DBMS_OUTPUT.PUT_LINE('');

    DBMS_OUTPUT.PUT_LINE('--- Test 5: Young animal marked as sterilized ---');
    DECLARE
        v_young_date DATE := ADD_MONTHS(SYSDATE, -3);
    BEGIN
        register_new_animal(1, 'Za mlody', 'Cat', 'Siamese', v_young_date, 'M', 1);
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    END;
    DBMS_OUTPUT.PUT_LINE('');

    DBMS_OUTPUT.PUT_LINE('--- Test 6: Future birth date ---');
    DECLARE
        v_future_date DATE := ADD_MONTHS(SYSDATE, 6);
    BEGIN
        register_new_animal(1, 'Z przyszlosci', 'Dog', 'Bulldog', v_future_date, 'F', 0);
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    END;
    DBMS_OUTPUT.PUT_LINE('');

    DBMS_OUTPUT.PUT_LINE('--- Test 7: NULL parameters ---');
    BEGIN
        register_new_animal(NULL, 'Test NULL', 'Dog', 'Beagle', DATE '2023-01-01', 'M', 0);
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    END;
    DBMS_OUTPUT.PUT_LINE('');

    DBMS_OUTPUT.PUT_LINE('--- Recently Added Animals ---');
    FOR rec IN (
        SELECT animal_ID, name, species, gender, is_sterilized
        FROM (SELECT animal_ID, name, species, gender, is_sterilized
              FROM animal
              ORDER BY animal_ID DESC)
        WHERE ROWNUM <= 5
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('ID: ' || rec.animal_ID || ', Name: ' || rec.name || ', Species: ' || rec.species || ', Gender: ' || rec.gender || ', Sterilized: ' || rec.is_sterilized);
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('');

    DBMS_OUTPUT.PUT_LINE('--- Cleaning test data ---');
    DELETE FROM animal WHERE name IN ('Azor', 'Mruczek', 'Starszy', 'Za mlody', 'Z przyszlosci', 'Nieprawidlowy', 'Bezdomny', 'Test NULL');
    UPDATE medicine_batch SET stock_quantity = 100 WHERE medicine_batch_ID = 1;
    UPDATE medicine_batch SET stock_quantity = 200 WHERE medicine_batch_ID = 2;
    UPDATE medicine_batch SET stock_quantity = 30 WHERE medicine_batch_ID = 5;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Test data cleaned');
    DBMS_OUTPUT.PUT_LINE('');

    DBMS_OUTPUT.PUT_LINE('===============================================');
    DBMS_OUTPUT.PUT_LINE('        PROCEDURE TESTING COMPLETED');
    DBMS_OUTPUT.PUT_LINE('===============================================');
END;
/