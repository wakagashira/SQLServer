
update
NewLeadPerson
set newleadperson.OptedOutOfEmails = c.optedOutOfEmail
from newleadperson as a 
inner join (



SELECT 
--99,260
a.domain,
b.email,
case when Max(convert(int, b.HasOptedOutOfEmail)) = 1 then 'Y' else 'N' end as optedOutOfEmail
FROM GetDomainFromLead AS a
     INNER JOIN leads AS b ON a.id = b.id
	 where b.email is not null 
	 and a.domain != 'Company Only'
Group by a.domain,
b.email






) as c on a.email = c.email and a.domain = c.domain
