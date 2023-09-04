select Id, 
website, 
replace(replace(replace(case when right(website, 1) = '/' then SUBSTRING(Website,1,LEN(Website)-1) else website end, 'www.', ''), 'https://', ''), 'http://', '') as newWebsite, 
* 
from Salesforce.dbo.account
where website like 'www.%' or website like 'http%'
