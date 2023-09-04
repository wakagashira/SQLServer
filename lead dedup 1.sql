select 
id,
company,
email,
FirstName,
lastname,
Phone,
l.ConvertedOpportunityId,
DATEPART(YEAR, l.LastTransferDate)
,L.*
from Salesforce.dbo.lead as l
where 
(phone is null 
or email is null 
or (firstname is null and case 
when lastname = 'x' then null 
when lastname = '[not provided]' then null  
when lastname = '[unknown]' then null
when lastname = '.' then null
else lastname end  is null))
and l.ConvertedOpportunityId is null 
and datepart(year, CreatedDate) < 2022
AND DATEPART(YEAR, l.LastTransferDate) < 2022
