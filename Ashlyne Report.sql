CREATE VIEW dbo.WAProdDInspectingLast30Days
AS

select id, Name, Teamname, teamid,  Count(Status) as Inspections
from   openquery(WAPROD , 'select a.name, 
a.id, 
b.id as teamid, 
b.name as TeamName, 
c.username, 
d.status,
date(d.created_at)
from   public.v2_businesses as a
left outer join public.v2_teams as b on a.id = b.business_id
Left Outer Join public.v2_drivers as c on b.id = c.team_id
Left Outer join public.inspection_statuses as d on a.id = cast(d.business_id as INT) and c.Id = cast(d.driver_id as INT)
where a.name like ''%Redbox%'' 
and a.id = 16972
and date(d.created_at) >= date(Current_date) - 30 ') as a
group by Name, id, Name, Teamname, teamid
--Order by id, Name, Teamname, teamid



