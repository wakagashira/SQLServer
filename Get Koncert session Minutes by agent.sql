DECLARE @Yesterday AS Date= case when datepart(dw, Getdate()) = 2 then convert(nvarchar, dateadd(day, -3, Getdate()), 23) 
when datepart(dw, Getdate()) = 1 then convert(nvarchar, dateadd(day, -2, Getdate()),23) 
else convert(nvarchar, dateadd(day, -1, Getdate()),23) end
DECLARE @Today AS Date=GetDate()
DECLARE @Select AS VARCHAR(Max)= 'select 
u.Id, 
isnull(sum(a.CLDR__Session_Duration__c), 0) as TotalCallDuration'
DECLARE @User as varchar(MAX) = 'openquery(SFWA , ''select id, User_Name__c  from User_On_Off_Boarding__c'') as u ' 
DECLARE @AStart as varchar(Max) = 'Left outer join openquery(SFWA , ''SELECT CLDR__Session_Duration__c, CreatedById, CreatedDate, Id FROM CLDR__Call_Session__c  where CreatedDate > '''''
DECLARE @AMID as varchar(MAX) = 'T00:00:00Z'''' and CreatedDate <'''''
DECLARE @AEnd as Varchar(50) = ''''''') as A on u.User_Name__c = a.CreatedById '
--DECLARE @B as nvarchar(MAX) = 'left outer Join openquery(SFWA , ''SELECT Id,Name FROM User'') as b on a.CreatedById = b.id' 
DECLARE @From as Varchar(MAX) = ' From ' +@User + @AStart +  convert(varchar, @Yesterday) + @AMID + convert(varchar, @Today)  + @AEnd + ' ' 
DECLARE @GroupBy as Varchar(MAX) = ' group by u.Id'
DECLARE @Script as Varchar(MAX) = @Select + @From + @GroupBy
--print @Script 
exec (@Script)
