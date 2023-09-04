select b.id,
t.Id as TeamId,
t.name as team,
Sum(t0.New) as New,
Sum(t0.InProgress) as InProgress,
Sum(t0.Corrected) as Corrected 
from 
v2_businesses b 
join public.v2_teams as t on b.id = t.business_id
Left Outer Join 
(select b.id, 
t.id as TeamId,
t.Name as team, 
count(f.id) as New,
0 as InProgress,
0 as Corrected
from 
v2_businesses b 
join public.v2_teams as t on b.id = t.business_id
Join public.v2_drivers as d on t.id = d.team_id 
join v2_faults f on b.id = f.business_id and d.id = f.driver_id and f.deleted_at is null and f.fault_status_id = 1
where b.id = 16972
Group by 1,2,3
union 
select b.id, 
t.id as TeamId,
t.Name as team, 
0 as New,
count(f.id) as InProgress,
0 as Corrected
from 
v2_businesses b 
join public.v2_teams as t on b.id = t.business_id
Join public.v2_drivers as d on t.id = d.team_id 
join v2_faults f on b.id = f.business_id and d.id = f.driver_id and f.deleted_at is null and f.fault_status_id = 2
where b.id = 16972
Group by 1,2,3
Union select b.id, 
t.id as TeamId,
t.Name as team, 
0 as New,
0 as InProgress,
count(f.id) as Corrected
from 
v2_businesses b 
join public.v2_teams as t on b.id = t.business_id
Join public.v2_drivers as d on t.id = d.team_id 
join v2_faults f on b.id = f.business_id and d.id = f.driver_id and f.deleted_at is null and f.fault_status_id = 3
where b.id = 16972
Group by 1,2,3) as t0 on b.id = t0.id and t.id = t0.teamid

where b.id = 16972
Group by 1,2,3
