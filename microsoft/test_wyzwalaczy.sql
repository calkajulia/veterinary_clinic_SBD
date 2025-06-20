USE [2019SBD];
SET NOCOUNT ON;

PRINT '===============================================';
PRINT '            TRIGGER TESTING SUITE';
PRINT '===============================================';
PRINT '';

PRINT '--- Cleaning previous test data ---';
DELETE vpm FROM visit_procedure_medicine vpm
JOIN visit_procedure vp ON vpm.visit_procedure_ID = vp.visit_procedure_ID
JOIN visit v ON vp.visit_ID = v.visit_ID
WHERE v.visit_ID > 10;

DELETE vp FROM visit_procedure vp
JOIN visit v ON vp.visit_ID = v.visit_ID
WHERE v.visit_ID > 10;

DELETE FROM visit WHERE visit_ID > 10;
DELETE FROM animal WHERE name LIKE 'Test%';
UPDATE animal SET is_sterilized = 0 WHERE name IN ('Puszek', 'Bella', 'Czarek', 'Leo');
UPDATE medicine_batch SET stock_quantity = 100 WHERE medicine_batch_ID = 1;
UPDATE medicine_batch SET stock_quantity = 50 WHERE medicine_batch_ID = 3;
UPDATE medicine_batch SET stock_quantity = 0 WHERE medicine_batch_ID = 8;
UPDATE medicine_batch SET stock_quantity = 30 WHERE medicine_batch_ID = 5;
PRINT 'Previous test data cleaned';
PRINT '';

PRINT '===============================================';
PRINT '     TESTING: check_sterilization_age';
PRINT '===============================================';
PRINT '';

PRINT '--- Initial Animal States (see Table 1 in Results) ---';
SELECT
    animal_ID,
    name,
    species,
    DATEDIFF(MONTH, birth_date, GETDATE()) AS age_months,
    is_sterilized
FROM animal
WHERE name IN ('Puszek', 'Bella', 'Czarek', 'Leo');
PRINT '';

PRINT '--- Test 1: Sterilize old animal (Czarek - 104+ months) ---';
UPDATE animal SET is_sterilized = 1 WHERE name = 'Czarek';
PRINT 'SUCCESS: Old animal sterilization allowed';
PRINT '';

PRINT '--- Test 2: Sterilize young animal (under 6 months) ---';
INSERT INTO animal (owner_ID, name, species, breed, birth_date, gender, is_sterilized) VALUES
    (1, 'TestMlody', 'Cat', 'Persian', DATEADD(MONTH, -3, GETDATE()), 'M', 0);

BEGIN TRY
UPDATE animal SET is_sterilized = 1 WHERE name = 'TestMlody';
PRINT 'ERROR: Young animal sterilization should have failed!';
END TRY
BEGIN CATCH
PRINT 'SUCCESS: Young animal sterilization correctly prevented';
    PRINT 'Error: ' + ERROR_MESSAGE();
END CATCH
PRINT '';

PRINT '--- Test 3: Sterilize multiple animals (Puszek and Leo) ---';
UPDATE animal SET is_sterilized = 1 WHERE name IN ('Puszek', 'Leo');
PRINT 'SUCCESS: Multiple animal sterilization completed';
PRINT '';

PRINT '--- Final Animal States (see Table 2 in Results) ---';
SELECT
    animal_ID,
    name,
    DATEDIFF(MONTH, birth_date, GETDATE()) AS age_months,
    is_sterilized
FROM animal
WHERE name IN ('Puszek', 'Bella', 'Czarek', 'Leo', 'TestMlody');
PRINT '';

PRINT '===============================================';
PRINT '   TESTING: auto_decrease_medicine_stock';
PRINT '===============================================';
PRINT '';

PRINT '--- Initial Medicine Stock (see Table 3 in Results) ---';
SELECT
    mb.medicine_batch_ID as BatchID,
    m.name as Medicine,
    mb.stock_quantity as Stock,
    mb.expiry_date
FROM medicine_batch mb
         JOIN medicine m ON mb.medicine_ID = m.medicine_ID
WHERE mb.medicine_batch_ID IN (1, 3, 8, 5);
PRINT '';

