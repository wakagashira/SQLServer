CREATE VIEW dbo.WAProdDriversInspectingLast30Days
AS

select * 
from  openquery(WAprod , 'select name,
businessid,
TeamName,
TeamId,
sum(Inspecting) as Inspecting,
sum(TotalDrivers) as TotalDrivers
from 
(
select a.id as BusinessId, 
a.name, 
b.name as TeamName, 
b.id as TeamId,
Count(c.last_inspection) as Inspecting,
0 as TotalDrivers
from   public.v2_businesses as a
left outer join public.v2_teams as b on a.id = b.business_id
Left Outer Join public.v2_drivers as c on b.id = c.team_id
--Left Outer join public.inspection_statuses as d on a.id = cast(d.business_id as INT) and c.Id = cast(d.driver_id as INT)
where a.name like ''%Redbox%'' 
and a.id = 16972
and c.deleted_username is null 
and date(c.last_inspection ) >= date(Current_date) - 30 
Group by a.name, b.name, a.Id, b.Id
 union 
 select a.id as BusinessId, 
a.name, 
b.name as TeamName, 
b.id as TeamId,
0 as Inspecting,
count(c.id) as TotalDrivers
from   public.v2_businesses as a
left outer join public.v2_teams as b on a.id = b.business_id
Left Outer Join public.v2_drivers as c on b.id = c.team_id
--Left Outer join public.inspection_statuses as d on a.id = cast(d.business_id as INT) and c.Id = cast(d.driver_id as INT)
where a.name like ''%Redbox%'' 
and a.id = 16972
and c.deleted_username is null 
--and date(c.last_inspection ) >= date(Current_date) - 30 
Group by a.name, b.name, a.Id, b.Id ) as T0
group by name, teamname, businessId, teamId
order by Name, Teamname') 



