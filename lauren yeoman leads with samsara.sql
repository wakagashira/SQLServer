select z2.*


from 
(select email, min(id) as id

from 
(select 'Lead' as Type, Id, pi__url__c as PardotUrl, FirstName, LastName, Company,  GPS_Provider__c, Email
from Salesforce.dbo.lead
where 
(GPS_Provider__c like '%Samsara%')
and Name not like '**%'
and company not like '**%'
and IsDeleted != 1
Union 
select a.type, a.id, c.pi__url__c, c.FirstName, c.LastName, a.name, a.GPS_Provider__c, c.Email
from Salesforce.dbo.Account as a 
inner join Salesforce.dbo.Contact as c on a.Primary_Contact__c = c.id
where 
(a.GPS_Provider__c like '%Samsara%')
and a.Name not like '**%'
and c.firstname not like '**%'
and c.lastname not like '**%'
and isnull(a.Integration_Names__c, 'NULL') not like '%samsara%'
and type != 'Ex-Customer'
and a.IsDeleted != 1
union 
select a.type, a.id, c.pi__url__c, c.FirstName, c.LastName, a.name, a.GPS_Provider__c, c.Email
from Salesforce.dbo.Account as a 
inner join Salesforce.dbo.Contact as c on a.Primary_Contact__c = c.id
where 
(a.GPS_Provider__c like '%Samsara%')
and a.Name not like '**%'
and c.firstname not like '**%'
and c.lastname not like '**%'
and type = 'Ex-Customer'
and a.IsDeleted != 1

) as t0 

Group by email) as z1
inner join (select 'Lead' as Type, Id, pi__url__c as PardotUrl, FirstName, LastName, Company,  GPS_Provider__c, Email
from Salesforce.dbo.lead
where 
(GPS_Provider__c like '%Samsara%')
and Name not like '**%'
and company not like '**%'
and IsDeleted != 1
Union 
select a.type, a.id, c.pi__url__c, c.FirstName, c.LastName, a.name, a.GPS_Provider__c, c.Email
from Salesforce.dbo.Account as a 
inner join Salesforce.dbo.Contact as c on a.Primary_Contact__c = c.id
where 
(a.GPS_Provider__c like '%Samsara%')
and a.Name not like '**%'
and c.firstname not like '**%'
and c.lastname not like '**%'
and isnull(a.Integration_Names__c, 'NULL') not like '%samsara%'
and type != 'Ex-Customer'
and a.IsDeleted != 1
union 
select a.type, a.id, c.pi__url__c, c.FirstName, c.LastName, a.name, a.GPS_Provider__c, c.Email
from Salesforce.dbo.Account as a 
inner join Salesforce.dbo.Contact as c on a.Primary_Contact__c = c.id
where 
(a.GPS_Provider__c like '%Samsara%')
and a.Name not like '**%'
and c.firstname not like '**%'
and c.lastname not like '**%'
and type = 'Ex-Customer'
and a.IsDeleted != 1
) as Z2 on z1.id = z2.id
where z2.email is not null 
order by type


