SELECT  CASE WHEN a.TC_Recurly_MRR__c < 120 THEN '1-Micro'
WHEN a.TC_Recurly_MRR__c < 250 THEN '2-Growth'
WHEN a.TC_Recurly_MRR__c < 425 THEN '3-SMB'
WHEN a.TC_Recurly_MRR__c < 1000 THEN '4-MM'
WHEN a.TC_Recurly_MRR__c >= 1000 THEN '5-Ent' ELSE 'other' END AS Segment 
, COUNT(id) AS Cnt
FROM Salesforce.dbo.Account a
WHERE type = 'Customer'
GROUP BY CASE WHEN a.TC_Recurly_MRR__c < 120 THEN '1-Micro'
WHEN a.TC_Recurly_MRR__c < 250 THEN '2-Growth'
WHEN a.TC_Recurly_MRR__c < 425 THEN '3-SMB'
WHEN a.TC_Recurly_MRR__c < 1000 THEN '4-MM'
WHEN a.TC_Recurly_MRR__c >= 1000 THEN '5-Ent' ELSE 'other' END;
SELECT  CASE WHEN a.TC_Recurly_MRR__c < 120 THEN '1-Micro'
WHEN a.TC_Recurly_MRR__c < 250 THEN '2-Growth'
WHEN a.TC_Recurly_MRR__c < 500 THEN '3-SMB'
WHEN a.TC_Recurly_MRR__c < 1000 THEN '4-MM'
WHEN a.TC_Recurly_MRR__c >= 1000 THEN '5-Ent' ELSE 'other' END AS Segment 
, COUNT(id) AS Cnt
FROM Salesforce.dbo.Account a
WHERE type = 'Customer'
GROUP BY CASE WHEN a.TC_Recurly_MRR__c < 120 THEN '1-Micro'
WHEN a.TC_Recurly_MRR__c < 250 THEN '2-Growth'
WHEN a.TC_Recurly_MRR__c < 500 THEN '3-SMB'
WHEN a.TC_Recurly_MRR__c < 1000 THEN '4-MM'
WHEN a.TC_Recurly_MRR__c >= 1000 THEN '5-Ent' ELSE 'other' END