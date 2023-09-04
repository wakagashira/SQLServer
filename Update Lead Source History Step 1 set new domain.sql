
update
NewLead_Source_History
set newlead_Source_History.NewDomain = c.domain
from newlead_Source_History
 as a 
inner join (



SELECT 
a.id,
a.domain
FROM GetDomainFromLead AS a
     INNER JOIN leads AS b ON a.id = b.id
--	 where b.email is not null 
--	 and a.domain != 'Company Only'
--	 and isNull(b.phone, 'X') + isNull(b.MobilePhone, 'X') != 'XX'






) as c on  a.id = c.id
