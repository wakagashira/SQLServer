select NS.ReportDate,
(NP.Pilot + NP.SatNegotiating  + NS.NewSales) + ((Cmm.mrr_expansion + BE.ExpansionMRR ) - (CMM.mrr_contraction + BE.ContractionMRR+ CMM.mrr_churn + CM.Churn_Mrr)) as 'Projected Net MRR', --Q21 + (S12 - S39) 
NS.NewSales as 'New Sales MTD', --Q6
(NP.Pilot + NP.SatNegotiating  + NS.NewSales) as 'New Sales Projected', --Q21
((Cmm.mrr_expansion + BE.ExpansionMRR ) - (CMM.mrr_contraction + BE.ContractionMRR+ CMM.mrr_churn + CM.Churn_Mrr)) as 'Projected Net Revenue', --'Feb 22'!S12 - 'Feb 22'!S39
Null as 'Change vs yesterday',
KL.[New_Sales_Goal__c] as 'New Sales Goal',--Q3
kl.Reactivation_Goal__c as 'Reactivation Goal', 
KL.Expansion_Goal__c as 'Expansion Goal',
KL.Expected_Contraction__c 'Contraction Goal',
KL.Expected_Churn__c as 'Churn Goal',
KL.[New_Sales_Goal__c] + KL.Expansion_Goal__c - KL.Expected_Contraction__c - KL.Expected_Churn__c as 'Net MRR',
kl.Price_Increase__c

from dbo.MasterTrackerNewSales as NS
left outer Join dbo.MasterTrackerNegotiatingAndPilot as NP on NS.ReportDate = NP.ReportDate
Left Outer Join dbo.MasterTrackerKeyLevers as KL on NS.ReportDate = KL.ReportDate
Left outer join dbo.MasterTrackerCMMetrics as CMM on ns.ReportDate = cmm.ReportDate
left outer join dbo.MasterTrackerBiExpansionContractionMRR as BE on NS.ReportDate = be.ReportDate
Left outer join [dbo].[MasterTrackerChrunMRR] as CM on ns.ReportDate = cm.ReportDate
left outer join openquery(SFWA , 'select id, website from Account') as b on a.website = dbo.ProperWebsite(b.website) 