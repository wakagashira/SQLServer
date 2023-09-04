Select sum(a.totaltickets) as TotalTickets,
sum(a.ClosedTickets) as ClosedTickets,
Sum(a.data) as Data,
Sum(a.Recurly) as Recurly,
Sum(a.Dashboard) as Dashboard,
Sum(a.Reporting) as Reporting,
Sum(a.AutomationRequest) As Automation,
Sum(a.Sales) as Sales,
Sum(a.CustomerSuccess) as CS,
Sum(a.Marketing) as Marketing


from 


(select  
count(ticket_id) as TotalTickets,
0 as ClosedTickets,
0 as Data,	
0 as Recurly,
0 as Dashboard,	
0 as Reporting,	
0 as AutomationRequest,
0 as Sales,
0 as CustomerSuccess,
0 as Marketing
from Halp 
where 
[Created_At] like '2021-11-%' 
--or  closed_at like '2021-11-%' ) 
Union 
select 
0 as TotalTickets,
count(ticket_id) as ClosedTickets,
0 as Data,	
0 as Recurly,
0 as Dashboard,	
0 as Reporting,	
0 as AutomationRequest,
0 as Sales,
0 as CustomerSuccess,
0 as Marketing
from Halp 
where 
--([Created_At] like '2021-11-%' 
closed_at like '2021-11-%' 

Union
select 
0 as TotalTickets,
0 as ClosedTickets,
count(ticket_id) as Data,	
0 as Recurly,
0 as Dashboard,	
0 as Reporting,	
0 as AutomationRequest,
0 as Sales,
0 as CustomerSuccess,
0 as Marketing
from Halp 
where 
([Created_At] like '2021-11-%' 
or  closed_at like '2021-11-%' ) 
and Type like '%data%'

Union
select 
0 as TotalTickets,
0 as ClosedTickets,
0 as Data,	
count(ticket_id) as Recurly,
0 as Dashboard,	
0 as Reporting,	
0 as AutomationRequest,
0 as Sales,
0 as CustomerSuccess,
0 as Marketing
from Halp 
where 
([Created_At] like '2021-11-%' 
or  closed_at like '2021-11-%' ) 
and type like '%rec%'

Union
select 
0 as TotalTickets,
0 as ClosedTickets,
0 as Data,	
0 as Recurly,
count(ticket_id) as Dashboard,	
0 as Reporting,	
0 as AutomationRequest,
0 as Sales,
0 as CustomerSuccess,
0 as Marketing
from Halp 
where 
([Created_At] like '2021-11-%' 
or  closed_at like '2021-11-%' ) 
and type like '%dash%'

Union
select 
0 as TotalTickets,
0 as ClosedTickets,
0 as Data,	
0 as Recurly,
0 as Dashboard,	
count(ticket_id) as Reporting,	
0 as AutomationRequest,
0 as Sales,
0 as CustomerSuccess,
0 as Marketing
from Halp 
where 
([Created_At] like '2021-11-%' 
or  closed_at like '2021-11-%' ) 
and type like '%repor%'

Union
select 
0 as TotalTickets,
0 as ClosedTickets,
0 as Data,	
0 as Recurly,
0 as Dashboard,	
0 as Reporting,	
count(ticket_id) as AutomationRequest,
0 as Sales,
0 as CustomerSuccess,
0 as Marketing
from Halp 
where 
([Created_At] like '2021-11-%' 
or  closed_at like '2021-11-%' ) 
and type like '%auto%'

Union
select 
0 as TotalTickets,
0 as ClosedTickets,
0 as Data,	
0 as Recurly,
0 as Dashboard,	
0 as Reporting,	
0 as AutomationRequest,
count(ticket_id) as Sales,
0 as CustomerSuccess,
0 as Marketing
from Halp 
where 
([Created_At] like '2021-11-%' 
or  closed_at like '2021-11-%' ) 
and department like '%sales%'
Union
select 
0 as TotalTickets,
0 as ClosedTickets,
0 as Data,	
0 as Recurly,
0 as Dashboard,	
0 as Reporting,	
0 as AutomationRequest,
0 as Sales,
count(ticket_id) as CustomerSuccess,
0 as Marketing
from Halp 
where 
([Created_At] like '2021-11-%' 
or  closed_at like '2021-11-%' ) 
and department like '%customer%'

Union
select 
0 as TotalTickets,
0 as ClosedTickets,
0 as Data,	
0 as Recurly,
0 as Dashboard,	
0 as Reporting,	
0 as AutomationRequest,
0 as Sales,
0 as CustomerSuccess,
count(ticket_id) as Marketing
from Halp 
where 
([Created_At] like '2021-11-%' 
or  closed_at like '2021-11-%' ) 
and department like '%Mark%'
) as a