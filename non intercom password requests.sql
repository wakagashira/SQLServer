/****** Script for SelectTopNRows command from SSMS  ******/
SELECT COUNT(id) AS count, 
--subject, t.Description, 
DATEPART(MONTH, t.CreatedDate) AS Month,
DATEPART(Year, t.CreatedDate) AS year,
CAST(DATEPART(Month, t.CreatedDate) AS NVARCHAR) + '-' + CAST(datepart(year, t.CreatedDate) as nvarchar) As Date
FROM Salesforce.dbo.Task t
WHERE t.Subject LIKE '%password%' OR t.Description like '%password%'
AND subject NOT LIKE 'Intercom%'
AND subject NOT LIKE '%on boarding%'
AND subject NOT LIKE '%Re: %'
GROUP BY DATEPART(MONTH, t.CreatedDate),
DATEPART(Year, t.CreatedDate),
CAST(DATEPART(Month, t.CreatedDate) AS NVARCHAR) + '-' + CAST(datepart(year, t.CreatedDate) as nvarchar)