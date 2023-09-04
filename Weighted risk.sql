SELECT acc.Account__c, 
acc.TC_Total_Health_Score__c, 
CASE WHEN acc.TC_Total_Health_Score__c >= 8 THEN '0%- Totally Secure'
 WHEN ROUND(acc.TC_Total_Health_Score__c, -1) >= 6 THEN '25% - Unlikely To Churn'
 WHEN acc.TC_Total_Health_Score__c >= 4 THEN '50% - Likely To Churn'
 WHEN acc.TC_Total_Health_Score__c >= 2 THEN '75% - Highly Likely To Churn'
 WHEN acc.TC_Total_Health_Score__c < 2  THEN '90% - Expected Churn'
 WHEN acc.TC_Total_Health_Score__c IS NULL THEN NULL 
 ELSE NULL 
END AS WeightedRisk
FROM Salesforce.dbo.App_CDP__c acc
INNER JOIN Salesforce.dbo.Account a ON acc.Account__c = a.id
WHERE a.type = 'Customer'