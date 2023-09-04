--Getting Rank 3
--Getting the Stagename for the end stage
select t0.*
,t1.StageName as EndStage
,case when DATEDIFF(day, t0.startdate,
                       CASE
                           WHEN t0.endDate IS NULL
                           THEN  GETDATE()
                           ELSE t0.endDate
                       END) = 0 then .016 else DATEDIFF(HOUR, t0.startdate,
                       CASE
                           WHEN t0.endDate IS NULL
                           THEN  GETDATE()
                           ELSE t0.endDate
                       END) end   AS HoursinStage
from
(
--Fining the most likely rank when the dates are the same for the end rank 
select a.*, Min(b.TheRank) as MinRank
from 
(
--Finding the next stage date
select a.OpportunityId, 
a.stagename as StartStage, 
a.MaxProspectDate as startdate, 
min(b.MaxProspectDate) as endDate
from Salesforce.dbo.MaxOppStageDate as a
left Outer join Salesforce.dbo.MaxOppStageDate as b on a.OpportunityId = b.OpportunityId 
and a.MaxProspectDate <= b.MaxProspectDate 
--This should change every new Path Stage
and b.TheRank > 3
where
--This should change every new Path Stage
a.TheRank= 3
--and a.OpportunityId = '0064p00000XmgPEAAZ'
group by a.OpportunityId, 
a.stagename , 
a.MaxProspectDate) as A
left Outer join Salesforce.dbo.MaxOppStageDate as b on 
a.OpportunityId = b.OpportunityId 
--This should change every new Path Stage
and b.TheRank > 3 
and b.MaxProspectDate >= a.endDate
group by a.OpportunityId, 
a.StartStage,
a.startdate,
a.endDate
) as t0
Left outer join Salesforce.dbo.MaxOppStageDate as T1 on 
t0.OpportunityId = t1.OpportunityId and t0.endDate = t1.MaxProspectDate --and t0.MinRank = t1.TheRank
--where t0.OpportunityId = '0064p00000WBsi0AAD'