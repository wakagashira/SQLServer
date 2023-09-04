CREATE VIEW dbo.MasterTrackerSFSat
AS
 
select CONVERT(date, GETDATE()) AS ReportDate, count(id) as Sat
from openquery(SFWA , 'select id, StartDateTime, Event_Inv_Check__c, sit_Status__c, Type
from event 
where sit_Status__c = ''Sat''
and Type in (''Demo_Scheduled'', ''Rebook'')
and Event_Inv_Check__c = 0
and ischild = 0
') 
where datepart(month, startdatetime) = datepart(Month, getdate())
and datepart(YEAR, startdatetime) = datepart(year, getdate())
