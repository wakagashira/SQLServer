
update
NewLeadPerson
set newleadperson.LastContactDate = c.LastContactDate
from newleadperson as a 
inner join (



SELECT 
--99,260
a.domain,
b.email,
Max(cast(b.Last_Touchpoint__c as date)) as LastContactDate
FROM GetDomainFromLead AS a
     INNER JOIN leads AS b ON a.id = b.id
	 where b.email is not null 
	 and a.domain != 'Company Only'
	 and b.Last_Touchpoint__c is not null
Group by a.domain,
b.email






) as c on a.email = c.email and a.domain = c.domain
