select o.id, 
o.Term__c, 
o.contract_term__c, 
o.Payment_Frequency__c,
pd.pandadoc__Status__c  ,
pd.pandadoc__InputJSON_EV2__c,
pd.pandadoc__InputJSON__c,
case when pd.pandadoc__Status__c = 'document.completed' then 1 else 0 end as HasContractSigned ,
case when isnull(pd.pandadoc__Status__c, 'document.voided') != 'document.voided' then 1 else 0 end as HasOfferedContract,
case 
when isnull(pd.pandadoc__Status__c, 'document.voided') = 'document.voided' then Null 
when (o.Term__c) like '12 Months%' then '12 Months'
when (o.Term__c) = 'Month-to-Month' then 'N/A'
when (o.Term__c) = '48 Months' then '48 Months'
when (o.Term__c) like '6 Months%' then '6 Months' 
when (o.Term__c) like '24 Months%' then '24 Months'
when (o.Term__c) = '3 Months' Then '3 Months'
when (o.Term__c) = '36 Months' then '36 Months'
when (o.Term__c) = '6 month%' then '6 Months'
else Null 
end as Contract_term__c__New,
case 
when (o.Term__c) = 'Month-to-Month' then 'Monthly'
when (o.Term__c) = '48 Months' then 'Every 48 Months'
when (o.Term__c) = '6 Months(Monthly)' then 'Monthly'
when (o.Term__c) = '12 Months(Monthly)' then 'Monthly'
when (o.Term__c) = '24 Months (Paid Upfront Contract)' then 'Every 24 Months'
when (o.Term__c) = '3 Months' then 'Every 3 Months'
when (o.Term__c) = '36 Months' then 'Every 36 Months'
when (o.Term__c) = '6 month( Contract paid monthly)' then 'Monthly'
when (o.Term__c) = '6 month (Contract paid upfront)' then 'Every 6 Months' 
when (o.Term__c) = '12 Months (Paid Upfront Contract)' then 'Every 12 Months'
when (o.Term__c) = '12 Months (Paid Upfront)' then 'Every 12 Months'
when (o.Term__c) = '24 Months' then 'Every 24 Months'
when (o.Term__c) = '12 Months_MC' then 'Monthly'
when (o.Term__c) = '12 Months( Quarterly Contract)' then 'Every 3 months'
when (o.Term__c) = '24 Month (Monthly Contract)' then 'Monthly'
else null end as PaymentFrequency__c_new

from Salesforce.dbo.pandadoc__PandaDocDocument__c as pd
Left Outer Join Salesforce.dbo.Opportunity as o on pd.pandadoc__Opportunity__c = o.id
WHERE pd.pandadoc__Status__c = 'document.completed';

