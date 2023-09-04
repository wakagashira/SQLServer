select 
count(Id),
Sales_status__c
--* 
--distinct RecordTypeId
from 
openquery(SFWA , 'select id, sales_status__c
from Account 
where RecordTypeId in (''0124p000000iICzAAM'', ''0124p000000NkuCAAS'', ''0124p000000E4B0AAK''
)
and Type Not In (''Trial Customer'', ''Customer'')
and Website != ''''
and Account_Status__c not in (''Customer'', ''New Customer'', ''Needs Account Set Up'', ''Needs Training'', ''First Month'', ''30 to 90 Days'', ''Low Risk'', ''High Risk'', ''Customer Unresponsive'', ''Dont Touch'')
and Sales_Status__c not In (''Engaging'', ''Converted To Opp'', ''Closed Account'')




') as A
Group by sales_status__c