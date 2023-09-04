SELECT acct.name
,b.*
,DATEPART(YEAR, b.DATE) Year
,DATEPART(Month, b.DATE) month
,SUM(ISNULL(b.MRRChange, 0)) OVER(PARTITION BY business_id ORDER BY b.date) AS TrendTotal
, acct.type
FROM 
(SELECT a.*,
CASE WHEN a.ProductType = 'Wa_maintain' THEN P.maintain_price_per_unit
WHEN a.ProductType = 'Wa_inspect' THEN  P.unit_price_per_vehicle
WHEN a.ProductType = 'Wa_wallet' THEN  P.wallet_price_per_unit
WHEN a.ProductType = 'Maintain_Lite' THEN p.maintain_lite_price_per_unit
WHEN a.ProductType = 'wa_inspect.lite' THEN p.inspect_lite_price_per_unit
END AS Price,
CASE WHEN a.ProductType = 'Wa_maintain' THEN a.UpOrDownQty * P.maintain_price_per_unit
WHEN a.ProductType = 'Wa_inspect' THEN a.UpOrDownQty * P.unit_price_per_vehicle
WHEN a.ProductType = 'Wa_wallet' THEN a.UpOrDownQty * P.wallet_price_per_unit
WHEN a.ProductType = 'Maintain_Lite' THEN a.UpOrDownQty *  p.maintain_lite_price_per_unit
WHEN a.ProductType = 'wa_inspect.lite' THEN a.UpOrDownQty *  p.inspect_lite_price_per_unit
END AS MRRChange
FROM

(SELECT DISTINCT
c.date
	,vba.id
   ,c.business_id
   ,vba.description
   , CASE WHEN vba.description IS NULL THEN NULL ELSE CASE WHEN vba.description LIKE '%added%' OR vba.description LIKE '%new%' THEN 'Expansion' ELSE 'Contraction' END END  AS ExpOrCont
   , CASE WHEN vba.description IS NULL THEN NULL ELSE  CASE WHEN CASE WHEN vba.description LIKE '%added%' OR vba.description LIKE '%new%' THEN 'Expansion' ELSE 'Contraction' END = 'Contraction' THEN (vba.adjusted_vehicles * -1) ELSE vba.adjusted_vehicles END END  AS UpOrDownQty
   , CASE WHEN vba.description IS NULL THEN NULL ELSE  CASE WHEN vba.description LIKE '%Maintain%' AND vba.description LIKE '%lite%' Then 'Maintain_Lite'
   WHEN vba.description LIKE '%Inspect%' AND vba.description LIKE '%lite%' Then 'wa_inspect.lite'
   WHEN vba.description LIKE '%Maintain%' AND vba.description NOT LIKE '%lite%' Then 'wa_maintain'
   WHEN vba.description LIKE '%Inspect%' AND vba.description NOT LIKE '%lite%' Then 'wa_inspect'
   When (vba.description LIKE '%new vehicle%' OR vba.description LIKE '%Removed%vehicle%') AND vba.description NOT LIKE '%lite%' AND vba.description NOT LIKE '%Maintain%' Then 'wa_inspect'
   WHEN vba.description LIKE '%wallet%' THEN 'wa_wallet'
   ELSE 'Other'  END END AS ProductType
   ,vba.adjusted_vehicles
   ,vba.created_at
   ,vb.salesforce_account_id

FROM 
(SELECT c.DATE, vb1.id AS business_id FROM LocalWAProd.dbo.calendar c 
INNER JOIN LocalWAProd.dbo.v2_businesses vb1 ON 1=1) AS c
LEFT OUTER JOIN LocalWAProd.dbo.v2_billing_audits vba ON c.Date = CAST(vba.created_at AS DATE) AND c.business_id = vba.business_id
LEFT OUTER JOIN  LocalWAProd.dbo.v2_businesses vb
	ON c.business_id = vb.id
 ) AS a 
 INNER JOIN localwaprod.dbo.GetProdcutCostAndAmount AS p ON a.business_id = P.id



) AS b
LEFT OUTER JOIN Salesforce.dbo.account AS acct ON b.salesforce_account_id = acct.id
WHERE b.business_id = 13351
 AND b.date >= '2021-10-01' AND b.date <= getdate()
ORDER BY business_id
,  b.Date