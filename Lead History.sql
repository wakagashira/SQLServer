select distinct t0.*, max(t1.sbsfid ) as sbsfid
from
(select distinct a.CompanyName as CompanyName,
a.sfid as LeadCompanyID,
b.NAME as leadName,
b.LEADSOURCE as LeadSource,
cast(b.CREATEDDATE as date) as Createdate,
b.email as email
/*rank() over(
partition by a.sfid, b.name
order by b.CREATEDDATE
) as Rank*/

from leadCompany as a
inner join [dbo].[Leadextract122421] as b on SUBSTRING (b.[Email], CHARINDEX( '@', b.[Email]) + 1, LEN(b.[Email])) = a.Domain
where a.sfid is not null
and b.name != 'x'
and b.name != '[not provided]'
and b.name not like '***%'
and b.name not in ('[[Unknown]]', '[unknown] [unknown]')
--and b.name in ('Chris Generale')

) 
as t0 
inner join [dbo].[Leadextract122421] as t1 on t1.name = t0.leadname
and t1.sbsfid is not null 

Group by t0.CompanyName,
t0.LeadCompanyID,
T0.leadName,
T0.LeadSource,
T0.Createdate,
T0.email
