CREATE VIEW dbo.MasterTrackerSFCalls
AS
select 
CONVERT(date, GETDATE()) AS ReportDate,
Count(a.id) as Calls
from openquery(SFWA, 'Select c.Id, 
c.Truly_id__c, 
c.tasksubtype, 
c.createddate, 
c.ownerid 
from task as c
where c.truly_id__c is not null 
and c.tasksubtype = ''Call'' 
order by c.createddate desc
Limit 25000
') as a --add user role lookup and other filters 
Inner Join   openquery(SFWA, 'select a.id 
from user as a 
inner join userrole as b on a.userRoleId = b.id
where (b.name like ''%Sales%'' or b.name like ''%marketing%'')
') as b on a.ownerid = b.id

where a.createddate >= DATEADD(month, DATEDIFF(month, 0, getdate()), 0)
--and a.activityData >= date(''now'', ''start of month'')