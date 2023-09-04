/****** Script for SelectTopNRows command from SSMS  ******/
SELECT 
cm1.Customer_name,
cm1.description,
cm1.activity_mrr /100 as ActivityMRR,
cm1.date,
cm1.type,
cm1.Currency,
cm1.plan_external_id,
cm1.customer_external_id,
a.id as sfid,
a.name,
a.Industry,
a.Recurly_Create_Date__c,
a.OB_Stage__c,
u.Name as OwnerName,
a.acc_Total_Fleet_Size__c as FleetSize,
a.type       
  FROM [Recurly].[dbo].[chartmogul_activities] as cm1
  left outer join Salesforce.dbo.account as a on cm1.customer_external_id = a.Recurly_External_ID__c
 Left outer join  Salesforce.dbo.[User] as u on a.ownerid = u.id
 where datepart(year, cm1.date) = 2022 
 and (cm1.activity_mrr_movement < 0 or cm1.type = 'Contraction')
 and cm1.type != 'Churn'
 --and cm1.description like '%Lite%'