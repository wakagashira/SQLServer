CREATE VIEW dbo.GetTrialandDeferredBilling
AS


select 
a.id as SFId,
a.RecurlyID__c,
a.RecurlyExID__c,
--ii.description,
--ii.created_at,
case when ii.description like '%trial%' and ra.has_active_subscription = 1 and (wb.free_trial_end_date is null or  wb.free_trial_end_date  <= Getdate()) then 1
else 0 end as DeferedBilling,
ra.has_active_subscription,
case when ct.SFAcctId is not null then 1 else 0 end as IsInTrial,
a.recurly_v2__Recurly_In_Trial__c,
wb.free_trial_end_date
from 
Salesforce.dbo.Account as a 
Left Outer Join 
(
-- Get Max Invoice ID 
select accountId , max(id) as MaxInvItemId 
from recurly.[dbo].[recurly_invoice_items]
Group by accountid
) as T0 on a.RecurlyID__c = T0.accountId
Left outer Join recurly.[dbo].[recurly_invoice_items] as II on t0.MaxInvItemId = II.id
left outer Join recurly.[dbo].[recurly_accounts] as RA on t0.accountId = ra.id
--Left outer join recurly.[dbo].[recurly_invoices] as RI on II.subscriptionId = RI.id
Left Outer Join LocalWAProd.dbo.v2_businesses as WB on RA.code = WB.recurly_account_code
--Gets the current trials from a view 
Left outer join LocalWAProd.dbo.GetCurrentTrials as ct on a.id = ct.SFAcctId

--ii.description like '%trial%'
