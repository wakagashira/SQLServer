select [dbo].[GetTotalWorkingDays](DATEADD(month, DATEDIFF(month, 0, Getdate()), 0), getdate()) as 'Days In', [dbo].[GetTotalWorkingDays](getdate(), EOMONTH(getdate())) as 'Days To Get It Done...'