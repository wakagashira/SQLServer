select t0.salesforce_account_id,
t0.Id,
t0.name,
t1.name teamname,
t1.teamid,
convert(nvarchar, t0.id) + '-' + convert(nvarchar, t1.teamid) as TheKey, 
isnull(a.Inspections, 0) as Inspections,
isnull(b.inspectingassets, 0) as inspectingassets, isnull(b.totalassets, 0) as totalassets, isnull(c.inspecting,0) as  inspectingDrivers, 
isnull(c.totaldrivers , 0) as totaldrivers, 
isnull(d.NewFault, 0) as NewFault, 
isnull(d.InProgressFault, 0) as InProgressFault , 
isnull(d.CorrectedFault, 0) as CorrectedFaults

from 
 openquery(WAPROD , 'select id, name, salesforce_account_id from public.v2_businesses where salesforce_account_id is not null') as t0
left outer join openquery(WAPROD, 'select id as teamid, business_id, name from public.v2_teams') as t1 on t0.id = t1.business_id
Left outer join dbo.WAProdDInspectingLast30Days as a on t0.id = a.id and t1.teamid = a.teamid
left outer join dbo.WAProdDriversAssetsInspectingLast30Days as b on t0.id = b.businessid and a.teamid = b.teamid
left outer join dbo.WAProdDriversInspectingLast30Days as c on t0.id = c.businessid and t1.teamid = c.teamid
Left Outer Join dbo.WAProdFaults as d on t0.id = d.id and t1.teamid = d.teamid
--where t0.id = 16972
