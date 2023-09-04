select 
'website Visits' as Report,
isnull(Sales_Status__c, '-') as Status,
Count(id) as cnt

from account
where

RecordTypeId in ('0124p000000iICzAAM', '0124p000000NkuCAAS', '0124p000000E4B0AAK')
and (Type not in ('Trial Customer', 'Customer') or type is null)
and Website is not null 
and website != ''
and (Account_Status__c not in ('Customer', 'New Customer', 'Needs Account Set Up', 'Needs Training', 'First Month', '30 to 90 Days', 'Low Risk', 'High Risk', 'Customer Unresponsive', 'Dont Touch') or Account_Status__c is null)
and isnull(sales_status__c, '-') not in ('Engaging', 'Converted To Opp', 'Customer', 'Closed Account')
Group by isnull(Sales_Status__c, '-')