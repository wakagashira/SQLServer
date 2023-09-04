/*CREATE VIEW dbo.AccountGetRecomendedType
AS
 */
select a.id,
a.name,
case when act.Maxid is null then null else 'Customer' end as ActiveStatus,
inact.StatusRec,
case 
--If it has a active subscription its a customer 
when act.Maxid is not null and a.name not like '**%' then 'Customer'
--If it has ** then its always a bad account
when a.name like '**%' then 'Bad Account'
--If already marked as a bad account then stay in Bad Account 
when a.type = 'Bad Account' then 'Bad Account'
--If already tagged as a partner stay in partner
when a.type = 'Partner' then 'Partner'
-- If has inact record i.e. ex-customer
when inact.id is not null then inact.StatusRec


else 'Prospect' end as RecomendedType,
a.type as CurrentType

from 
Salesforce.dbo.Account as a
Left outer Join salesforce.[dbo].[GetActiveRecSubs] as Act on a.id = act.recurly_v2__Account__c
Left Outer join salesforce.[dbo].[GetInactiveRecSubs] as Inact on a.id = inact.recurly_v2__Account__c

