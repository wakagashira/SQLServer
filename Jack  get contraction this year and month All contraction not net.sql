select z1.month,
a.name,
a.Industry,
a.Recurly_Create_Date__c,
a.OB_Stage__c,
u.Name as OwnerName,
a.acc_Total_Fleet_Size__c as FleetSize,
a.type, 
z1.Product,
z1.SFID,
z1.TotalVechicles as TotalVehiclesChanged,
z3.MonthsPerBill,
case when z1.product = 'Inspect' then z2.InspectPrice 
when z1.product = 'Inspect Lite' then z2.InspectLitePrice / z3.MonthsPerBill
when z1.product = 'Maintain' then z2.MaintainPrice / z3.MonthsPerBill
when z1.product = 'Maintain lite' then z2.MaintainLitePrice / z3.MonthsPerBill
else .01 end  as MRRPerUnit,
case when z1.product = 'Inspect' then z2.InspectPrice
when z1.product = 'Inspect Lite' then z2.InspectLitePrice / z3.MonthsPerBill
when z1.product = 'Maintain' then z2.MaintainPrice / z3.MonthsPerBill
when z1.product = 'Maintain lite' then z2.MaintainLitePrice / z3.MonthsPerBill
else .01 end * z1.TotalVechicles as MRRTotal 


from 
(

select 
datepart(month, t0.created_at) as month,
t0.sfid,
t0.Product,
sum(t0.Adjusted_vehiclesTotal) as TotalVechicles


from 
(

select cast(a.salesforce_account_id as nvarchar) as SFID, 
cast(a.product as nvarchar) as Product,
case when cast(a.addedRemoved as nvarchar) = 'Added' then adjusted_vehicles 
else adjusted_vehicles * -1 end as Adjusted_vehiclesTotal,
a.created_at



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
) T0
where t0.Adjusted_vehiclesTotal <0
Group by datepart(month, t0.created_at),
t0.sfid,
t0.Product
)
as z1
left outer join Salesforce.dbo.account as a on z1.SFID = a.id
Left outer join  Salesforce.dbo.[User] as u on a.ownerid = u.id
left outer join dbo.GetProductCostPerAccount as z2 on z1.SFID = z2.Salesforce_account_id 
left outer join dbo.GetBillingLengthfromAccountid as z3 on z1.SFID = z3.AccountId 
where z1.TotalVechicles <0
order by Month
