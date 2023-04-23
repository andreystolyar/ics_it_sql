SET QUOTED_IDENTIFIER ON;
DROP TRIGGER IF EXISTS dbo.TR_Basket_insert_update;
GO

CREATE TRIGGER dbo.TR_Basket_insert_update
ON dbo.Basket INSTEAD OF INSERT
AS
	INSERT INTO dbo.Basket
		("ID_SKU", "ID_Family", "Quantity", "Value", "PurchaseDate", "DiscountValue")
	SELECT "ID_SKU", "ID_Family", "Quantity", "Value", "PurchaseDate",
		CASE
			WHEN "ID_SKU" IN
				(
					SELECT "ID_SKU"
					FROM inserted
					GROUP BY "ID_SKU"
					HAVING COUNT(*) >= 2
				)
				THEN "Value" * 0.05
			ELSE 0
		END AS "DiscountValue"
	FROM inserted;
GO