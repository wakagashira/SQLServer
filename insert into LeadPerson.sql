/****** Script for SelectTopNRows command from SSMS  ******/

SELECT distinct a.[COMPANY]
,a.[NAME]
,a.EMAIL
,SUBSTRING (a.[Email], CHARINDEX( '@', a.[Email]) + 1, LEN(a.[Email])) as EmailDomain
,convert(int, LEFT(a.TOTAL_FLEET_SIZE_C, CHARINDEX('.', a.TOTAL_FLEET_SIZE_C) - 1)) as FleetSize
, b.ID as CompanyID

  INTO LeadPerson    
  FROM [Whiparound].[dbo].[Leadextract122421] as a
  Inner join leadcompany as b on SUBSTRING (a.[Email], CHARINDEX( '@', a.[Email]) + 1, LEN(a.[Email])) = b.domain

  where a.company not like '%***%'
and convert(int, LEFT(a.TOTAL_FLEET_SIZE_C, CHARINDEX('.', a.TOTAL_FLEET_SIZE_C) - 1)) >= 10
and a.company not in ('[not provided]', '[[Unknown]]')
and a.Name not in ('[not provided]', '[[Unknown]]')
and a.email LIKE '%_@__%.__%'
and (a.Company + '||' + a.Name  not like '%?%||%?%')
--and email = 'melissa_3091@yahoo.com'
and a.email not like '%@gmail.%'
and a.email not like '%@yahoo.%'
and a.email not like '%@aol.%'
and a.email not like '%@hotmail.%'
and a.email not like '%@comcast.net'
and a.email not like '%@bellsouth.net'
and a.email not like '%@msn.com'
and a.email not like '%@sbcglobal.net'
and a.email not like '%@att.net'
and a.email not like '%@live.com'
and a.email not like '%@outlook.com'
and a.email not like '%@verizon.net'
and a.email not like '%@windstream.net'
and a.email not like '%@icloud.com'
and a.email not like '%@ymail.com'
and a.email not like '%@embarqmail.com'
and a.email not like '%@cox.net'
and a.email not like '%@frontier.com'
and a.email not like '%@centurytel.net'
and a.email not like '%@charter.net'
and a.email not like '%@frontiernet.net'
and a.email not like '%@me.com'
and a.email not like '%@earthlink.net'
and a.email not like '%@tds.net'
and a.email not like '%@optonline.net'
and a.email not like '%@whiparound.com'
and a.email not like '%@dotauthority.com'
and a.email not like '%@cableone.net'
and a.email not like '%@qwestoffice.net'
and a.email not like '%@hughes.net'
and a.email not like '%@mail.com'
and a.email not like '%@roadrunner.com'
and a.email not like '%@centurylink.net'
and a.email not like '%@rocketmail.com'
and a.email not like '%@fuse.net'
and a.email not like '%@email.com'
and a.email not like '%@unknown.com'

