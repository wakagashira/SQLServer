
select CONVERT(date, GETDATE(), 23) AS ReportDate, count(a.id) as ConvoCnt
from openquery(SFWA, 'Select Id, ownerId 
from task as c
where c.truly_id__c is not null 
and Is_Current_Month_and_Year__c = 1
and c.tasksubtype = ''Call'' 
and 	truly_callDuration__c > ''00:03:00''
and (truly_customCallDisposition__c like ''%dm%''
or truly_customCallDisposition__c like ''%discovery%'' 
or truly_customCallDisposition__c like ''%not interested%''
or truly_customCallDisposition__c like ''%koncert%'' 
or truly_customCallDisposition__c like ''%otf%'')
') as a
Inner Join   openquery(SFWA, 'select a.id 
from user as a 
inner join userrole as b on a.userRoleId = b.id
where (b.name like ''%Sales%'' or b.name like ''%marketing%'')
') as b on a.ownerid = b.id

