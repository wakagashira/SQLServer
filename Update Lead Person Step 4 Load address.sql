drop table TempLeadPersonStep4;
select distinct
t2.domain
,t2.email
,t1.Street
, t1.City
,t1.State
,t1.PostalCode
,t1.Country
,case when t1.Street is not null then 1 else 0 end  + 
case when t1.City is not null then 1 else 0 end + 
case when t1.State is not null then 1 else 0 end +
case when t1.PostalCode is not null then 1 else 0 end +
case when t1.Country is not null then 1 else 0 end 
 as therank


Into TempLeadPersonStep4
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
and t1.title is not null 
;



update
NewLeadPerson
set newleadperson.Street = c.street,
newleadperson.City = c.city,
newleadperson.State = c.state,
newleadperson.PostalCode = c.PostalCode,
newleadperson.Country = c.Country
from newleadperson as a 
inner join (



select z1.domain
,z1.email
,z2.Street
,z2.City
,z2.State
,z2.PostalCode
,z2.Country

from(


select a.Domain, 
a.email,
Max(a.TheRank) as TheRank
from TempLeadPersonStep4 as A
Group by a.Domain, 
a.email

)
As Z1
Inner Join TempLeadPersonStep4 as Z2 on z1.domain = z2.domain and z1.email = z2.email and z1.TheRank = z2.therank



) as c on a.email = c.email and a.domain = c.domain

