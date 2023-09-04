select type as customerType, * from Salesforce.dbo.Opportunity
where 
(Demo_Notes_New__c like '%Samsara%' 
or Description_and_Notes__c like '%Samsara%' 
or Mutual_Demo_Notes__c like '%Samsara%' 
or PreDemo_Notes__c like '%Samsara%' 
or GPS_Provider__c like '%Samsara%'
)
and stagename != 'closed won'
order by type 


