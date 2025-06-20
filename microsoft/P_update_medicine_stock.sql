USE [2019SBD];
GO 
DROP PROCEDURE IF EXISTS update_medicine_stock;
GO
CREATE PROCEDURE update_medicine_stock
	@medicine_batch_ID INT,
	@quantity_to_decrease INT
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @current_stock INT, @medicine_name NVARCHAR(100);

	BEGIN TRY
		IF @medicine_batch_ID IS NULL OR @quantity_to_decrease IS NULL OR @quantity_to_decrease <= 0
		BEGIN 
			RAISERROR('nieprawidlowe parametry procedury.', 16, 1);
		END;

		SELECT @current_stock = mb.stock_quantity, @medicine_name = m.name
		FROM medicine_batch mb
		JOIN medicine m ON mb.medicine_ID = m.medicine_ID
		WHERE mb.medicine_batch_ID = @medicine_batch_ID;

		IF @current_stock IS NULL
		BEGIN
			RAISERROR('brak partii leku o id: %d', 16, 1, @medicine_batch_ID);
		END;

		IF @current_stock < @quantity_to_decrease
		BEGIN 
			DECLARE @m NVARCHAR(255) = 'niewystarczajaca ilosc leku. dostepne: ' + CAST(@current_stock AS NVARCHAR(10));
			RAISERROR(@m, 16, 1);
		END;

		BEGIN TRANSACTION;
			UPDATE medicine_batch
			SET stock_quantity = stock_quantity - @quantity_to_decrease
			WHERE medicine_batch_ID = @medicine_batch_ID;
		COMMIT TRANSACTION;

		PRINT 'zaktualizowano lek: ' + @medicine_name;
		PRINT '		nowy stan: ' + CAST(@current_stock - @quantity_to_decrease AS NVARCHAR(10));
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