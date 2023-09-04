select Jan.Tier, 
jan.Jan,
feb.Feb,
mar.Mar,
Apr.Apr,
May.May,
June.June
from (select  CASE WHEN a.TC_Recurly_MRR__c > 1000 THEN 'Tier 1' 
WHEN a.TC_Recurly_MRR__c < 1000 AND a.TC_Recurly_MRR__c >= 500 THEN 'Tier 2'
WHEN a.TC_Recurly_MRR__c < 500 AND a.TC_Recurly_MRR__c >= 200 THEN 'Tier 3'
WHEN a.TC_Recurly_MRR__c < 200 AND a.TC_Recurly_MRR__c >= 0 THEN 'Tier 4'
ELSE 'Other' END AS Tier
, count(a.id) as Jan
from Salesforce.dbo.account as a
where a.type in ('customer', 'ex-customer')
and cast(a.CreatedDate as date) < '2023-02-01'
and (a.Computation_Month__c > '2023-02-01' or a.Computation_Month__c is null)
group by CASE WHEN a.TC_Recurly_MRR__c > 1000 THEN 'Tier 1' 
WHEN a.TC_Recurly_MRR__c < 1000 AND a.TC_Recurly_MRR__c >= 500 THEN 'Tier 2'
WHEN a.TC_Recurly_MRR__c < 500 AND a.TC_Recurly_MRR__c >= 200 THEN 'Tier 3'
WHEN a.TC_Recurly_MRR__c < 200 AND a.TC_Recurly_MRR__c >= 0 THEN 'Tier 4'
ELSE 'Other' END) as jan
Inner join (select  CASE WHEN a.TC_Recurly_MRR__c > 1000 THEN 'Tier 1' 
WHEN a.TC_Recurly_MRR__c < 1000 AND a.TC_Recurly_MRR__c >= 500 THEN 'Tier 2'
WHEN a.TC_Recurly_MRR__c < 500 AND a.TC_Recurly_MRR__c >= 200 THEN 'Tier 3'
WHEN a.TC_Recurly_MRR__c < 200 AND a.TC_Recurly_MRR__c >= 0 THEN 'Tier 4'
ELSE 'Other' END AS Tier
, count(a.id) as Feb
from Salesforce.dbo.account as a
where a.type in ('customer', 'ex-customer')
and cast(a.CreatedDate as date) < '2023-03-01'
and (a.Computation_Month__c > '2023-03-01' or a.Computation_Month__c is null)
group by CASE WHEN a.TC_Recurly_MRR__c > 1000 THEN 'Tier 1' 
WHEN a.TC_Recurly_MRR__c < 1000 AND a.TC_Recurly_MRR__c >= 500 THEN 'Tier 2'
WHEN a.TC_Recurly_MRR__c < 500 AND a.TC_Recurly_MRR__c >= 200 THEN 'Tier 3'
WHEN a.TC_Recurly_MRR__c < 200 AND a.TC_Recurly_MRR__c >= 0 THEN 'Tier 4'
ELSE 'Other' END) as Feb on jan.Tier = Feb.Tier
Inner join (select  CASE WHEN a.TC_Recurly_MRR__c > 1000 THEN 'Tier 1' 
WHEN a.TC_Recurly_MRR__c < 1000 AND a.TC_Recurly_MRR__c >= 500 THEN 'Tier 2'
WHEN a.TC_Recurly_MRR__c < 500 AND a.TC_Recurly_MRR__c >= 200 THEN 'Tier 3'
WHEN a.TC_Recurly_MRR__c < 200 AND a.TC_Recurly_MRR__c >= 0 THEN 'Tier 4'
ELSE 'Other' END AS Tier
, count(a.id) as mar
from Salesforce.dbo.account as a
where a.type in ('customer', 'ex-customer')
and cast(a.CreatedDate as date) < '2023-04-01'
and (a.Computation_Month__c > '2023-04-01' or a.Computation_Month__c is null)
group by CASE WHEN a.TC_Recurly_MRR__c > 1000 THEN 'Tier 1' 
WHEN a.TC_Recurly_MRR__c < 1000 AND a.TC_Recurly_MRR__c >= 500 THEN 'Tier 2'
WHEN a.TC_Recurly_MRR__c < 500 AND a.TC_Recurly_MRR__c >= 200 THEN 'Tier 3'
WHEN a.TC_Recurly_MRR__c < 200 AND a.TC_Recurly_MRR__c >= 0 THEN 'Tier 4'
ELSE 'Other' END) as Mar on jan.Tier = Mar.Tier
Inner join (select  CASE WHEN a.TC_Recurly_MRR__c > 1000 THEN 'Tier 1' 
WHEN a.TC_Recurly_MRR__c < 1000 AND a.TC_Recurly_MRR__c >= 500 THEN 'Tier 2'
WHEN a.TC_Recurly_MRR__c < 500 AND a.TC_Recurly_MRR__c >= 200 THEN 'Tier 3'
WHEN a.TC_Recurly_MRR__c < 200 AND a.TC_Recurly_MRR__c >= 0 THEN 'Tier 4'
ELSE 'Other' END AS Tier
, count(a.id) as Apr
from Salesforce.dbo.account as a
where a.type in ('customer', 'ex-customer')
and cast(a.CreatedDate as date) < '2023-05-01'
and (a.Computation_Month__c > '2023-05-01' or a.Computation_Month__c is null)
group by CASE WHEN a.TC_Recurly_MRR__c > 1000 THEN 'Tier 1' 
WHEN a.TC_Recurly_MRR__c < 1000 AND a.TC_Recurly_MRR__c >= 500 THEN 'Tier 2'
WHEN a.TC_Recurly_MRR__c < 500 AND a.TC_Recurly_MRR__c >= 200 THEN 'Tier 3'
WHEN a.TC_Recurly_MRR__c < 200 AND a.TC_Recurly_MRR__c >= 0 THEN 'Tier 4'
ELSE 'Other' END) as Apr on jan.Tier = Apr.Tier
Inner join (select  CASE WHEN a.TC_Recurly_MRR__c > 1000 THEN 'Tier 1' 
WHEN a.TC_Recurly_MRR__c < 1000 AND a.TC_Recurly_MRR__c >= 500 THEN 'Tier 2'
WHEN a.TC_Recurly_MRR__c < 500 AND a.TC_Recurly_MRR__c >= 200 THEN 'Tier 3'
WHEN a.TC_Recurly_MRR__c < 200 AND a.TC_Recurly_MRR__c >= 0 THEN 'Tier 4'
ELSE 'Other' END AS Tier
, count(a.id) as May
from Salesforce.dbo.account as a
where a.type in ('customer', 'ex-customer')
and cast(a.CreatedDate as date) < '2023-06-01'
and (a.Computation_Month__c > '2023-06-01' or a.Computation_Month__c is null)
group by CASE WHEN a.TC_Recurly_MRR__c > 1000 THEN 'Tier 1' 
WHEN a.TC_Recurly_MRR__c < 1000 AND a.TC_Recurly_MRR__c >= 500 THEN 'Tier 2'
WHEN a.TC_Recurly_MRR__c < 500 AND a.TC_Recurly_MRR__c >= 200 THEN 'Tier 3'
WHEN a.TC_Recurly_MRR__c < 200 AND a.TC_Recurly_MRR__c >= 0 THEN 'Tier 4'
ELSE 'Other' END) as May on jan.Tier = May.Tier
Inner join (select  CASE WHEN a.TC_Recurly_MRR__c > 1000 THEN 'Tier 1' 
WHEN a.TC_Recurly_MRR__c < 1000 AND a.TC_Recurly_MRR__c >= 500 THEN 'Tier 2'
WHEN a.TC_Recurly_MRR__c < 500 AND a.TC_Recurly_MRR__c >= 200 THEN 'Tier 3'
WHEN a.TC_Recurly_MRR__c < 200 AND a.TC_Recurly_MRR__c >= 0 THEN 'Tier 4'
ELSE 'Other' END AS Tier
, count(a.id) as June
from Salesforce.dbo.account as a
where a.type in ('customer', 'ex-customer')
and cast(a.CreatedDate as date) < '2023-07-01'
and (a.Computation_Month__c > '2023-07-01' or a.Computation_Month__c is null)
group by CASE WHEN a.TC_Recurly_MRR__c > 1000 THEN 'Tier 1' 
WHEN a.TC_Recurly_MRR__c < 1000 AND a.TC_Recurly_MRR__c >= 500 THEN 'Tier 2'
WHEN a.TC_Recurly_MRR__c < 500 AND a.TC_Recurly_MRR__c >= 200 THEN 'Tier 3'
WHEN a.TC_Recurly_MRR__c < 200 AND a.TC_Recurly_MRR__c >= 0 THEN 'Tier 4'
ELSE 'Other' END) as june on jan.Tier = June.Tier