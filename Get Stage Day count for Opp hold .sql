SELECT a.OpportunityId, 
       a.Prospect,
	   B.NextStage,
       DATEDIFF(day, a.MinProspectDate,
                       CASE
                           WHEN b.EndProspectDate IS NULL
                           THEN CONVERT(DATE, GETDATE())
                           ELSE b.EndProspectDate
                       END) AS DaysinStage
FROM
(
    SELECT OpportunityId, 
           stagename AS Prospect, 
           MIN(CreatedDate) AS MinProspectDate
    FROM Salesforce.dbo.opportunityhistory
    WHERE stagename = 'Waiting to Book'
    GROUP BY OpportunityId, 
             stagename
) AS a
LEFT OUTER JOIN
(
    SELECT b.OpportunityId, 
           b.stagename AS NextStage, 
           MIN(b.Createddate) AS EndProspectDate
    FROM Salesforce.dbo.opportunityhistory as b
Inner Join (
    SELECT OpportunityId, 
           stagename AS Prospect, 
           MIN(CreatedDate) AS MinProspectDate
    FROM Salesforce.dbo.opportunityhistory
    WHERE stagename = 'Waiting to Book'
    GROUP BY OpportunityId, 
             stagename
) AS a on b.OpportunityId  = a.OpportunityId







	    WHERE b.stagename != 'Prospect'
          AND b.stagename != 'Waiting to Book'
		  and a.MinProspectDate <= b.CreatedDate
    GROUP BY b.OpportunityId, 
             b.stagename
) AS b ON a.OpportunityId = b.[OpportunityId];