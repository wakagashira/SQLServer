update
NewLeadPerson
set newleadperson.Mobile = c.phone
from newleadperson as a 
inner join (


SELECT 
--99,260
a.domain,
a.email,
a.name,
replace(replace(replace(Replace(replace(b.MobilePhone, '-', ''), '(', ''), ')', ''), ' ', ''), '+', '') as Phone ,
count(replace(replace(replace(Replace(replace(b.MobilePhone, '-', ''), '(', ''), ')', ''), ' ', ''), '+', '')) as countp
FROM NewLeadPerson AS a
     INNER JOIN leads AS b ON a.email = b.email
                              AND a.domain = dbo.ProperWebsite(b.website)
							  and a.FirstName = b.FirstName
WHERE a.email NOT LIKE '**%'
and b.Phone is not null 


Group by a.domain,
a.email,
a.name,
replace(replace(replace(Replace(replace(b.MobilePhone, '-', ''), '(', ''), ')', ''), ' ', ''), '+', '')





) as c on a.email = c.email and a.domain = c.domain

