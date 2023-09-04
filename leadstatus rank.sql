select distinct status,
case when 
status = 'Attempting Contact' then '3'
when status = 'Call completed' then '6'
when status ='Call new'then '4'
when status ='Call scheduled'then '5'
when status ='Closed Lead'then '25'
when status ='Contacted'then '7'
when status ='Engaging'then '9'
when status ='Existing Customer'then '110'
when status ='Existing Prospect Account' then '100'
when status ='Open' then '2'
when status ='Open - Not Contacted' then '1'
when status ='Partner' then '50'
when status ='Qualified' then '8'
when status ='Waiting to book' then '10'
else 0 end as StatusNumb
from leads
where datepart(year, LastModifiedDate) = 2021
order by statusnumb