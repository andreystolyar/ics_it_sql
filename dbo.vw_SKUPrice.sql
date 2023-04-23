SET QUOTED_IDENTIFIER ON;
DROP VIEW IF EXISTS dbo.vw_SKUPrice;
GO

CREATE VIEW dbo.vw_SKUPrice
AS
	SELECT "ID", "Code", "Name",
		dbo.udf_GetSKUPrice(ID) as "Price"
	FROM dbo.SKU;
GO
