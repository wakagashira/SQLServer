select a.*, b.StageName as endstage 
from 
(select a.OpportunityId, 
a.stagename as StartStage, 
a.MinProspectDate as startdate, 
min(b.MinProspectDate) as endDate
from Salesforce.dbo.MaxOppStageDate as a
left Outer join Salesforce.dbo.MaxOppStageDate as b on a.OpportunityId = b.OpportunityId and a.MinProspectDate <= b.MinProspectDate and b.StageName != 'Prospect'
where a.stagename = 'Prospect'
--and a.OpportunityId = '0064600000I5xeSAAR'
group by a.OpportunityId, 
a.stagename , 
a.MinProspectDate) as A
left Outer join Salesforce.dbo.MaxOppStageDate as b on 
a.OpportunityId = b.OpportunityId 
and b.StageName != 'Prospect' 
and b.MinProspectDate = a.endDate