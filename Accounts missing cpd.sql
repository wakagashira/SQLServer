SELECT a.id AS sfaid, 
       c.id AS cdpid, 
       a.Type,
	   a.OwnerId,
	   u.Name
FROM Salesforce.dbo.Account AS a
left outer join Salesforce.dbo.[user] as u on a.ownerid = u.id
     LEFT OUTER JOIN Salesforce.dbo.App_CDP__c AS c ON a.id = c.Account__c
WHERE c.id IS NULL
and a.type = 'customer'
--and a.id in ('0016T00002stsRVQAY', '0016T00002yB2gLQAS')