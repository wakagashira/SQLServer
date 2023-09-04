SELECT distinct 
-- p. is pardot all others are salesforce
p.id as PardotId, --pardot unique id
p.CrmAccountFid, --Pardots Account if know in Pardot 
case when a.id is not null then a.id 
when c.AccountId is not null then c.AccountId
when l.Account__c is not null then l.Account__c
when l.ConvertedAccountId is not null then l.ConvertedAccountId  
else null end as SFAcctid,
p.CrmLeadFid,
l.id as SFLeadId,
p.CrmContactFid,
c.id as ContactId,
p.Email,
p.Score,
case when p.score between 10 and 49 then 'Warm' when p.score > 49 then 'Hot' else 'Cold' end as TempStatus  --This is not 100 solid and may change in the future.
  FROM [Salesforce].[dbo].[Pardot_Prospects] as p
 left outer join  Salesforce.dbo.lead as l on p.CrmLeadFid = l.id
  left outer join Salesforce.dbo.CampaignMember as cm on p.CrmLeadFid = cm.LeadId
  left outer join  Salesforce.dbo.Contact as c on p.Email = c.Email
  Left outer join Salesforce.dbo.account as a on l.Account__c = a.id or c.AccountId = a.id 
  where 
  --(p.crmleadfid is not null or (CrmContactFid is not null and p.CrmContactFid like '003%' ))
  p.score >0
 -- and CrmLeadFid = '00Q4600000Lo9A7EAJ'
  --and p.Email = 'mlee@apolloperforators.com'  
	--and case when c.accountid is not null then c.accountid when l.Account__c is not null then l.Account__c when l.ConvertedAccountId is not null then l.ConvertedAccountId when cm.LeadId is not null then cm.leadid when cm.Lead_For_Reports__c is not null then cm.Lead_For_Reports__c end is not null 

  
