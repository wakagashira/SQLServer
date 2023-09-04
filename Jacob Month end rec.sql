/*** Get All Items with a match for both CM and SF ***/

SELECT 
REPLACE(opp.name, ' - New Biz', '') strippedName,
cm.company,
opp.extid,
opp.Accountid as sfid,
Opp.OppId,
opp.OwnerId,
opp.Amount as SFMRR,
Cm.[mrr] / 100 as CMMRR,
case when opp.Amount is null then 'Add Opp To Salesforce'
when Cm.[mrr] is null then 'Check Recurly'
When opp.Amount - (Cm.[mrr] / 100) = 20 then 'Add License Fee'
when opp.Amount < (Cm.[mrr] / 100) then 'Check Salesforce'
when opp.Amount > (Cm.[mrr] / 100) then 'Recurly Less then Salesforce'
else 'All Good' end as  Issue
--cm.[id], cm.[company]
  FROM openquery(SFWA , 'select r.name as extId, a.ID as AccountId , o.OwnerId, a.Recurly_External_ID__c, o.id as OppId, o.Name, o.TotalOpportunityQuantity as Quantity, o.Amount, o.CloseDate 
  from opportunity as o 
  inner join Account as a on o.accountid = a.id
  Left outer join recurly_v2__Recurly_Account__c as r on a.id = r.	recurly_v2__Account__c
  where o.closedate between ''12-01-2022'' and ''12-31-2022'' and  
  	o.StageName in (''Closed Won'', ''Ready To Close'', ''Docs Requested'')
  and o.type in (''New Business'', ''CS - New Biz'')
  and o.name not like ''***%''
  and a.Name not like ''***%''
  ') as opp
Left outer join [Recurly].[dbo].[chartmogul_customers] as cm on (opp.extId = cm.external_id or REPLACE(opp.name, ' - New Biz', '') = cm.company)  and convert(date, cm.customer_since) between '2022-12-01' and '2022-12-31'
union 
/**** Get All items that are only in CM ****/
SELECT 
REPLACE(opp.name, ' - New Biz', '') strippedName,
cm.company,
opp.extid,
opp.Accountid as sfid,
Opp.OppId,
opp.OwnerId,
opp.Amount as SFMRR,
Cm.[mrr] / 100 as CMMRR,
case when opp.Amount is null then 'Add Opp To Salesforce'
when Cm.[mrr] is null then 'Check Recurly'
When opp.Amount - (Cm.[mrr] / 100) = 20 then 'Add License Fee'
when opp.Amount < (Cm.[mrr] / 100) then 'Check Salesforce'
when opp.Amount > (Cm.[mrr] / 100) then 'Recurly Less then Salesforce'
else 'All Good' end as  Issue
  FROM 
  [Recurly].[dbo].[chartmogul_customers] as cm
  left outer join openquery(SFWA , 'select r.name as extId, a.ID as AccountId , o.OwnerId, a.Recurly_External_ID__c, o.id as OppId, o.Name, o.TotalOpportunityQuantity as Quantity, o.Amount, o.CloseDate 
  from opportunity as o 
  inner join Account as a on o.accountid = a.id
  Left outer join recurly_v2__Recurly_Account__c as r on a.id = r.	recurly_v2__Account__c
  where o.closedate between ''12-01-2022'' and ''12-31-2022'' and  
  	o.StageName in (''Closed Won'', ''Ready To Close'', ''Docs Requested'')
  and o.type in (''New Business'', ''CS - New Biz'')
  and o.name not like ''***%''
  and a.Name not like ''***%''
  ') as opp on (cm.external_id = opp.extId or cm.company = REPLACE(opp.name, ' - New Biz', '')  )
  
  where  convert(date, cm.customer_since) between '2022-12-01' and '2022-12-31' and opp.Accountid is null 


