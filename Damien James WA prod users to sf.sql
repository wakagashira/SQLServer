select s.*,
w.*

from openquery(WAPROD , 'select 
--r.id as WARoleId,
--b.name,
b.salesforce_account_id,
u.id as WAUserId,
u.first_name,
u.last_name,
u.phone,
u.job_title,
u.email,
--u.profile_completed,
--u.seen_tour,
--u.active,
--r.Name as RoleName,
r.display_name as RoleDisplayName,
u.business_id,
u.team_id,
--u.deleted_at,
--u.created_at,
--u.updated_at,
--u.deleted_email,
u.timezone,
u.phone_e164,
--u.last_login,
--u.invite_sent,
--u.first_login,
u.username,
u.driver_id
from public.v2_users as u
Inner Join public.v2_user_roles as r on u.user_role_id = r.id
Inner Join public.v2_businesses as b on u.business_id = b.id
Where

u.email not like ''%@whiparound%''
and b.salesforce_account_id is not null 
and b.name not like ''***%''
and r.id not in (1,5,6,7,9)
and u.deleted_at is null 
and b.deleted_at is null 
') as w
 left outer join openquery(SFWA , 'select id as SFContactId, AccountId as SFAccountId, email As sfEmail from Contact') as s on w.salesforce_account_id = s.sfAccountId and w.email = s.sfemail 

 where s.sfContactId is null 