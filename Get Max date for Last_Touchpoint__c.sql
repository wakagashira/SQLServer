select accountid,
TheDate,
TheDateTime,
LastTouch


From
(

Select accountid,
max(Thedate) as TheDate,
max(TheDateTime) TheDateTime,
Max(Last_Touchpoint__c) as LastTouch
From(

select t0.accountId,
t0.CreatedDate,
convert(date, T0.CreatedDate) as TheDate,
convert(datetime, T0.CreatedDate) as TheDatetime,
convert(datetime, T0.Last_touchpoint__c) as Last_TouchPoint__c
from
(

Select --top  1000
a.*, 
b.*
from
openquery(SFWA, '
SELECT AccountId,
CreatedDate
FROM Task 
WHERE WhatId != null 
AND (Subject LIKE ''Call:Out%'' 
or Subject like ''sms:outbound%'' 
or Subject like ''Email:%''
or SUbject like ''sent%'')
--and accountid = ''0014600001a5dFYAAY''
') as a
left outer join openquery(SFWA , 'select id, Last_Touchpoint__c from Account') as b on a.accountid = b.id

) as t0
) as Z1
where z1.accountId is not null 
Group by z1.accountId

) as A1
Where convert(date, Thedatetime) != convert(date, LastTouch)
