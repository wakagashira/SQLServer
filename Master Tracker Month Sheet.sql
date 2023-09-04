select NS.ReportDate,
[dbo].[GetTotalWorkingDays](DATEADD(month, DATEDIFF(month, 0, Getdate()), 0), getdate()) as 'Days In', 
[dbo].[GetTotalWorkingDays](getdate(), EOMONTH(getdate())) as 'Days To Get It Done...',
KL.[New_Sales_Goal__c] as 'New Sales Goal',  --Q3
NS.NewSales as 'New Sales', --Q6
NP.SatNegotiating as 'Negotiating', --Q9
NS.NewSales + NP.PilotNegotiatingTotal as 'New Sales + Negotiating', --Q12
NP.Pilot , --Q15
NP.Pilot + NP.SatNegotiating as 'Negotiating + Pilot',--Q18
NP.Pilot + NP.SatNegotiating  + NS.NewSales as 'New Sales + Total Forcast', --Q21
NS.NewSales - KL.New_Sales_Goal__c as 'MRR Gap', --Q23
(NS.NewSales + NP.PilotNegotiatingTotal) - KL.New_Sales_Goal__c as 'Forcasted MRRGap', --Q28
KL.Expansion_Goal__c as 'CS Totals', --S3
Cmm.mrr_expansion as Expansion,--S6
BE.ExpansionMRR as '(bi) Expansion',--S9
Cmm.mrr_expansion + BE.ExpansionMRR as '*expansion + (bi)',--S12  S9+S6
0 as 'Additinal Expansion (cs)',--S15 currently unset
Cmm.mrr_reactivation as Reactivation,--S18
CMM.mrr_contraction as 'Current Contraction',--S21
BE.ContractionMRR as '(bi) Contraction',--S24
CMM.mrr_contraction + BE.ContractionMRR as 'Contraction Forecast', --S27 =S21+S24
CMM.mrr_churn as 'Current Churn',--S30
CM.Churn_Mrr as '(bi) Churn', --S33
CMM.mrr_churn + CM.Churn_Mrr as 'Churn Forecast', --S36 =S30+S33
CMM.mrr_contraction + BE.ContractionMRR+ CMM.mrr_churn + CM.Churn_Mrr as 'C&C Forecast',--S39 =S27+S36
KL.Expansion_Goal__c - Cmm.mrr_expansion as 'Expansion GAP',--S6--S42 =S3-S6
KL.Expansion_Goal__c - (Cmm.mrr_expansion + BE.ExpansionMRR) as 'Forecasted Exp GAP', --S54 =S3-S12
KL.[New_Sales_Goal__c] + KL.Expansion_Goal__c as 'Gross/Net Totals',--U3
NS.NewSales + Cmm.mrr_expansion + Cmm.mrr_reactivation as 'Gross Total',--U6 =Q6+S6+S18
(KL.[New_Sales_Goal__c] + KL.Expansion_Goal__c) - (NS.NewSales + Cmm.mrr_expansion + Cmm.mrr_reactivation) as 'Gross GAP', --U9 =U3 - U6 
(NP.Pilot + NP.SatNegotiating  + NS.NewSales) + (Cmm.mrr_expansion + BE.ExpansionMRR) as 'Total Projected Gross',-- U12 =Q21+S12
KL.C_C_Goal__c as 'C&C Goal',--U15 
(KL.[New_Sales_Goal__c] + KL.Expansion_Goal__c) - (KL.C_C_Goal__c) as 'Net Goal',--U18 =U3-U15
((NP.Pilot + NP.SatNegotiating  + NS.NewSales) + (Cmm.mrr_expansion + BE.ExpansionMRR)) - (BE.ContractionMRR) as 'Forecasted Net',  --U21 =U12-S24
((KL.[New_Sales_Goal__c] + KL.Expansion_Goal__c) - (KL.C_C_Goal__c)) - ((KL.[New_Sales_Goal__c] + KL.Expansion_Goal__c) - (KL.C_C_Goal__c)) as 'Net GAP', --U24 =U18-X18
((KL.[New_Sales_Goal__c] + KL.Expansion_Goal__c) - (KL.C_C_Goal__c)) - (((NP.Pilot + NP.SatNegotiating  + NS.NewSales) + (Cmm.mrr_expansion + BE.ExpansionMRR)) - (BE.ContractionMRR)) as 'Forecasted Net GAP', --U27 =U18-U21
NS.NewSales as 'New Business MRR',--X3 
--Cmm.mrr_expansion as 'Expansion',--X6 = S6
CMM.mrr_contraction as 'Contraction', --X9 = S21
CMM.mrr_churn as Churn, --X12 =S30
--Cmm.mrr_reactivation as Reactivation, --X15 = S18
(NS.NewSales) + (Cmm.mrr_expansion) - (CMM.mrr_contraction) - (CMM.mrr_churn) + (Cmm.mrr_reactivation) as 'Net MRR Movement', --X18 =X3+X6-X9-X12+X15
((NS.NewSales) + (Cmm.mrr_expansion) - (CMM.mrr_contraction) - (CMM.mrr_churn) + (Cmm.mrr_reactivation)) + (NS.NewSales) as MRR,--x21 =X6+X3
(cmm.mrr_expansion + cmm.mrr_contraction + cmm.mrr_churn + CMM.mrr_reactivation) + (BE.ExpansionMRR - Be.ContractionMRR) - cm.Churn_Mrr as 'Projected CS NRR', --Per Tyler J for slack 
((cmm.mrr_expansion + cmm.mrr_contraction + cmm.mrr_churn + CMM.mrr_reactivation) + (BE.ExpansionMRR - Be.ContractionMRR) - cm.Churn_Mrr) + NS.NewSales as 'Current NET' -- Q3 + Projected CS NRR
from dbo.MasterTrackerNewSales as NS
left outer Join dbo.MasterTrackerNegotiatingAndPilot as NP on NS.ReportDate = NP.ReportDate
Left Outer Join dbo.MasterTrackerKeyLevers as KL on NS.ReportDate = KL.ReportDate
left outer join dbo.MasterTrackerBiExpansionContractionMRR as BE on NS.ReportDate = be.ReportDate
Left outer join [dbo].[MasterTrackerChrunMRR] as CM on ns.ReportDate = cm.ReportDate
Left outer join dbo.MasterTrackerCMMetrics as CMM on ns.ReportDate = cmm.ReportDate