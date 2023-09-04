/*Next step pivot starting stage */
--Sum up the pivot to one Line per Oppid
select OpportunityId,
cast(isnull(sum([Prospect]), 0) as int) as [Prospect],
cast(isnull(sum([Waiting to Book]), 0) as int) as [Waiting to Book],
cast(isnull(sum([Qualified]), 0) as int) as [Qualified],
cast(isnull(sum([Demo Booked]), 0) as int) as [Demo Booked],
cast(isnull(sum([Demos]), 0) as int) as [Demos],
cast(isnull(sum([Sat - Presented]), 0) as int) as [Sat - Presented],
cast(isnull(sum([Sat - Negotiating]), 0) as int) as [Sat - Negotiating],
cast(isnull(sum([Negotiation]), 0) as int) as [Negotiation],
cast(isnull(sum([Pilot]), 0) as int) as [Pilot],
cast(isnull(sum([No Sit]), 0) as int) as [No Sit],
cast(isnull(sum([Some Interest]), 0) as int) as [Some Interest],
cast(isnull(sum([High Interest]), 0) as int) as [High Interest],
cast(isnull(sum([Contract]), 0) as int) as [Contract],
cast(isnull(sum([Docs Requested]), 0) as int) as [Docs Requested],
cast(isnull(sum([Ready To Close]), 0) as int)  as [Ready To Close]
from (
--create Pivot table 
select OpportunityId, 
[Contract],
[Demo Booked],
[Demos],
[Docs Requested],
[High Interest],
[Negotiation],
[No Sit],
[Pilot],
[Prospect],
[Qualified],
[Ready To Close],
[Sat - Negotiating],
[Sat - Presented],
[Some Interest],
[Waiting to Book]

From(
--Getting Rank 1
/*Getting the Stagename for the end stage*/ select t0.* ,t1.StageName as EndStage ,case when DATEDIFF(Day, t0.startdate,                        CASE                            WHEN t0.endDate IS NULL THEN  GETDATE() ELSE t0.endDate END) = 0 then .016 else DATEDIFF(Day, t0.startdate, CASE WHEN t0.endDate IS NULL THEN  GETDATE() ELSE t0.endDate END) end   AS DaysInStage
from ( /*Fining the most likely rank when the dates are the same for the end rank */ select a.*, Min(b.TheRank) as MinRank from (/*Finding the next stage date*/ select a.OpportunityId, a.stagename as StartStage, a.MaxProspectDate as startdate, min(b.MaxProspectDate) as endDate from Salesforce.dbo.MaxOppStageDate as a left Outer join Salesforce.dbo.MaxOppStageDate as b on a.OpportunityId = b.OpportunityId and a.MaxProspectDate <= b.MaxProspectDate /*This should change every new Path Stage*/ and 
b.TheRank > 1 where /*This should change every new Path Stage*/
a.TheRank= 1 group by a.OpportunityId, a.stagename , a.MaxProspectDate) as A left Outer join Salesforce.dbo.MaxOppStageDate as b on  a.OpportunityId = b.OpportunityId and 
b.TheRank > 1 and b.MaxProspectDate >= a.endDate group by a.OpportunityId,  a.StartStage, a.startdate, a.endDate ) as t0 Left outer join Salesforce.dbo.MaxOppStageDate as T1 on t0.OpportunityId = t1.OpportunityId and t0.endDate = t1.MaxProspectDate 
Union
--Getting Rank 2
/*Getting the Stagename for the end stage*/ select t0.* ,t1.StageName as EndStage ,case when DATEDIFF(Day, t0.startdate,                        CASE                            WHEN t0.endDate IS NULL THEN  GETDATE() ELSE t0.endDate END) = 0 then .016 else DATEDIFF(Day, t0.startdate, CASE WHEN t0.endDate IS NULL THEN  GETDATE() ELSE t0.endDate END) end   AS DaysInStage
from ( /*Fining the most likely rank when the dates are the same for the end rank */ select a.*, Min(b.TheRank) as MinRank from (/*Finding the next stage date*/ select a.OpportunityId, a.stagename as StartStage, a.MaxProspectDate as startdate, min(b.MaxProspectDate) as endDate from Salesforce.dbo.MaxOppStageDate as a left Outer join Salesforce.dbo.MaxOppStageDate as b on a.OpportunityId = b.OpportunityId and a.MaxProspectDate <= b.MaxProspectDate /*This should change every new Path Stage*/ and 
b.TheRank > 2 where /*This should change every new Path Stage*/
a.TheRank= 2 group by a.OpportunityId, a.stagename , a.MaxProspectDate) as A left Outer join Salesforce.dbo.MaxOppStageDate as b on  a.OpportunityId = b.OpportunityId and 
b.TheRank > 2 and b.MaxProspectDate >= a.endDate group by a.OpportunityId,  a.StartStage, a.startdate, a.endDate ) as t0 Left outer join Salesforce.dbo.MaxOppStageDate as T1 on t0.OpportunityId = t1.OpportunityId and t0.endDate = t1.MaxProspectDate 
Union
--Getting Rank 3
/*Getting the Stagename for the end stage*/ select t0.* ,t1.StageName as EndStage ,case when DATEDIFF(Day, t0.startdate,                        CASE                            WHEN t0.endDate IS NULL THEN  GETDATE() ELSE t0.endDate END) = 0 then .016 else DATEDIFF(Day, t0.startdate, CASE WHEN t0.endDate IS NULL THEN  GETDATE() ELSE t0.endDate END) end   AS DaysInStage
from ( /*Fining the most likely rank when the dates are the same for the end rank */ select a.*, Min(b.TheRank) as MinRank from (/*Finding the next stage date*/ select a.OpportunityId, a.stagename as StartStage, a.MaxProspectDate as startdate, min(b.MaxProspectDate) as endDate from Salesforce.dbo.MaxOppStageDate as a left Outer join Salesforce.dbo.MaxOppStageDate as b on a.OpportunityId = b.OpportunityId and a.MaxProspectDate <= b.MaxProspectDate /*This should change every new Path Stage*/ and 
b.TheRank > 3 where /*This should change every new Path Stage*/
a.TheRank= 3 group by a.OpportunityId, a.stagename , a.MaxProspectDate) as A left Outer join Salesforce.dbo.MaxOppStageDate as b on  a.OpportunityId = b.OpportunityId and 
b.TheRank > 3 and b.MaxProspectDate >= a.endDate group by a.OpportunityId,  a.StartStage, a.startdate, a.endDate ) as t0 Left outer join Salesforce.dbo.MaxOppStageDate as T1 on t0.OpportunityId = t1.OpportunityId and t0.endDate = t1.MaxProspectDate 
Union
--Getting Rank 4
/*Getting the Stagename for the end stage*/ select t0.* ,t1.StageName as EndStage ,case when DATEDIFF(Day, t0.startdate, CASE WHEN t0.endDate IS NULL THEN  GETDATE() ELSE t0.endDate END) = 0 then .016 else DATEDIFF(Day, t0.startdate, CASE WHEN t0.endDate IS NULL THEN  GETDATE() ELSE t0.endDate END) end   AS DaysInStage
from ( /*Fining the most likely rank when the dates are the same for the end rank */ select a.*, Min(b.TheRank) as MinRank from (/*Finding the next stage date*/ select a.OpportunityId, a.stagename as StartStage, a.MaxProspectDate as startdate, min(b.MaxProspectDate) as endDate from Salesforce.dbo.MaxOppStageDate as a left Outer join Salesforce.dbo.MaxOppStageDate as b on a.OpportunityId = b.OpportunityId and a.MaxProspectDate <= b.MaxProspectDate /*This should change every new Path Stage*/ and 
b.TheRank > 4 where /*This should change every new Path Stage*/
a.TheRank= 4 group by a.OpportunityId, a.stagename , a.MaxProspectDate) as A left Outer join Salesforce.dbo.MaxOppStageDate as b on  a.OpportunityId = b.OpportunityId and 
b.TheRank > 4 and b.MaxProspectDate >= a.endDate group by a.OpportunityId,  a.StartStage, a.startdate, a.endDate ) as t0 Left outer join Salesforce.dbo.MaxOppStageDate as T1 on t0.OpportunityId = t1.OpportunityId and t0.endDate = t1.MaxProspectDate 
Union
--Getting Rank 5
/*Getting the Stagename for the end stage*/ select t0.* ,t1.StageName as EndStage ,case when DATEDIFF(Day, t0.startdate,                        CASE                            WHEN t0.endDate IS NULL THEN  GETDATE() ELSE t0.endDate END) = 0 then .016 else DATEDIFF(Day, t0.startdate, CASE WHEN t0.endDate IS NULL THEN  GETDATE() ELSE t0.endDate END) end   AS DaysInStage
from ( /*Fining the most likely rank when the dates are the same for the end rank */ select a.*, Min(b.TheRank) as MinRank from (/*Finding the next stage date*/ select a.OpportunityId, a.stagename as StartStage, a.MaxProspectDate as startdate, min(b.MaxProspectDate) as endDate from Salesforce.dbo.MaxOppStageDate as a left Outer join Salesforce.dbo.MaxOppStageDate as b on a.OpportunityId = b.OpportunityId and a.MaxProspectDate <= b.MaxProspectDate /*This should change every new Path Stage*/ and 
b.TheRank > 5 where /*This should change every new Path Stage*/
a.TheRank= 5 group by a.OpportunityId, a.stagename , a.MaxProspectDate) as A left Outer join Salesforce.dbo.MaxOppStageDate as b on  a.OpportunityId = b.OpportunityId and 
b.TheRank > 5 and b.MaxProspectDate >= a.endDate group by a.OpportunityId,  a.StartStage, a.startdate, a.endDate ) as t0 Left outer join Salesforce.dbo.MaxOppStageDate as T1 on t0.OpportunityId = t1.OpportunityId and t0.endDate = t1.MaxProspectDate 
Union
--Getting Rank 6
/*Getting the Stagename for the end stage*/ select t0.* ,t1.StageName as EndStage ,case when DATEDIFF(Day, t0.startdate,                        CASE                            WHEN t0.endDate IS NULL THEN  GETDATE() ELSE t0.endDate END) = 0 then .016 else DATEDIFF(Day, t0.startdate, CASE WHEN t0.endDate IS NULL THEN  GETDATE() ELSE t0.endDate END) end   AS DaysInStage
from ( /*Fining the most likely rank when the dates are the same for the end rank */ select a.*, Min(b.TheRank) as MinRank from (/*Finding the next stage date*/ select a.OpportunityId, a.stagename as StartStage, a.MaxProspectDate as startdate, min(b.MaxProspectDate) as endDate from Salesforce.dbo.MaxOppStageDate as a left Outer join Salesforce.dbo.MaxOppStageDate as b on a.OpportunityId = b.OpportunityId and a.MaxProspectDate <= b.MaxProspectDate /*This should change every new Path Stage*/ and 
b.TheRank > 6 where /*This should change every new Path Stage*/
a.TheRank= 6 group by a.OpportunityId, a.stagename , a.MaxProspectDate) as A left Outer join Salesforce.dbo.MaxOppStageDate as b on  a.OpportunityId = b.OpportunityId and 
b.TheRank > 6 and b.MaxProspectDate >= a.endDate group by a.OpportunityId,  a.StartStage, a.startdate, a.endDate ) as t0 Left outer join Salesforce.dbo.MaxOppStageDate as T1 on t0.OpportunityId = t1.OpportunityId and t0.endDate = t1.MaxProspectDate 
Union
--Getting Rank 7
/*Getting the Stagename for the end stage*/ select t0.* ,t1.StageName as EndStage ,case when DATEDIFF(Day, t0.startdate,                        CASE                            WHEN t0.endDate IS NULL THEN  GETDATE() ELSE t0.endDate END) = 0 then .016 else DATEDIFF(Day, t0.startdate, CASE WHEN t0.endDate IS NULL THEN  GETDATE() ELSE t0.endDate END) end   AS DaysInStage
from ( /*Fining the most likely rank when the dates are the same for the end rank */ select a.*, Min(b.TheRank) as MinRank from (/*Finding the next stage date*/ select a.OpportunityId, a.stagename as StartStage, a.MaxProspectDate as startdate, min(b.MaxProspectDate) as endDate from Salesforce.dbo.MaxOppStageDate as a left Outer join Salesforce.dbo.MaxOppStageDate as b on a.OpportunityId = b.OpportunityId and a.MaxProspectDate <= b.MaxProspectDate /*This should change every new Path Stage*/ and 
b.TheRank > 7 where /*This should change every new Path Stage*/
a.TheRank= 7 group by a.OpportunityId, a.stagename , a.MaxProspectDate) as A left Outer join Salesforce.dbo.MaxOppStageDate as b on  a.OpportunityId = b.OpportunityId and 
b.TheRank > 7 and b.MaxProspectDate >= a.endDate group by a.OpportunityId,  a.StartStage, a.startdate, a.endDate ) as t0 Left outer join Salesforce.dbo.MaxOppStageDate as T1 on t0.OpportunityId = t1.OpportunityId and t0.endDate = t1.MaxProspectDate 
Union
--Getting Rank 8
/*Getting the Stagename for the end stage*/ select t0.* ,t1.StageName as EndStage ,case when DATEDIFF(Day, t0.startdate,                        CASE                            WHEN t0.endDate IS NULL THEN  GETDATE() ELSE t0.endDate END) = 0 then .016 else DATEDIFF(Day, t0.startdate, CASE WHEN t0.endDate IS NULL THEN  GETDATE() ELSE t0.endDate END) end   AS DaysInStage
from ( /*Fining the most likely rank when the dates are the same for the end rank */ select a.*, Min(b.TheRank) as MinRank from (/*Finding the next stage date*/ select a.OpportunityId, a.stagename as StartStage, a.MaxProspectDate as startdate, min(b.MaxProspectDate) as endDate from Salesforce.dbo.MaxOppStageDate as a left Outer join Salesforce.dbo.MaxOppStageDate as b on a.OpportunityId = b.OpportunityId and a.MaxProspectDate <= b.MaxProspectDate /*This should change every new Path Stage*/ and 
b.TheRank > 8 where /*This should change every new Path Stage*/
a.TheRank= 8 group by a.OpportunityId, a.stagename , a.MaxProspectDate) as A left Outer join Salesforce.dbo.MaxOppStageDate as b on  a.OpportunityId = b.OpportunityId and 
b.TheRank > 8 and b.MaxProspectDate >= a.endDate group by a.OpportunityId,  a.StartStage, a.startdate, a.endDate ) as t0 Left outer join Salesforce.dbo.MaxOppStageDate as T1 on t0.OpportunityId = t1.OpportunityId and t0.endDate = t1.MaxProspectDate 
Union
--Getting Rank 9
/*Getting the Stagename for the end stage*/ select t0.* ,t1.StageName as EndStage ,case when DATEDIFF(Day, t0.startdate,                        CASE                            WHEN t0.endDate IS NULL THEN  GETDATE() ELSE t0.endDate END) = 0 then .016 else DATEDIFF(Day, t0.startdate, CASE WHEN t0.endDate IS NULL THEN  GETDATE() ELSE t0.endDate END) end   AS DaysInStage
from ( /*Fining the most likely rank when the dates are the same for the end rank */ select a.*, Min(b.TheRank) as MinRank from (/*Finding the next stage date*/ select a.OpportunityId, a.stagename as StartStage, a.MaxProspectDate as startdate, min(b.MaxProspectDate) as endDate from Salesforce.dbo.MaxOppStageDate as a left Outer join Salesforce.dbo.MaxOppStageDate as b on a.OpportunityId = b.OpportunityId and a.MaxProspectDate <= b.MaxProspectDate /*This should change every new Path Stage*/ and 
b.TheRank > 9 where /*This should change every new Path Stage*/
a.TheRank= 9 group by a.OpportunityId, a.stagename , a.MaxProspectDate) as A left Outer join Salesforce.dbo.MaxOppStageDate as b on  a.OpportunityId = b.OpportunityId and 
b.TheRank > 9 and b.MaxProspectDate >= a.endDate group by a.OpportunityId,  a.StartStage, a.startdate, a.endDate ) as t0 Left outer join Salesforce.dbo.MaxOppStageDate as T1 on t0.OpportunityId = t1.OpportunityId and t0.endDate = t1.MaxProspectDate 
Union
--Getting Rank 10
/*Getting the Stagename for the end stage*/ select t0.* ,t1.StageName as EndStage ,case when DATEDIFF(Day, t0.startdate,                        CASE                            WHEN t0.endDate IS NULL THEN  GETDATE() ELSE t0.endDate END) = 0 then .016 else DATEDIFF(Day, t0.startdate, CASE WHEN t0.endDate IS NULL THEN  GETDATE() ELSE t0.endDate END) end   AS DaysInStage
from ( /*Fining the most likely rank when the dates are the same for the end rank */ select a.*, Min(b.TheRank) as MinRank from (/*Finding the next stage date*/ select a.OpportunityId, a.stagename as StartStage, a.MaxProspectDate as startdate, min(b.MaxProspectDate) as endDate from Salesforce.dbo.MaxOppStageDate as a left Outer join Salesforce.dbo.MaxOppStageDate as b on a.OpportunityId = b.OpportunityId and a.MaxProspectDate <= b.MaxProspectDate /*This should change every new Path Stage*/ and 
b.TheRank > 10 where /*This should change every new Path Stage*/
a.TheRank= 10 group by a.OpportunityId, a.stagename , a.MaxProspectDate) as A left Outer join Salesforce.dbo.MaxOppStageDate as b on  a.OpportunityId = b.OpportunityId and 
b.TheRank > 10 and b.MaxProspectDate >= a.endDate group by a.OpportunityId,  a.StartStage, a.startdate, a.endDate ) as t0 Left outer join Salesforce.dbo.MaxOppStageDate as T1 on t0.OpportunityId = t1.OpportunityId and t0.endDate = t1.MaxProspectDate 
union
--Getting Rank 11
/*Getting the Stagename for the end stage*/ select t0.* ,t1.StageName as EndStage ,case when DATEDIFF(Day, t0.startdate,                        CASE                            WHEN t0.endDate IS NULL THEN  GETDATE() ELSE t0.endDate END) = 0 then .016 else DATEDIFF(Day, t0.startdate, CASE WHEN t0.endDate IS NULL THEN  GETDATE() ELSE t0.endDate END) end   AS DaysInStage
from ( /*Fining the most likely rank when the dates are the same for the end rank */ select a.*, Min(b.TheRank) as MinRank from (/*Finding the next stage date*/ select a.OpportunityId, a.stagename as StartStage, a.MaxProspectDate as startdate, min(b.MaxProspectDate) as endDate from Salesforce.dbo.MaxOppStageDate as a left Outer join Salesforce.dbo.MaxOppStageDate as b on a.OpportunityId = b.OpportunityId and a.MaxProspectDate <= b.MaxProspectDate /*This should change every new Path Stage*/ and 
b.TheRank > 11 where /*This should change every new Path Stage*/
a.TheRank= 11 group by a.OpportunityId, a.stagename , a.MaxProspectDate) as A left Outer join Salesforce.dbo.MaxOppStageDate as b on  a.OpportunityId = b.OpportunityId and 
b.TheRank > 11 and b.MaxProspectDate >= a.endDate group by a.OpportunityId,  a.StartStage, a.startdate, a.endDate ) as t0 Left outer join Salesforce.dbo.MaxOppStageDate as T1 on t0.OpportunityId = t1.OpportunityId and t0.endDate = t1.MaxProspectDate 
union
--Getting Rank 12
/*Getting the Stagename for the end stage*/ select t0.* ,t1.StageName as EndStage ,case when DATEDIFF(Day, t0.startdate,                        CASE                            WHEN t0.endDate IS NULL THEN  GETDATE() ELSE t0.endDate END) = 0 then .016 else DATEDIFF(Day, t0.startdate, CASE WHEN t0.endDate IS NULL THEN  GETDATE() ELSE t0.endDate END) end   AS DaysInStage
from ( /*Fining the most likely rank when the dates are the same for the end rank */ select a.*, Min(b.TheRank) as MinRank from (/*Finding the next stage date*/ select a.OpportunityId, a.stagename as StartStage, a.MaxProspectDate as startdate, min(b.MaxProspectDate) as endDate from Salesforce.dbo.MaxOppStageDate as a left Outer join Salesforce.dbo.MaxOppStageDate as b on a.OpportunityId = b.OpportunityId and a.MaxProspectDate <= b.MaxProspectDate /*This should change every new Path Stage*/ and 
b.TheRank > 12 where /*This should change every new Path Stage*/
a.TheRank= 12 group by a.OpportunityId, a.stagename , a.MaxProspectDate) as A left Outer join Salesforce.dbo.MaxOppStageDate as b on  a.OpportunityId = b.OpportunityId and 
b.TheRank > 12 and b.MaxProspectDate >= a.endDate group by a.OpportunityId,  a.StartStage, a.startdate, a.endDate ) as t0 Left outer join Salesforce.dbo.MaxOppStageDate as T1 on t0.OpportunityId = t1.OpportunityId and t0.endDate = t1.MaxProspectDate 
union
--Getting Rank 13
/*Getting the Stagename for the end stage*/ select t0.* ,t1.StageName as EndStage ,case when DATEDIFF(Day, t0.startdate,                        CASE                            WHEN t0.endDate IS NULL THEN  GETDATE() ELSE t0.endDate END) = 0 then .016 else DATEDIFF(Day, t0.startdate, CASE WHEN t0.endDate IS NULL THEN  GETDATE() ELSE t0.endDate END) end   AS DaysInStage
from ( /*Fining the most likely rank when the dates are the same for the end rank */ select a.*, Min(b.TheRank) as MinRank from (/*Finding the next stage date*/ select a.OpportunityId, a.stagename as StartStage, a.MaxProspectDate as startdate, min(b.MaxProspectDate) as endDate from Salesforce.dbo.MaxOppStageDate as a left Outer join Salesforce.dbo.MaxOppStageDate as b on a.OpportunityId = b.OpportunityId and a.MaxProspectDate <= b.MaxProspectDate /*This should change every new Path Stage*/ and 
b.TheRank > 13 where /*This should change every new Path Stage*/
a.TheRank= 13 group by a.OpportunityId, a.stagename , a.MaxProspectDate) as A left Outer join Salesforce.dbo.MaxOppStageDate as b on  a.OpportunityId = b.OpportunityId and 
b.TheRank > 13 and b.MaxProspectDate >= a.endDate group by a.OpportunityId,  a.StartStage, a.startdate, a.endDate ) as t0 Left outer join Salesforce.dbo.MaxOppStageDate as T1 on t0.OpportunityId = t1.OpportunityId and t0.endDate = t1.MaxProspectDate 
union
--Getting Rank 14
/*Getting the Stagename for the end stage*/ select t0.* ,t1.StageName as EndStage ,case when DATEDIFF(Day, t0.startdate,                        CASE                            WHEN t0.endDate IS NULL THEN  GETDATE() ELSE t0.endDate END) = 0 then .016 else DATEDIFF(Day, t0.startdate, CASE WHEN t0.endDate IS NULL THEN  GETDATE() ELSE t0.endDate END) end   AS DaysInStage
from ( /*Fining the most likely rank when the dates are the same for the end rank */ select a.*, Min(b.TheRank) as MinRank from (/*Finding the next stage date*/ select a.OpportunityId, a.stagename as StartStage, a.MaxProspectDate as startdate, min(b.MaxProspectDate) as endDate from Salesforce.dbo.MaxOppStageDate as a left Outer join Salesforce.dbo.MaxOppStageDate as b on a.OpportunityId = b.OpportunityId and a.MaxProspectDate <= b.MaxProspectDate /*This should change every new Path Stage*/ and 
b.TheRank > 14 where /*This should change every new Path Stage*/
a.TheRank= 14 group by a.OpportunityId, a.stagename , a.MaxProspectDate) as A left Outer join Salesforce.dbo.MaxOppStageDate as b on  a.OpportunityId = b.OpportunityId and 
b.TheRank > 14 and b.MaxProspectDate >= a.endDate group by a.OpportunityId,  a.StartStage, a.startdate, a.endDate ) as t0 Left outer join Salesforce.dbo.MaxOppStageDate as T1 on t0.OpportunityId = t1.OpportunityId and t0.endDate = t1.MaxProspectDate 
) as A
pivot
( Sum(DaysInStage)
For StartStage in ([Contract],
[Demo Booked],
[Demos],
[Docs Requested],
[High Interest],
[Negotiation],
[No Sit],
[Pilot],
[Prospect],
[Qualified],
[Ready To Close],
[Sat - Negotiating],
[Sat - Presented],
[Some Interest],
[Waiting to Book])

) as PivotTable
) as A
Group by A.OpportunityId
