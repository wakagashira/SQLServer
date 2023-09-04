/****** Script for SelectTopNRows command from SSMS  ******/

Select a.website,
Max(b.id) as ID,
b.type,
'0124p000000iICzAAM' as RecordTypeId,
'T- Account' as [Type],
'T-Prospect' as Terminus_Account_Stage__c

from 
(SELECT /*TOP (1000) [Lead_Source_Date]
      ,[First_Name]
      ,[Last_Name]
      ,[Company_Account]
      ,[Website]
      ,[Email]
      ,[Google_Analytics_Medium]
      ,[Google_Analytics_Source]
      ,[Google_Analytics_Term]
      ,[Pardot_Conversion_Object_Name]
      ,[Lead_Status]
      ,[Fleet_Size]
      ,[Lead_Source]*/
	  distinct 
	  case when max(email) is not null   then max([aCCOUNT_ID]) 
	  when max(First_Name) is not null then Max([Account_ID])
	  else max([ACCOUNT_ID]) end as ID, 
	  dbo.ProperWebsite(website) as Website 
  FROM [dbo].[TermAccounts]
  group by dbo.ProperWebsite(website))As A
  left outer join openquery(SFWA , 'select id, Type,  website from Account') as b on a.website = dbo.ProperWebsite(b.website) and b.[type] in ('Ex-Customer', 'Prospect')
where b.id is not null 
Group by a.website,
b.type
