select t0.id
, callcnt.OppCallcnt as OpportunityCallCount 
, sms.OppOnlySMSCount
, email.OppOnlyEmailCount
, MaxDates.MaxCallDate
, MaxDates.MaxEmailDate
, MaxDates.MaxSMSDate
, callcnt.OppCallcnt + sms.OppOnlySMSCount + email.OppOnlyEmailCount as TotalTouchPointsFromSales,
case when isnull(MaxDates.MaxCallDate, '01-01-2000') >=  isnull(MaxDates.MaxsmsDate, '01-01-2000') then maxdates.MaxCallDate else maxdates.MaxSMSDate end as LastTouchPointDate 
from
Salesforce.dbo.Opportunity as T0
--left outer join  Salesforce.dbo.account_stats__c as stat on t0.id = stat.Account__c
--Get Call Counts 
Left Outer join (SELECT a.id AS oppid, ISNULL(o.OppCallcnt, 0) AS OppCallcnt FROM Salesforce.dbo.opportunity AS a     LEFT OUTER JOIN (    SELECT c.Id AS acctid,            COUNT(t.id) AS OppCallcnt     FROM Salesforce.dbo.task AS t          LEFT OUTER JOIN Salesforce.dbo.Opportunity AS c ON t.whatid = c.id     WHERE t.TaskSubtype = 'call'           AND t.WhatId LIKE '006%'     GROUP BY c.Id ) AS o ON a.id = o.acctid) as callcnt on t0.id = callcnt.oppid
--Get SMS Counts 
Left outer join (SELECT a.id AS oppId,        ISNULL(opp.AccountOnlySMSCount, 0) AS OppOnlySMSCount FROM Salesforce.dbo.Opportunity AS a     LEFT OUTER JOIN (    SELECT o.Id AS oppid,            COUNT(t.id) AS AccountOnlySMSCount    FROM Salesforce.dbo.Opportunity AS o         LEFT OUTER JOIN Salesforce.dbo.task AS t ON o.id = t.whatid    WHERE t.TaskSubtype = 'Task'          AND t.Subject LIKE 'sms%'          AND t.whatid LIKE '006%'    GROUP BY o.Id ) AS opp ON a.id = opp.oppid) as sms on T0.id = sms.oppId 
--Get Email Counts
Left Outer Join (SELECT a.id AS OppId, ISNULL(opp.OppOnlyEmailCount, 0) AS OppOnlyEmailCount FROM Salesforce.dbo.Opportunity AS a LEFT OUTER JOIN (    SELECT o.Id AS oppid, COUNT(t.id) AS OppOnlyEmailCount     FROM Salesforce.dbo.Opportunity AS o          LEFT OUTER JOIN Salesforce.dbo.task AS t ON o.id = t.whatid     WHERE t.TaskSubtype = 'Email'           AND t.whatid LIKE '006%'     GROUP BY o.Id ) AS opp ON a.id = opp.oppid) as Email on t0.id = email.oppid 
-- Get max dates for last tasks by subtypes
Left outer join (SELECT a.id, call.MaxCallDate,        email.MaxEmailDate,         sms.MaxSMSDate FROM Salesforce.dbo.Opportunity AS a LEFT OUTER JOIN (    SELECT t.whatid as id,            CAST(MAX(t.CreatedDate) AS DATE) AS MaxCallDate FROM Salesforce.dbo.task AS T WHERE t.whatid LIKE '006%'           AND t.TaskSubtype = 'Call'     GROUP BY t.whatid ) AS Call ON a.id = call.id      LEFT OUTER JOIN (SELECT t.whatid as id,            CAST(MAX(t.CreatedDate) AS DATE) AS MaxEmailDate     FROM Salesforce.dbo.task AS T WHERE t.whatid LIKE '006%'           AND t.TaskSubtype = 'Email'     GROUP BY t.whatid ) AS email ON a.id = email.id      LEFT OUTER JOIN ( SELECT t.whatid as id, CAST(MAX(t.CreatedDate) AS DATE) AS MaxSMSDate FROM Salesforce.dbo.task AS T WHERE t.WhatId like '006%' 	and t.whoid LIKE '003%'           AND t.Subject LIKE 'SMS%'     GROUP BY t.whatid ) AS sms ON a.id = sms.id) as MaxDates on t0.id = maxdates.id
where callcnt.OppCallcnt + sms.OppOnlySMSCount + email.OppOnlyEmailCount != isnull(t0.Opportunity_Total_Touch_Point__c, 0)


