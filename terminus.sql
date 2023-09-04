/****** Script for SelectTopNRows command from SSMS  ******/
SELECT a.[Account_ID]
--,b.id as SFID
      ,a.[Account_Name]
      ,dbo.ProperWebsite(a.website) as  ListWebsite
	--  ,dbo.ProperWebsite(b.website) as SFWebsite
      ,'0124p000000iICzAAM' AS [RecordTypeID]
	  ,'T- Account' AS Type
	  ,'T-Prospect' as [Terminus_Account_Stage]
  FROM [Whiparound].[dbo].[termdedup3] as a
  Left outer join openquery(SFWA, 'SELECT Id,Website FROM Account WHERE Type = ''T- Account'' AND Terminus_Account_Stage__c like ''T-%''') as b on dbo.ProperWebsite(a.website) = dbo.ProperWebsite(b.Website)
  where dbo.ProperWebsite(b.website) is null 
  -- is null removes SF websites that match the current system 
