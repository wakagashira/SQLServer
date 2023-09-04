select 
convert(date, Getdate()) as Date, 
convert(nvarchar, convert(date, Getdate())) + '-' + t0.account__c as theKey,
t0.Account__c as accountId,
t0.id as OldId,
t1.Id as NewId,
t1.Inspect_Actual_Count__c as NewInspectAssets,
t0.Inspect_Actual_Count__c as OldInspectAssets,
t1.Inspect_Actual_Count__c - t0.Inspect_Actual_Count__c as ChangeInInspectAssets,
t1.Maintain_Assets__c as NewMaintainAssets,
t0.Maintain_Assets__c as OldMaintainAssets,
t1.Maintain_Assets__c - t0.Maintain_Assets__c as ChangeInMaintainAssets,
t1.Inspect_Lite_Assets__c NewInspectLiteAssets,
t0.Inspect_Lite_Assets__c OldInspectLiteAssets,
t1.Inspect_Lite_Assets__c - t0.Inspect_Lite_Assets__c as ChangeInInspectLiteAssets,
t1.Maintain_Lite_Assets__c NewMaintainLiteAssets,
t0.Maintain_Lite_Assets__c OldMaintainLiteAssets,
t1.Maintain_Lite_Assets__c	- t0.Maintain_Lite_Assets__c as ChangeInMaintainLiteAssets
from  openquery(SFWA , 'select Account__c , id, Inspect_Actual_Count__c, Maintain_Assets__c, Inspect_Lite_Assets__c, Maintain_Lite_Assets__c, wa_appid__c from WA_Asset__c where date__c = ''2022-06-14''') as t0
inner join openquery(SFWA , 'select Account__c , id, Inspect_Actual_Count__c, Maintain_Assets__c, Inspect_Lite_Assets__c, Maintain_Lite_Assets__c, wa_appid__c from WA_Asset__c where date__c = ''2022-06-13''') as t1 on t0.wa_appid__c = t1.wa_appid__c
where (t1.Inspect_Actual_Count__c - t0.Inspect_Actual_Count__c) + (t1.Maintain_Assets__c - t0.Maintain_Assets__c) + (t1.Inspect_Lite_Assets__c - t0.Inspect_Lite_Assets__c) + (t1.Maintain_Lite_Assets__c	- t0.Maintain_Lite_Assets__c) != 0


