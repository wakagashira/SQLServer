select l.id, 
l.Name,
l.Company,
l.pi__url__c,
l.LeadSource, 
l.pi__conversion_object_name__c, 
l.* 
from lead as l
left outer join (
select id, 
Name,
Company,
pi__url__c,
LeadSource, 
pi__conversion_object_name__c
from lead 
where  
LeadSource in ('Intercom', 'Software Advice', 'Phone Inquiry')

or 
(pi__conversion_object_name__c is not null and 
pi__conversion_object_name__c not like '%ebook%' and 
pi__conversion_object_name__c not like '%Webinar%')) as l1 on l.id = l1.id
where l1.id is null and l.pi__url__c is  null 


