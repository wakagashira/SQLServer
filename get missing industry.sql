select ZoomInfo_Industry__c,
Industry,
Sic,
SIC_Code2__c,
SicDesc,
X4_Digit_SIC__c
from Salesforce.dbo.account
where type = 'customer' and industry is null 