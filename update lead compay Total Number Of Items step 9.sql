update
NewLeadCompany
set newleadcompany.TotalDriversWCDL = c.TotalDriversWCDL,
newleadcompany.TotalNumberOfDrivers = c.TotalNumberOfDrivers,
newleadcompany.TotalNumberOfHazmat = c.TotalNumberOfHazmat,
newleadcompany.TotalNumberOfTractors = c.TotalNumberOfTractors,
newleadcompany.TotalNumberOfTrailers = c.TotalNumberOfTrailers,
newleadcompany.TotalNumberOfTrucks = c.TotalNumberOfTrucks



from newleadcompany as a 
inner join (

select *

from (
select b.domain,
case when max(c.accountid) is not null then max(d.Total_Drivers_w_CDL__c) else max(a.Total_Drivers_w_CDL__c) end as TotalDriversWCDL,
case when max(c.accountid) is not null then max(d.Total_Number_of_Drivers__c) else max(a.Total_Number_of_Drivers__c) end as TotalNumberOfDrivers,
case when max(c.accountid) is not null then Max(d.Total_Trucks__c) else Max(a.Total_Trucks__c) end as TotalNumberOfTrucks,
case when max(c.accountid) is not null then Max(d.Total_Hazmat_Trucks__c) else Max(a.Total_Hazmat_Trucks__c) end  TotalNumberOfHazmat,
case when max(c.accountid) is not null then Max(d.Total_Tractors__c) else Max(a.Total_Tractors__c) end as TotalNumberOfTractors,
case when max(c.accountid) is not null then max(d.Total_Trailers__c) else max(a.Total_Trailers__c) end as TotalNumberOfTrailers
from leads as a 
inner join GetDomainFromLead as b on a.id = b.id
left outer join NewLeadCompany as c on b.domain = c.domain
left outer join account as d on c.accountid = d.id
Group by b.domain
) as t0
where isnull(TotalDriversWCDL, 0) + isnull(TotalNumberOfDrivers, 0) + isnull(TotalNumberOfHazmat, 0) + isnull(TotalNumberOfTractors, 0) + isnull(TotalNumberOfTrailers, 0) + isnull(TotalNumberOfTrucks, 0) != 0



) as c on a.domain = c.domain 