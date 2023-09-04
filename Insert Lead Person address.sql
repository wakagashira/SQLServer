update
NewLeadPerson
set newleadperson.Street = c.Street,
newleadperson.City = c.city,
newleadperson.State = c.state,
newleadperson.PostalCode = c.PostalCode,
newleadperson.Country = c.Country
from newleadperson as a 
inner join (



SELECT 
--99,260
a.domain,
a.email,
a.name,
b.FirstName,
b.lastname,
b.street,
b.city,
b.state, 
b.PostalCode,
b.Country
FROM NewLeadPerson AS a
     INNER JOIN leads AS b ON a.email = b.email
                              AND a.domain = dbo.ProperWebsite(b.website)
							  and a.FirstName = b.FirstName
WHERE a.email NOT LIKE '**%'






) as c on a.email = c.email and a.domain = c.domain
