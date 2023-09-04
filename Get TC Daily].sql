Declare @Select nvarchar(MAX) = '
select
a.id,
isnull(b.Truly_CallDurationMinutesTotal, 0) as Truly_CallDurationMinutesTotal
from 
openQuery(SFWA, ''Select Id, User_Name__c From User_On_Off_Boarding__c'') as a 
Left outer join openquery(SFWA , ''SELECT OwnerId, Sum(truly_callDurationMinutes__c) as Truly_CallDurationMinutesTotal '

Declare @From nvarchar(max) = 'FROM Task '
Declare @Where nvarchar(max) = 'Where truly_callDurationMinutes__c != null '
Declare @DateStart nvarchar(MAX) =  'and CreatedDate >= ''''' 
+ case when datepart(dw, Getdate()) = 2 then convert(nvarchar, dateadd(day, -3, Getdate()), 23) 
when datepart(dw, Getdate()) = 1 then convert(nvarchar, dateadd(day, -2, Getdate()),23) 
else convert(nvarchar, dateadd(day, -1, Getdate()),23) end
+ 'T00:00:00.000Z'''' and CreatedDate < ''''' 
+ convert(nvarchar, Getdate(), 23 )
+ 'T00:00:00.000Z'''' Group by OwnerId'') as b on a.User_Name__c = b.OwnerId'
Declare @Script nvarchar(Max) = @Select + @From + @Where + @DateStart
--Print @script
Exec (@Script) 
