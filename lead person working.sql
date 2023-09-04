select a.CompanyName,
a.sfid as LeadCompanyID,
b.NAME,
max(b.TITLE) as title,
max(b.EMAIL) as email,
Max(b.[FIRSTNAME]) as FirstName,
max(b.LASTNAME) as LastName,
max(b.id) as OrgId

from leadCompany as a
inner join [dbo].[Leadextract122421] as b on SUBSTRING (b.[Email], CHARINDEX( '@', b.[Email]) + 1, LEN(b.[Email])) = a.Domain
where a.sfid is not null
and b.name != 'x'
and b.name != '[not provided]'
and b.name not like '***%'
and b.name not in ('[[Unknown]]', '[unknown] [unknown]')
--and b.name in ('Chris Generale', 'Kelly Clay')
Group by a.CompanyName, a.sfid, b.NAME
order by b.name
