select t0.AuditId,
t0.salesforce_account_id,
t0.Description,
adjusted_vehicles * case when convert(nvarchar, t0.addedremoved) = 'Removed' then -1 else 1 end  as Adjested_vehicles,
t0.created_at,
t0.addedremoved,
T0.product,
case when convert(nvarchar, t0.addedremoved) = 'Removed' then t0.MrrPerItem * -1 else t0.MrrPerItem end  as MrrPerItem,
t0.totalMrrChange,
t1.OwnerId
 
from  openquery(WAPROD , 'select 
t0.AuditId as AuditId,
t0.Salesforce_account_id,
t0.description,
Adjusted_vehicles as Adjusted_vehicles ,
Created_at,
AddedRemoved as AddedRemoved, 
Product,
MrrPerItem as MRRPerItem,
case when addedremoved = ''Added'' then cast(Adjusted_vehicles as int) * MrrPerItem else (cast(Adjusted_vehicles as int) * MrrPerItem) * -1 end as TotalMRRChange

from 
(
select a.*,
	a.id as AuditId,
b.salesforce_account_id,

case when a.prorated_price_per_vehicle not like ''-%'' then ''Added'' else ''Removed'' end as AddedRemoved,

--get type of change 
case when a.description like ''%Maintain Lite%'' then ''Maintain Lite''
when a.description like ''%Maintain%'' then ''Maintain''
when a.description like ''%Inspect Lite%'' then ''inspect Lite''
else ''Inspect'' end as Product,

--Find Cost of Item  
case when (case when a.description like ''%Maintain Lite%'' then ''Maintain Lite''
when a.description like ''%Maintain%'' then ''Maintain''
when a.description like ''%Inspect Lite%'' then ''Inspect Lite''
else ''Inspect'' end) = ''Inspect'' then b.unit_price_per_vehicle
else s.price_per_unit end as MRRPerItem,

b.Name,
b.id
from v2_billing_audits as a 
inner join public.v2_businesses as b on a.business_id = b.id
left outer join (SELECT a.*, s.name
FROM public.business_sub_add_ons as a
left outer join public.subscription_add_ons as s on a.subscription_add_on_id = s.id
inner join public.v2_businesses as b on a.business_id = b.id
where a.deleted_at is null 
order by a.business_id) as s on a.business_id = s.business_id and case when a.description like ''%Maintain Lite%'' then ''Maintain Lite''
when a.description like ''%Maintain%'' then ''Maintain''
when a.description like ''%Inspect Lite%'' then ''inspect Lite''
else ''Inspect'' end = s.name
--where a.created_at > ''2022-04-01 00:00:01''
) as T0') as T0
left outer join Salesforce.dbo.Account as T1 on t0.salesforce_account_id = t1.Id
--where t0.salesforce_account_id = '0014p00001ser75AAA'