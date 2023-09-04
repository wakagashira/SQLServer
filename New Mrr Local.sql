select 
a.name,
a.LastMonthMRR,
b.Added,
b.Removed,
b.MRRChangeTotal,
sum(a.LastMonthMRR + b.MRRChangeTotal) as NewMRR


from 
[dbo].[GetLocalMRRLastPlan] as a
Left Outer Join 
[dbo].[GetLocalMRRChangeTotal] as b 
on a.accountid = b.accountid
where b.MRRChangeTotal <> 0
group by 
a.name,
a.LastMonthMRR,
b.Added,
b.Removed,
b.MRRChangeTotal