select NS.ReportDate,
--format(NS.NewSales, 'N0'),
sfc.Calls,
sfco.ConvoCnt, 
sfsat.Sat,
sfb.sit as Booked,
sfd.Deals, 
sfa.Assets,
sfmrr.MRR,
sfb.sit as scheduled,
sfb.sit - sfrb.Rebookings as NewBookings,
sfrb.Rebookings as ReBookings,
[dbo].[GetTotalWorkingDays](DATEADD(month, DATEDIFF(month, 0, Getdate()), 0), getdate()) as 'Days In', 
[dbo].[GetTotalWorkingDays](getdate(), EOMONTH(getdate())) as 'Days To Get It Done...',
'* New Sales - $' + convert(nvarchar, format(NS.NewSales, 'N0')) + ' / $' + convert(nvarchar, format(KL.[New_Sales_Goal__c], 'N0')) as 'Slack New Sales',--Q6 / Q3
'* Projected CS NRR - $' + convert(nvarchar, format((cmm.mrr_expansion + cmm.mrr_contraction + cmm.mrr_churn + CMM.mrr_reactivation) + (BE.ExpansionMRR - Be.ContractionMRR) - cm.Churn_Mrr, 'N0')) as ' Slack Projected CS NRR', --Per Tyler J work 
'* SAT Pipeline - $' + Convert(nvarchar, NP.SatNegotiating ) + ' + $' + convert(nvarchar, NP.Pilot) + ' in Pilot' as 'Slack SAT Pipeline',   -- Q9 and Q15
'* Current NET = $' + convert(nvarchar, Round(((cmm.mrr_expansion + cmm.mrr_contraction + cmm.mrr_churn + CMM.mrr_reactivation) + (BE.ExpansionMRR - Be.ContractionMRR) - cm.Churn_Mrr) + NS.NewSales, 2,1)) + ' / $' + convert(nvarchar, Round(Kl.Net_MRR_Goal__c, 2,1)) as 'Current NET' -- Q3 + Projected CS NRR

from dbo.MasterTrackerNewSales as NS
left outer Join dbo.MasterTrackerNegotiatingAndPilot as NP on NS.ReportDate = NP.ReportDate
Left Outer Join dbo.MasterTrackerKeyLevers as KL on NS.ReportDate = KL.ReportDate
left outer join dbo.MasterTrackerBiExpansionContractionMRR as BE on NS.ReportDate = be.ReportDate
Left outer join [dbo].[MasterTrackerChrunMRR] as CM on ns.ReportDate = cm.ReportDate
Left outer join dbo.MasterTrackerCMMetrics as CMM on ns.ReportDate = cmm.ReportDate
left outer Join [dbo].[MasterTrackerSFCalls] as SFC on ns.ReportDate = sfc.ReportDate
left outer Join [dbo].[MasterTrackerSFConvoCnt] as SFCO on ns.ReportDate = sfco.ReportDate
left outer Join dbo.MasterTrackerSFSat as SFSAT on ns.ReportDate = sfsat.ReportDate
Left Outer Join dbo.MasterTrackerSFBooked as SFB on ns.ReportDate = sfb.ReportDate
Left Outer Join dbo.MasterTrackerSFDeals as SFD on ns.ReportDate = SFD.ReportDate
Left Outer Join dbo.MasterTrackerSFAssets as SFA on ns.reportDate = SFA.ReportDate
Left Outer Join dbo.MasterTrackerSFMRR as SFMRR on ns.reportDate = SFMRR.ReportDate
Left Outer Join [dbo].[MasterTrackerSFRebookings] as SFRB on ns.reportDate = SFRB.ReportDate