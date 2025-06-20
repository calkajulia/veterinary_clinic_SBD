USE [2019SBD];
SET NOCOUNT ON;

PRINT '===============================================';
PRINT '           PROCEDURE TESTING SUITE';
PRINT '===============================================';
PRINT '';

PRINT '--- Cleaning previous test data ---';
DELETE FROM animal WHERE name IN ('Azor', 'Mruczek', 'Starszy', 'Za mlody', 'Z przyszlosci', 'Nieprawidlowy', 'Bezdomny', 'Test NULL');
UPDATE medicine_batch SET stock_quantity = 100 WHERE medicine_batch_ID = 1;
UPDATE medicine_batch SET stock_quantity = 200 WHERE medicine_batch_ID = 2;
UPDATE medicine_batch SET stock_quantity = 30 WHERE medicine_batch_ID = 5;
PRINT 'Previous test data cleaned';
PRINT '';

PRINT '===============================================';
PRINT '      TESTING: update_medicine_stock';
PRINT '===============================================';
PRINT '';

PRINT '--- Initial Medicine Stock (see Table 1 in Results) ---';
SELECT
    mb.medicine_batch_ID as BatchID,
    m.name as Medicine,
    mb.stock_quantity as Stock
FROM medicine_batch mb
         JOIN medicine m ON mb.medicine_ID = m.medicine_ID
WHERE mb.medicine_batch_ID IN (1, 2, 5);
PRINT '';

PRINT '--- Test 1: Valid stock reduction (Batch 1, reduce by 10) ---';
EXEC update_medicine_stock 1, 10;
PRINT '';

PRINT '--- Test 2: Insufficient stock (Batch 2, reduce by 250) ---';
EXEC update_medicine_stock 2, 250;
PRINT '';

PRINT '--- Test 3: Invalid parameters (NULL batch) ---';
EXEC update_medicine_stock NULL, 10;
PRINT '';

PRINT '--- Test 4: Non-existent batch (ID 999) ---';
EXEC update_medicine_stock 999, 5;
PRINT '';

PRINT '--- Final Medicine Stock (see Table 2 in Results) ---';
SELECT
    mb.medicine_batch_ID as BatchID,
    m.name as Medicine,
    mb.stock_quantity as Stock
FROM medicine_batch mb
         JOIN medicine m ON mb.medicine_ID = m.medicine_ID
WHERE mb.medicine_batch_ID IN (1, 2, 5);
PRINT '';

PRINT '===============================================';
PRINT '      TESTING: register_new_animal';
PRINT '===============================================';
PRINT '';

PRINT '--- Available Owners (see Table 3 in Results) ---';
SELECT owner_ID, first_name, last_name FROM owner WHERE owner_ID IN (1, 2, 3);
PRINT '';

PRINT '--- Test 1: Valid animal registration ---';
EXEC register_new_animal 1, 'Azor', 'Dog', 'German Shepherd', '2022-05-15', 'M', 0;
PRINT '';

PRINT '--- Test 2: Animal with default breed (NULL) ---';
EXEC register_new_animal 2, 'Mruczek', 'Cat', NULL, '2023-01-10', 'F';
PRINT '';

PRINT '--- Test 3: Invalid gender (X) ---';
EXEC register_new_animal 1, 'Nieprawidlowy', 'Dog', 'Labrador', '2023-01-01', 'X', 0;
PRINT '';

PRINT '--- Test 4: Non-existent owner (ID 999) ---';
EXEC register_new_animal 999, 'Bezdomny', 'Cat', 'Persian', '2023-01-01', 'F', 0;
PRINT '';

PRINT '--- Test 5: Young animal marked as sterilized ---';
DECLARE @young_date DATE = DATEADD(MONTH, -3, GETDATE());
EXEC register_new_animal 1, 'Za mlody', 'Cat', 'Siamese', @young_date, 'M', 1;
PRINT '';

PRINT '--- Test 6: Future birth date ---';
DECLARE @future_date DATE = DATEADD(MONTH, 6, GETDATE());
EXEC register_new_animal 1, 'Z przyszlosci', 'Dog', 'Bulldog', @future_date, 'F', 0;
PRINT '';

PRINT '--- Test 7: NULL parameters ---';
EXEC register_new_animal NULL, 'Test NULL', 'Dog', 'Beagle', '2023-01-01', 'M', 0;
PRINT '';

PRINT '--- Recently Added Animals (see Table 4 in Results) ---';
SELECT TOP 5 animal_ID, name, species, gender, is_sterilized
FROM animal
ORDER BY animal_ID DESC;
PRINT '';

PRINT '--- Cleaning test data ---';
DELETE FROM animal WHERE name IN ('Azor', 'Mruczek', 'Starszy', 'Za mlody', 'Z przyszlosci', 'Nieprawidlowy', 'Bezdomny', 'Test NULL');
UPDATE medicine_batch SET stock_quantity = 100 WHERE medicine_batch_ID = 1;
UPDATE medicine_batch SET stock_quantity = 200 WHERE medicine_batch_ID = 2;
UPDATE medicine_batch SET stock_quantity = 30 WHERE medicine_batch_ID = 5;
PRINT 'Test data cleaned';
PRINT '';

PRINT '===============================================';
PRINT '        PROCEDURE TESTING COMPLETED';
PRINT '===============================================';