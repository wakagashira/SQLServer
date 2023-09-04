SELECT a.id,
b.id,
CASE WHEN a.id = b.id THEN 'True' ELSE 'Mismatch' END AS iderror,
a.name,
b.name,
CASE WHEN a.name = b.name THEN 'True' ELSE 'Mismatch' END AS nameerror,
a.recurly_v2__Account_id__c,
b.recurly_v2__Account_ID__c,
CASE WHEN a.recurly_v2__Account_ID__c = b.recurly_v2__Account_ID__c THEN 'True' ELSE 'Mismatch' END AS acocuntiderror,
a.recurly_v2__Account__c,
b.recurly_v2__Account__c,
CASE WHEN a.recurly_v2__Account__c = b.recurly_v2__Account__c THEN 'True' ELSE 'Mismatch' END AS recurly_v2__Account__cerror,
a.recurly_v2__Active_subscribers__c,
b.recurly_v2__Active_subscribers__c,
CASE WHEN a.recurly_v2__Active_subscribers__c = b.recurly_v2__Active_subscribers__c THEN 'True' ELSE 'Mismatch' END AS recurly_v2__Active_subscribers__cerror,
a.recurly_v2__billing_Created_By__c,
b.recurly_v2__billing_Created_By__c,
CASE WHEN a.recurly_v2__billing_Created_By__c = b.recurly_v2__billing_Created_By__c THEN 'True' ELSE 'Mismatch' END AS recurly_v2__billing_Created_By__cERROR,
a.recurly_v2__Billing_Payment_Method__c,
b.recurly_v2__Billing_Payment_Method__c,
CASE WHEN a.recurly_v2__Billing_Payment_Method__c = b.recurly_v2__Billing_Payment_Method__c THEN 'True' ELSE 'Mismatch' END AS recurly_v2__Billing_Payment_Method__cERROR,
a.reculy_v2__deleted_at__c,
b.recurly_v2__Deleted_At__c,
CASE WHEN a.reculy_v2__deleted_at__c = b.recurly_v2__Deleted_At__c THEN 'True' ELSE 'Mismatch' END AS reculy_v2__deleted_at__cERROR,
a.Recurly_v2__estimated_mrr__c,
b.Recurly_v2__estimated_mrr__c,
CASE WHEN a.Recurly_v2__estimated_mrr__c = b.Recurly_v2__estimated_mrr__c THEN 'True' ELSE 'Mismatch' END AS Recurly_v2__estimated_mrr__cERROR,
a.recurly_v2__Exp_Month__c,
b.recurly_v2__Exp_Month__c,
CASE WHEN a.recurly_v2__Exp_Month__c = b.recurly_v2__Exp_Month__c THEN 'True' ELSE 'Mismatch' END AS recurly_v2__Exp_Month__cERROR,
a.recurly_v2__Exp_Year__c AS recurly_v2__Exp_Year__c,
b.recurly_v2__Exp_Year__c AS recurly_v2__Exp_Year__c,
CASE WHEN a.recurly_v2__Exp_Year__c = b.recurly_v2__Exp_Year__c THEN 'True' ELSE 'Mismatch' END AS recurly_v2__Exp_Year__cERROR,
a.recurly_vs_status__c,
b.recurly_v2__Status__c,
CASE WHEN a.recurly_vs_status__c = b.recurly_v2__status__c THEN 'True' ELSE 'Mismatch' END AS recurly_vs_status__cERROR,
a.recurly_v2__Total_Invoices_Sum__c,
b.recurly_v2__Total_Invoices_Sum__c,
CASE WHEN a.recurly_v2__Total_Invoices_Sum__c = b.recurly_v2__Total_Invoices_Sum__c THEN 'True' ELSE 'Mismatch' END AS recurly_v2__Total_Invoices_Sum__cERROR
--CASE WHEN a. = b. THEN 'True' ELSE 'Mismatch' END AS error




FROM 


