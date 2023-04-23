SET QUOTED_IDENTIFIER ON;
DROP PROC IF EXISTS dbo.usp_MakeFamilyPurchase;
GO

CREATE PROC dbo.usp_MakeFamilyPurchase(@FamilySurName AS VARCHAR(255))
AS
	SET NOCOUNT ON;

	DECLARE @FamilyId AS INT =
		(SELECT "ID" FROM dbo.Family WHERE "SurName" = @FamilySurName);

	IF @FamilyId IS NULL
		RAISERROR(N'Семьи фамилией "%s" не найдено', 11, 1, @FamilySurName)
	ELSE
		BEGIN
			UPDATE dbo.Family
			SET "BudgetValue" -=
			(
				SELECT SUM("Value")
				FROM dbo.Basket
				WHERE "ID_Family" = @FamilyId
			)
			WHERE "ID" = @FamilyId
		END
GO
