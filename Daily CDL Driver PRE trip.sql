select 
 f.DefectId  as 'Defect ID'
,f.assetname  as Asset 
, dateadd(hour, -4, f.created_at) as 'Date Created'
,dateadd(hour, -4, f.Updated_at) as 'Last Updated'
, isnull(p.name, 'Undefined') as Priority
, f.Fault_name as Defect
, f.driver_name AS Driver
, f.form_name as 'Form Name'
from 
Openquery (WAPROD, '
 select 
 f.id as DefectId
-- f.id
 ,f.business_id
-- ,f.UI_Number_text
--,f.vehicle_id
,v.name as assetName
,f.created_at
,f.Updated_at
--, p.name as PriorityName
,f.priority_id
, f.Fault_name 
--, d.id as did
, f.driver_name
--, ''https://api.whip-around.com/dashboard/v2/work-orders'' as CreateWorkOrder
, t.name as teamName
,F.form_name
from v2_faults as f
Left Outer join  v2_fault_statuses as fs on f.fault_status_id = fs.id
Left Outer Join  v2_vehicles as v on f.vehicle_id = v.id
left outer join v2_teams as t on f.business_id = t.business_id
--left outer join priorities as p on f.priority_id = p.id
left outer join v2_drivers as d on f.driver_id = d.id
where f.business_id = 10523
--and t.name like ''%trip%''
--and cast(f.created_at as date) = cast(getdate() as date)
and t.name in (''Roll - OFF'', ''Front End Trucks'', ''Tractor'' )
and f.form_name like ''%Pre-Trip%Inspection%''
--and Datepart(year, f.created_at) =  2022
order by f.created_at
') as f
left outer join localwaprod.dbo.priorities as p on f.priority_id = p.id
where f.business_id = 10523
--and cast(f.created_at as date) = cast(getdate() as date)
--and Datepart(year, f.created_at) =  2022
and f.driver_name is not null 
order by f.created_at