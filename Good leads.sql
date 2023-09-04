SELECT
CASE WHEN u.name IS NOT NULL THEN U.name ELSE g.name end AS NAME ,
L.Id,
L.LastName,
L.FirstName,
L.Title,
L.Company,
l.Email, 
l.Website,
l.Status,
l.Industry,
l.IsConverted,
l.ConvertedDate,
l.ConvertedAccountId,
l.ConvertedContactId,
l.ConvertedOpportunityId,
l.LastModifiedDate,
l.LastTransferDate,	
l.pi__campaign__c,
l.Lead_Origin__c,
l.Phone,
l.Country,
l.MobilePhone, 
l.DoNotCall, 
l.Closed_Reason__c, 
l.Lead_Source_Date__c, 
l.Total_Fleet_Size__c, 
l.Lead_Origin__c, 
l.DVIR_Solution__c, 
l.National_Acct__c, 
l.Toms_Meta_Data_Field__c, 
l.Last_Touch__c, 
l.Lead_Owner__c, 
l.Last_Email_Clicked__c, 
l.Last_Inspection_Date__c, 
l.Email_Check__c, 
l.Last_Touchpoint__c, 
l.Call_Ct__c, 
l.Truly_Last_Call__c, 
l.List__c, 
l.fleetSize__c
--COUNT(l.id) AS cnt


--COUNT(L.id) AS cnt
FROM Lead l
LEFT OUTER JOIN Salesforce.dbo.[User]  AS u ON l.OwnerId = u.id
LEFT OUTER JOIN Salesforce.[dbo].[group] AS g ON l.OwnerId = g.id
WHERE l.firstname IS NOT NULL 
AND l.lastname  is NOT NULL 
AND company != '[not provided]'
AND l.Company IS NOT NULL 
AND l.Closed_Reason__c IS NULL 
--AND l.IsConverted 
-- l.status
AND l.email IS NOT NULL 
AND l.phone IS NOT NULL 
AND (l.Total_Fleet_Size__c IS NOT NULL OR l.fleetsize__c IS NOT NULL)
AND l.IsDeleted = 0
--GROUP by CASE WHEN u.name IS NOT NULL THEN U.name ELSE g.name END,
--l.state
--order by COUNT(L.id) desc