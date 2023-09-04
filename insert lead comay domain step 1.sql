truncate table newleadcompany
insert into NewLeadCompany (Domain)
SELECT distinct 
     domain 

	 from GetDomainFromLead
	 where domain is not null 

