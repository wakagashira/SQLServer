/****** Script for SelectTopNRows command from SSMS  ******/

Select a.id,
a.website,
'True' as for_mass__c

from 
(SELECT 
	  distinct 
	  case when max(email) is not null   then max([Lead_ID]) 
	  when max(First_Name) is not null then Max([Lead_ID])
	  else max([Lead_ID]) end as ID, 
	  dbo.ProperWebsite(website) as Website 
  FROM [Whiparound].[dbo].[LeadForMass]
    group by dbo.ProperWebsite(website))As A
  left outer join openquery(SFWA , 'select id, website from Account') as b on a.website = dbo.ProperWebsite(b.website)
where b.id is null 