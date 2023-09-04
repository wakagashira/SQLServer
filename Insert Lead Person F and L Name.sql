update
NewLeadPerson
set newleadperson.firstname = c.firstname
from newleadperson as a 
inner join (



SELECT 
--99,260
a.domain,
a.email,
a.name,
MAX(b.FirstName) AS FirstName, 
MAX(b.LastName) AS LastName
FROM NewLeadPerson AS a
     INNER JOIN leads AS b ON a.email = b.email
                              AND a.domain = dbo.ProperWebsite(b.website)
WHERE a.email NOT LIKE '**%'
GROUP BY a.domain, 
         a.email, 
         a.name



) as c on a.email = c.email and a.domain = c.domain
