USE [2019SBD];
GO
DROP TRIGGER IF EXISTS auto_decrease_medicine_stock;
GO
CREATE TRIGGER auto_decrease_medicine_stock
ON visit_procedure_medicine
FOR INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @medicine_batch_id INT, @current_stock INT, @medicine_name NVARCHAR(100), @expiry_date DATE;
    
    DECLARE medicine_cursor CURSOR FOR
    SELECT medicine_batch_ID FROM inserted;
    
    OPEN medicine_cursor;
    FETCH NEXT FROM medicine_cursor INTO @medicine_batch_id;
    
    WHILE @@FETCH_STATUS = 0
    BEGIN
        SELECT @current_stock = mb.stock_quantity, @medicine_name = m.name, @expiry_date = mb.expiry_date
        FROM medicine_batch mb
        JOIN medicine m ON mb.medicine_ID = m.medicine_ID
        WHERE mb.medicine_batch_ID = @medicine_batch_id;
        
        IF @current_stock <= 0
        BEGIN
            CLOSE medicine_cursor;
            DEALLOCATE medicine_cursor;
            ROLLBACK TRANSACTION;
            RAISERROR('brak leku "%s" w magazynie', 16, 1, @medicine_name);
            RETURN;
        END;
        
        UPDATE medicine_batch 
        SET stock_quantity = stock_quantity - 1
        WHERE medicine_batch_ID = @medicine_batch_id;
        
        FETCH NEXT FROM medicine_cursor INTO @medicine_batch_id;
    END;
    
    CLOSE medicine_cursor;
    DEALLOCATE medicine_cursor;
END;
GO