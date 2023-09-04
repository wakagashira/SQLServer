--CREATE VIEW dbo.NegotiatingAndPilot
--AS
select a.ReportDate,
Sum(a.PilotTotal) as Pilot,
Sum(a.SatTotal) as SatNegotiating,
Sum(a.PilotTotal) + Sum(a.SatTotal) as PilotNegotiatingTotal

from
(
Select 
convert(date, getdate(), 23) as ReportDate,
sum(o.Amount) as PilotTotal,
0 as SatTotal

from  openquery(SFWA , 'select AccountId, 
Amount as Amount,
id,
StageName
from Opportunity 
where Close_Date_Is_Current_Month__c = true 
and Close_Date_Current_Year__c = true 
and Type in (''New Business'', ''CS - New Biz'')
and Type != ''Customer''
and Name not like ''%****%''
and Sales_Rep__c != ''0054p00000324QiAAI''
and StageName =''Pilot''
') as O
inner join openquery(SFWA , 'select id, name from Account where Name not like ''%***%''') as A on o.AccountId = a.id

union 
Select 
convert(date, getdate(), 23) as ReportDate,
0 as PilotTotal,
sum(o.Amount) as SatTotal

from  openquery(SFWA , 'select AccountId, 
Amount as Amount,
id,
StageName
from Opportunity 
where Close_Date_Is_Current_Month__c = true 
and Close_Date_Current_Year__c = true 
and Type in (''New Business'', ''CS - New Biz'')
and Type != ''Customer''
and Name not like ''%****%''
and Sales_Rep__c != ''0054p00000324QiAAI''

and StageName = ''Sat - Negotiating''
') as O
inner join openquery(SFWA , 'select id, name from Account where Name not like ''%***%''') as A on o.AccountId = a.id
) as a
Group by a.ReportDate