DECLARE @Yesterday AS Date= dateadd(Day, -1, GetDate())
DECLARE @Today AS Date=GetDate()
DECLARE @Select AS VARCHAR(Max)= 'select 
b.Id, 
b.Name, 
sum(a.CLDR__CallDuration__c)/60 as TotalCallDuration'
DECLARE @AStart as varchar(Max) = 'openquery(SFWA , ''Select CLDR__CallDuration__c, CreatedById, CreatedDate, Id  FROM CLDR__CallLog__c where CreatedDate > '''''
DECLARE @AMID as varchar(MAX) = 'T00:00:00Z'''' and CreatedDate <'''''
DECLARE @AEnd as Varchar(50) = ''''''') as A'
DECLARE @B as nvarchar(MAX) = 'left outer Join openquery(SFWA , ''SELECT Id,Name FROM User'') as b on a.CreatedById = b.id' 
DECLARE @From as Varchar(MAX) = ' From ' + @AStart +  convert(varchar, @Yesterday) + @AMID + convert(varchar, @Today)  + @AEnd + ' ' + @B
DECLARE @GroupBy as Varchar(MAX) = ' group by b.name, b.Id'
DECLARE @Script as Varchar(MAX) = @Select + @From + @GroupBy
--print @Script 
exec (@Script)
/*



'Select CLDR__CallDuration__c, Id FROM CLDR__CallLog__c where CreatedDate = '
DECLARE @Script as varchar(max)
set @Script = @Part1 + Convert(nvarchar, @Today) 
--print @Script

select 
b.Id,
b.Name,
sum(a.CLDR__CallDuration__c) as TotalCallDuration
 from 
 openquery(SFWA , 'Select CLDR__CallDuration__c, CreatedById, CreatedDate, Id,  FROM CLDR__CallLog__c where ') as a 
 left outer Join openquery(SFWA , 'SELECT Id,Name FROM User') as b on a.CreatedById = b.id
 group by b.name
 */