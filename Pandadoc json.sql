SELECT  event = JSON_Value ([pandadoc__InputJSON_EV2__c], '$.event')
, PandaDocId = JSON_Value ([pandadoc__InputJSON_EV2__c], '$.data.id')
, PandaName = JSON_Value ([pandadoc__InputJSON_EV2__c], '$.data.name')
, WASignedBy = JSON_Value ([pandadoc__InputJSON_EV2__c], '$.data.recipients[1].email')
, CUSignedBy = JSON_Value ([pandadoc__InputJSON_EV2__c], '$.data.recipients[0].email')
, SFOppID = JSON_Value ([pandadoc__InputJSON_EV2__c], '$.data.metadata."salesforce.opportunity_id"')
, SFAcctID = JSON_Value ([pandadoc__InputJSON_EV2__c], '$.data.metadata."salesforce.account_id"')
, Template = JSON_Value ([pandadoc__InputJSON_EV2__c], '$.data.template.name')
, Product1 = JSON_Value ([pandadoc__InputJSON_EV2__c], '$.data.products[0].name')
, Qty1 = JSON_Value ([pandadoc__InputJSON_EV2__c], '$.data.products[0].qty')
, Price1 = JSON_Value ([pandadoc__InputJSON_EV2__c], '$.data.products[0].price')
, Product2 = JSON_Value ([pandadoc__InputJSON_EV2__c], '$.data.products[1].name')
, Product3 = JSON_Value ([pandadoc__InputJSON_EV2__c], '$.data.products[2].name')
, Product4 = JSON_Value ([pandadoc__InputJSON_EV2__c], '$.data.products[3].name')
/*, Contract start date,
Contract end date,
Term 
Payment frequency 
Last date to cancel on 
-- Need start and end date for the contact,  
*/
, pd.*
  FROM [Salesforce].[dbo].[pandadoc__PandaDocDocument__c] as pd
 -- cross apply openjson(pd.[pandadoc__InputJSON_EV2__c]) as j
  where id = 'a2f4p000000Ax0sAAC'
