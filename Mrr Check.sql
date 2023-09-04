select 
a.Id,
--a.Recurly_Billing_Email__c,
--a.name,
ri.id as RecurlyId,
ri.code,
--t0.accountId,
t0.total,
t0.subtotal,
ri.has_active_subscription,
t0.ContractTermLengthMonth,
t0.PeriodLengthMonth,
Round(case when ri.has_active_subscription = 1 and t0.PeriodLengthMonth = 0 then 0 
when ri.has_active_subscription = 1 then t0.subtotal / t0.PeriodLengthMonth else 0 end, 2) as RecurlyRecomendedMRR,
a.[TC_Recurly_MRR__c],
a.Subscription_MRR__c CurrentSalesforceRecurlyMRR,
(cm.mrr) / 100 as CMMRR,
t0.currency,
recSubId,
a.[TC_Chart_Mogul_MRR__c] as CurrentSFCMMRR
from 
Salesforce.dbo.account as a 
Left outer join Recurly.dbo.recurly_accounts as RI on a.RecurlyID__c = ri.id
Left outer join 
(
--Get last invoice by account 
Select accountId, id as recSubId, total, subtotal, currency, DATEDIFF(Month, current_term_started_at, current_term_ends_at) as ContractTermLengthMonth
, DATEDIFF(Month, current_period_started_at, current_period_ends_at) as PeriodLengthMonth
from Recurly.dbo.recurly_subscriptions
where --accountid = 'ixig6kvgbbtw'
state = 'active'
) as T0 on ri.id = t0.accountId
-- Get Chart mogul Mrr
Left outer join Recurly.[dbo].[chartmogul_customers] as cm on ri.code = cm.external_id
where a.type = 'customer'
--and Round(case when ri.has_active_subscription = 1 and t0.PeriodLengthMonth = 0 then 0 when ri.has_active_subscription = 1 then t0.subtotal / t0.PeriodLengthMonth else 0 end, 2)!= (cm.mrr) / 100