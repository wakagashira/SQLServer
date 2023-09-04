SELECT vb.id,
a.Vitally_Health_Score__c,
a.Churn_Risk__c,
DATEDIFF(DAY, a.pISU__c, getdate()) AS IniitialSignUpDate,
a.Contract_Status__c
FROM 
LocalWAProd.dbo.v2_businesses vb 
LEFT OUTER JOIN Salesforce.dbo.account AS a ON vb.salesforce_account_id = a.id
WHERE vb.id in (19581,
10742,
13862,
26296,
19096,
5104,
19503,
19251,
18722,
18007,
8461,
7756,
6726,
31312,
31064,
30770,
29689
)
