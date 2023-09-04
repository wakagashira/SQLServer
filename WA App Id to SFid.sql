 select a.id as WAid,
 b.id as SFid
 from
 
 
 openquery(WAPROD , 'SELECT ID, Name, salesforce_account_id, * FROM public.v2_businesses where Name not like ''***%'' and Name != ''Unknown'' and salesforce_account_id is null and sub_status in (''trial'', ''active'')') as a
 left outer join openquery(SFWA , 'select id, Name from Account where 	AppID__c = null and type = ''customer''') as b on a.Name = b.name
 where b.id is not null 
 order by WAid