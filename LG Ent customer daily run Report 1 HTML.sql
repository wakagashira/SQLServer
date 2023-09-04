select 
 '<a href="https://api.whip-around.com/dashboard/v2/faults/' + cast(f.id as nvarchar) + '">' + f.UI_Number_text + '</a>' as 'Defect ID'
,'<a href="https://api.whip-around.com/dashboard/v2/vehicles/' + cast(f.vehicle_id as nvarchar) + '">' +f.assetname + '</a>' as Asset 
, dateadd(hour, -4, f.created_at) as 'Date Created'
,dateadd(hour, -4, f.Updated_at) as 'Last Updated'
, isnull(p.name, 'Undefined') as Priority
, f.Fault_name as Defect
, '<a href="https://api.whip-around.com/dashboard/v2/drivers/' + cast(f.did as varchar(10)) + '">' + f.driver_name +'</a>' AS Driver
, '<a href="https://api.whip-around.com/dashboard/v2/work-orders"> Create New Work Order </a>' as 'Create Work Order'
from 
Openquery (WAPROD, '
select 
 f.id
 ,f.business_id
 ,f.UI_Number_text
,f.vehicle_id
,v.name as assetName
,f.created_at
,f.Updated_at
--, p.name as PriorityName
,f.priority_id
, f.Fault_name
, d.id as did
, f.driver_name
, ''https://api.whip-around.com/dashboard/v2/work-orders'' as CreateWorkOrder
from v2_faults as f
Left Outer join  v2_fault_statuses as fs on f.fault_status_id = fs.id
Left Outer Join  v2_vehicles as v on f.vehicle_id = v.id
--left outer join priorities as p on f.priority_id = p.id
left outer join v2_drivers as d on f.driver_id = d.id
where f.business_id = 10523
--and cast(f.created_at as date) = cast(getdate() as date)
--and Datepart(year, f.created_at) =  2022
order by f.created_at

') as f
left outer join localwaprod.dbo.priorities as p on f.priority_id = p.id
where f.business_id = 10523
and cast(f.created_at as date) = cast(getdate() as date)
--and Datepart(year, f.created_at) =  2022
order by f.created_at