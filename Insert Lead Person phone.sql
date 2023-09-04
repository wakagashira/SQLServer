update
NewLeadPerson
set newleadperson.LastContactDate = c.LastTouchpoint
from newleadperson as a 
inner join (


SELECT 
--99,260
a.domain,
a.email,
a.name,
max(Last_Touch__c) as LastTouchpoint
FROM NewLeadPerson AS a
     INNER JOIN leads AS b ON a.email = b.email
                              AND a.domain = dbo.ProperWebsite(b.website)
							  and a.FirstName = b.FirstName
WHERE a.email NOT LIKE '**%'
and b.Last_Touch__c is not null 


Group by a.domain,
a.email,
a.name





) as c on a.email = c.email and a.domain = c.domain
