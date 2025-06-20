USE [2019SBD];
GO
DROP PROCEDURE IF EXISTS register_new_animal;
GO
CREATE PROCEDURE register_new_animal
    @owner_ID INT,
    @name NVARCHAR(50),
    @species NVARCHAR(50),
    @breed NVARCHAR(50) = NULL,
    @birth_date DATE,
    @gender CHAR(1),
    @is_sterilized TINYINT = 0
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @owner_name NVARCHAR(101);
    DECLARE @animal_id INT, @age_in_months INT;
    
    BEGIN TRY
        IF @owner_ID IS NULL OR @name IS NULL OR @species IS NULL OR @birth_date IS NULL OR @gender IS NULL
        BEGIN
            RAISERROR('nieprawidlowe parametry procedury.', 16, 1);
        END;
        
        IF @gender NOT IN ('M', 'F')
        BEGIN 
            RAISERROR('bledna plec zwierzecia. dopuszczalne: M/F.', 16, 1);
        END;
        
        SELECT @owner_name = first_name + ' ' + last_name
        FROM owner
        WHERE owner_ID = @owner_ID;
        
        IF @owner_name IS NULL 
        BEGIN 
            RAISERROR('brak wlasciciela o id: %d', 16, 1, @owner_ID);
        END;
        
        SET @age_in_months = DATEDIFF(MONTH, @birth_date, GETDATE());
        IF @age_in_months < 0
        BEGIN
            RAISERROR('data urodzenia nie moze byc przyszla', 16, 1);
        END;
        
        IF @is_sterilized = 1 AND @age_in_months < 6
        BEGIN 
            RAISERROR('zwierze mlodsze niz 6 miesiecy nie moze byc wysterylizowane', 16, 1);
        END;
        
        IF EXISTS(
            SELECT 1 FROM animal
            WHERE owner_ID = @owner_ID
            AND name = @name
            AND species = @species
            AND birth_date = @birth_date)
        BEGIN
            RAISERROR('zwierze juz jest zarejestrowane', 16, 1);
        END;
        
        BEGIN TRANSACTION;
            INSERT INTO animal(owner_ID, name, species, breed, birth_date, gender, is_sterilized)
            VALUES (@owner_ID, @name, @species, @breed, @birth_date, @gender, @is_sterilized);
            SET @animal_id = SCOPE_IDENTITY();
        COMMIT TRANSACTION;
        
        PRINT 'pomyslnie zarejestrowano zwierze:';
        PRINT '		id: ' + CAST(@animal_id AS NVARCHAR(10));
        PRINT '		imie: ' + @name;
        PRINT '		gatunek: ' + @species;
        IF @breed IS NOT NULL
            PRINT '		rasa: ' + @breed;
        PRINT '		wiek: ' + CAST(@age_in_months AS NVARCHAR(10)) + ' miesiecy';
        PRINT '		plec: ' + @gender;
        PRINT '		sterylizacja: ' + CASE @is_sterilized WHEN 1 THEN 'Tak' ELSE 'Nie' END;
        PRINT '		wlasciciel: ' + @owner_name + ' (ID: ' + CAST(@owner_ID AS NVARCHAR(10)) + ')';
        
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        DECLARE @message NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @severity INT = ERROR_SEVERITY();
        DECLARE @state INT = ERROR_STATE();
        RAISERROR(@message, @severity, @state);
    END CATCH;
END;
GO