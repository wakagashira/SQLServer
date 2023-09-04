--Next step add names 


select distinct *
into LeadContactPhase3
from 
(--Pull distinct list of lead contacts with both phone and email 
select distinct a.website, a.email,  a.phone
from LeadContactPhase2 as a
Where a.phone is not null and a.email is not null 
union 

--Pull distinct list of lead contacts with email but not phone 
select distinct a.website, a.email,  b.phone
from LeadContactPhase2 as a
inner join LeadContactPhase2 as b on a.website = b.website and a.email = b.email and b.phone is not null 
Where a.phone is null 

Union 

--Pull distinct list of lead contacts with email but not phone 
select distinct a.website, b.email,  a.phone
from LeadContactPhase2 as a
inner join LeadContactPhase2 as b on a.website = b.website and a.phone = b.phone and b.email is not null 
Where a.email is null 
) as T0