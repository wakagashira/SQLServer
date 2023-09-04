CREATE VIEW dbo.WAProdDriversAssetsInspectingLast30Days
AS

select * 
from  openquery(WAprod , 'select businessid, name, teamId, teamname,
sum(InspectingAssets) as InspectingAssets,
Sum(TotalAssets) as TotalAssets
From(

select a.name,
a.id as BusinessId,
b.name as TeamName, 
b.id as TeamId,
Count(c.last_inspection) as InspectingAssets,
0 as TotalAssets
from   public.v2_businesses as a
left outer join public.v2_teams as b on a.id = b.business_id
Left Outer Join public.v2_vehicles as c on b.id = c.team_id
--Left Outer join public.inspection_statuses as d on a.id = cast(d.business_id as INT) and c.Id = cast(d.driver_id as INT)
where a.name like ''%Redbox%'' 
and a.id = 16972
and c.deleted_at is null 
and date(c.last_inspection ) >= date(Current_date) - 30 
Group by a.name, b.name, a.id, b.id
union 
select a.name,
a.id as BusinessId,
b.name as TeamName, 
b.id as TeamId,
0 as InspectingAssetts,
count(c.Id) as TotalAssets
from   public.v2_businesses as a
left outer join public.v2_teams as b on a.id = b.business_id
Left Outer Join public.v2_vehicles as c on b.id = c.team_id
--Left Outer join public.inspection_statuses as d on a.id = cast(d.business_id as INT) and c.Id = cast(d.driver_id as INT)
where a.name like ''%Redbox%'' 
and a.id = 16972
and c.deleted_at is  null 
--and date(c.last_inspection ) >= date(Current_date) - 30 
Group by a.name, b.name, a.id, b.id) as T0
Group by name, teamname, businessId, teamid
order by name, teamname
'


) 



