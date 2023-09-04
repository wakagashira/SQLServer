SELECT  
a.*
--count(a.[ID]) as count,
--case when b.developerName is null then c.name else b.developerName end as NameOrQueue
  FROM [dbo].[Lead32822] as a
 -- left outer join openquery(SFWA , 'select id, DeveloperName from [Group]') as b on a.OWNERID = b.id
 -- Left outer join openquery(SFWA , 'select id, name  from [User] ') as c on a.OWNERID = c.id
 -- left outer join (select whoid, max(activitydate) as activitydate from [dbo].[Tasks32822] group by whoid) as d on a.id = 	d.WhoId
Left join tempactive as e on a.id = e.id
WHERE   
isnull(a.CLOSED_REASON_C, '1') not in ('Already a customer', 'Competitor Shopping us', 'Country/Language Not supported', 'driver -Non DM', 'Duplicate', 'less than 5', 'No longer with company', 'Out of business', 'Unqualified - not a company', 'unqualified - No Vehicles/equipment', 'test record' )  
and isnull(a.STATUS, '1') not in ('Qualified', 'existing customer', 'exisitng Prospect', 'Account', 'Partner')
and a.COMPANY not like '***%'
and a.company not like '%disney%'
and a.company not like '%not provided%'
and a.COMPANY not like '%retired%'
and a.TITLE != 'Driver'
and isnull(a.TOTAL_FLEET_SIZE_C, 10) >= 10
and e.id is null 

/*group by a.OWNERID,
  b.developerName,
  c.name,
 case when a.CREATEDDATE > dateadd(MONTH, -6, getdate()) then 'Active' 
when d.ActivityDate >= dateadd(MONTH, -6, getdate()) then 'Active'
when a.[ACCOUNT_C] is not null then 'Active'
when a.ISCONVERTED = 'True' then 'Active'
else 'Inactive' end
  order by AvI, count(a.id) desc*/