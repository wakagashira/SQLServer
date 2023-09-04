SELECT distinct
	vba.id
   ,vba.business_id
   ,vba.description
   , CASE WHEN vba.description LIKE '%added%' OR vba.description LIKE '%new%' THEN 'Expansion' ELSE 'Contraction' END AS ExpOrCont
   , CASE WHEN CASE WHEN vba.description LIKE '%added%' OR vba.description LIKE '%new%' THEN 'Expansion' ELSE 'Contraction' END = 'Contraction' THEN (vba.adjusted_vehicles * -1) ELSE vba.adjusted_vehicles END AS UpOrDownQty
   , CASE WHEN vba.description LIKE '%Maintain%' AND vba.description LIKE '%lite%' Then 'MAINTAIN_Lite'
   WHEN vba.description LIKE '%Inspect%' AND vba.description LIKE '%lite%' Then 'wa_inspect.lite'
   WHEN vba.description LIKE '%Maintain%' AND vba.description NOT LIKE '%lite%' Then 'wa_maintain'
   WHEN vba.description LIKE '%Inspect%' AND vba.description NOT LIKE '%lite%' Then 'wa_inspect'
   When (vba.description LIKE '%new vehicle%' OR vba.description LIKE '%Removed%vehicle%') AND vba.description NOT LIKE '%lite%' AND vba.description NOT LIKE '%Maintain%' Then 'wa_inspect'
   WHEN vba.description LIKE '%wallet%' THEN 'wa_wallet'
   ELSE 'Other'  end AS ProductType
   ,vba.adjusted_vehicles
   ,vba.created_at
   ,vb.salesforce_account_id
   ,oli.ProductCode
--   , o.Id
--   , o.StageName
   ,oli.ListPrice
   ,oli.UnitPrice AS SalesPrice
   ,oli.unitprice * CASE WHEN CASE WHEN vba.description LIKE '%added%' OR vba.description LIKE '%new%' THEN 'Expansion' ELSE 'Contraction' END = 'Contraction' THEN (vba.adjusted_vehicles * -1) ELSE vba.adjusted_vehicles END AS MRRMovement
   ,SUM(oli.unitprice * CASE WHEN CASE WHEN vba.description LIKE '%added%' OR vba.description LIKE '%new%' THEN 'Expansion' ELSE 'Contraction' END = 'Contraction' THEN (vba.adjusted_vehicles * -1) ELSE vba.adjusted_vehicles END)  OVER(PARTITION BY business_id ORDER BY vba.id) AS TrendTotal
   , CASE WHEN 
FROM 
LocalWAProd.dbo.v2_billing_audits vba
INNER JOIN LocalWAProd.dbo.v2_businesses vb
	ON vba.business_id = vb.id
	LEFT OUTER JOIN LocalWAProd.dbo.GetProdcutCostAndAmount AS p ON vba.business_id = p.id
	LEFT OUTER JOIN (SELECT b.id, b.AccountId 
FROM 
(SELECT o.AccountId, MAX(o.CreatedDate) AS maxdate   
FROM Salesforce.dbo.Opportunity o 
WHERE stagename = 'Closed Won'
GROUP BY o.AccountId) AS a 
INNER JOIN Salesforce.dbo.Opportunity b ON a.AccountId = b.AccountId AND a.maxdate = b.CreatedDate
) o ON vb.salesforce_account_id = o.AccountId 
	LEFT OUTER JOIN Salesforce.dbo.OpportunityLineItem oli ON o.id = oli.OpportunityId AND CASE WHEN vba.description LIKE '%Maintain%' AND vba.description LIKE '%lite%' Then 'MAINTAIN_Lite'
   WHEN vba.description LIKE '%Inspect%' AND vba.description LIKE '%lite%' Then 'wa_inspect.lite'
   WHEN vba.description LIKE '%Maintain%' AND vba.description NOT LIKE '%lite%' Then 'wa_maintain'
   WHEN vba.description LIKE '%Inspect%' AND vba.description NOT LIKE '%lite%' Then 'wa_inspect'
   When vba.description LIKE '%new vehicle%' AND vba.description NOT LIKE '%lite%' AND vba.description NOT LIKE '%Maintain%' Then 'wa_inspect'
   ELSE 'Other' 
   END = oli.ProductCode
  -- WHERE productCode IS NOT NULL 
   

ORDER BY vba.business_id, vba.created_at;