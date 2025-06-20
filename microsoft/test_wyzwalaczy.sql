USE [2019SBD];
SET NOCOUNT OFF;

PRINT '=== czyszczenie po poprzednich testach ===';
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
PRINT '=== czyszczenie zakonczone ===';
PRINT '';
GO

PRINT '=== TESTY check_sterilization_age ===';
PRINT '';

PRINT 'stan poczatkowy zwierzat (niewysterylizowanych):';
SELECT animal_ID, name, species, DATEDIFF(MONTH, birth_date, GETDATE()) AS wiek_w_miesiacach, is_sterilized 
FROM animal 
WHERE name IN ('Puszek', 'Bella', 'Czarek', 'Leo');
PRINT '';
GO

PRINT 'test sterylizacji starego zwierzecia Czarek (104+ miesiecy):';
UPDATE animal 
SET is_sterilized = 1 
WHERE name = 'Czarek';
PRINT 'sterylizacja starego zwierzecia zakonczona pomyslnie';
PRINT '';
GO

PRINT 'test sterylizacji mlodego zwierzecia:';
INSERT INTO animal (owner_ID, name, species, breed, birth_date, gender, is_sterilized) VALUES
(1, 'TestMlody', 'Cat', 'Persian', DATEADD(MONTH, -3, GETDATE()), 'M', 0);

UPDATE animal 
SET is_sterilized = 1 
WHERE name = 'TestMlody';
PRINT '';
GO

PRINT 'test sterylizacji wielu zwierzat jednoczesnie (Puszek i Leo):';
UPDATE animal 
SET is_sterilized = 1 
WHERE name IN ('Puszek', 'Leo');
PRINT 'sterylizacja wielu zwierzat zakonczona pomyslnie';
PRINT '';
GO

PRINT 'stan koncowy zwierzat:';
SELECT animal_ID, name, DATEDIFF(MONTH, birth_date, GETDATE()) AS wiek_w_miesiacach, is_sterilized 
FROM animal 
WHERE name IN ('Puszek', 'Bella', 'Czarek', 'Leo', 'TestMlody');
PRINT '';
GO

PRINT '=== TESTY auto_decrease_medicine_stock ===';
PRINT '';

PRINT 'stan poczatkowy magazynu lekow:';
SELECT 
    mb.medicine_batch_ID,
    m.name,
    mb.stock_quantity,
    mb.expiry_date
FROM medicine_batch mb
JOIN medicine m ON mb.medicine_ID = m.medicine_ID
WHERE mb.medicine_batch_ID IN (1, 3, 8, 5);
PRINT '';
GO

PRINT 'dodanie wizyty testowej (zwierze Burek):';
DECLARE @test_visit_ID INT;
INSERT INTO visit (animal_ID, doctor_ID, visit_date, visit_time) 
VALUES (1, 1, GETDATE(), GETDATE());
SET @test_visit_ID = SCOPE_IDENTITY();
PRINT 'dodano wizyte o id: ' + CAST(@test_visit_ID AS NVARCHAR(10));
PRINT '';

PRINT 'dodanie procedury do wizyty:';
DECLARE @test_visit_procedure_ID INT;
INSERT INTO visit_procedure (visit_ID, procedure_ID) 
VALUES (@test_visit_ID, 1);
SET @test_visit_procedure_ID = SCOPE_IDENTITY();
PRINT 'dodano procedure o id: ' + CAST(@test_visit_procedure_ID AS NVARCHAR(10));
PRINT '';

PRINT 'test dodania dostepnego leku (partia 1, stock=100):';
INSERT INTO visit_procedure_medicine (visit_procedure_ID, medicine_batch_ID) 
VALUES (@test_visit_procedure_ID, 1);
PRINT 'dodano lek - stan powinien sie zmniejszyc o 1';
PRINT '';

PRINT 'test dodania kolejnego dostepnego leku (partia 3, stock=50):';
INSERT INTO visit_procedure_medicine (visit_procedure_ID, medicine_batch_ID) 
VALUES (@test_visit_procedure_ID, 3);
PRINT 'dodano kolejny lek - stan powinien sie zmniejszyc o 1';
PRINT '';
GO

PRINT 'test dodania niedostepnego leku (partia 8, stock=0):';
DECLARE @test_visit_ID INT = (SELECT TOP 1 visit_ID FROM visit ORDER BY visit_ID DESC);
DECLARE @test_visit_procedure_ID INT = (SELECT TOP 1 visit_procedure_ID FROM visit_procedure ORDER BY visit_procedure_ID DESC);

INSERT INTO visit_procedure_medicine (visit_procedure_ID, medicine_batch_ID) 
VALUES (@test_visit_procedure_ID, 8);
PRINT '';
GO

PRINT 'test dodania wielu lekow jednoczesnie:';
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
PRINT 'dodano wiele lekow jednoczesnie';
PRINT '';
GO

PRINT 'stan koncowy magazynu lekow:';
SELECT 
    mb.medicine_batch_ID,
    m.name,
    mb.stock_quantity,
    mb.expiry_date
FROM medicine_batch mb
JOIN medicine m ON mb.medicine_ID = m.medicine_ID
WHERE mb.medicine_batch_ID IN (1, 3, 8, 5);
PRINT '';

PRINT '=== koniec testow wyzwalaczy ===';