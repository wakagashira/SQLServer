select distinct 
mu.email, 
mu.id,
mu.bid as sfacctId,
mc.id as sfcntid,
mc.WA_User_Id__c
from (
select 
b.salesforce_account_id,
u.email,
count(u.email) as Contactcnt
from LocalWAProd.dbo.v2_users as u
inner join LocalWAProd.dbo.v2_businesses as b on u.business_id = b.id
where u.email like '%@%'
and u.[user_role_id] != 9
and b.deleted_at is null 
and u.deleted_at is null 
and b.salesforce_account_id is not null 
group by b.salesforce_account_id,
email
having count(email) = 1) as u

left outer join 
(select 
AccountId,
email,
count(email) as Contactcnt
from Salesforce.dbo.contact
group by accountid,
email
having count(email) = 1) as c on u.email = c.email and u.salesforce_account_id = c.AccountId

inner join (select b.salesforce_account_id as bid, u.* 
from LocalWAProd.dbo.v2_users as u  
Inner Join localwaprod.dbo.v2_businesses as b on u.business_id = b.id
where u.email like '%@%'
and u.[user_role_id] != 9
and u.deleted_at is null 
)as mu on u.email = mu.email and u.salesforce_account_id = mu. bid

left outer join salesforce.dbo.Contact as mc on mu.bid = c.AccountId and mu.email =mc.email
--left outer join salesforce.dbo.Account as act on mu.bid = act.id and mu.id = act.AppID__c







