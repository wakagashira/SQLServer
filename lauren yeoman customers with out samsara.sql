select  * from Salesforce.dbo.account
where 
isnull(Integration_Names__c,'None') !=  '%Samsara%' and
type like 'customer'
--or Partner__c like '%Samsara%'


