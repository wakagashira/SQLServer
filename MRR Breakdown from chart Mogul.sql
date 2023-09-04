/****** Script for SelectTopNRows command from SSMS  ******/
 select CONVERT(date, GETDATE(), 23) AS ReportDate
      ,[mrr]
      ,[arr]
      ,[customers]
      ,[asp]
      ,[arpa]
      ,[customer_churn_rate]
      ,[mrr_churn_rate]
      ,[ltv]
      ,[mrr_churn] *.01 as [mrr_churn]
      ,[mrr_contraction] *.01 as [mrr_contraction]
      ,[mrr_expansion] *.01 as [mrr_expansion]
      ,[mrr_new_business] *.01 as [mrr_new_business]
      ,[mrr_reactivation] *.01 as [mrr_reactivation]
  FROM [Recurly].[dbo].[chartmogul_metrics]
  where  datepart(month, [date]) = datepart(month, getdate())
  and Datepart(year, date) = datepart(year, getdate())
  Order by date desc