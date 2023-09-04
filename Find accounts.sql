/****** Script for SelectTopNRows command from SSMS  ******/

Select a.*

from 
(SELECT 
	  [OwnerID],
	  [First_Name],
	  [Last_Name],
	  [Company_1],
	  [Address_1],
	  [Email_Address],
	  [City],
	  [State_Province],
	  [Postal_Code],
	  [Phone],
	  [Title],
	  [Campaign_Name],
	  [Campaign_Member_Status],
	  dbo.ProperWebsite(website) as Website 
  FROM [dbo].[WOC22 lead list (1)]
   -- group by dbo.ProperWebsite(website)
   )As A
  left outer join openquery(SFWA , 'select id, website from Account') as b on a.website = dbo.ProperWebsite(b.website)
where b.id is null 