--used to create new contacts from WA backend.  Excludes emails that are not unique from being imported

select 
z2.*
from 
(select t0.email 
,count(t0.email) as cnt
from 


(
--Get unique email addresses to import 
select
u.email
--,
--b.salesforce_account_id,
--a.id,
--c.id
from LocalWAProd.dbo.v2_users as u  
inner join LocalWAProd.dbo.v2_businesses as b on u.business_id = b.id
Inner Join localwaprod.dbo.v2_user_roles as r on u.user_role_id = r.id
inner join Salesforce.dbo.Account as A on b.salesforce_account_id = a.Id
Left outer join Salesforce.dbo.contact as c on u.email = c.Email and b.salesforce_account_id = c.AccountId
where u.deleted_at is null 
and b.salesforce_account_id is not null 
and u.user_role_id != 9
and c.id is null 

) as t0
group by  t0.email 
having count(t0.email) = 1
) as z1
Inner Join (
--Get the values of the sorted Z1 unique email addresses 
select
u.id,
b.salesforce_account_id,
c.id as contactId,
u.id as WAUserId,
u.business_id,
a.name as acctname,
u.user_role_id,
r.name,
u.first_name,
u.Last_name,
c.name as Cntname,
u.Phone,
u.email,
u.timezone,
c.WA_User_Id__c
from LocalWAProd.dbo.v2_users as u  
inner join LocalWAProd.dbo.v2_businesses as b on u.business_id = b.id
Inner Join localwaprod.dbo.v2_user_roles as r on u.user_role_id = r.id
inner join Salesforce.dbo.Account as A on b.salesforce_account_id = a.Id
Left outer join Salesforce.dbo.contact as c on u.email = c.Email and b.salesforce_account_id = c.AccountId
where u.deleted_at is null 
and b.salesforce_account_id is not null 
and u.user_role_id != 9
--and c.IsDeleted = 0
--AND isnull(c.WA_User_Id__c, 0) != isnull(u.id, 0)
--and c.WA_User_Id__c is null 
--order by u.email, c.id
) as z2 on z1.email = z2.email