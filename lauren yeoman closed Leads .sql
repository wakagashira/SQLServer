select status, * from Salesforce.dbo.lead
where 
--(Sales_Notes__c like '%Samsara%' or GPS_Provider__c like '%Samsara%')
Status like 'closed%'
--or Partner__c like '%Samsara%'


