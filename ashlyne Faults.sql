CREATE VIEW dbo.WAProdFaults
AS
 
SELECT        *
FROM            OPENQUERY(WAPROD, '

select t0.id,
t0.TeamId,
t0.team,
Sum(t0.High) as High,
Sum(t0.Medium) as Medium,
Sum(t0.Low) as Low 
from 
(select b.id, 
t.id as TeamId,
t.Name as team, 
count(*) as High,
0 as Medium,
0 as Low
from v2_faults f 
join v2_businesses b on f.business_id = b.id    
join priorities p  on f.priority_id = p.id
join public.v2_teams as t on b.id = t.business_id
Join public.v2_drivers as d on t.id = d.team_id and f.driver_id = d.id
where b.id = 16972
and p.name = ''High''
group by 1,2,3
Union 
select b.id, 
t.id as TeamId,
t.Name as team, 
0 as High,
count(*) as Medium,
0 as Low
from v2_faults f 
join v2_businesses b on f.business_id = b.id    
join priorities p  on f.priority_id = p.id
join public.v2_teams as t on b.id = t.business_id
Join public.v2_drivers as d on t.id = d.team_id and f.driver_id = d.id
where b.id = 16972
and p.name = ''Medium''
group by 1,2,3
Union 
select b.id, 
t.id as TeamId,
t.Name as team, 
0 as High,
0 as Medium,
count(*) as Low
from v2_faults f 
join v2_businesses b on f.business_id = b.id    
join priorities p  on f.priority_id = p.id
join public.v2_teams as t on b.id = t.business_id
Join public.v2_drivers as d on t.id = d.team_id and f.driver_id = d.id
where b.id = 16972
and p.name = ''Low''
group by 1,2,3
) as t0
Group by 1,2,3					   
				') as a 	   
