select t0.division, 
t0.description OneDigitDescription,
t1.Major_Group,
t1.Description TwoDigitDescription,
t2.Industry_Group,
t2.Description ThreeDigitDescription,
t3.[SIC],
t3.Description as FourDigitDescription
from recurly.[dbo].[1Sic] as t0
Left outer join recurly.[dbo].[2Sic] as t1 on t0.Division = t1.Division
Left outer join recurly.[dbo].[3Sic] as t2 on t0.Division = t2.Division and t1.Major_Group = t2.Major_Group
Left outer join recurly.[dbo].[4Sic] as t3 on t0.Division = t3.Division and t1.Major_Group = t3.Major_Group and t2.Industry_Group = t3.Industry_Group