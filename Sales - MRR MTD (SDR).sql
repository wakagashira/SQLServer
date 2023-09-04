Select 
Count(o.Id) as CntOppId,
sum(o.Amount) as NewSales,
sum(o.Amount) / Count(o.Id) AverageDeal

from  openquery(SFWA , 'select AccountId, 
Amount as Amount,
id
from Opportunity 
where Close_Date_Is_Current_Month__c = true 
and Close_Date_Current_Year__c = true 
and Type in (''New Business'', ''CS - New Biz'')
and Name not like ''%****%''
and Sales_Rep__c != ''0054p00000324QiAAI''

and StageName in (''Closed Won'', ''Docs Requested'', ''Ready To Close'')
') as O
