--CREATE VIEW dbo.MasterTrackerKeyLevers
--AS
 
Select 
convert(date, getdate(), 23) as ReportDate,
*

from  openquery(SFWA , 'select 
New_Sales_Goal__c,
Reactivation_Goal__c,
Expansion_Goal__c,
Expected_Contraction__c,
Expected_Churn__c,
Price_Increase__c,
License_Fees__c
from Report_Master_Tracker_Key_Levers__c
where strftime(''%Y'', ''now'') = Year__c
and case when strftime(''%m'', ''now'') = ''01'' then ''Q4''
when strftime(''%m'', ''now'') = ''02'' then ''Q4''
when strftime(''%m'', ''now'') = ''03'' then ''Q4''
when strftime(''%m'', ''now'') = ''04'' then ''Q1''
when strftime(''%m'', ''now'') = ''05'' then ''Q1''
when strftime(''%m'', ''now'') = ''06'' then ''Q1''
when strftime(''%m'', ''now'') = ''07'' then ''Q2''
when strftime(''%m'', ''now'') = ''08'' then ''Q2''
when strftime(''%m'', ''now'') = ''09'' then ''Q2''
when strftime(''%m'', ''now'') = ''10'' then ''Q3''
when strftime(''%m'', ''now'') = ''11'' then ''Q3''
when strftime(''%m'', ''now'') = ''12'' then ''Q3''
else ''Q0'' end = Quarter__c

') as O



