Select 
--99265 Unique emails
a.domain, a.email, Max(b.Name) as Name
From LeadcontactPhase4 as A 
Inner Join LeadcontactPhase5 as b on a.domain = b.domain and a.email = b.email and a.CountNames = b.countofNames

and Name not like '***%'
group by a.domain, a.email
order by a.domain, a.email