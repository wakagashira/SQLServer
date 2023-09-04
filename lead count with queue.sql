CREATE VIEW dbo.tempActive 
AS

SELECT  
a.id,
a.website,
a.COMPANY,
a.[DOMAIN_C],
a.[DOMAIN_NEW_C],
--count(a.[ID]) as count,
case when a.CREATEDDATE > dateadd(MONTH, -6, getdate()) then 'Create Date' 
when d.ActivityDate >= dateadd(MONTH, -6, getdate()) then 'Activity Date'
when a.[ACCOUNT_C] is not null then 'Has Account'
when a.ISCONVERTED = 'True' then 'Converted'
else 'Inactive' end as activereason,

case when a.CREATEDDATE > dateadd(MONTH, -6, getdate()) then 'Active' 
when d.ActivityDate >= dateadd(MONTH, -6, getdate()) then 'Active'
when a.[ACCOUNT_C] is not null then 'Active'
when a.ISCONVERTED = 'True' then 'Active'
else 'Inactive' end as AvI,
case when b.developerName is null then c.name else b.developerName end as NameOrQueue
  FROM [dbo].[Lead32822] as a
  left outer join openquery(SFWA , 'select id, DeveloperName from [Group]') as b on a.OWNERID = b.id
  Left outer join openquery(SFWA , 'select id, name  from [User] ') as c on a.OWNERID = c.id
  left outer join (select whoid, max(activitydate) as activitydate from [dbo].[Tasks32822] group by whoid) as d on a.id = 	d.WhoId
WHERE   case when a.CREATEDDATE > dateadd(MONTH, -6, getdate()) then 'Active' 
when d.ActivityDate >= dateadd(MONTH, -6, getdate()) then 'Active'
when a.[ACCOUNT_C] is not null then 'Active'
when a.ISCONVERTED = 'True' then 'Active'
else 'Inactive' end = 'Active'

/*group by a.OWNERID,
  b.developerName,
  c.name,
 case when a.CREATEDDATE > dateadd(MONTH, -6, getdate()) then 'Active' 
when d.ActivityDate >= dateadd(MONTH, -6, getdate()) then 'Active'
when a.[ACCOUNT_C] is not null then 'Active'
when a.ISCONVERTED = 'True' then 'Active'
else 'Inactive' end
  order by AvI, count(a.id) desc*/