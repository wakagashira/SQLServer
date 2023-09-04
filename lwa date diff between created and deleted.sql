SELECT vb.[created_at]
,vb.[sub_cancellation_date]
,DateDiff(DAY, vb.[created_at], vb.[sub_cancellation_date] ) AS dateDiffCreatedAndCanceled
,vb.[sub_status]
,a.type 
,vb.is_trial
,a.TC_Vitally_MRR__c
,a.pISU__c
,a.TCChurn_Date__c
, DATEDIFF(DAY, a.pISU__c, a.TCChurn_Date__c) AS salesforceDaysToChurn
,DATEDIFF(DAY, a.pISU__c, vb.sub_cancellation_date) AS SfStartWAend
, a.Segment__c
, a.Industry
--, * 
FROM LocalWAProd.dbo.v2_businesses vb 
LEFT OUTER JOIN Salesforce.dbo.Account a ON vb.id = a.AppID__c AND a.type != 'true'
WHERE vb.sub_status IN ('canceled', 'expired')
--AND vb.is_trial = 1 
AND DATEPART(YEAR, vb.created_at) >2019
AND a.type != 'Prospect' 