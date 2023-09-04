select distinct --integration_type
case when i.integration_type = 1 then 'GEOTAB' 
when i.integration_type = 2 then 'KEEPTRUCKIN'
when i.integration_type = 3 then 'RTA'
when i.integration_type = 4 then 'VERIZON CONNECT'
when i.integration_type = 5 then 'SAMSARA' end as IntType ,
i.business_id
, b.salesforce_account_id
from [LocalWAProd].dbo.v2_integrations as  i 
inner join [LocalWAProd].dbo.v2_businesses as b on i.business_id = b.id and b.salesforce_account_id is not null 
Left Outer Join Salesforce.dbo.Account as a on b.salesforce_account_id = a.id
where i.deleted_at is null 
and isnull(a.Integration_Names__c, 'NULL') != case when i.integration_type = 1 then 'GEOTAB' 
when i.integration_type = 2 then 'KEEPTRUCKIN'
when i.integration_type = 3 then 'RTA'
when i.integration_type = 4 then 'VERIZON CONNECT'
when i.integration_type = 5 then 'SAMSARA' end