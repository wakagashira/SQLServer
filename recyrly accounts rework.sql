CREATE VIEW dbo.GetRecurlyAccountStatsForRecurlyAccountInSF

AS
 


SELECT * FROM 




(SELECT * FROM 


(SELECT 
sfra.id
,ra.code AS name 
, ra.id AS recurly_v2__Account_id__c
,A.ID AS recurly_v2__Account__c
,ra.has_live_subscription AS recurly_v2__Active_subscribers__c
, rba.street1 AS recurly_v2__address_1__c
, rba.street2 AS recurly_v2__address_2__c
-- average of last three invoices here if needed 
, rba.city AS recurly__v2__billing_city__c
,rbi.company AS recurly__v2__billing_Company
, rba.country
,rbi.created_at AS recurly_v2__billing_Created_By__c
,rbi.first_name recurly__v2__billing_First_name__c
,rbi.last_name recurly__v2__billing_Last_name__c
,RBI.id recurly__v2__billing_id__c
,rpm.object AS recurly_v2__Billing_Payment_Method__c
,rba.phone AS recurly_v2__billing_phone__c
,rba.postal_code AS recurly_v2__billing_postal_code__c
,rba.region AS recurly_v2__billing_state__c
,rbi.updated_at AS recurly__v2_billing_Updated_at__c
,rbi.valid AS recurly_v2__billing_Valid__c
,rbi.vat_number AS  recurly_v2__billing_vat_number__c
--insert cc email if needed 
,rpm.card_type AS recurly_v2__cardTrype__c
, rba.city AS recurly__v2__city__c
,ra.code AS recurly_v2__Code__c
,ra.company AS Recurly_v2__company__c
,rba.country AS recurly_v2__country__c
,ra.created_at AS reculy_v2__created_at__c
,ra.deleted_at AS reculy_v2__deleted_at__c
,amrr.total AS Recurly_v2__estimated_mrr__c
,rpm.exp_month AS recurly_v2__Exp_Month__c
,rpm.exp_year AS recurly_v2__Exp_Year__c
,rpm.first_six AS recurly_v2__first_six__c
,rpm.last_four AS recurly_v2__last_four__c
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
EXCEPT
SELECT id
,name 
,recurly_v2__Account_id__c
,recurly_v2__Account__c
,recurly_v2__Active_subscribers__c
,recurly_v2__address_1__c
,recurly_v2__address_2__c
-- average of last three invoices here if needed 
,recurly_v2__billing_city__c
,recurly_v2__billing_Company__c
,recurly_v2__Country__c
,recurly_v2__billing_Created_By__c
,recurly_v2__First_Name__c
,recurly_v2__Last_Name__c
,recurly_v2__Billing_ID__c
,recurly_v2__Billing_Payment_Method__c
,recurly_v2__billing_phone__c
,recurly_v2__billing_postal_code__c
,recurly_v2__billing_state__c
,recurly_v2__billing_Updated_at__c
,recurly_v2__billing_Valid__c
,recurly_v2__billing_vat_number__c
--insert cc email if needed 
,recurly_v2__Card_Type__c
,recurly_v2__city__c
,recurly_v2__Code__c
,Recurly_v2__company__c
,recurly_v2__country__c
,CreatedDate
,null
,Recurly_v2__estimated_mrr__c
,recurly_v2__Exp_Month__c
,recurly_v2__Exp_Year__c
,recurly_v2__first_six__c
,recurly_v2__last_four__c
,recurly_v2__status__c
,recurly_v2__Total_Invoices_Sum__c
FROM Salesforce.dbo.recurly_v2__Recurly_Account__c
) AS t0
WHERE t0.id IS NOT NULL 