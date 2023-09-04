
update
NewLeadPerson
set newleadperson.timezone = c.Timezone
from newleadperson as a 
inner join (



SELECT distinct
--99,260
a.domain,
b.email,
b.Timezone__c as timezone
FROM GetDomainFromLead AS a
     INNER JOIN leads AS b ON a.id = b.id
	 where b.email is not null 
	 and a.domain != 'Company Only'
	 and b.Timezone__c is not null 
--Group by a.domain,
--b.email






) as c on a.email = c.email and a.domain = c.domain
