SELECT
a.Segment__c
,ISNULL(T0.Actual_MRR__c, 0) 
, ISNULL(T1.Actual_MRR__c, 0) 
	,CAST(T0.Report_Date__c AS NVARCHAR) + '-' + T0.Account_Name__c AS TheKey
   ,T0.Report_Date__c
   ,T0.Account_Name__c
   ,ISNULL(T0.Inspect_Assets__c, 0) - ISNULL(T1.Inspect_Assets__c, 0) AS InspectAssetsChange
	,ISNULL(T0.TC_Inspect_Billed__c, 0) - ISNULL(T1.TC_Inspect_Billed__c, 0)  AS InspectBilledChange
   ,ISNULL(T0.TC_Maintain_Assets__c, 0) - ISNULL(T1.TC_Maintain_Assets__c, 0) AS MaintainAssetsChange
   ,ISNULL(T0.TC_Maintain_Billed__c, 0) - ISNULL(T1.TC_Maintain_Billed__c, 0) AS MaintainBilledChange
   ,ISNULL(T0.TC_Inspect_Lite_Assets__c, 0) - ISNULL(T1.TC_Inspect_Lite_Assets__c, 0) AS InspectLiteAssetsChange
   ,ISNULL(T0.TC_Inspect_Lite_Billed__c, 0) - ISNULL(T1.TC_Inspect_Lite_Billed__c, 0) AS InspectLiteBilledChange
   ,ISNULL(T0.TC_Maintain_Lite_Assets__c, 0) - ISNULL(T1.TC_Maintain_Lite_Assets__c, 0) AS MaintainLiteAssetsChange
   ,ISNULL(T0.TC_Maintain_Lite_Billed__c, 0) - ISNULL(T1.TC_Maintain_Lite_Billed__c, 0) AS MaintainLiteBilledChange
   ,ISNULL(T0.TC_Wallet_Users__c, 0) - ISNULL(T1.TC_Wallet_Users__c, 0) AS WalletUsersChange
   ,ISNULL(T0.TC_Wallet_Billed__c, 0) - ISNULL(T1.TC_Wallet_Billed__c, 0) AS WalletBilledChange
   ,ISNULL(T0.of_Drivers__c, 0) - ISNULL(T1.of_Drivers__c, 0) AS DriversChange
   ,ISNULL(T0.TC_License_fee_billed__c, 0) - ISNULL(T1.TC_License_fee_billed__c, 0) AS LiceneBilledChange
   ,ISNULL(T0.Actual_MRR__c, 0) - ISNULL(T1.Actual_MRR__c, 0) AS ActualMRRChange

   ,CAST(ISNULL(T0.Inspect_Assets__c, 0) AS NVARCHAR)
	+ CAST(ISNULL(T0.TC_Inspect_Billed__c, 0) AS NVARCHAR)
	+ CAST(ISNULL(T0.TC_Maintain_Assets__c, 0) AS NVARCHAR)
	+ CAST(ISNULL(T0.[TC_Maintain_Billed__c], 0) AS NVARCHAR)
	+ CAST(ISNULL(T0.TC_Inspect_Lite_Assets__c, 0) AS NVARCHAR)
	+ CAST(ISNULL(T0.TC_Inspect_Lite_Billed__c, 0) AS NVARCHAR)
	+ CAST(ISNULL(T0.TC_Maintain_Lite_Assets__c, 0) AS NVARCHAR)
	+ CAST(ISNULL(T0.TC_Maintain_Lite_Billed__c, 0) AS NVARCHAR)
	+ CAST(ISNULL(T0.TC_Wallet_Users__c, 0) AS NVARCHAR)
	+ CAST(ISNULL(T0.TC_Wallet_Billed__c, 0) AS NVARCHAR)
	+ CAST(ISNULL(T0.of_Drivers__c, 0) AS NVARCHAR)
	+ CAST(ISNULL(T0.Actual_MRR__c, 0) AS NVARCHAR) AS Todaycheck

   ,CAST(ISNULL(T1.Inspect_Assets__c, 0) AS NVARCHAR)
	+ CAST(ISNULL(T1.TC_Inspect_Billed__c, 0) AS NVARCHAR)
	+ CAST(ISNULL(T1.TC_Maintain_Assets__c, 0) AS NVARCHAR)
	+ CAST(ISNULL(T1.[TC_Maintain_Billed__c], 0) AS NVARCHAR)
	+ CAST(ISNULL(T1.TC_Inspect_Lite_Assets__c, 0) AS NVARCHAR)
	+ CAST(ISNULL(T1.TC_Inspect_Lite_Billed__c, 0) AS NVARCHAR)
	+ CAST(ISNULL(T1.TC_Maintain_Lite_Assets__c, 0) AS NVARCHAR)
	+ CAST(ISNULL(T1.TC_Maintain_Lite_Billed__c, 0) AS NVARCHAR)
	+ CAST(ISNULL(T1.TC_Wallet_Users__c, 0) AS NVARCHAR)
	+ CAST(ISNULL(T1.TC_Wallet_Billed__c, 0) AS NVARCHAR)
	+ CAST(ISNULL(T1.of_Drivers__c, 0) AS NVARCHAR)
	+ CAST(ISNULL(T1.Actual_MRR__c, 0) AS NVARCHAR) AS Othercheck

   
