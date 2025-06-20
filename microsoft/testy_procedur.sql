USE [2019SBD];
SET NOCOUNT OFF;

PRINT '=== czyszczenie po poprzednich testach ===';
DELETE FROM animal WHERE name IN ('Azor', 'Mruczek', 'Starszy', 'Za mlody', 'Z przyszlosci', 'Nieprawidlowy', 'Bezdomny', 'Test NULL');
UPDATE medicine_batch SET stock_quantity = 100 WHERE medicine_batch_ID = 1;
UPDATE medicine_batch SET stock_quantity = 200 WHERE medicine_batch_ID = 2;
UPDATE medicine_batch SET stock_quantity = 30 WHERE medicine_batch_ID = 5;
PRINT '=== czyszczenie zakonczone ===';
PRINT '';

PRINT '=== TESTY update_medicine_stock ===';
PRINT '';

PRINT 'stan poczatkowy magazynu lekow:';
SELECT 
    mb.medicine_batch_ID,
    m.name,
    mb.stock_quantity
FROM medicine_batch mb
JOIN medicine m ON mb.medicine_ID = m.medicine_ID
WHERE mb.medicine_batch_ID IN (1, 2, 5);
PRINT '';

PRINT 'test prawidlowego zmniejszenia stanu (partia 1, -10):';
EXEC update_medicine_stock 1, 10;
PRINT '';

PRINT 'test zmniejszenia o wiecej niz dostepne (partia 2, -250):';
EXEC update_medicine_stock 2, 250;
PRINT '';

PRINT 'test z parametrem null:';
EXEC update_medicine_stock NULL, 10;
PRINT '';

PRINT 'test z nieistniejaca partia (id 999):';
EXEC update_medicine_stock 999, 5;
PRINT '';

PRINT 'stan koncowy magazynu lekow:';
SELECT 
    mb.medicine_batch_ID,
    m.name,
    mb.stock_quantity
FROM medicine_batch mb
JOIN medicine m ON mb.medicine_ID = m.medicine_ID
WHERE mb.medicine_batch_ID IN (1, 2, 5);
PRINT '';

PRINT '=== TESTY register_new_animal ===';
PRINT '';

PRINT 'stan poczatkowy wlascicieli:';
SELECT owner_ID, first_name, last_name FROM owner WHERE owner_ID IN (1, 2, 3);
PRINT '';

PRINT 'test prawidlowego dodania zwierzecia:';
EXEC register_new_animal 1, 'Azor', 'Dog', 'German Shepherd', '2022-05-15', 'M', 0;
PRINT '';

PRINT 'test dodania z parametrami domyslnymi:';
EXEC register_new_animal 2, 'Mruczek', 'Cat', NULL, '2023-01-10', 'F';
PRINT '';

PRINT 'test nieprawidlowej plci (X):';
EXEC register_new_animal 1, 'Nieprawidlowy', 'Dog', 'Labrador', '2023-01-01', 'X', 0;
PRINT '';

PRINT 'test nieistniejacego wlasciciela (id 999):';
EXEC register_new_animal 999, 'Bezdomny', 'Cat', 'Persian', '2023-01-01', 'F', 0;
PRINT '';

PRINT 'test mlodego zwierzecia jako wysterylizowane:';
DECLARE @young_date DATE = DATEADD(MONTH, -3, GETDATE());
EXEC register_new_animal 1, 'Za mlody', 'Cat', 'Siamese', @young_date, 'M', 1;
PRINT '';

PRINT 'test przyszlej daty urodzenia:';
DECLARE @future_date DATE = DATEADD(MONTH, 6, GETDATE());
EXEC register_new_animal 1, 'Z przyszlosci', 'Dog', 'Bulldog', @future_date, 'F', 0;
PRINT '';

PRINT 'test z parametrem null:';
EXEC register_new_animal NULL, 'Test NULL', 'Dog', 'Beagle', '2023-01-01', 'M', 0;
PRINT '';

PRINT 'ostatnio dodane zwierzeta:';
SELECT TOP 5 animal_ID, name, species, gender, is_sterilized FROM animal ORDER BY animal_ID DESC;
PRINT '';

PRINT '=== koniec testow  procedur ===';
