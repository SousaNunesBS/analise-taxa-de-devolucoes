

/* Banco de Dados - ContosoRetailDW */

USE ContosoRetailDW;

/* Análise de Devolução por loja ON*/

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

	
/* Contoso Guangzhou Store é a loja com o menor percentual de devoluções (57%). Enquanto a  Contoso Toulouse Store é a lider de 
   devoluções com ( 122%). A diferença percentual é quase o dobro.

   Suposições:

   Será que o atendimento da loja está ruím?;
   Sera que o suporte não está acontecendo adequadamente?;
   Será que o canal de vendas está ruím?
   Será que o tempo de entrega está ruim?
   Será que o produto está com problema ?
*/


/* Análise de canal de vendas*/

SELECT 
        DS.StoreType,
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
        DS.StoreType,
        DS.STORETYPE
    HAVING 
        SUM(FS.RETURNQUANTITY) > 0
	ORDER BY (100.0 * SUM(FS.ReturnQuantity)) / SUM(FS.SalesQuantity);



