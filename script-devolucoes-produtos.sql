

/* Banco de Dados - ContosoRetailDW */

USE ContosoRetailDW;

/* An�lise de Devolu��o por loja ON*/

SELECT 
        DS.StoreName,
       -- DS.STORETYPE,
        SUM(FS.SALESQUANTITY) AS Total_Vendido,
        SUM(FS.RETURNQUANTITY) AS Total_Devolvido,
        FORMAT((100.0 * SUM(FS.ReturnQuantity)) / SUM(FS.SalesQuantity), '0.00%') AS Percentual_Devolvido
        --ROW_NUMBER() OVER (ORDER BY (100.0 * SUM(FS.ReturnQuantity)) / SUM(FS.SalesQuantity) DESC) AS Ranking
    FROM 
        FactSales AS FS
        INNER JOIN DimStore AS DS ON FS.StoreKey = DS.StoreKey 
        INNER JOIN DimProduct AS DP ON FS.ProductKey = DP.ProductKey
        INNER JOIN DimProductSubcategory AS DPS ON DP.ProductSubcategoryKey = DPS.ProductSubcategoryKey
        INNER JOIN DimProductCategory AS DPC ON DPS.ProductCategoryKey = DPC.ProductCategoryKey
        INNER JOIN DimPromotion AS DPP ON FS.PromotionKey = DPP.PromotionKey
    WHERE 
        DS.[STATUS] IN ('ON') 
    GROUP BY 
        DS.storename,
        DS.STORETYPE
    HAVING 
        SUM(FS.RETURNQUANTITY) > 0
	ORDER BY (100.0 * SUM(FS.ReturnQuantity)) / SUM(FS.SalesQuantity);