FROM (SELECT
		dhtc.Account_Name__c
	   ,dhtc.Report_Date__c
	   ,dhtc.Inspect_Assets__c
	   ,dhtc.TC_Inspect_Billed__c
	   ,dhtc.TC_Maintain_Assets__c
	   ,dhtc.[TC_Maintain_Billed__c]
	   ,dhtc.TC_Inspect_Lite_Assets__c
	   ,dhtc.TC_Inspect_Lite_Billed__c
	   ,dhtc.TC_Maintain_Lite_Assets__c
	   ,dhtc.TC_Maintain_Lite_Billed__c
	   ,dhtc.TC_Wallet_Users__c
	   ,dhtc.TC_Wallet_Billed__c
	   ,dhtc.of_Drivers__c
	   ,dhtc.TC_License_fee_billed__c
	   ,dhtc.Actual_MRR__c
	FROM Salesforce.dbo.Daily_Health_Tracker__c dhtc
	WHERE dhtc.Actual_MRR__c IS NOT NULL
--	AND dhtc.Account_Name__c = '0014600001a5dFYAAY'
	AND dhtc.Report_Date__c = CAST(DATEADD(DAY, -1, GETDATE()) AS DATE)) AS T0

LEFT OUTER JOIN (SELECT
		dhtc.Account_Name__c
	   ,dhtc.Report_Date__c
	   ,dhtc.Inspect_Assets__c
	   ,dhtc.TC_Inspect_Billed__c
	   ,dhtc.TC_Maintain_Assets__c
	   ,dhtc.[TC_Maintain_Billed__c]
	   ,dhtc.TC_Inspect_Lite_Assets__c
	   ,dhtc.TC_Inspect_Lite_Billed__c
	   ,dhtc.TC_Maintain_Lite_Assets__c
	   ,dhtc.TC_Maintain_Lite_Billed__c
	   ,dhtc.TC_Wallet_Users__c
	   ,dhtc.TC_Wallet_Billed__c
	   ,dhtc.of_Drivers__c
	   ,dhtc.TC_License_fee_billed__c
	   ,dhtc.Actual_MRR__c
	FROM Salesforce.dbo.Daily_Health_Tracker__c dhtc
	WHERE dhtc.Actual_MRR__c IS NOT NULL
--	AND dhtc.Account_Name__c = '0014600001a5dFYAAY'
	AND dhtc.Report_Date__c = CAST(DATEADD(DAY, -2, GETDATE()) AS DATE)) AS T1
	ON T0.Account_Name__c = T1.Account_Name__c
	LEFT OUTER JOIN Salesforce.dbo.Account a ON t0.Account_Name__c = a.id
WHERE CASE
	WHEN CAST(ISNULL(T0.Inspect_Assets__c, 0) AS NVARCHAR)
		+ CAST(ISNULL(T0.TC_Inspect_Billed__c, 0) AS NVARCHAR)
		+ CAST(ISNULL(T0.TC_Maintain_Assets__c, 0) AS NVARCHAR)
		+ CAST(ISNULL(T0.[TC_Maintain_Billed__c], 0) AS NVARCHAR)
		+ CAST(ISNULL(T0.TC_Inspect_Lite_Assets__c, 0) AS NVARCHAR)
		+ CAST(ISNULL(T0.TC_Inspect_Lite_Billed__c, 0) AS NVARCHAR)
		+ CAST(ISNULL(T0.TC_Maintain_Lite_Assets__c, 0) AS NVARCHAR)
		+ CAST(ISNULL(T0.TC_Maintain_Lite_Billed__c, 0) AS NVARCHAR)
		+ CAST(ISNULL(T0.TC_Wallet_Users__c, 0) AS NVARCHAR)
		+ CAST(ISNULL(T0.TC_Wallet_Billed__c, 0) AS NVARCHAR)
		+ CAST(ISNULL(T0.of_Drivers__c, 0) AS NVARCHAR)
		+ CAST(ISNULL(T0.Actual_MRR__c, 0) AS NVARCHAR) =
		CAST(ISNULL(T1.Inspect_Assets__c, 0) AS NVARCHAR)
		+ CAST(ISNULL(T1.TC_Inspect_Billed__c, 0) AS NVARCHAR)
		+ CAST(ISNULL(T1.TC_Maintain_Assets__c, 0) AS NVARCHAR)
		+ CAST(ISNULL(T1.[TC_Maintain_Billed__c], 0) AS NVARCHAR)
		+ CAST(ISNULL(T1.TC_Inspect_Lite_Assets__c, 0) AS NVARCHAR)
		+ CAST(ISNULL(T1.TC_Inspect_Lite_Billed__c, 0) AS NVARCHAR)
		+ CAST(ISNULL(T1.TC_Maintain_Lite_Assets__c, 0) AS NVARCHAR)
		+ CAST(ISNULL(T1.TC_Maintain_Lite_Billed__c, 0) AS NVARCHAR)
		+ CAST(ISNULL(T1.TC_Wallet_Users__c, 0) AS NVARCHAR)
		+ CAST(ISNULL(T1.TC_Wallet_Billed__c, 0) AS NVARCHAR)
		+ CAST(ISNULL(T1.of_Drivers__c, 0) AS NVARCHAR)
		+ CAST(ISNULL(T1.Actual_MRR__c, 0) AS NVARCHAR) THEN 0
	ELSE 1
END = 1
AND T0.Account_Name__c = '0014p00001ffuQiAAI'