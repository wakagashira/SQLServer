select z1.business_id,
b.salesforce_account_id,
0 as Assets, 
0 as teams,
0 as Drivers,
0 as Inspections,
--sum(z1.inspectingV) as inspectingV,
--sum(z1.totalV) as TotalV,
case when sum(z1.totalV) = 0 then 1 when  sum(z1.inspectingV) = 0 then 0 else sum(z1.inspectingV) / sum(z1.totalV) end as PerVehInspect
From 
(select v.business_id,
0 as inspectingV,
--count(t0.Vehicle_id) as InspectingV,
Count(v.vehid) as TotalV
from
(select 
ID as vehid,
 business_id
from public.v2_vehicles
where deleted_at is null ) as V
/*Left Outer Join 
(SELECT distinct r.business_id,
r.vehicle_id
FROM public.v2_reports as r 
where r.created_at > now() - interval '30 day')
 as  T0 on v.business_id = T0.business_id
*/
Group by v.business_id

union 

select t0.business_id,
count(t0.Vehicle_id) as InspectingV,
0 as TotalV
from
(SELECT distinct r.business_id,
r.vehicle_id
FROM public.v2_reports as r 
where r.created_at > now() - interval '30 day')
 as  T0 

Group by t0.business_id
) as Z1
Inner Join v2_businesses as b on z1.business_id = b.id
where b.salesforce_account_id is not null 
Group by z1.business_id, b.salesforce_account_id