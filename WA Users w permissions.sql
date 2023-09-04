select  u.id
, u.first_name + ' ' + u.last_name as Name
, ur.name as Role
,case when t.id as teamid
,t.name as TeamName 
from localwaprod.dbo.v2_users as U 
left outer join  localwaprod.dbo.v2_user_roles UR on u.user_role_id = ur.id
Left Outer join localwaprod.dbo.v2_followings as F on u.id = f.user_id
Left Outer Join  localwaprod.dbo.v2_teams as T on case when u.team_id is not null then u.team_id else f.team_id end = T.user_Id
where u.business_id = 5847
and u.active = 'true'
--and u.first_name = 'ralph'
and u.deleted_at is null 
and ur.name != 'Driver'

--order by u.first_name || ' ' || u.last_name, UR.Name, t.name

