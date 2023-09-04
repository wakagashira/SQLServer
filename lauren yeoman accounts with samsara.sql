select type as customerType, * from Salesforce.dbo.account
where 
(isnull(Integration_Names__c,'None') =  '%Samsara%' or Demo_NOtes__c like '%Samsara%' or GPS_Provider__c like '%Samsara%')
--type like 'customer'
--or Partner__c like '%Samsara%'
order by type 


