update
NewLeadCompany
set newleadcompany.FleetSize = c.fleetsize
from newleadcompany as a 
inner join (



SELECT 
     t0.domain, 
	 max(a.Total_Fleet_Size__c) as FleetSize -- Gets the Max listed Fleet size of all the leads with the same domain
	 from GetDomainFromLead as t0
	 inner join leads as a on t0.id = a.id
	 where t0.domain is not null 
	 Group by t0.domain


															  ) as c on a.domain = c.domain 
															   





