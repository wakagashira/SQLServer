
update
NewLeadPerson
set newleadperson.phone = c.Phone,
newleadperson.Mobile = c.Mobile
from newleadperson as a 
inner join (



SELECT 
--99,260
a.domain,
b.email,
Max(b.Phone) as Phone,
max(b.MobilePhone) as Mobile
FROM GetDomainFromLead AS a
     INNER JOIN leads AS b ON a.id = b.id
	 where b.email is not null 
	 and a.domain != 'Company Only'
	 and isNull(b.phone, 'X') + isNull(b.MobilePhone, 'X') != 'XX'
Group by a.domain,
b.email






) as c on a.email = c.email and a.domain = c.domain