PRINT '--- Creating test visit and procedure ---';
DECLARE @test_visit_ID INT;
INSERT INTO visit (animal_ID, doctor_ID, visit_date, visit_time)
VALUES (1, 1, GETDATE(), GETDATE());
SET @test_visit_ID = SCOPE_IDENTITY();

DECLARE @test_visit_procedure_ID INT;
INSERT INTO visit_procedure (visit_ID, procedure_ID)
VALUES (@test_visit_ID, 1);
SET @test_visit_procedure_ID = SCOPE_IDENTITY();
PRINT 'Test visit and procedure created';
PRINT '';

PRINT '--- Test 1: Add available medicine (Batch 1, stock=100) ---';
INSERT INTO visit_procedure_medicine (visit_procedure_ID, medicine_batch_ID)
VALUES (@test_visit_procedure_ID, 1);
PRINT 'SUCCESS: Medicine added, stock should decrease by 1';
PRINT '';

PRINT '--- Test 2: Add another available medicine (Batch 3, stock=50) ---';
INSERT INTO visit_procedure_medicine (visit_procedure_ID, medicine_batch_ID)
VALUES (@test_visit_procedure_ID, 3);
PRINT 'SUCCESS: Medicine added, stock should decrease by 1';
PRINT '';

PRINT '--- Test 3: Add unavailable medicine (Batch 8, stock=0) ---';
BEGIN TRY
INSERT INTO visit_procedure_medicine (visit_procedure_ID, medicine_batch_ID)
    VALUES (@test_visit_procedure_ID, 8);
    PRINT 'ERROR: Unavailable medicine insertion should have failed!';
END TRY
BEGIN CATCH
PRINT 'SUCCESS: Unavailable medicine correctly prevented';
    PRINT 'Error: ' + ERROR_MESSAGE();
END CATCH
PRINT '';

PRINT '--- Test 4: Add multiple medicines simultaneously ---';
DECLARE @test_visit_ID2 INT, @test_visit_procedure_ID2 INT;
INSERT INTO visit (animal_ID, doctor_ID, visit_date, visit_time)
VALUES (3, 2, GETDATE(), GETDATE());
SET @test_visit_ID2 = SCOPE_IDENTITY();

INSERT INTO visit_procedure (visit_ID, procedure_ID)
VALUES (@test_visit_ID2, 2);
SET @test_visit_procedure_ID2 = SCOPE_IDENTITY();

INSERT INTO visit_procedure_medicine (visit_procedure_ID, medicine_batch_ID)
VALUES
    (@test_visit_procedure_ID2, 1),
    (@test_visit_procedure_ID2, 3);
PRINT 'SUCCESS: Multiple medicines added simultaneously';
PRINT '';

PRINT '--- Final Medicine Stock (see Table 4 in Results) ---';
SELECT
    mb.medicine_batch_ID as BatchID,
    m.name as Medicine,
    mb.stock_quantity as Stock,
    mb.expiry_date
FROM medicine_batch mb
         JOIN medicine m ON mb.medicine_ID = m.medicine_ID
WHERE mb.medicine_batch_ID IN (1, 3, 8, 5);
PRINT '';

PRINT '--- Cleaning test data ---';
DELETE vpm FROM visit_procedure_medicine vpm
JOIN visit_procedure vp ON vpm.visit_procedure_ID = vp.visit_procedure_ID
JOIN visit v ON vp.visit_ID = v.visit_ID
WHERE v.visit_ID > 10;

DELETE vp FROM visit_procedure vp
JOIN visit v ON vp.visit_ID = v.visit_ID
WHERE v.visit_ID > 10;

DELETE FROM visit WHERE visit_ID > 10;
DELETE FROM animal WHERE name LIKE 'Test%';
UPDATE animal SET is_sterilized = 0 WHERE name IN ('Puszek', 'Bella', 'Czarek', 'Leo');
UPDATE medicine_batch SET stock_quantity = 100 WHERE medicine_batch_ID = 1;
UPDATE medicine_batch SET stock_quantity = 50 WHERE medicine_batch_ID = 3;
UPDATE medicine_batch SET stock_quantity = 0 WHERE medicine_batch_ID = 8;
UPDATE medicine_batch SET stock_quantity = 30 WHERE medicine_batch_ID = 5;
PRINT 'Test data cleaned and reset to original state';
PRINT '';

PRINT '===============================================';
PRINT '         TRIGGER TESTING COMPLETED';
PRINT '===============================================';