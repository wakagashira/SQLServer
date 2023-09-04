update
NewLeadCompany
set newleadcompany.company = c.companyName



from newleadcompany as a 
inner join (

select a.Domain,
case when b.accountid is not null then c.name
else a.Company end as CompanyName

from GetBestCompanyNameNoAccount as a 
Inner Join NewLeadCompany as b on a.domain = b.domain
Left Outer join account as c on b.accountid = c.id
) as c on a.domain = c.domain 