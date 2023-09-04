select i.*, a.id as APpCDPId, a.Inspections_WA_Prod__c
from 
openquery(WAPRod, 'select T0.id as WAId, 
T0.salesforce_account_id, 
sum(T0.Assets) as Assets, 
Sum(T0.teams) as Teams,
Sum(T0.Drivers) as Drivers,
sum(T0.Inspections) as Inspections,
Sum(T0.PerVehInspect) as PerVehInspect
From
(select distinct b.id, 
b.salesforce_account_id, 
count(v.id) as Assets, 
0 as teams,
0 as Drivers,
0 As Inspections,
0 as PerVehInspect,
0 as OpenServices
        from v2_businesses as b
		left Outer Join v2_vehicles as v on b.id = v.business_id
		--left outer join v2_teams as t on b.id = t.business_id
		WHERE 
		v.deleted_at is null  
and b.salesforce_account_id is not null 
GROUP BY b.id, b.salesforce_account_id
union 
select distinct b.id, 
b.salesforce_account_id, 
0 as Assets, 
Count(t.id) as teams,
0 as Drivers,
0 As Inspections,
0 as PerVehInspect,
0 as OpenServices
        from v2_businesses as b
		left outer join v2_teams as t on b.id = t.business_id
		WHERE 
		t.deleted_at is null 
and b.salesforce_account_id is not null 
GROUP BY b.id, b.salesforce_account_id
union 
select distinct b.id, 
b.salesforce_account_id, 
0 as Assets, 
0 as teams,
Count(d.id) as Drivers,
0 As Inspections,
0 as PerVehInspect,
0 as OpenServices
        from v2_businesses as b
		left outer join v2_teams as t on b.id = t.business_id
		left outer join v2_drivers as d on t.id = d.team_id
		WHERE 
		d.deleted_at is null 
and b.salesforce_account_id is not null 
GROUP BY b.id, b.salesforce_account_id
Union 
select b.id, 
b.salesforce_account_id,
0 as Assets, 
0 as teams,
0 as Drivers,
count(r.id) as Inspections,
0 as PerVehInspect,
0 as OpenServices
        from v2_businesses as b
		inner join v2_reports as r on r.business_id = b.id
WHERE r.deleted_at is null
and b.salesforce_account_id is not null 
GROUP BY b.id, b.salesforce_account_id
union 

select z1.business_id,
b.salesforce_account_id,
0 as Assets, 
0 as teams,
0 as Drivers,
0 as Inspections,
--sum(z1.inspectingV) as inspectingV,
--sum(z1.totalV) as TotalV,
case when sum(z1.totalV) = 0 then 1 when  sum(z1.inspectingV) = 0 then 0 else sum(z1.inspectingV) / sum(z1.totalV) end as PerVehInspect,
0 as OpenServices
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
Group by v.business_id

union 

select t0.business_id,
count(t0.Vehicle_id) as InspectingV,
0 as TotalV
from
(SELECT distinct r.business_id,
r.vehicle_id
FROM public.v2_reports as r 
where r.created_at > now() - interval ''30 day'')
 as  T0 

Group by t0.business_id





) as Z1
Inner Join v2_businesses as b on z1.business_id = b.id
where b.salesforce_account_id is not null 
Group by z1.business_id, b.salesforce_account_id

 
  union 

select b.id, 
b.salesforce_account_id, 
0 as Assets, 
0 as teams,
0 as Drivers,
0 As Inspections,
0 as PerVehInspect,
count(s.id) as OpenServices

from public.services as s 
inner join public.v2_businesses as b on s.business_id = b.id

where s.completed_By_user_id is null 
and s.deleted_at is null 
and b.salesforce_account_id is not null 
group by b.id,
b.salesforce_account_id




) as T0
Group by T0.id,
T0.salesforce_account_id





') as I
inner Join  salesforce.dbo.App_CDP__c as A on I.salesforce_account_id = a.Account__c
where i.inspections != isnull(a.inspections_Wa_prod__c, 0)
or i.teams != isnull(a.Teams_WA_Prod__c, 0)
or i.drivers != isnull(a.Drivers__c, 0)
or i.assets != isnull(a.Assets_WA_Prod__c, 0)