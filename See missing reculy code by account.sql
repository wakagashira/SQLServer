SELECT a.code,
		sfa.id,
		s.accountId, 
       s.id AS recSubId, 
       s.total, 
       s.subtotal, 
       s.currency, 
       DATEDIFF(Month, s.current_term_started_at, s.current_term_ends_at) AS ContractTermLengthMonth, 
       DATEDIFF(Month, s.current_period_started_at, s.current_period_ends_at) AS PeriodLengthMonth
FROM recurly.dbo.recurly_subscriptions as s
left outer join recurly.dbo.recurly_accounts as a on s.accountid = a.id
Left outer join Salesforce.dbo.account as sfa on a.code = sfa.Recurly_External_ID__c
WHERE(s.state = 'active')
and sfa.id  is null ;