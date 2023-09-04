select 
t0.SFID,
a.name,
t0.product,
sum(t0.Adjusted_vehiclesTotal) TotalChangeInVehicles,
a.Industry,
a.Recurly_Create_Date__c,
a.OB_Stage__c,
u.Name as OwnerName,
a.acc_Total_Fleet_Size__c as FleetSize,
a.type

from (
select cast(a.salesforce_account_id as nvarchar) as SFID, 
cast(a.product as nvarchar) as Product,
case when cast(a.addedRemoved as nvarchar) = 'Added' then adjusted_vehicles 
else adjusted_vehicles * -1 end as Adjusted_vehiclesTotal   

from openquery(WAPROD, 'select a.id as AuditKey, a.*,
b.salesforce_account_id,case when a.prorated_price_per_vehicle not like ''-%'' then ''Added'' else ''Removed'' end as AddedRemoved,--get type of change
case when a.description like ''%Maintain Lite%'' then ''Maintain Lite''
when a.description like ''%Maintain%'' then ''Maintain''
when a.description like ''%Inspect Lite%'' then ''inspect Lite''
else ''Inspect'' end as Product,--Find Cost of Item
case when (case when a.description like ''%Maintain Lite%'' then ''Maintain Lite''
when a.description like ''%Maintain%'' then ''Maintain''
when a.description like ''%Inspect Lite%'' then ''inspect Lite''
else ''Inspect'' end) = ''Inspect'' then b.unit_price_per_vehicle
else s.price_per_unit end as MRRPerItem,b.Name,
b.id ,
 b.recurly_account_code,
 b.currency_id,
 c.name,
 a.created_at
from v2_billing_audits as a
inner join public.v2_businesses as b on a.business_id = b.id
inner join public.v2_currencies as c on b.currency_id = c.id
left outer join (SELECT a.*, s.name
FROM public.business_sub_add_ons as a
left outer join public.subscription_add_ons as s on a.subscription_add_on_id = s.id
inner join public.v2_businesses as b on a.business_id = b.id
where a.deleted_at is null
order by a.business_id) as s on a.business_id = s.business_id and case when a.description like ''%Maintain Lite%'' then ''Maintain Lite''
when a.description like ''%Maintain%'' then ''Maintain''
when a.description like ''%Inspect Lite%'' then ''inspect Lite''
else ''Inspect'' end = s.name
-- and salesforce_account_id = ''0014p00001m9EupAAE''
') as a
Where datepart(year, cast(a.created_at as date)) = datepart(year, cast(getdate() as date))
) as t0
Left Outer Join Salesforce.dbo.account as a on t0.SFID = a.Id
Left outer join  Salesforce.dbo.[User] as u on a.ownerid = u.id
Where a.type != 'Ex-Customer'
Group by t0.sfid,
a.name,
t0.product,
a.Industry,
a.Recurly_Create_Date__c,
a.OB_Stage__c,
u.name,
a.acc_Total_Fleet_Size__c ,
a.type
having sum(t0.Adjusted_vehiclesTotal) < 0