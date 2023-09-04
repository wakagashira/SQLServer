update
NewLeadCompany
set newleadcompany.Segment = c.Segment__c



from newleadcompany as a 
inner join (

select t0.domain,
case 
when Min(t0.SegRank) = 1 then 'Strategic'
when Min(t0.SegRank) = 2 then 'ENT'
when Min(t0.SegRank) = 3 then 'Mid Market'
when Min(t0.SegRank) = 4 then 'SMB'
when Min(t0.SegRank) = 5 then 'Micro'
when Min(t0.SegRank) = 6 then 'Missing Fleet Size'
else 'Missing Fleet Size' end as Segment__c
from (
select b.domain 
,case
when a.Segment__c = 'Strategic' then 1
when a.Segment__c = 'ENT' then 2
when a.Segment__c = 'Mid Market' then 3
when a.Segment__c = 'SMB' then 4
when a.Segment__c = 'Micro' then 5
when a.Segment__c = 'Missing Fleet Size' then 6
else 6
end as SegRank
from leads as a 
Inner join GetDomainFromLead as b on a.id = b.id) as t0

group by t0.domain


) as c on a.domain = c.domain 