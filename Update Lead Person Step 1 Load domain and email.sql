insert into 
NewLeadPerson
(domain, Email)
(Select distinct 

t0.domain
--,t1.FirstName
--,t1.LastName
,t1.email
--,phone
from GetDomainFromLead as t0
Inner Join leads as t1 on 
-- t0.website = t1.domain  
  
t0.id = t1.id
where 
T1.name != 'x'
and T1.name != '[not provided]'
and T1.name not like '***%'
and T1.name not in ('[[Unknown]]', '[unknown] [unknown]')
and t0.domain != 'Company Only'
and t1.email is not null 
)
