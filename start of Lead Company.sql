select 
/*
,[dbo].[GetDomainFromEmail](email) as Domain
,[dbo].[IsBadEmailDomain](email) as badEmail
,[dbo].[IsBadDomain](Domain__c) as badDomain
*/
max(id) as SFID,
lower(case when [dbo].[IsBadDomain](Domain__c) = 0 then Domain__c
When email is not null and [dbo].[IsBadEmailDomain](email) = 0 then [dbo].[IsBadEmailDomain](email) 
When Company like '%@%' and dbo.IsBadEmailDomain(dbo.[GetDomainFromEmail](Company))= 0  then dbo.[GetDomainFromEmail](Company)
else Company + '.wa'
end ) as ImputedDomain
from openquery(SFWA , 'select id, FirstName, LastName, Company, state, website, lead_origin__c, domain__c, email, OwnerId from lead  ') as L
Where email is not null 
Group by 
lower(case when [dbo].[IsBadDomain](Domain__c) = 0 then Domain__c
When email is not null and [dbo].[IsBadEmailDomain](email) = 0 then [dbo].[IsBadEmailDomain](email) 
When Company like '%@%' and dbo.IsBadEmailDomain(dbo.[GetDomainFromEmail](Company))= 0  then dbo.[GetDomainFromEmail](Company)
else Company + '.wa'
end )
order by Count(id) desc
