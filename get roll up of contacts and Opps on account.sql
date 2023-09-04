select t0.id
,C.TotalContacts as TotalContacts
, isnull(o.TotalOpportunies, 0) as  TotalOpps
, callcnt.AccountOnlyCnt as AccountCallCount
, callcnt.OppCallcnt as OpportunityCallCount 
, callcnt.ContactCallcnt as ContactCallCount
, callcnt.TotalCallCnt TotalCallCount 
, sms.AccountOnlySMSCount
, sms.OppOnlySMSCount
, sms.ContactOnlySMSCount
, sms.SMSTotalCnt
, email.AccountOnlyEmailCount
, email.OppOnlyEmailCount
, email.ContactOnlyEmailCount
, email.TotalEmailCnt
, cper.ContactPercentageWithTouchPoints
, cper.TotalContactsWithTouchPoints
, MaxDates.MaxCallDate
, MaxDates.MaxEmailDate
, MaxDates.MaxSMSDate
, callcnt.TotalCallCnt + sms.SMSTotalCnt + email.TotalEmailCnt as TotalTouchPointsFromSales,
case when isnull(MaxDates.MaxCallDate, '01-01-2000') >=  isnull(MaxDates.MaxsmsDate, '01-01-2000') then maxdates.MaxCallDate else maxdates.MaxSMSDate end as LastTouchPointDate 
from
Salesforce.dbo.account as T0
left outer join  Salesforce.dbo.account_stats__c as stat on t0.id = stat.Account__c
--Get total contacts
left outer join (select a.id, count(c.id) as TotalContacts from Salesforce.dbo.account as a left outer join Salesforce.dbo.contact as c on a.id = c.AccountId group by a.id) as C on T0.id = C.id
--Get Total Oppotunities total 
Left Outer Join (select o.AccountId, count(o.id) as TotalOpportunies from Salesforce.dbo.Opportunity as o group by o.accountid) as o on t0.id = o.AccountId 
--Get Call Counts 
Left Outer join (SELECT a.id AS acctid,            ISNULL(c.AccountOnlyCnt, 0) AS AccountOnlyCnt,             ISNULL(o.OppCallcnt, 0) AS OppCallcnt, 		   ISNULL(con.ContactCallcnt, 0) as ContactCallcnt,            ISNULL(c.AccountOnlyCnt, 0) + ISNULL(o.OppCallcnt, 0) + ISNULL(con.ContactCallcnt, 0) AS TotalCallCnt     FROM Salesforce.dbo.account AS a          LEFT OUTER JOIN     (        SELECT Whatid,                COUNT(id) AS AccountOnlyCnt         FROM Salesforce.dbo.task         WHERE TaskSubtype = 'call'               AND WhatId LIKE '001%'         GROUP BY WhatId     ) AS c ON a.id = c.WhatId          LEFT OUTER JOIN     (        SELECT c.AccountId AS acctid,                COUNT(t.id) AS OppCallcnt         FROM Salesforce.dbo.task AS t              LEFT OUTER JOIN Salesforce.dbo.Opportunity AS c ON t.whatid = c.id         WHERE t.TaskSubtype = 'call'               AND t.WhatId LIKE '006%'         GROUP BY c.AccountId     ) AS o ON a.id = o.acctid          LEFT OUTER JOIN     (        SELECT t.AccountId AS acctid,                COUNT(t.id) AS ContactCallcnt         FROM Salesforce.dbo.task AS t WHERE t.TaskSubtype = 'call'               AND t.WhoId LIKE '003%' 			  AND t.WhatId is null         GROUP BY t.AccountId    ) AS con ON a.id = con.acctid) as callcnt on t0.id = callcnt.acctid
--Get SMS Counts 
Left outer join (SELECT a.id AS acctId, ISNULL(acct.AccountOnlySMSCount, 0) AS AccountOnlySMSCount, ISNULL(opp.AccountOnlySMSCount, 0) AS OppOnlySMSCount, 		   ISNULL(con.ContactOnlySMSCount, 0) AS ContactOnlySMSCount,            ISNULL(acct.AccountOnlySMSCount, 0) + ISNULL(opp.AccountOnlySMSCount, 0) + ISNULL(con.ContactOnlySMSCount, 0) AS SMSTotalCnt     FROM Salesforce.dbo.account AS a          LEFT OUTER JOIN     (         SELECT whatid AS acctid,                COUNT(id) AS AccountOnlySMSCount         FROM Salesforce.dbo.task         WHERE TaskSubtype = 'Task'               AND Subject LIKE 'sms%'               AND whatid LIKE '001%'         GROUP BY whatid     ) AS acct ON a.id = acct.acctid          LEFT OUTER JOIN     (        SELECT o.AccountId AS acctid,                COUNT(t.id) AS AccountOnlySMSCount         FROM Salesforce.dbo.Opportunity AS o              LEFT OUTER JOIN Salesforce.dbo.task AS t ON o.id = t.whatid         WHERE t.TaskSubtype = 'Task'               AND t.Subject LIKE 'sms%'               AND t.whatid LIKE '006%'         GROUP BY o.AccountId     ) AS opp ON a.id = opp.acctid 	LEFT OUTER JOIN     (         SELECT o.AccountId AS acctid,                COUNT(t.id) AS ContactOnlySMSCount         FROM Salesforce.dbo.Opportunity AS o              LEFT OUTER JOIN Salesforce.dbo.task AS t ON o.id = t.whatid         WHERE t.TaskSubtype = 'Task'               AND t.Subject LIKE 'sms%'               AND t.whoid LIKE '003%' 			  AND t.whatid is null          GROUP BY o.AccountId     ) AS con ON a.id = con.acctid) as sms on T0.id = sms.acctId 
--Get Email Counts
Left Outer Join (SELECT a.id AS acctId, ISNULL(acct.AccountOnlyEmailcnt, 0) AS AccountOnlyEmailCount, ISNULL(opp.OppOnlyEmailCount, 0) AS OppOnlyEmailCount, ISNULL(con.ContactOnlyEmailCount, 0) as ContactOnlyEmailCount,       ISNULL(acct.AccountOnlyEmailcnt, 0) + ISNULL(opp.OppOnlyEmailCount, 0) + ISNULL(con.ContactOnlyEmailCount, 0) AS TotalEmailCnt FROM Salesforce.dbo.account AS a      LEFT OUTER JOIN (    SELECT whatid AS acctid,            COUNT(id) AS AccountOnlyEmailcnt     FROM Salesforce.dbo.task     WHERE TaskSubtype = 'email'           AND whatid LIKE '001%'     GROUP BY whatid ) AS acct ON a.id = acct.acctid      LEFT OUTER JOIN (    SELECT o.AccountId AS acctid,            COUNT(t.id) AS OppOnlyEmailCount     FROM Salesforce.dbo.Opportunity AS o          LEFT OUTER JOIN Salesforce.dbo.task AS t ON o.id = t.whatid     WHERE t.TaskSubtype = 'Email'           AND t.whatid LIKE '006%'     GROUP BY o.AccountId ) AS opp ON a.id = opp.acctid left outer join (     SELECT t.AccountId AS acctid,            COUNT(t.id) AS ContactOnlyEmailCount     FROM Salesforce.dbo.task AS t     WHERE t.TaskSubtype = 'Email'           AND t.whoid LIKE '003%' 		  and t.whatid is null     GROUP BY t.AccountId ) AS Con ON a.id = con.acctid) as Email on t0.id = email.acctid 
--Get Contacts with Touchpoints 
Left Outer Join (select a.id as acctid, isnull(tp.totalContacsWithTouchPoints, 0) as TotalContactsWithTouchPoints, isnull(c.TotalContacts, 0) as TotalContacts, case when isnull(tp.totalContacsWithTouchPoints, 0) = 0 then 0 when isnull(c.TotalContacts, 0) = 0 then 0 else (cast(isnull(tp.totalContacsWithTouchPoints, 0) as float) / Cast(isnull(c.TotalContacts, 0) as Float)) * 100  end as ContactPercentageWithTouchPoints from Salesforce.dbo.Account as a Left Outer Join (select t0.accountid, count(t0.ContactsWithTouchPoints) as totalContacsWithTouchPoints from (SELECT distinct c.AccountId,        c.id AS ContactsWithTouchPoints FROM Salesforce.dbo.task AS T      INNER JOIN Salesforce.dbo.contact AS c ON t.whoid = c.id WHERE t.whoid LIKE '003%'      AND (t.TaskSubtype = 'Call'           OR t.TaskSubtype = 'Email'           OR t.Subject LIKE 'SMS%')) as T0 		   Group by t0.AccountId) as TP on a.id = tp.accountid Left outer join (select c.AccountId, count(c.id) as TotalContacts from Salesforce.dbo.contact as c where c.IsDeleted = 0 Group by c.AccountId) as C on a.id = c.accountid) as CPer on t0.id = CPer.acctid
-- Get max dates for last tasks by subtypes
Left outer join (select a.id, 	call.MaxCallDate, 	email.MaxEmailDate, 	sms.MaxSMSDate 	from Salesforce.dbo.Account as a 	Left outer Join (SELECT  c.AccountId,            cast(max(t.CreatedDate) as date) as MaxCallDate     FROM Salesforce.dbo.task AS T          INNER JOIN Salesforce.dbo.contact AS c ON t.whoid = c.id     WHERE t.whoid LIKE '003%'           AND t.TaskSubtype = 'Call' 	group by c.AccountId) as Call on a.id = call.accountid 	   left outer join (SELECT  c.AccountId,            cast(max(t.CreatedDate) as date) as MaxEmailDate     FROM Salesforce.dbo.task AS T          INNER JOIN Salesforce.dbo.contact AS c ON t.whoid = c.id     WHERE t.whoid LIKE '003%'          AND t.TaskSubtype = 'email'               	group by c.AccountId)  as email on a.id = email.accountid 		    Left Outer Join (SELECT  c.AccountId,             cast(max(t.CreatedDate) as date) as MaxSMSDate     FROM Salesforce.dbo.task AS T          INNER JOIN Salesforce.dbo.contact AS c ON t.whoid = c.id     WHERE t.whoid LIKE '003%'           and t.Subject LIKE 'SMS%' 	group by c.AccountId) as sms on a.id = sms.accountid) as MaxDates on t0.id = maxdates.id
where /*C.TotalContacts != stat.Contacts_On_Account__c
or isnull(o.TotalOpportunies, 0) != stat.Opportunities_On_Account__c
or callcnt.TotalCallCnt + sms.SMSTotalCnt + email.TotalEmailCnt != stat.Total_Touch_Points__c 
or email.TotalEmailCnt != stat.Total_Email_Count__c
or stat.id is null 
*/
t0.id = '0014p00001ffuz8AAA'



