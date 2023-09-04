select I.type,
a.TotalAccountCnt,
i.IndustryCnt,
z.ZoomIndustryCnt,
s.SicCnt,
s2.Sic2Cnt,
s4.Sic4Cnt

from
(select type, 
count(industry) as IndustryCnt
--, ZoomInfo_Industry__c, Sic, SIC_Code2__c, SicDesc, X4_Digit_SIC__c, * 
from Salesforce.dbo.Account as a 
where industry is not null 
--, ZoomInfo_Industry__c, Sic, SIC_Code2__c, SicDesc, X4_Digit_SIC__c, * 
Group by Type) as I
Left outer join (select type, 
count(ZoomInfo_Industry__c) as ZoomIndustryCnt
--, ZoomInfo_Industry__c, Sic, SIC_Code2__c, SicDesc, X4_Digit_SIC__c, * 
from Salesforce.dbo.Account as a 
where ZoomInfo_Industry__c is not null 
--, ZoomInfo_Industry__c, Sic, SIC_Code2__c, SicDesc, X4_Digit_SIC__c, * 
Group by Type) as z on I.Type = z.type
Left outer join (select type, 
count(Id) as TotalAccountCnt
--, ZoomInfo_Industry__c, Sic, SIC_Code2__c, SicDesc, X4_Digit_SIC__c, * 
from Salesforce.dbo.Account as a  
Group by Type) as a on I.Type = a.type
Left outer join (select type, 
count(Sic) as SicCnt
--, ZoomInfo_Industry__c, Sic, SIC_Code2__c, SicDesc, X4_Digit_SIC__c, * 
from Salesforce.dbo.Account as a 
where sic is not null 
--, ZoomInfo_Industry__c, Sic, SIC_Code2__c, SicDesc, X4_Digit_SIC__c, * 
Group by Type) as s on I.Type = s.type
Left outer join (select type, 
count(SIC_Code2__c) as Sic2Cnt
--, ZoomInfo_Industry__c, Sic, SIC_Code2__c, SicDesc, X4_Digit_SIC__c, * 
from Salesforce.dbo.Account as a 
where SIC_Code2__c is not null 
--, ZoomInfo_Industry__c, Sic, SIC_Code2__c, SicDesc, X4_Digit_SIC__c, * 
Group by Type) as s2 on I.Type = s2.type
Left outer join (select type, 
count(X4_Digit_SIC__c) as Sic4Cnt
--, ZoomInfo_Industry__c, Sic, SIC_Code2__c, SicDesc, X4_Digit_SIC__c, * 
from Salesforce.dbo.Account as a 
where X4_Digit_SIC__c is not null 
--, ZoomInfo_Industry__c, Sic, SIC_Code2__c, SicDesc, X4_Digit_SIC__c, * 
Group by Type) as s4 on I.Type = s4.type