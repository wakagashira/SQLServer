/****** Script for SelectTopNRows command from SSMS  ******/
Insert into leadcompany (CompanyName, Domain, FleetSize)
SELECT max([COMPANY]) as Company
--,[NAME]
--,EMAIL
,SUBSTRING ([Email], CHARINDEX( '@', [Email]) + 1, LEN([Email])) as EmailDomain

,Max(convert(int, LEFT(TOTAL_FLEET_SIZE_C, CHARINDEX('.', TOTAL_FLEET_SIZE_C) - 1))) as FleetSize


      
  FROM [Whiparound].[dbo].[Leadextract122421]
  where company not like '%***%'
and convert(int, LEFT(TOTAL_FLEET_SIZE_C, CHARINDEX('.', TOTAL_FLEET_SIZE_C) - 1)) >= 10
and company not in ('[not provided]', '[[Unknown]]')
and Name not in ('[not provided]', '[[Unknown]]')
and email LIKE '%_@__%.__%'
and (Company + '||' + Name  not like '%?%||%?%')
--and email = 'melissa_3091@yahoo.com'
and email not like '%@gmail.%'
and email not like '%@yahoo.%'
and email not like '%@aol.%'
and email not like '%@hotmail.%'
and email not like '%@comcast.net'
and email not like '%@bellsouth.net'
and email not like '%@msn.com'
and email not like '%@sbcglobal.net'
and email not like '%@att.net'
and email not like '%@live.com'
and email not like '%@outlook.com'
and email not like '%@verizon.net'
and email not like '%@windstream.net'
and email not like '%@icloud.com'
and email not like '%@ymail.com'
and email not like '%@embarqmail.com'
and email not like '%@cox.net'
and email not like '%@frontier.com'
and email not like '%@centurytel.net'
and email not like '%@charter.net'
and email not like '%@frontiernet.net'
and email not like '%@me.com'
and email not like '%@earthlink.net'
and email not like '%@tds.net'
and email not like '%@optonline.net'
and email not like '%@whiparound.com'
and email not like '%@dotauthority.com'
and email not like '%@cableone.net'
and email not like '%@qwestoffice.net'
and email not like '%@hughes.net'
and email not like '%@mail.com'
and email not like '%@roadrunner.com'
and email not like '%@centurylink.net'
and email not like '%@rocketmail.com'
and email not like '%@fuse.net'
and email not like '%@email.com'
and email not like '%@unknown.com'
Group by SUBSTRING ([Email], CHARINDEX( '@', [Email]) + 1, LEN([Email])) 

order by SUBSTRING ([Email], CHARINDEX( '@', [Email]) + 1, LEN([Email]))