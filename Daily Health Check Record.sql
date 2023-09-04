SELECT 
CAST(CAST(getdate() AS DATE) AS NVARCHAR) + '-' + a.id AS TheKey,
a.id, 
acc.Actual_MRR__c,
acc.Id,
acc.Of_Assets_With_Work_Orders__c,
acc.Contract_MRR__c,
acc.app_driver_count__c,
acc.Percent_of_Drivers_Inspecting__c,
acc.Drivers_Never_Completed_Inspection__c,
acc.Drivers_Not_Completed_Inspection_L14D__c,
acc.Faults_in_Progress__c,
acc.Form_Count__c,
a.R_INSPECT_MRR__c,
a.MAINTAIN_MRR__c,
a.OB_Stage__c,
acc.app_Number_of_Services_Open__c,
acc.app_Open_Work_Orders__c,
a.TC_Recurly_MRR__c,
CAST(getdate() AS DATE) AS Report_date__c,
acc.Service_Tasks_Due_Soon__c,
acc.Overdue_Workorders__c,
acc.TC_Account_Score__c,
acc.Assets_With_Open_Work_Orders__c,
acc.TC_Churn_Risk_score__c,
acc.Contract_Status_Score__c,
acc.Drivers_Not_Completed_Inspection_L14D__c AS TC_Drivers_Not_inspecting_last_7_days__c,
acc.TC_Has_Inspect_Lite__c,
acc.TC_Has_Inspect__c,
acc.TC_Has_License_Fee__c,
acc.TC_Has_Maintain_Lite__c,
acc.Has_Maintain__c,
acc.TC_Has_Wallet__c,
acc.Initial_Sign_Up_Date__c,
acc.TC_Inspect_Billed__c,
acc.TC_Inspect_Lite_Billed__c,
acc.TC_Inspect_Score__c,
acc.Inspections_Today__c,
acc.Inspections_Yesterday__c,
acc.License_Fee_Billed__c,
acc.TC_Maintain_Assets__c,
acc.TC_Maintain_Billed__c,
acc.TC_Maintain_Lite_Assets__c,
acc.TC_Maintain_Lite_Billed__c,
acc.TC_Maintain_Score__c,
acc.TC_Per_Correct_Faults_90_Days__c AS TC_Per_Corrected_Defects_90_Days__c,
acc.TC_Per_Correct_Faults_All_Time_Score__c AS TC_Per_Corrected_Defects_All_Time__c,
acc.TC_Per_Drivers_Inspecting_30_Days__c,
acc.TC_Per_Drivers_Inspecting_7_Days__c,
acc.TC_Per_Drivers_Inspecting_90_Days__c,
acc.TC_Per_Closed_Services_90_Days__c ,
acc.TC_Per_Closed_Work_Orders_90_Days__c,
acc.TC_Per_Vehicles_W_Service_90_Days__c,
acc.TC_Per_Closed_Work_Orders_90_Days__c,
acc.TC_Per_Unique_vehicles_inspecting_30_Day__c,
acc.TC_Per_Unique_vehicles_inspecting_7_Days__c,
acc.TC_Per_Vehicles_Inspecting_90_Days__c,
acc.TC_Per_Vehicles_Inspecting_All_Time__c,
acc.TC_Strategic_Contacts_Score__c,
acc.TC_Tactical_Contacts_Score__c,
acc.TC_Total_Health_Score__c,
acc.TC_Training_Score__c,
acc.TC_Vehicle_Inspection_Trend__c,
acc.TC_Wallet_Billed__c,
acc.TC_Wallet_Users__c,
acc.Teams_WA_Prod__c,
acc.app_stat_fault_count__c AS Total_Defects__c,
acc.Inspections_WA_Prod__c,
acc.app_stat_pc_vehicles_inspected_30_days__c,
acc.app_stat_pc_vehicles_inspected_7_days__c AS Vehicles_Inspected__c,
acc.app_Pct_Vehicles_with_Services__c AS Vehicles_with_services__c,
acc.Assets_WA_Prod__c AS waAssets__c,
acc.Weighted_At_Risk_MRR__c,
acc.Weighted_Risk__c,
acc.app_Closed_Work_Orders__c AS Work_orders_completed__c,
acc.Overdue_Workorders__c AS work_overs_overdue__c,
acc.of_Drivers__c



FROM App_CDP__c acc 
INNER JOIN Account a ON acc.Account__c = a.Id
