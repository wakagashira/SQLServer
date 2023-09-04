SELECT top 1 sf.[Id]
      ,sf.[IsDeleted]
      ,sf.[AccountId]
      ,sf.[CreatedById]
      ,sf.[CreatedDate]
      ,sf.[Field]
      ,sf.[DataType]
      ,sf.[OldValue]
      ,isnull(sf.[NewValue], '') AS NewValue
FROM 
OPENQUERY([SFWA], 'select * from accounthistory') AS SF
LEFT OUTER JOIN salesforce.dbo.AccountHistory ah ON sf.id = ah.id 
WHERE ah.id IS NULL 
