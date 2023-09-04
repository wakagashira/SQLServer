select 
case when rf.id is null then 'Passed' else 'Fault' end as Status
,'<a href="https://api.whip-around.com/dashboard/v2/teams/' + cast(r.team_id as nvarchar(10)) + '/managers' + '">' +r.team_name + '</a>' as Team
,'<a href="https://api.whip-around.com/dashboard/v2/drivers/' + cast(r.Driver_id  as varchar(10)) + '">' + r.dfirst_name + ' '+  r.dlast_name + '</a>' AS Driver
,'<a href="https://api.whip-around.com/dashboard/v2/vehicles/' + cast(r.vehicle_id as nvarchar(10)) + '">' +r.vname + '</a>' as Asset 
, vt.name as 'Vehicle Type'
,r.rfirst_name as 'First Name'
,r.rlast_name as 'Last Name'
,dateadd(hour, -4,r.report_started_on_device) as 'Report Started On Device'
,dateadd(hour, -4,r.report_ended_on_device) as 'Report Ended On Device'
,r.report_duration_sec as 'Duration In Seconds'

from openquery (WAPROD, 'select 
--rf.id AS ReportFaultID
r.Id
,r.team_id
,r.business_id
,r.created_at
,r.team_name
,r.Driver_id
,d.first_name as Dfirst_name
,d.last_name as Dlast_name
,r.vehicle_id 
,v.name vName
,v.vehicle_type_id
--,vt.name VTname
,r.first_name as rfirst_name
,r.last_name as rlast_name
,r.report_started_on_device
,r.report_ended_on_device
,r.report_duration_sec

from v2_reports as r
left outer join v2_vehicles as v on r.vehicle_id = v.id
--left outer join v2_vehicle_types as vt on v.vehicle_type_id = vt.id
--left outer join v2_report_faults as rf on r.id = rf.report_id
left outer join v2_drivers as d on r.driver_id = d.id
where r.business_id = 10523
--and datepart(year, r.report_started_on_device) = 2022
--and cast(r.created_at as date) = cast(getdate() as date)
Order by 
r.team_id
,r.report_started_on_device ') as r
left outer join localwaprod.dbo.v2_vehicle_types as vt on r.vehicle_type_id = vt.id
left outer join openQuery(WAPROD, 'select id, report_id from v2_report_faults where business_id = 10523') as rf on r.id = rf.report_id
where r.business_id = 10523
--and datepart(year, r.report_started_on_device) = 2022
and cast(r.created_at as date) = cast(getdate() as date)
Order by 
r.team_id
,r.report_started_on_device 