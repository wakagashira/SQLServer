select cast(l.CreatedDate as date) date, count(CreatedDate) as Idcnt  
from Salesforce.dbo.Lead as l
where (Lead_Source_Date__c is null or LeadSource is null) 
and Datepart(year, l.CreatedDate) = 2022
group by cast(l.CreatedDate as date)
order by cast(l.CreatedDate as date)
