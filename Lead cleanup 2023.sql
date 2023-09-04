SELECT
	Id
   ,FirstName
   ,LastName
   ,Company
   ,Email
   ,Phone
   ,ConvertedDate
   ,Last_Touchpoint__c
   ,Last_Touch__c
   ,CreatedDate
   , CASE WHEN Last_Touchpoint__c IS NULL  AND Last_Touch__c IS NULL THEN CreatedDate
   WHEN Last_Touchpoint__c IS NOT NULL AND (Last_Touch__c IS NULL OR  Last_Touchpoint__c >= Last_Touch__c) THEN Last_Touchpoint__c
   WHEN Last_touch__c IS NOT NULL AND (Last_Touchpoint__c IS NULL or Last_Touchpoint__c < Last_Touch__c) THEN Last_Touch__c END    
    AS LatestDate
FROM Salesforce.dbo.lead
WHERE ConvertedDate IS NULL
AND DATEPART(YEAR, CAST(CASE WHEN Last_Touchpoint__c IS NULL  AND Last_Touch__c IS NULL THEN CreatedDate
   WHEN Last_Touchpoint__c IS NOT NULL AND (Last_Touch__c IS NULL OR  Last_Touchpoint__c >= Last_Touch__c) THEN Last_Touchpoint__c
   WHEN Last_touch__c IS NOT NULL AND (Last_Touchpoint__c IS NULL or Last_Touchpoint__c < Last_Touch__c) THEN Last_Touch__c END AS DATE)) < 2022
; -- out of 410k records
--SELECT COUNT(id) FROM lead;

