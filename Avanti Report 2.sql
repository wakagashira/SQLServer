select b.name as status, 
v.name as VehicleName,
V.team_name,
a.ui_number_text as Defect, 
case when a.fault_status_id = 1 then DATEDIFF(Day, cast(a.created_at as date), getdate()) else DATEDIFF(Day, cast(a.created_at as date), cast(a.updated_at as date)) end  DaysOpen
from localwaprod.dbo.v2_faults as a
inner join localwaprod.[dbo].[v2_fault_statuses] as b on a.fault_status_id = b.id
Inner Join localwaprod.dbo.v2_vehicles as v on a.vehicle_id = v.id
where a.business_id = 30393
and cast(a.created_at as date) > = cast(dateadd(day, -7, getdate()) as date)
--Group by b.name