(SELECT 
sfra.id
,ra.code AS name 
, ra.id AS recurly_v2__Account_id__c
,A.ID AS recurly_v2__Account__c
,ra.has_live_subscription AS recurly_v2__Active_subscribers__c
,rbi.created_at AS recurly_v2__billing_Created_By__c
,rpm.object AS recurly_v2__Billing_Payment_Method__c
,ra.deleted_at AS reculy_v2__deleted_at__c
,amrr.total AS Recurly_v2__estimated_mrr__c
,rpm.exp_month AS recurly_v2__Exp_Month__c
,rpm.exp_year AS recurly_v2__Exp_Year__c
,ra.state AS recurly_vs_status__c
,gti.recurly_v2__Total_Invoices_Sum__c
FROM recurly.dbo.recurly_accounts AS ra  
LEFT OUTER JOIN Salesforce.dbo.recurly_v2__Recurly_Account__c sfra ON ra.id = recurly_v2__Account_ID__c
LEFT OUTER JOIN Salesforce.dbo.account AS A ON ra.code = a.RecurlyExID__c
LEFT OUTER JOIN recurly.[dbo].[recurly_billing_infos] AS rbi ON ra.id = rbi.accountId
LEFT OUTER JOIN recurly.[dbo].[recurly_billing_addresses] AS rba ON rbi.id = rba.[billingInfoId]
LEFT OUTER JOIN recurly.dbo.recurly_payment_methods rpm ON rbi.id = rpm.billingInfoId
LEFT OUTER JOIN Salesforce.[dbo].[AccountGetMrr] AS amrr ON ra.code = amrr.code
LEFT OUTER JOIN recurly.dbo.GetTotalInvoicesByCode AS gti ON ra.code = gti.code
) AS A
LEFT OUTER JOIN (
SELECT id
,name 
,recurly_v2__Account_id__c
,recurly_v2__Account__c
,recurly_v2__Active_subscribers__c
,recurly_v2__billing_Created_By__c
,recurly_v2__Billing_Payment_Method__c
,recurly_v2__Deleted_At__c
,Recurly_v2__estimated_mrr__c
,recurly_v2__Exp_Month__c
,recurly_v2__Exp_Year__c
,recurly_v2__Status__c
,recurly_v2__Total_Invoices_Sum__c

FROM Salesforce.dbo.recurly_v2__Recurly_Account__c
) AS b ON a.id = b.id

WHERE 
ISNULL(a.name, 'NULL') != ISNULL(b.name, 'NULL') or
ISNULL(a.recurly_v2__Account_ID__c, 'NULL') != ISNULL(b.recurly_v2__Account_ID__c, 'NULL')or
ISNULL(a.recurly_v2__Account__c, 'NULL') != ISNULL(b.recurly_v2__Account__c, 'NULL')or
ISNULL(a.recurly_v2__Active_subscribers__c, 0) != ISNULL(b.recurly_v2__Active_subscribers__c, 0)or
--ISNULL(a.recurly_v2__billing_Created_By__c, 'NULL') ! = ISNULL(b.recurly_v2__billing_Created_By__c, 'NULL')or
ISNULL(a.recurly_v2__Billing_Payment_Method__c, 'NULL') ! = ISNULL(b.recurly_v2__Billing_Payment_Method__c, 'NULL')or
ISNULL(CAST(a.reculy_v2__deleted_at__c AS NVARCHAR(MAX)), 'NULL') ! = ISNULL(CAST(b.recurly_v2__Deleted_At__c AS NVARCHAR(MAX)), 'NULL') or
ISNULL(a.Recurly_v2__estimated_mrr__c, 0) ! = ISNULL(b.Recurly_v2__estimated_mrr__c, 0)or
ISNULL(a.recurly_v2__Exp_Month__c, 0) ! = ISNULL(b.recurly_v2__Exp_Month__c, 0)or
ISNULL(a.recurly_v2__Exp_Year__c, 0) ! = ISNULL(b.recurly_v2__Exp_Year__c, 0) or
ISNULL(a.recurly_vs_status__c, 'NULL') ! = ISNULL(b.recurly_v2__status__c, 'NULL')or
ISNULL(CAST(a.recurly_v2__Total_Invoices_Sum__c AS INT), 0) ! = ISNULL(CAST(b.recurly_v2__Total_Invoices_Sum__c AS INT), 0) 