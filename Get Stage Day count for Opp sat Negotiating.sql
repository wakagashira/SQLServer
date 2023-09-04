--Getting Rank 1
/*Getting the Stagename for the end stage*/ select t0.* ,t1.StageName as EndStage ,case when DATEDIFF(Day, t0.startdate,                        CASE                            WHEN t0.endDate IS NULL THEN  GETDATE() ELSE t0.endDate END) = 0 then .016 else DATEDIFF(Day, t0.startdate, CASE WHEN t0.endDate IS NULL THEN  GETDATE() ELSE t0.endDate END) end   AS HoursinStage
from ( /*Fining the most likely rank when the dates are the same for the end rank */ select a.*, Min(b.TheRank) as MinRank from (/*Finding the next stage date*/ select a.OpportunityId, a.stagename as StartStage, a.MaxProspectDate as startdate, min(b.MaxProspectDate) as endDate from Salesforce.dbo.MaxOppStageDate as a left Outer join Salesforce.dbo.MaxOppStageDate as b on a.OpportunityId = b.OpportunityId and a.MaxProspectDate <= b.MaxProspectDate /*This should change every new Path Stage*/ and 
b.TheRank > 1 where /*This should change every new Path Stage*/
a.TheRank= 1 group by a.OpportunityId, a.stagename , a.MaxProspectDate) as A left Outer join Salesforce.dbo.MaxOppStageDate as b on  a.OpportunityId = b.OpportunityId and 
b.TheRank > 1 and b.MaxProspectDate >= a.endDate group by a.OpportunityId,  a.StartStage, a.startdate, a.endDate ) as t0 Left outer join Salesforce.dbo.MaxOppStageDate as T1 on t0.OpportunityId = t1.OpportunityId and t0.endDate = t1.MaxProspectDate 
Union
--Getting Rank 2
/*Getting the Stagename for the end stage*/ select t0.* ,t1.StageName as EndStage ,case when DATEDIFF(Day, t0.startdate,                        CASE                            WHEN t0.endDate IS NULL THEN  GETDATE() ELSE t0.endDate END) = 0 then .016 else DATEDIFF(Day, t0.startdate, CASE WHEN t0.endDate IS NULL THEN  GETDATE() ELSE t0.endDate END) end   AS HoursinStage
from ( /*Fining the most likely rank when the dates are the same for the end rank */ select a.*, Min(b.TheRank) as MinRank from (/*Finding the next stage date*/ select a.OpportunityId, a.stagename as StartStage, a.MaxProspectDate as startdate, min(b.MaxProspectDate) as endDate from Salesforce.dbo.MaxOppStageDate as a left Outer join Salesforce.dbo.MaxOppStageDate as b on a.OpportunityId = b.OpportunityId and a.MaxProspectDate <= b.MaxProspectDate /*This should change every new Path Stage*/ and 
b.TheRank > 2 where /*This should change every new Path Stage*/
a.TheRank= 2 group by a.OpportunityId, a.stagename , a.MaxProspectDate) as A left Outer join Salesforce.dbo.MaxOppStageDate as b on  a.OpportunityId = b.OpportunityId and 
b.TheRank > 2 and b.MaxProspectDate >= a.endDate group by a.OpportunityId,  a.StartStage, a.startdate, a.endDate ) as t0 Left outer join Salesforce.dbo.MaxOppStageDate as T1 on t0.OpportunityId = t1.OpportunityId and t0.endDate = t1.MaxProspectDate 
Union
--Getting Rank 3
/*Getting the Stagename for the end stage*/ select t0.* ,t1.StageName as EndStage ,case when DATEDIFF(Day, t0.startdate,                        CASE                            WHEN t0.endDate IS NULL THEN  GETDATE() ELSE t0.endDate END) = 0 then .016 else DATEDIFF(Day, t0.startdate, CASE WHEN t0.endDate IS NULL THEN  GETDATE() ELSE t0.endDate END) end   AS HoursinStage
from ( /*Fining the most likely rank when the dates are the same for the end rank */ select a.*, Min(b.TheRank) as MinRank from (/*Finding the next stage date*/ select a.OpportunityId, a.stagename as StartStage, a.MaxProspectDate as startdate, min(b.MaxProspectDate) as endDate from Salesforce.dbo.MaxOppStageDate as a left Outer join Salesforce.dbo.MaxOppStageDate as b on a.OpportunityId = b.OpportunityId and a.MaxProspectDate <= b.MaxProspectDate /*This should change every new Path Stage*/ and 
b.TheRank > 3 where /*This should change every new Path Stage*/
a.TheRank= 3 group by a.OpportunityId, a.stagename , a.MaxProspectDate) as A left Outer join Salesforce.dbo.MaxOppStageDate as b on  a.OpportunityId = b.OpportunityId and 
b.TheRank > 3 and b.MaxProspectDate >= a.endDate group by a.OpportunityId,  a.StartStage, a.startdate, a.endDate ) as t0 Left outer join Salesforce.dbo.MaxOppStageDate as T1 on t0.OpportunityId = t1.OpportunityId and t0.endDate = t1.MaxProspectDate 
Union
--Getting Rank 4
/*Getting the Stagename for the end stage*/ select t0.* ,t1.StageName as EndStage ,case when DATEDIFF(Day, t0.startdate, CASE WHEN t0.endDate IS NULL THEN  GETDATE() ELSE t0.endDate END) = 0 then .016 else DATEDIFF(Day, t0.startdate, CASE WHEN t0.endDate IS NULL THEN  GETDATE() ELSE t0.endDate END) end   AS HoursinStage
from ( /*Fining the most likely rank when the dates are the same for the end rank */ select a.*, Min(b.TheRank) as MinRank from (/*Finding the next stage date*/ select a.OpportunityId, a.stagename as StartStage, a.MaxProspectDate as startdate, min(b.MaxProspectDate) as endDate from Salesforce.dbo.MaxOppStageDate as a left Outer join Salesforce.dbo.MaxOppStageDate as b on a.OpportunityId = b.OpportunityId and a.MaxProspectDate <= b.MaxProspectDate /*This should change every new Path Stage*/ and 
b.TheRank > 4 where /*This should change every new Path Stage*/
a.TheRank= 4 group by a.OpportunityId, a.stagename , a.MaxProspectDate) as A left Outer join Salesforce.dbo.MaxOppStageDate as b on  a.OpportunityId = b.OpportunityId and 
b.TheRank > 4 and b.MaxProspectDate >= a.endDate group by a.OpportunityId,  a.StartStage, a.startdate, a.endDate ) as t0 Left outer join Salesforce.dbo.MaxOppStageDate as T1 on t0.OpportunityId = t1.OpportunityId and t0.endDate = t1.MaxProspectDate 
Union
--Getting Rank 5
/*Getting the Stagename for the end stage*/ select t0.* ,t1.StageName as EndStage ,case when DATEDIFF(Day, t0.startdate,                        CASE                            WHEN t0.endDate IS NULL THEN  GETDATE() ELSE t0.endDate END) = 0 then .016 else DATEDIFF(Day, t0.startdate, CASE WHEN t0.endDate IS NULL THEN  GETDATE() ELSE t0.endDate END) end   AS HoursinStage
from ( /*Fining the most likely rank when the dates are the same for the end rank */ select a.*, Min(b.TheRank) as MinRank from (/*Finding the next stage date*/ select a.OpportunityId, a.stagename as StartStage, a.MaxProspectDate as startdate, min(b.MaxProspectDate) as endDate from Salesforce.dbo.MaxOppStageDate as a left Outer join Salesforce.dbo.MaxOppStageDate as b on a.OpportunityId = b.OpportunityId and a.MaxProspectDate <= b.MaxProspectDate /*This should change every new Path Stage*/ and 
b.TheRank > 5 where /*This should change every new Path Stage*/
a.TheRank= 5 group by a.OpportunityId, a.stagename , a.MaxProspectDate) as A left Outer join Salesforce.dbo.MaxOppStageDate as b on  a.OpportunityId = b.OpportunityId and 
b.TheRank > 5 and b.MaxProspectDate >= a.endDate group by a.OpportunityId,  a.StartStage, a.startdate, a.endDate ) as t0 Left outer join Salesforce.dbo.MaxOppStageDate as T1 on t0.OpportunityId = t1.OpportunityId and t0.endDate = t1.MaxProspectDate 
Union
--Getting Rank 6
/*Getting the Stagename for the end stage*/ select t0.* ,t1.StageName as EndStage ,case when DATEDIFF(Day, t0.startdate,                        CASE                            WHEN t0.endDate IS NULL THEN  GETDATE() ELSE t0.endDate END) = 0 then .016 else DATEDIFF(Day, t0.startdate, CASE WHEN t0.endDate IS NULL THEN  GETDATE() ELSE t0.endDate END) end   AS HoursinStage
from ( /*Fining the most likely rank when the dates are the same for the end rank */ select a.*, Min(b.TheRank) as MinRank from (/*Finding the next stage date*/ select a.OpportunityId, a.stagename as StartStage, a.MaxProspectDate as startdate, min(b.MaxProspectDate) as endDate from Salesforce.dbo.MaxOppStageDate as a left Outer join Salesforce.dbo.MaxOppStageDate as b on a.OpportunityId = b.OpportunityId and a.MaxProspectDate <= b.MaxProspectDate /*This should change every new Path Stage*/ and 
b.TheRank > 6 where /*This should change every new Path Stage*/
a.TheRank= 6 group by a.OpportunityId, a.stagename , a.MaxProspectDate) as A left Outer join Salesforce.dbo.MaxOppStageDate as b on  a.OpportunityId = b.OpportunityId and 
b.TheRank > 6 and b.MaxProspectDate >= a.endDate group by a.OpportunityId,  a.StartStage, a.startdate, a.endDate ) as t0 Left outer join Salesforce.dbo.MaxOppStageDate as T1 on t0.OpportunityId = t1.OpportunityId and t0.endDate = t1.MaxProspectDate 
Union
--Getting Rank 7
/*Getting the Stagename for the end stage*/ select t0.* ,t1.StageName as EndStage ,case when DATEDIFF(Day, t0.startdate,                        CASE                            WHEN t0.endDate IS NULL THEN  GETDATE() ELSE t0.endDate END) = 0 then .016 else DATEDIFF(Day, t0.startdate, CASE WHEN t0.endDate IS NULL THEN  GETDATE() ELSE t0.endDate END) end   AS HoursinStage
from ( /*Fining the most likely rank when the dates are the same for the end rank */ select a.*, Min(b.TheRank) as MinRank from (/*Finding the next stage date*/ select a.OpportunityId, a.stagename as StartStage, a.MaxProspectDate as startdate, min(b.MaxProspectDate) as endDate from Salesforce.dbo.MaxOppStageDate as a left Outer join Salesforce.dbo.MaxOppStageDate as b on a.OpportunityId = b.OpportunityId and a.MaxProspectDate <= b.MaxProspectDate /*This should change every new Path Stage*/ and 
b.TheRank > 7 where /*This should change every new Path Stage*/
a.TheRank= 7 group by a.OpportunityId, a.stagename , a.MaxProspectDate) as A left Outer join Salesforce.dbo.MaxOppStageDate as b on  a.OpportunityId = b.OpportunityId and 
b.TheRank > 7 and b.MaxProspectDate >= a.endDate group by a.OpportunityId,  a.StartStage, a.startdate, a.endDate ) as t0 Left outer join Salesforce.dbo.MaxOppStageDate as T1 on t0.OpportunityId = t1.OpportunityId and t0.endDate = t1.MaxProspectDate 
Union
--Getting Rank 8
/*Getting the Stagename for the end stage*/ select t0.* ,t1.StageName as EndStage ,case when DATEDIFF(Day, t0.startdate,                        CASE                            WHEN t0.endDate IS NULL THEN  GETDATE() ELSE t0.endDate END) = 0 then .016 else DATEDIFF(Day, t0.startdate, CASE WHEN t0.endDate IS NULL THEN  GETDATE() ELSE t0.endDate END) end   AS HoursinStage
from ( /*Fining the most likely rank when the dates are the same for the end rank */ select a.*, Min(b.TheRank) as MinRank from (/*Finding the next stage date*/ select a.OpportunityId, a.stagename as StartStage, a.MaxProspectDate as startdate, min(b.MaxProspectDate) as endDate from Salesforce.dbo.MaxOppStageDate as a left Outer join Salesforce.dbo.MaxOppStageDate as b on a.OpportunityId = b.OpportunityId and a.MaxProspectDate <= b.MaxProspectDate /*This should change every new Path Stage*/ and 
b.TheRank > 8 where /*This should change every new Path Stage*/
a.TheRank= 8 group by a.OpportunityId, a.stagename , a.MaxProspectDate) as A left Outer join Salesforce.dbo.MaxOppStageDate as b on  a.OpportunityId = b.OpportunityId and 
b.TheRank > 8 and b.MaxProspectDate >= a.endDate group by a.OpportunityId,  a.StartStage, a.startdate, a.endDate ) as t0 Left outer join Salesforce.dbo.MaxOppStageDate as T1 on t0.OpportunityId = t1.OpportunityId and t0.endDate = t1.MaxProspectDate 
Union
--Getting Rank 9
/*Getting the Stagename for the end stage*/ select t0.* ,t1.StageName as EndStage ,case when DATEDIFF(Day, t0.startdate,                        CASE                            WHEN t0.endDate IS NULL THEN  GETDATE() ELSE t0.endDate END) = 0 then .016 else DATEDIFF(Day, t0.startdate, CASE WHEN t0.endDate IS NULL THEN  GETDATE() ELSE t0.endDate END) end   AS HoursinStage
from ( /*Fining the most likely rank when the dates are the same for the end rank */ select a.*, Min(b.TheRank) as MinRank from (/*Finding the next stage date*/ select a.OpportunityId, a.stagename as StartStage, a.MaxProspectDate as startdate, min(b.MaxProspectDate) as endDate from Salesforce.dbo.MaxOppStageDate as a left Outer join Salesforce.dbo.MaxOppStageDate as b on a.OpportunityId = b.OpportunityId and a.MaxProspectDate <= b.MaxProspectDate /*This should change every new Path Stage*/ and 
b.TheRank > 9 where /*This should change every new Path Stage*/
a.TheRank= 9 group by a.OpportunityId, a.stagename , a.MaxProspectDate) as A left Outer join Salesforce.dbo.MaxOppStageDate as b on  a.OpportunityId = b.OpportunityId and 
b.TheRank > 9 and b.MaxProspectDate >= a.endDate group by a.OpportunityId,  a.StartStage, a.startdate, a.endDate ) as t0 Left outer join Salesforce.dbo.MaxOppStageDate as T1 on t0.OpportunityId = t1.OpportunityId and t0.endDate = t1.MaxProspectDate 
Union
--Getting Rank 10
/*Getting the Stagename for the end stage*/ select t0.* ,t1.StageName as EndStage ,case when DATEDIFF(Day, t0.startdate,                        CASE                            WHEN t0.endDate IS NULL THEN  GETDATE() ELSE t0.endDate END) = 0 then .016 else DATEDIFF(Day, t0.startdate, CASE WHEN t0.endDate IS NULL THEN  GETDATE() ELSE t0.endDate END) end   AS HoursinStage
from ( /*Fining the most likely rank when the dates are the same for the end rank */ select a.*, Min(b.TheRank) as MinRank from (/*Finding the next stage date*/ select a.OpportunityId, a.stagename as StartStage, a.MaxProspectDate as startdate, min(b.MaxProspectDate) as endDate from Salesforce.dbo.MaxOppStageDate as a left Outer join Salesforce.dbo.MaxOppStageDate as b on a.OpportunityId = b.OpportunityId and a.MaxProspectDate <= b.MaxProspectDate /*This should change every new Path Stage*/ and 
b.TheRank > 10 where /*This should change every new Path Stage*/
a.TheRank= 10 group by a.OpportunityId, a.stagename , a.MaxProspectDate) as A left Outer join Salesforce.dbo.MaxOppStageDate as b on  a.OpportunityId = b.OpportunityId and 
b.TheRank > 10 and b.MaxProspectDate >= a.endDate group by a.OpportunityId,  a.StartStage, a.startdate, a.endDate ) as t0 Left outer join Salesforce.dbo.MaxOppStageDate as T1 on t0.OpportunityId = t1.OpportunityId and t0.endDate = t1.MaxProspectDate 
union
--Getting Rank 11
/*Getting the Stagename for the end stage*/ select t0.* ,t1.StageName as EndStage ,case when DATEDIFF(Day, t0.startdate,                        CASE                            WHEN t0.endDate IS NULL THEN  GETDATE() ELSE t0.endDate END) = 0 then .016 else DATEDIFF(Day, t0.startdate, CASE WHEN t0.endDate IS NULL THEN  GETDATE() ELSE t0.endDate END) end   AS HoursinStage
from ( /*Fining the most likely rank when the dates are the same for the end rank */ select a.*, Min(b.TheRank) as MinRank from (/*Finding the next stage date*/ select a.OpportunityId, a.stagename as StartStage, a.MaxProspectDate as startdate, min(b.MaxProspectDate) as endDate from Salesforce.dbo.MaxOppStageDate as a left Outer join Salesforce.dbo.MaxOppStageDate as b on a.OpportunityId = b.OpportunityId and a.MaxProspectDate <= b.MaxProspectDate /*This should change every new Path Stage*/ and 
b.TheRank > 11 where /*This should change every new Path Stage*/
a.TheRank= 11 group by a.OpportunityId, a.stagename , a.MaxProspectDate) as A left Outer join Salesforce.dbo.MaxOppStageDate as b on  a.OpportunityId = b.OpportunityId and 
b.TheRank > 11 and b.MaxProspectDate >= a.endDate group by a.OpportunityId,  a.StartStage, a.startdate, a.endDate ) as t0 Left outer join Salesforce.dbo.MaxOppStageDate as T1 on t0.OpportunityId = t1.OpportunityId and t0.endDate = t1.MaxProspectDate 
union
--Getting Rank 12
/*Getting the Stagename for the end stage*/ select t0.* ,t1.StageName as EndStage ,case when DATEDIFF(Day, t0.startdate,                        CASE                            WHEN t0.endDate IS NULL THEN  GETDATE() ELSE t0.endDate END) = 0 then .016 else DATEDIFF(Day, t0.startdate, CASE WHEN t0.endDate IS NULL THEN  GETDATE() ELSE t0.endDate END) end   AS HoursinStage
from ( /*Fining the most likely rank when the dates are the same for the end rank */ select a.*, Min(b.TheRank) as MinRank from (/*Finding the next stage date*/ select a.OpportunityId, a.stagename as StartStage, a.MaxProspectDate as startdate, min(b.MaxProspectDate) as endDate from Salesforce.dbo.MaxOppStageDate as a left Outer join Salesforce.dbo.MaxOppStageDate as b on a.OpportunityId = b.OpportunityId and a.MaxProspectDate <= b.MaxProspectDate /*This should change every new Path Stage*/ and 
b.TheRank > 12 where /*This should change every new Path Stage*/
a.TheRank= 12 group by a.OpportunityId, a.stagename , a.MaxProspectDate) as A left Outer join Salesforce.dbo.MaxOppStageDate as b on  a.OpportunityId = b.OpportunityId and 
b.TheRank > 12 and b.MaxProspectDate >= a.endDate group by a.OpportunityId,  a.StartStage, a.startdate, a.endDate ) as t0 Left outer join Salesforce.dbo.MaxOppStageDate as T1 on t0.OpportunityId = t1.OpportunityId and t0.endDate = t1.MaxProspectDate 
union
--Getting Rank 13
/*Getting the Stagename for the end stage*/ select t0.* ,t1.StageName as EndStage ,case when DATEDIFF(Day, t0.startdate,                        CASE                            WHEN t0.endDate IS NULL THEN  GETDATE() ELSE t0.endDate END) = 0 then .016 else DATEDIFF(Day, t0.startdate, CASE WHEN t0.endDate IS NULL THEN  GETDATE() ELSE t0.endDate END) end   AS HoursinStage
from ( /*Fining the most likely rank when the dates are the same for the end rank */ select a.*, Min(b.TheRank) as MinRank from (/*Finding the next stage date*/ select a.OpportunityId, a.stagename as StartStage, a.MaxProspectDate as startdate, min(b.MaxProspectDate) as endDate from Salesforce.dbo.MaxOppStageDate as a left Outer join Salesforce.dbo.MaxOppStageDate as b on a.OpportunityId = b.OpportunityId and a.MaxProspectDate <= b.MaxProspectDate /*This should change every new Path Stage*/ and 
b.TheRank > 13 where /*This should change every new Path Stage*/
a.TheRank= 13 group by a.OpportunityId, a.stagename , a.MaxProspectDate) as A left Outer join Salesforce.dbo.MaxOppStageDate as b on  a.OpportunityId = b.OpportunityId and 
b.TheRank > 13 and b.MaxProspectDate >= a.endDate group by a.OpportunityId,  a.StartStage, a.startdate, a.endDate ) as t0 Left outer join Salesforce.dbo.MaxOppStageDate as T1 on t0.OpportunityId = t1.OpportunityId and t0.endDate = t1.MaxProspectDate 
union
--Getting Rank 14
/*Getting the Stagename for the end stage*/ select t0.* ,t1.StageName as EndStage ,case when DATEDIFF(Day, t0.startdate,                        CASE                            WHEN t0.endDate IS NULL THEN  GETDATE() ELSE t0.endDate END) = 0 then .016 else DATEDIFF(Day, t0.startdate, CASE WHEN t0.endDate IS NULL THEN  GETDATE() ELSE t0.endDate END) end   AS HoursinStage
from ( /*Fining the most likely rank when the dates are the same for the end rank */ select a.*, Min(b.TheRank) as MinRank from (/*Finding the next stage date*/ select a.OpportunityId, a.stagename as StartStage, a.MaxProspectDate as startdate, min(b.MaxProspectDate) as endDate from Salesforce.dbo.MaxOppStageDate as a left Outer join Salesforce.dbo.MaxOppStageDate as b on a.OpportunityId = b.OpportunityId and a.MaxProspectDate <= b.MaxProspectDate /*This should change every new Path Stage*/ and 
b.TheRank > 14 where /*This should change every new Path Stage*/
a.TheRank= 14 group by a.OpportunityId, a.stagename , a.MaxProspectDate) as A left Outer join Salesforce.dbo.MaxOppStageDate as b on  a.OpportunityId = b.OpportunityId and 
b.TheRank > 14 and b.MaxProspectDate >= a.endDate group by a.OpportunityId,  a.StartStage, a.startdate, a.endDate ) as t0 Left outer join Salesforce.dbo.MaxOppStageDate as T1 on t0.OpportunityId = t1.OpportunityId and t0.endDate = t1.MaxProspectDate 
ORDER by OpportunityId, startdate