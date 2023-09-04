select distinct  t0.*, max(t1.id) as App_id
from 
--SFWA is used pulling Devarts Salesforce ODCB driver see Ambrose via linked server 
openquery(sfwa, 'select id, name, Primary_Contact_Email__c from account where appId__c is null
and name not in (''Unknown'', ''Whip Around'', ''whip'', ''test'', ''NA'', ''N/A'', ''None'', ''Myself'', ''Me'', ''Mine'')
and length(name) >=2
and name not like ''***%''
and Primary_Contact_Email__c not like ''%@whiparound.com''
and Primary_Contact_Email__c not like ''test@%''
and Primary_Contact_Email__c not like ''na@%''') as t0
--WAPROD connects to the Postgres system Whiparound_andrew via pg_odbc connector via linked server 
Inner Join openquery(WAPROD, 'SELECT id, Name FROM public.v2_businesses
where salesforce_account_id is null and deleted_at is null ') as t1 on t0.name = t1.name
Group by t0.id,
t0.name,
t0.Primary_Contact_email__c
order by Name

