SELECT 
CAST(vr.business_id AS NVARCHAR) + '-' + CAST(CAST(vr.created_at AS  DATE) AS NVARCHAR) AS TheKey,
vr.business_id ,
CAST(vr.created_at AS  DATE) AS TheDate,
COUNT(vr.id) AS CntOfInspections,
a.id AS sfid			
FROM LocalWAProd.dbo.v2_reports vr
LEFT OUTER JOIN LocalWAProd.dbo.v2_businesses vb ON vr.business_id = vb.id
LEFT OUTER JOIN Salesforce.dbo.account AS a ON vb.salesforce_account_id = a.id
WHERE vr.deleted_at IS NULL 
AND Datepart(YEAR, vr.created_at) >= 2022
AND a.id IS NOT NULL 
GROUP BY 
CAST(vr.business_id AS NVARCHAR) + '-' + CAST(CAST(vr.created_at AS  DATE) AS NVARCHAR),
vr.business_id,
CAST(vr.created_at AS  DATE),
a.id
ORDER BY vr.business_id