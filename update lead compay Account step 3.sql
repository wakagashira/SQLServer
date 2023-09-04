update
NewLeadCompany
set newleadcompany.accountid = c.account



from newleadcompany as a 
inner join (


SELECT  
     t0.domain, 
	 max(b.id) as Account -- Gets the Max listed Fleet size of all the leads with the same domain
	 from GetDomainFromLead as t0
	 inner join leads as a on t0.id = a.id
	 Left Outer Join Accounts as b on a.ConvertedAccountId = b.id
	 where t0.domain is not null 
	 and b.id is not null 
	 Group by t0.domain



															  ) as c on a.domain = c.domain 

--and newleadcompany.domain = '123.net'


															   





