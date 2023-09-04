select distinct l.id as leadid,
c.id as Contactid,
t0.id as Pardotid,
t0.Email,
t0.Company,
t0.FirstName,
t0.LastName

from 
(SELECT p.ID,
p.Email,
p.Company,
p.FirstName,
p.LastName,
p.CrmAccountFid,
a.id as AcctId,
p.CrmContactFid,
c.id as ContactId,
p.CrmLeadFid,
l.id as LeadId,
p.CrmLastSync
FROM [Salesforce].[dbo].[Pardot_Prospects] as p
Left Outer Join [Salesforce].[dbo].Account as a on p.CrmAccountFid = a.id
Left Outer Join [Salesforce].[dbo].Contact as c on p.CrmContactFid = c.id
Left Outer Join [Salesforce].[dbo].lead as l on p.CrmLeadFid = l.id
where a.id is null and c.id is null and l.id is null 
) as t0 
Left outer join Salesforce.dbo.lead as l on t0.company = l.company and t0.FirstName = l.FirstName and t0.LastName = l.lastname
Left outer join Salesforce.dbo.Contact as c on t0.FirstName = c.FirstName and t0.LastName = c.lastname and t0.Email = c.email
where c.id is not null or l.id is not null 