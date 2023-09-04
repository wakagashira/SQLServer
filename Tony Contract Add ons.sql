SELECT
	a.id AS sfid
   ,a.name
   ,a.Contract_Status__c
   ,a.Under_Contract__c AS UnderContract
   ,a.Most_Current_Contract_Start__c
   ,a.Contract_Expiration_Date__c
   ,a.Days_Left_In_Contract__c
   ,a.Contract_Status__c
   ,a.Under_Contract__c
   ,a.TCCurrent_Contract_End_Date__c
   , a.Contract_Term__c

FROM Salesforce.dbo.Account AS a

WHERE type = 'customer'
AND a.Under_Contract__c = 1
--AND name LIKE '%jr.%'
--AND a.TCCurrent_Contract_End_Date__c IS NULL 