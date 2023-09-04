/*update
NewLeadPerson
set newleadperson.FirstName = c.FirstName,
newleadperson.LastName = c.LastName
from newleadperson as a 
inner join (

*/
select distinct
t2.domain
,t2.email
,t1.title
--,t1.phone
from 
TempLeadPerson1 as t2
Inner join GetDomainFromLead as t0 on t2.domain = t0.domain 
Inner Join leads as t1 on t0.id = t1.id and t2.email = t1.email and t2.MinDate = t1.CreatedDate

where 
T1.name != 'x'
and T1.name != '[not provided]'
and T1.name not like '***%'
and T1.name not in ('[[Unknown]]', '[unknown] [unknown]')
and t0.domain != 'Company Only'
and t1.email is not null 
and dbo.IsBadEmailDomain(t1.email) = 0
--group by t2.domain , t2.email


--) as c on a.email = c.email and a.domain = c.domain

