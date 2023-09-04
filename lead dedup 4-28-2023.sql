SELECT b.id
FROM 
(SELECT COUNT(id) AS cnt
,FirstName
,LastName
,Email
FROM Salesforce.dbo.lead 
WHERE pi__url__c IS NOT NULL 
GROUP BY FirstName
,LastName
,Email

HAVING COUNT(id ) >1) AS a 
INNER JOIN (SELECT id
,FirstName
,LastName
,Email
FROM Salesforce.dbo.lead 
WHERE pi__url__c IS NOT NULL 
) AS b ON a.FirstName = b.FirstName
AND a.LastName = b.LastName
AND a.email = b.email 
LEFT OUTER JOIN [dbo].[TempKeepid] AS c ON b.id = c.KeepId
WHERE c.keepid IS NULL 

ORDER BY b.email