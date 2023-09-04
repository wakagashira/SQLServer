update
NewLeadPerson
set newleadperson.OptedOutOfEmails = c.optedoutofemail
from newleadperson as a 
inner join (


SELECT 
--99,260
a.domain,
a.email,
a.name,
max(cast(b.HasOptedOutOfEmail as int)) as optedoutofemail
FROM NewLeadPerson AS a
     INNER JOIN leads AS b ON a.email = b.email
                              AND a.domain = dbo.ProperWebsite(b.website)
							  and a.FirstName = b.FirstName
WHERE a.email NOT LIKE '**%'


Group by a.domain,
a.email,
a.name





) as c on a.email = c.email and a.domain = c.domain
