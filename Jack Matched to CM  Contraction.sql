
/****** Script for SelectTopNRows command from SSMS  ******/

SELECT cm1.[customer_name], 
                  cm1.[customer_uuid], 
                  cm1.[customer_external_id], 
                  cm1.[subscription_external_id], 
                  cm1.[currency], 
                  cm1.[mrr_movement] / 100 as MRR_Movement, 
                  cm1.[description], 
                  cm1.[movement_type], 
                  cm1.[date],
				  a.id as sfid,
a.name,
a.Industry,
a.Recurly_Create_Date__c,
a.OB_Stage__c,
u.Name as OwnerName,
a.acc_Total_Fleet_Size__c as FleetSize,
a.type
FROM [Whiparound].[dbo].[CMContraction2022] as cm1
Left outer join Salesforce.dbo.Account as A on cm1.customer_external_id = a.Recurly_External_ID__c
 Left outer join  Salesforce.dbo.[User] as u on a.ownerid = u.id
