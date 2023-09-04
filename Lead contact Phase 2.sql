select distinct 
--139,917 unique contacts with email and phone 
Domain,
email,
Phone,
case when email is not null and Phone is not null then 4
when email is not null and phone is null then 3
When email is null and Phone is not null then 2
when email is null and phone is null then 1
else 0 end as Ranks
into LeadContactPhase2
from Leadcontactphase1
--where (isnull(email, '') + isnull(phone, '')) != ''



