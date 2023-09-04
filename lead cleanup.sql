SELECT top 100000  a.[ID], 
a.ISCONVERTED,
Max(b.activitydate) as MaxActivityTaskDate,
CREATEDDATE,
LAST_TOUCHPOINT_C,
LEAD_SOURCE_DATE_C
,a.LEADSOURCE
,a.[ISDELETED]
      ,a.[LASTNAME]
      ,a.[FIRSTNAME]
      ,a.[SALUTATION]
      ,a.[MIDDLENAME]
      ,a.[SUFFIX]
      ,a.[NAME]
      ,a.[TITLE]
      ,a.[COMPANY]
      ,a.[STREET]
      ,a.[CITY]
      ,a.[STATE]
      ,a.[POSTALCODE]
      ,a.[COUNTRY]
      ,a.[ADDRESS]
      ,a.[PHONE]
      ,a.[MOBILEPHONE]
      ,a.[EMAIL]
      ,a.[WEBSITE]
      ,a.[DESCRIPTION]
      ,a.[LEADSOURCE]
      ,a.[STATUS]
      ,a.[INDUSTRY]
      ,a.[ISCONVERTED]
  FROM [dbo].[Leadextract122421] as a
  left outer join [dbo].[Tasks32822] as b on a.id = 	b.WhoId
  where CREATEDDATE < dateadd(MONTH, -6, getdate()) 
  and (LAST_TOUCHPOINT_C < dateadd(MONTH, -6, getdate()) or LAST_TOUCHPOINT_C is null) 
  and (LEAD_SOURCE_DATE_C < dateadd(MONTH, -6, getdate())  or LEAD_SOURCE_DATE_C is null  )
  and (b.ActivityDate < dateadd(MONTH, -6, getdate()) or b.ActivityDate is null)
  and (a.LAST_EMAIL_CLICKED_C < dateadd(MONTH, -6, getdate()) or a.LAST_EMAIL_CLICKED_C is null)
  and a.COMPANY not like '***%'
  and a.ISCONVERTED != 'True'
  group by a.[ID], 
a.ISCONVERTED,
CREATEDDATE,
LAST_TOUCHPOINT_C,
LEAD_SOURCE_DATE_C
,a.[ISDELETED]
      ,a.[LASTNAME]
      ,a.[FIRSTNAME]
      ,a.[SALUTATION]
      ,a.[MIDDLENAME]
      ,a.[SUFFIX]
      ,a.[NAME]
      ,a.[TITLE]
      ,a.[COMPANY]
      ,a.[STREET]
      ,a.[CITY]
      ,a.[STATE]
      ,a.[POSTALCODE]
      ,a.[COUNTRY]
      ,a.[ADDRESS]
      ,a.[PHONE]
      ,a.[MOBILEPHONE]
      ,a.[EMAIL]
      ,a.[WEBSITE]
      ,a.[DESCRIPTION]
      ,a.[LEADSOURCE]
      ,a.[STATUS]
      ,a.[INDUSTRY]
      ,a.[ISCONVERTED]
	  ,a.LEADSOURCE
	  Order by a.createddate desc