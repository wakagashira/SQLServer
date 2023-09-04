
select distinct case when website is not null then dbo.ProperWebsite(website) 
when email is not null and email LIKE '%_@__%.__%'
and (Company + '||' + Name  not like '%?%||%?%')
--and email = 'melissa_3091@yahoo.com'
and dbo.IsBadEmailDomain(website) = 0 then dbo.GetDomainFromEmail(email)
when company is not null and company not like '%@%.%' then 'Company Only'
else 'bad Lead'
end as domain
from leads

