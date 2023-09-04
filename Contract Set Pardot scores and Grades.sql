select  t0.ContactId,
Max(t0.score) as Score,
Min(t0.grade) as maxGrade,
case when isnull(max(score), 0) = 0 then 'Unaware' when max(score) between 1 and 9 then 'Aware' when max(score) between 10 and 24 then 'Interested' when max(score) between 25 and 49 then 'Considering' when max(score) >=50 then 'Deciding' end as PardotScoringStatus,
case when isnull(max(T0.score), 0) = 0 or isnull(Min(T0.grade), 'F') in ('F-', 'F', 'F+') then Null 
when max(T0.score) between 1 and 9 and Min(T0.grade) in ('D-', 'D', 'D+', 'C-', 'C', 'C+') then 'Known' 
when max(T0.score) between 1 and 9 and Min(T0.grade) in ('B-', 'B', 'B+', 'A') then 'Inquiry'
when max(T0.score) between 10 and 24 and Min(T0.grade) in ('D-', 'D', 'D+', 'C-', 'C', 'C+', 'B-', 'B', 'B+') then 'Inquiry'
when max(T0.score) between 10 and 24 and Min(T0.grade) = 'A' then 'Engaged'
when max(T0.score) between 25 and 49 and Min(T0.grade) in ('D-', 'D', 'D+', 'C-', 'C', 'C+') then 'Inquiry'
when max(T0.score) between 25 and 49 and Min(T0.grade) in ('B-', 'B', 'B+', 'A-', 'A', 'A+') then 'Engaged'
when max(T0.score) > 49 and Min(T0.grade) in ('D-', 'D', 'D+') then 'Inquiry'
when max(T0.score) > 49 and Min(T0.grade) in ('C-', 'C', 'C+', 'B-', 'B', 'B+', 'A-', 'A', 'A+') then 'MQL' end as PardotMatrix,
case when isnull(Max(T0.score), 0) < 1 then 'Cold' 
when Max(T0.score) between 1 and 9 then 'Room Temperature' 
when Max(T0.score) between 10 and 24 then 'Warm' 
when Max(T0.score) between 25 and 49 then 'Hot'
when Max(T0.score) > 49 then 'Boiling' end as PardotTemperature
from(
SELECT distinct 
p.id as PardotId,
CrmAccountFid,
case when a.id is not null then a.id 
when c.AccountId is not null then c.AccountId
when l.Account__c is not null then l.Account__c
when l.ConvertedAccountId is not null then l.ConvertedAccountId
else null end as SFAcctid,
CrmLeadFid,
l.id as SFLeadId,
CrmContactFid,
c.id as ContactId,
p.Email,
p.grade,
p.Score,
case when isnull(p.score, 0) = 0 then 'Unaware' when p.score between 1 and 9 then 'Aware' when p.score between 10 and 24 then 'Interested' when p.score between 25 and 49 then 'Considering' when p.score >=50 then 'Deciding' end as PardotScoringStatus,
case when isnull(p.score, 0) = 0 or isnull(p.Grade, 'F') in ('F-', 'F', 'F+') then Null 
when p.score between 1 and 9 and p.Grade in ('D-', 'D', 'D+', 'C-', 'C', 'C+') then 'Known' 
when p.score between 1 and 9 and p.Grade in ('B-', 'B', 'B+', 'A') then 'Inquiry'
when p.score between 10 and 24 and p.Grade in ('D-', 'D', 'D+', 'C-', 'C', 'C+', 'B-', 'B', 'B+') then 'Inquiry'
when p.score between 10 and 24 and p.Grade = 'A' then 'Engaged'
when p.score between 25 and 49 and p.Grade in ('D-', 'D', 'D+', 'C-', 'C', 'C+') then 'Inquiry'
when p.score between 25 and 49 and p.Grade in ('B-', 'B', 'B+', 'A-', 'A', 'A+') then 'Engaged'
when p.score > 49 and p.Grade in ('D-', 'D', 'D+') then 'Inquiry'
when p.score > 49 and p.Grade in ('C-', 'C', 'C+', 'B-', 'B', 'B+', 'A-', 'A', 'A+') then 'MQL' end as PardotMatrix,
case when isnull(p.score, 0) < 1 then 'Cold' 
when p.score between 1 and 9 then 'Room Temperature' 
when p.score between 10 and 24 then 'Warm' 
when p.score between 25 and 49 then 'Hot'
when p.score > 49 then 'Boiling' end as PardotTemperature
  FROM [Salesforce].[dbo].[Pardot_Prospects] as p
  left outer join  Salesforce.dbo.lead as l on p.CrmLeadFid = l.id
  left outer join Salesforce.dbo.CampaignMember as cm on p.CrmLeadFid = cm.LeadId
  left outer join  Salesforce.dbo.Contact as c on p.Email = c.Email
  Left outer join Salesforce.dbo.account as a on l.Account__c = a.id or c.AccountId = a.id 
  where 
c.id is not null
and isnull(p.score, 0) >0  -- This is to limit the Nulls 
	) as T0 
--where SFAcctid = '0014p00001sffSKAAY'
group by t0.ContactId
--order by count(grade) desc