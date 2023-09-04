/*
update
NewLead_Source_History
set newlead_Source_History.priority = c.Priority
from newlead_Source_History
 as a 
inner join (
*/


Select 
ID,
NewDomain,
Website,
FirstName,
LastName,
Title,
Email,
--dbo.IsBadEmailDomain(email) BadEmail,
Total_Fleet_Size__c,
Company,
--dbo.IsBadCompanyName(company) as BadCompany,
Phone,
--Len(Phone) as LenPhone,
case when website is null and NewDomain = 'Company Only' then 3 else 0 end +
case when FirstName is null or FirstName = 'x'  then 1 else 0 end +
case when LastName is null or LastName = 'x'  then 1 else 0 end + 
case when email is null then 3 else 0 end +
case when dbo.IsBadEmailDomain(email) = 1 and email is not null then 2 else 0 end +
case when Total_Fleet_Size__c is null then 1  when Total_Fleet_Size__c < 10 then 10 else 0 end +
case when Company is null then 3 when email like '%@%' and dbo.IsBadCompanyName(company) = 1 then 3 else 0 end +
case when dbo.isbadphone(Phone) = 1  then 1 else 0 end 

as Priority

from NewLead_Source_History
--where len(Phone) < 10
--order by Len(Phone)




--) as c on  a.id = c.id
