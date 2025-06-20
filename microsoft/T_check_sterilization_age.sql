USE [2019SBD];
GO
DROP TRIGGER IF EXISTS check_sterilization_age;
GO
CREATE TRIGGER check_sterilization_age
ON animal
FOR UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    
    IF UPDATE(is_sterilized)
    BEGIN
        DECLARE @animal_ID INT, @birth_date DATE, @name NVARCHAR(50), @age_in_months INT;
        
        DECLARE sterilization_cursor CURSOR FOR
        SELECT i.animal_ID, i.birth_date, i.name
        FROM inserted i
        JOIN deleted d ON i.animal_ID = d.animal_ID
        WHERE i.is_sterilized = 1 AND d.is_sterilized = 0;
        
        OPEN sterilization_cursor;
        FETCH NEXT FROM sterilization_cursor INTO @animal_ID, @birth_date, @name;
        
        WHILE @@FETCH_STATUS = 0
        BEGIN
            SET @age_in_months = DATEDIFF(MONTH, @birth_date, GETDATE());
            
            IF @age_in_months < 6
            BEGIN
                CLOSE sterilization_cursor;
                DEALLOCATE sterilization_cursor;
                ROLLBACK TRANSACTION;
                RAISERROR('zwierze %s jest za mlode na sterylizacje (wiek: %d miesiecy)', 16, 1, @name, @age_in_months);
                RETURN;
            END;
            
            FETCH NEXT FROM sterilization_cursor INTO @animal_ID, @birth_date, @name;
        END;
        
        CLOSE sterilization_cursor;
        DEALLOCATE sterilization_cursor;
    END;
END;
GO