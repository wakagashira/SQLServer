
SELECT
	a.AppID__c AS business_id
   ,a.Id AS sfid
   ,a.Name
   ,a.Contract_Status__c
   ,a.Churn_Risk__c
   ,a.Type
   ,b.TotalContacts
   ,c.Stratigic
   , c.Tactical
   ,c.Operational
FROM Salesforce.dbo.Account AS a
LEFT OUTER JOIN (SELECT
	COUNT(c.id) AS TotalContacts
	,c.AccountId
FROM Salesforce.dbo.Contact c
WHERE c.IsDeleted = 0
AND c.AccountId IS NOT NULL 
GROUP BY c.AccountId) AS b ON a.id = b.AccountId

LEFT OUTER JOIN (SELECT pivot_table.AccountId, pivot_table.Stratigic, pivot_table.Operational, pivot_table.Tactical FROM   
(
    SELECT
	c.id
	,c.AccountId
	,c.STO_Type__c
FROM Salesforce.dbo.Contact c
) t 
PIVOT(
    COUNT(id) 
    FOR STO_Type__c IN (
        [Stratigic], 
        [Operational], 
        [Tactical]
		)
) AS pivot_table) AS c ON a.id = c.accountid



WHERE a.AppID__c IS NOT NULL 
