SET SERVEROUTPUT ON;

BEGIN
    DBMS_OUTPUT.PUT_LINE('===============================================');
    DBMS_OUTPUT.PUT_LINE('            TRIGGER TESTING SUITE');
    DBMS_OUTPUT.PUT_LINE('===============================================');
    DBMS_OUTPUT.PUT_LINE('');

    DBMS_OUTPUT.PUT_LINE('--- Cleaning previous test data ---');
    DELETE FROM visit_procedure_medicine 
    WHERE visit_procedure_ID IN (
        SELECT vp.visit_procedure_ID 
        FROM visit_procedure vp 
        JOIN visit v ON vp.visit_ID = v.visit_ID 
        WHERE v.visit_ID > 10
    );

    DELETE FROM visit_procedure 
    WHERE visit_ID IN (SELECT visit_ID FROM visit WHERE visit_ID > 10);

    DELETE FROM visit WHERE visit_ID > 10;
    DELETE FROM animal WHERE name LIKE 'Test%';

    UPDATE animal SET is_sterilized = 0 WHERE name IN ('Puszek', 'Bella', 'Czarek', 'Leo');
    UPDATE medicine_batch SET stock_quantity = 100 WHERE medicine_batch_ID = 1;
    UPDATE medicine_batch SET stock_quantity = 50 WHERE medicine_batch_ID = 3;
    UPDATE medicine_batch SET stock_quantity = 0 WHERE medicine_batch_ID = 8;
    UPDATE medicine_batch SET stock_quantity = 30 WHERE medicine_batch_ID = 5;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Previous test data cleaned');
    DBMS_OUTPUT.PUT_LINE('');

    DBMS_OUTPUT.PUT_LINE('===============================================');
    DBMS_OUTPUT.PUT_LINE('     TESTING: check_sterilization_age');
    DBMS_OUTPUT.PUT_LINE('===============================================');
    DBMS_OUTPUT.PUT_LINE('');

    DBMS_OUTPUT.PUT_LINE('--- Initial Animal States ---');
    FOR rec IN (
        SELECT animal_ID, name, species,
               FLOOR(MONTHS_BETWEEN(SYSDATE, birth_date)) AS age_months,
               is_sterilized
        FROM animal
        WHERE name IN ('Puszek', 'Bella', 'Czarek', 'Leo')
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('ID: ' || rec.animal_ID || ', Name: ' || rec.name || ', Species: ' || rec.species || ', Age: ' || rec.age_months || ' months, Sterilized: ' || rec.is_sterilized);
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('');

    DBMS_OUTPUT.PUT_LINE('--- Test 1: Sterilize old animal (Czarek - 104+ months) ---');
    BEGIN
        UPDATE animal SET is_sterilized = 1 WHERE name = 'Czarek';
        DBMS_OUTPUT.PUT_LINE('SUCCESS: Old animal sterilization allowed');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('ERROR: ' || SQLERRM);
    END;
    DBMS_OUTPUT.PUT_LINE('');

    DBMS_OUTPUT.PUT_LINE('--- Test 2: Sterilize young animal (under 6 months) ---');
    BEGIN
        INSERT INTO animal (animal_ID, owner_ID, name, species, breed, birth_date, gender, is_sterilized) 
        VALUES (seq_animal.NEXTVAL, 1, 'TestMlody', 'Cat', 'Persian', ADD_MONTHS(SYSDATE, -3), 'M', 0);
        COMMIT;
        
        UPDATE animal SET is_sterilized = 1 WHERE name = 'TestMlody';
        DBMS_OUTPUT.PUT_LINE('ERROR: Young animal sterilization should have failed!');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('SUCCESS: Young animal sterilization correctly prevented');
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
            ROLLBACK;
    END;
    DBMS_OUTPUT.PUT_LINE('');

    DBMS_OUTPUT.PUT_LINE('--- Test 3: Sterilize multiple animals (Puszek and Leo) ---');
    BEGIN
        UPDATE animal SET is_sterilized = 1 WHERE name IN ('Puszek', 'Leo');
        DBMS_OUTPUT.PUT_LINE('SUCCESS: Multiple animal sterilization completed');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('ERROR: ' || SQLERRM);
    END;
    DBMS_OUTPUT.PUT_LINE('');

    DBMS_OUTPUT.PUT_LINE('--- Final Animal States ---');
    FOR rec IN (
        SELECT animal_ID, name,
               FLOOR(MONTHS_BETWEEN(SYSDATE, birth_date)) AS age_months,
               is_sterilized
        FROM animal
        WHERE name IN ('Puszek', 'Bella', 'Czarek', 'Leo', 'TestMlody')
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('ID: ' || rec.animal_ID || ', Name: ' || rec.name || ', Age: ' || rec.age_months || ' months, Sterilized: ' || rec.is_sterilized);
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('');

    DBMS_OUTPUT.PUT_LINE('===============================================');
    DBMS_OUTPUT.PUT_LINE('   TESTING: auto_decrease_medicine_stock');
    DBMS_OUTPUT.PUT_LINE('===============================================');
    DBMS_OUTPUT.PUT_LINE('');

    DBMS_OUTPUT.PUT_LINE('--- Initial Medicine Stock ---');
    FOR rec IN (
        SELECT mb.medicine_batch_ID as BatchID,
               m.name as Medicine,
               mb.stock_quantity as Stock,
               mb.expiry_date
        FROM medicine_batch mb
        JOIN medicine m ON mb.medicine_ID = m.medicine_ID
        WHERE mb.medicine_batch_ID IN (1, 3, 8, 5)
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('BatchID: ' || rec.BatchID || ', Medicine: ' || rec.Medicine || ', Stock: ' || rec.Stock || ', Expiry: ' || TO_CHAR(rec.expiry_date, 'YYYY-MM-DD'));
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('');

    DBMS_OUTPUT.PUT_LINE('--- Creating test visit and procedure ---');
    DECLARE
        v_test_visit_ID NUMBER;
        v_test_visit_procedure_ID NUMBER;
    BEGIN
        INSERT INTO visit (visit_ID, animal_ID, doctor_ID, visit_date, visit_time)
        VALUES (seq_visit.NEXTVAL, 1, 1, SYSDATE, SYSTIMESTAMP)
        RETURNING visit_ID INTO v_test_visit_ID;

        INSERT INTO visit_procedure (visit_procedure_ID, visit_ID, procedure_ID)
        VALUES (seq_visit_procedure.NEXTVAL, v_test_visit_ID, 1)
        RETURNING visit_procedure_ID INTO v_test_visit_procedure_ID;
        
        DBMS_OUTPUT.PUT_LINE('Test visit and procedure created');
        DBMS_OUTPUT.PUT_LINE('');

        DBMS_OUTPUT.PUT_LINE('--- Test 1: Add available medicine (Batch 1, stock=100) ---');
        BEGIN
            INSERT INTO visit_procedure_medicine (visit_procedure_medicine_ID, visit_procedure_ID, medicine_batch_ID)
            VALUES (seq_visit_procedure_medicine.NEXTVAL, v_test_visit_procedure_ID, 1);
            DBMS_OUTPUT.PUT_LINE('SUCCESS: Medicine added, stock should decrease by 1');
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('ERROR: ' || SQLERRM);
        END;
        DBMS_OUTPUT.PUT_LINE('');

        DBMS_OUTPUT.PUT_LINE('--- Test 2: Add another available medicine (Batch 3, stock=50) ---');
        BEGIN
            INSERT INTO visit_procedure_medicine (visit_procedure_medicine_ID, visit_procedure_ID, medicine_batch_ID)
            VALUES (seq_visit_procedure_medicine.NEXTVAL, v_test_visit_procedure_ID, 3);
            DBMS_OUTPUT.PUT_LINE('SUCCESS: Medicine added, stock should decrease by 1');
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('ERROR: ' || SQLERRM);
        END;
        DBMS_OUTPUT.PUT_LINE('');

        DBMS_OUTPUT.PUT_LINE('--- Test 3: Add unavailable medicine (Batch 8, stock=0) ---');
        BEGIN
            INSERT INTO visit_procedure_medicine (visit_procedure_medicine_ID, visit_procedure_ID, medicine_batch_ID)
            VALUES (seq_visit_procedure_medicine.NEXTVAL, v_test_visit_procedure_ID, 8);
            DBMS_OUTPUT.PUT_LINE('ERROR: Unavailable medicine insertion should have failed!');
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('SUCCESS: Unavailable medicine correctly prevented');
                DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        END;
        DBMS_OUTPUT.PUT_LINE('');

        DBMS_OUTPUT.PUT_LINE('--- Test 4: Add multiple medicines simultaneously ---');
        DECLARE
            v_test_visit_ID2 NUMBER;
            v_test_visit_procedure_ID2 NUMBER;
        BEGIN
            INSERT INTO visit (visit_ID, animal_ID, doctor_ID, visit_date, visit_time)
            VALUES (seq_visit.NEXTVAL, 3, 2, SYSDATE, SYSTIMESTAMP)
            RETURNING visit_ID INTO v_test_visit_ID2;

            INSERT INTO visit_procedure (visit_procedure_ID, visit_ID, procedure_ID)
            VALUES (seq_visit_procedure.NEXTVAL, v_test_visit_ID2, 2)
            RETURNING visit_procedure_ID INTO v_test_visit_procedure_ID2;

            INSERT INTO visit_procedure_medicine (visit_procedure_medicine_ID, visit_procedure_ID, medicine_batch_ID)
            VALUES (seq_visit_procedure_medicine.NEXTVAL, v_test_visit_procedure_ID2, 1);
            
            INSERT INTO visit_procedure_medicine (visit_procedure_medicine_ID, visit_procedure_ID, medicine_batch_ID)
            VALUES (seq_visit_procedure_medicine.NEXTVAL, v_test_visit_procedure_ID2, 3);
            
            DBMS_OUTPUT.PUT_LINE('SUCCESS: Multiple medicines added simultaneously');
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('ERROR: ' || SQLERRM);
        END;
        DBMS_OUTPUT.PUT_LINE('');

    END;

    DBMS_OUTPUT.PUT_LINE('--- Final Medicine Stock ---');
    FOR rec IN (
        SELECT mb.medicine_batch_ID as BatchID,
               m.name as Medicine,
               mb.stock_quantity as Stock,
               mb.expiry_date
        FROM medicine_batch mb
        JOIN medicine m ON mb.medicine_ID = m.medicine_ID
        WHERE mb.medicine_batch_ID IN (1, 3, 8, 5)
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('BatchID: ' || rec.BatchID || ', Medicine: ' || rec.Medicine || ', Stock: ' || rec.Stock || ', Expiry: ' || TO_CHAR(rec.expiry_date, 'YYYY-MM-DD'));
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('');

    DBMS_OUTPUT.PUT_LINE('--- Cleaning test data ---');
    DELETE FROM visit_procedure_medicine 
    WHERE visit_procedure_ID IN (
        SELECT vp.visit_procedure_ID 
        FROM visit_procedure vp 
        JOIN visit v ON vp.visit_ID = v.visit_ID 
        WHERE v.visit_ID > 10
    );

    DELETE FROM visit_procedure 
    WHERE visit_ID IN (SELECT visit_ID FROM visit WHERE visit_ID > 10);

    DELETE FROM visit WHERE visit_ID > 10;
    DELETE FROM animal WHERE name LIKE 'Test%';

    UPDATE animal SET is_sterilized = 0 WHERE name IN ('Puszek', 'Bella', 'Czarek', 'Leo');
    UPDATE medicine_batch SET stock_quantity = 100 WHERE medicine_batch_ID = 1;
    UPDATE medicine_batch SET stock_quantity = 50 WHERE medicine_batch_ID = 3;
    UPDATE medicine_batch SET stock_quantity = 0 WHERE medicine_batch_ID = 8;
    UPDATE medicine_batch SET stock_quantity = 30 WHERE medicine_batch_ID = 5;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Test data cleaned and reset to original state');
    DBMS_OUTPUT.PUT_LINE('');

    DBMS_OUTPUT.PUT_LINE('===============================================');
    DBMS_OUTPUT.PUT_LINE('         TRIGGER TESTING COMPLETED');
    DBMS_OUTPUT.PUT_LINE('===============================================');
END;