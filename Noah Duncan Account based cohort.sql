
SELECT
t0.id AS business_id
, acc.id AS sfid
	,CASE
		WHEN T0.actual_MRR > 999 THEN 'Tier 1'
		WHEN T0.actual_MRR > 500 THEN 'Tier 2'
		WHEN T0.actual_MRR > 200 THEN 'Tier 3'
		ELSE 'Tier 4'
	END AS Cohort
, isnull(t0.inspect_billed_units, 0) as TC_Inspect_Assets__c
, isnull(t0.inspect_total_billed, 0) as tc_inspect_billed__c
, isnull(t0.maintain_billed_units, 0) as TC_Maintain_Assets__c
, isnull(t0.maintain_total_billed, 0) as TC_Maintain_Billed__c
, isnull(t0.inspect_lite_billed_units, 0) as TC_Inspect_Lite_Assets__c
, isnull(t0.inspect_lite_total_billed, 0) as TC_Inspect_Lite_Billed__c
, isnull(t0.maintain_lite_billed_units, 0) as TC_Maintain_Lite_Assets__c
, isnull(t0.maintain_lite_total_billed, 0) as TC_Maintain_Lite_Billed__c
, isnull(t0.wallet_billed_units, 0) as TC_Wallet_Users__c
, isnull(t0.wallet_total_billed, 0) as TC_Walled_Billed__c
, isnull(t0.total_drivers, 0) as total_drivers
, isnull(t0.actual_MRR, 0) as Actual_Mrr__c
, CASE WHEN isnull(t0.inspect_billed_units, 0) > 0 THEN 1 ELSE 0 end as TC_Has_Inspect__c
, CASE WHEN isnull(t0.maintain_billed_units, 0)  > 0 THEN 1 ELSE 0 end  as TC_Has_Maintain__c
, CASE WHEN isnull(t0.inspect_lite_billed_units, 0) > 0 THEN 1 ELSE 0 end  as TC_Has_Inspect_Lite__c
, CASE WHEN isnull(t0.maintain_lite_billed_units, 0) > 0 THEN 1 ELSE 0 end  as TC_Has_Maintain_Lite__c
, CASE WHEN isnull(t0.wallet_billed_units, 0)  > 0 THEN 1 ELSE 0 end  as TC_Has_Wallet__c
, ISNULL(T0.license_fee, 0) AS TC_License_fee_billed
, CASE WHEN ISNULL(T0.license_fee, 0) > 0 THEN 1 ELSE 0 END AS TC_Has_License_fee
, CAST(t0.id AS NVARCHAR) 
+ CAST(isnull(t0.inspect_billed_units, 0)  AS NVARCHAR) 
+ CAST(CAST(isnull(t0.inspect_total_billed, 0) AS DECIMAL (16,2) )  AS NVARCHAR) 
+ CAST(isnull(t0.maintain_billed_units, 0)  AS NVARCHAR) 
+ CAST(CAST(isnull(t0.maintain_total_billed, 0) AS DECIMAL (16,2) )  AS NVARCHAR) 
+ CAST(isnull(t0.inspect_lite_billed_units, 0)  AS NVARCHAR) 
+ CAST(CAST(isnull(t0.inspect_lite_total_billed, 0) AS DECIMAL (16,2) ) AS NVARCHAR) 
+ CAST(isnull(t0.maintain_lite_billed_units, 0)  AS NVARCHAR) 
+ CAST(CAST(isnull(t0.maintain_lite_total_billed, 0) AS DECIMAL (16,2) ) AS NVARCHAR) 
+ CAST(isnull(t0.wallet_billed_units, 0)  AS NVARCHAR) 
+ CAST(CAST(isnull(t0.wallet_total_billed, 0) AS DECIMAL (16,2) ) AS NVARCHAR) 
+ CAST(isnull(t0.total_drivers, 0)  AS NVARCHAR) 
+ CAST(CAST(isnull(t0.actual_MRR, 0) AS DECIMAL (16,2) ) AS NVARCHAR) 
 AS WAchecksumVal
 , CAST(acc.WA_group_Id__c AS NVARCHAR) 
+ CAST(ISNULL(acc.TC_Inspect_Assets__c, 0) AS NVARCHAR) 
+ CAST(ISNULL(acc.tc_inspect_billed__c, 0) AS NVARCHAR)
+ CAST(isnull(acc.TC_Maintain_Assets__c, 0)  AS NVARCHAR) 
+ CAST(ISNULL(acc.[TC_Maintain_Billed__c], 0) AS NVARCHAR)
+ CAST(isnull(acc.TC_Inspect_Lite_Assets__c, 0)  AS NVARCHAR) 
+ CAST(isnull(acc.TC_Inspect_Lite_Billed__c, 0)  AS NVARCHAR) 
+ CAST(isnull(acc.TC_Maintain_Lite_Assets__c, 0)  AS NVARCHAR) 
+ CAST(isnull(acc.TC_Maintain_Lite_Billed__c, 0)  AS NVARCHAR) 
+ CAST(isnull(acc.TC_Wallet_Users__c, 0)  AS NVARCHAR) 
+ CAST(isnull(acc.[TC_Walled_Billed__c], 0)  AS NVARCHAR) 
+ CAST(isnull(acc.of_Drivers__c, 0)  AS NVARCHAR) 
+ CAST(isnull(acc.Actual_Mrr__c, 0) AS NVARCHAR) 
 AS SFWACheckasumVal

FROM (SELECT
		id
	   ,name
	   ,currency
	   ,ThePlan
	   ,inspect_ppv AS inspect_unit_price
	   ,CASE
			WHEN COALESCE((CASE
					WHEN COALESCE(data.inspect_min_bill_count, 0) > COALESCE(data.inspect_vehicles_count, 0) THEN COALESCE(data.inspect_min_bill_count, 0)
					ELSE COALESCE(data.inspect_vehicles_count, 0)
				END), 0) > COALESCE((CASE
					WHEN COALESCE(data.inspect_lite_min_bill_count, 0)
						> COALESCE(data.inspect_lite_vehicles_count, 0) THEN COALESCE(data.inspect_lite_min_bill_count, 0)
					ELSE COALESCE(data.inspect_lite_vehicles_count, 0)
				END), 0) THEN COALESCE((CASE
					WHEN COALESCE(data.inspect_min_bill_count, 0) > COALESCE(data.inspect_vehicles_count, 0) THEN COALESCE(data.inspect_min_bill_count, 0)
					ELSE COALESCE(data.inspect_vehicles_count, 0)
				END), 0) - COALESCE((CASE
					WHEN COALESCE(data.inspect_lite_min_bill_count, 0) > COALESCE(data.inspect_lite_vehicles_count, 0) THEN COALESCE(data.inspect_lite_min_bill_count, 0)
					ELSE COALESCE(data.inspect_lite_vehicles_count, 0)
				END), 0)
			ELSE COALESCE((CASE
					WHEN COALESCE(data.inspect_lite_min_bill_count, 0)
						> COALESCE(data.inspect_lite_vehicles_count, 0) THEN COALESCE(data.inspect_lite_min_bill_count, 0)
					ELSE COALESCE(data.inspect_lite_vehicles_count, 0)
				END), 0)
				- COALESCE((CASE
					WHEN COALESCE(data.inspect_min_bill_count, 0) > COALESCE(data.inspect_vehicles_count, 0) THEN COALESCE(data.inspect_min_bill_count, 0)
					ELSE COALESCE(data.inspect_vehicles_count, 0)
				END), 0)
		END AS inspect_billed_units
	   ,CASE
			WHEN COALESCE((CASE
					WHEN COALESCE(data.inspect_min_bill_count, 0)
						> COALESCE(data.inspect_vehicles_count, 0) THEN COALESCE(data.inspect_min_bill_count, 0)
					ELSE COALESCE(data.inspect_vehicles_count, 0)
				END), 0)
				> COALESCE((CASE
					WHEN COALESCE(data.inspect_lite_min_bill_count, 0) > COALESCE(data.inspect_lite_vehicles_count, 0) THEN COALESCE(data.inspect_lite_min_bill_count, 0)
					ELSE COALESCE(data.inspect_lite_vehicles_count, 0)
				END), 0) THEN COALESCE((CASE
					WHEN COALESCE(data.inspect_min_bill_count, 0) > COALESCE(data.inspect_vehicles_count, 0) THEN COALESCE(data.inspect_min_bill_count, 0)
					ELSE COALESCE(data.inspect_vehicles_count, 0)
				END), 0) - COALESCE((CASE
					WHEN COALESCE(data.inspect_lite_min_bill_count, 0)
						> COALESCE(data.inspect_lite_vehicles_count, 0) THEN COALESCE(data.inspect_lite_min_bill_count, 0)
					ELSE COALESCE(data.inspect_lite_vehicles_count, 0)
				END), 0)
			ELSE COALESCE((CASE
					WHEN COALESCE(data.inspect_lite_min_bill_count, 0) > COALESCE(data.inspect_lite_vehicles_count, 0) THEN COALESCE(data.inspect_lite_min_bill_count, 0)
					ELSE COALESCE(data.inspect_lite_vehicles_count, 0)
				END), 0) - COALESCE((CASE
					WHEN COALESCE(data.inspect_min_bill_count, 0) > COALESCE(data.inspect_vehicles_count, 0) THEN COALESCE(data.inspect_min_bill_count, 0)
					ELSE COALESCE(data.inspect_vehicles_count, 0)
				END), 0)
		END * COALESCE(inspect_ppv, 0) AS inspect_total_billed
	   ,maintain_ppv AS maintain_unit_price
	   ,COALESCE((CASE
			WHEN COALESCE(data.maintain_min_bill_count, 0) > COALESCE(data.maintain_vehicles_count, 0) THEN COALESCE(data.maintain_min_bill_count, 0)
			ELSE COALESCE(data.maintain_vehicles_count, 0)
		END), 0) AS maintain_billed_units
	   ,COALESCE((CASE
			WHEN COALESCE(data.maintain_min_bill_count, 0) > COALESCE(data.maintain_vehicles_count, 0) THEN COALESCE(data.maintain_min_bill_count, 0)
			ELSE COALESCE(data.maintain_vehicles_count, 0)
		END), 0) * COALESCE(maintain_ppv, 0) AS maintain_total_billed
	   ,inspect_lite_ppv AS inspect_lite_unit_price
	   ,COALESCE((CASE
			WHEN COALESCE(data.inspect_lite_min_bill_count, 0) > COALESCE(data.inspect_lite_vehicles_count, 0) THEN COALESCE(data.inspect_lite_min_bill_count, 0)
			ELSE COALESCE(data.inspect_lite_vehicles_count, 0)
		END), 0) AS inspect_lite_billed_units
	   ,COALESCE((CASE
			WHEN COALESCE(data.inspect_lite_min_bill_count, 0) > COALESCE(data.inspect_lite_vehicles_count,
				0) THEN COALESCE(data.inspect_lite_min_bill_count, 0)
			ELSE COALESCE(data.inspect_lite_vehicles_count, 0)
		END), 0) * COALESCE(inspect_lite_ppv, 0) AS inspect_lite_total_billed
	   ,maintain_lite_ppv AS maintain_lite_unit_price
	   ,COALESCE((CASE
			WHEN COALESCE(data.maintain_lite_min_bill_count, 0) > COALESCE(data.maintain_lite_vehicles_count, 0) THEN COALESCE(data.maintain_lite_min_bill_count, 0)
			ELSE COALESCE(data.maintain_lite_vehicles_count, 0)
		END), 0) AS maintain_lite_billed_units
	   ,COALESCE((CASE
			WHEN COALESCE(data.maintain_lite_min_bill_count, 0) > COALESCE(data.maintain_lite_vehicles_count, 0) THEN COALESCE(data.maintain_lite_min_bill_count, 0)
			ELSE COALESCE(data.maintain_lite_vehicles_count, 0)
		END), 0) * COALESCE(maintain_lite_ppv, 0) AS maintain_lite_total_billed
	   ,wallet_ppd AS wallet_unit_price
	   ,COALESCE((CASE
			WHEN COALESCE(data.wallet_min_bill_count, 0) > COALESCE(data.wallet_driver_count, 0) THEN COALESCE(data.wallet_min_bill_count, 0)
			ELSE COALESCE(data.wallet_driver_count, 0)
		END), 0)
		AS wallet_billed_units
	   ,COALESCE((CASE
			WHEN COALESCE(data.wallet_min_bill_count, 0) > COALESCE(data.wallet_driver_count, 0) THEN COALESCE(data.wallet_min_bill_count, 0)
			ELSE COALESCE(data.wallet_driver_count, 0)
		END), 0) * COALESCE(wallet_ppd, 0) AS wallet_total_billed
	   ,total_drivers
	   ,license_fee
	   ,((((COALESCE(license_fee, 0)
		+
		CASE
			WHEN COALESCE((CASE
					WHEN COALESCE(data.inspect_min_bill_count, 0) > COALESCE(data.inspect_vehicles_count, 0) THEN COALESCE(data.inspect_min_bill_count, 0)
					ELSE COALESCE(data.inspect_vehicles_count, 0)
				END), 0) > COALESCE((CASE
					WHEN COALESCE(data.inspect_lite_min_bill_count, 0) > COALESCE(data.inspect_lite_vehicles_count, 0) THEN COALESCE(data.inspect_lite_min_bill_count, 0)
					ELSE COALESCE(data.inspect_lite_vehicles_count, 0)
				END), 0) THEN COALESCE((CASE
					WHEN COALESCE(data.inspect_min_bill_count, 0)
						> COALESCE(data.inspect_vehicles_count, 0) THEN COALESCE(data.inspect_min_bill_count, 0)
					ELSE COALESCE(data.inspect_vehicles_count, 0)
				END), 0)
				- COALESCE((CASE
					WHEN COALESCE(data.inspect_lite_min_bill_count, 0) > COALESCE(data.inspect_lite_vehicles_count, 0) THEN COALESCE(data.inspect_lite_min_bill_count, 0)
					ELSE COALESCE(data.inspect_lite_vehicles_count, 0)
				END), 0)
			ELSE COALESCE((CASE
					WHEN COALESCE(data.inspect_lite_min_bill_count, 0) > COALESCE(data.inspect_lite_vehicles_count, 0) THEN COALESCE(data.inspect_lite_min_bill_count, 0)
					ELSE COALESCE(data.inspect_lite_vehicles_count, 0)
				END), 0) - COALESCE((CASE
					WHEN COALESCE(data.inspect_min_bill_count, 0)
						> COALESCE(data.inspect_vehicles_count, 0) THEN COALESCE(data.inspect_min_bill_count, 0)
					ELSE COALESCE(data.inspect_vehicles_count, 0)
				END), 0)
		END * COALESCE(inspect_ppv, 0))
		+ COALESCE((CASE
			WHEN COALESCE(data.maintain_min_bill_count, 0) > COALESCE(data.maintain_vehicles_count, 0) THEN COALESCE(data.maintain_min_bill_count, 0)
			ELSE COALESCE(data.maintain_vehicles_count, 0)
		END), 0) * COALESCE(maintain_ppv, 0)) + COALESCE((CASE
			WHEN COALESCE(data.inspect_lite_min_bill_count, 0)
				> COALESCE(data.inspect_lite_vehicles_count, 0) THEN COALESCE(data.inspect_lite_min_bill_count, 0)
			ELSE COALESCE(data.inspect_lite_vehicles_count, 0)
		END), 0) * COALESCE(inspect_lite_ppv, 0))
		+ COALESCE((CASE
			WHEN COALESCE(data.maintain_lite_min_bill_count, 0) > COALESCE(data.maintain_lite_vehicles_count, 0) THEN COALESCE(data.maintain_lite_min_bill_count, 0)
			ELSE COALESCE(data.maintain_lite_vehicles_count, 0)
		END), 0) * COALESCE(maintain_lite_ppv, 0)) + COALESCE((CASE
			WHEN COALESCE(data.wallet_min_bill_count, 0) > COALESCE(data.wallet_driver_count, 0) THEN COALESCE(data.wallet_min_bill_count, 0)
			ELSE COALESCE(data.wallet_driver_count, 0)
		END), 0) * COALESCE(wallet_ppd, 0) AS actual_MRR
	FROM (SELECT
			dbo.v2_businesses.id
		   ,dbo.v2_businesses.name
		   ,dbo.b_assets.total_vehicles
		   ,dbo.v2_subscription_plans.recurly_code AS ThePlan
		   ,dbo.v2_businesses.activated_at
		   ,dbo.v2_currencies.name AS currency
		   ,dbo.b_drivers.total_drivers
		   ,CASE
				WHEN (v2_businesses.subscription_plan_id = 17 OR
					v2_businesses.subscription_plan_id = 18 OR
					v2_businesses.subscription_plan_id = 26 OR
					v2_businesses.subscription_plan_id = 27) THEN CAST(v2_businesses.stat_bill_last_amount / 3 AS DECIMAL)
				WHEN (v2_businesses.subscription_plan_id = 19 OR
					v2_businesses.subscription_plan_id = 20) THEN CAST(v2_businesses.stat_bill_last_amount / 6 AS DECIMAL)
				WHEN (v2_businesses.subscription_plan_id = 21 OR
					v2_businesses.subscription_plan_id = 22) THEN CAST(v2_businesses.stat_bill_last_amount / 12 AS DECIMAL)
				WHEN v2_businesses.subscription_plan_id = 23 THEN CAST(v2_businesses.stat_bill_last_amount / 8 AS DECIMAL)
				WHEN v2_businesses.subscription_plan_id = 25 THEN CAST(v2_businesses.stat_bill_last_amount / 24 AS DECIMAL)
				ELSE v2_businesses.stat_bill_last_amount
			END AS last_month_payment
		   ,CASE
				WHEN (v2_businesses.subscription_plan_id = 17 OR
					v2_businesses.subscription_plan_id = 18 OR
					v2_businesses.subscription_plan_id = 26 OR
					v2_businesses.subscription_plan_id = 27) THEN CAST(l_fee.price_per_unit / 3 AS DECIMAL)
				WHEN (v2_businesses.subscription_plan_id = 19 OR
					v2_businesses.subscription_plan_id = 20) THEN CAST(l_fee.price_per_unit / 6 AS DECIMAL)
				WHEN (v2_businesses.subscription_plan_id = 21 OR
					v2_businesses.subscription_plan_id = 22) THEN CAST(l_fee.price_per_unit / 12 AS DECIMAL)
				WHEN v2_businesses.subscription_plan_id = 23 THEN CAST(l_fee.price_per_unit / 8 AS DECIMAL)
				WHEN v2_businesses.subscription_plan_id = 25 THEN CAST(l_fee.price_per_unit / 24 AS DECIMAL)
				ELSE l_fee.price_per_unit
			END AS license_fee
		   ,CASE
				WHEN v2_businesses.min_billed_unit_count = 0 THEN maint.min_billed_unit_count
				ELSE v2_businesses.min_billed_unit_count
			END AS inspect_min_bill_count
		   ,CASE
				WHEN (v2_businesses.subscription_plan_id = 17 OR
					v2_businesses.subscription_plan_id = 18 OR
					v2_businesses.subscription_plan_id = 26 OR
					v2_businesses.subscription_plan_id = 27) THEN CAST(v2_businesses.unit_price_per_vehicle / 3 AS DECIMAL)
				WHEN (v2_businesses.subscription_plan_id = 19 OR
					v2_businesses.subscription_plan_id = 20) THEN CAST(v2_businesses.unit_price_per_vehicle / 6 AS DECIMAL)
				WHEN (v2_businesses.subscription_plan_id = 21 OR
					v2_businesses.subscription_plan_id = 22) THEN CAST(v2_businesses.unit_price_per_vehicle / 12 AS DECIMAL)
				WHEN v2_businesses.subscription_plan_id = 23 THEN CAST(v2_businesses.unit_price_per_vehicle / 8 AS DECIMAL)
				WHEN v2_businesses.subscription_plan_id = 25 THEN CAST(v2_businesses.unit_price_per_vehicle / 24 AS DECIMAL)
				ELSE v2_businesses.unit_price_per_vehicle
			END AS inspect_ppv
		   ,CASE
				WHEN maint.id IS NOT NULL AND
					v2_businesses.min_billed_unit_count = 0 AND
					inspect_assets.total_vehicles >= v2_businesses.min_billed_unit_count THEN inspect_assets.total_vehicles
				WHEN maint.id IS NOT NULL AND
					v2_businesses.min_billed_unit_count <> 0 AND
					inspect_assets.total_vehicles < v2_businesses.min_billed_unit_count THEN v2_businesses.min_billed_unit_count
				ELSE b_assets.total_vehicles
			END AS inspect_vehicles_count
		   ,maint.min_billed_unit_count AS maintain_min_bill_count
		   ,CASE
				WHEN (v2_businesses.subscription_plan_id = 17 OR
					v2_businesses.subscription_plan_id = 18 OR
					v2_businesses.subscription_plan_id = 26 OR
					v2_businesses.subscription_plan_id = 27) THEN CAST(maint.price_per_unit / 3 AS DECIMAL)
				WHEN (v2_businesses.subscription_plan_id = 19 OR
					v2_businesses.subscription_plan_id = 20) THEN CAST(maint.price_per_unit / 6 AS DECIMAL)
				WHEN (v2_businesses.subscription_plan_id = 21 OR
					v2_businesses.subscription_plan_id = 22) THEN CAST(maint.price_per_unit / 12 AS DECIMAL)
				WHEN v2_businesses.subscription_plan_id = 23 THEN CAST(maint.price_per_unit / 8 AS DECIMAL)
				WHEN v2_businesses.subscription_plan_id = 25 THEN CAST(maint.price_per_unit / 24 AS DECIMAL)
				ELSE maint.price_per_unit
			END AS maintain_ppv
		   ,CASE
				WHEN maint.id IS NOT NULL AND
					v2_businesses.min_billed_unit_count = 0 THEN b_assets.total_vehicles
				WHEN maint.id IS NOT NULL AND
					maint_assets.total_vehicles > maint.min_billed_unit_count THEN maint_assets.total_vehicles
				WHEN maint.id IS NOT NULL THEN maint.min_billed_unit_count
				ELSE 0
			END AS maintain_vehicles_count
		   ,CASE
				WHEN inspect_lite.min_billed_unit_count = 0 THEN maint_lite.min_billed_unit_count
				ELSE inspect_lite.min_billed_unit_count
			END AS inspect_lite_min_bill_count
		   ,CASE
				WHEN (v2_businesses.subscription_plan_id = 17 OR
					v2_businesses.subscription_plan_id = 18 OR
					v2_businesses.subscription_plan_id = 26 OR
					v2_businesses.subscription_plan_id = 27) THEN CAST(inspect_lite.price_per_unit / 3 AS DECIMAL)
				WHEN (v2_businesses.subscription_plan_id = 19 OR
					v2_businesses.subscription_plan_id = 20) THEN CAST(inspect_lite.price_per_unit / 6 AS DECIMAL)
				WHEN (v2_businesses.subscription_plan_id = 21 OR
					v2_businesses.subscription_plan_id = 22) THEN CAST(inspect_lite.price_per_unit / 12 AS DECIMAL)
				WHEN v2_businesses.subscription_plan_id = 23 THEN CAST(inspect_lite.price_per_unit / 8 AS DECIMAL)
				WHEN v2_businesses.subscription_plan_id = 25 THEN CAST(inspect_lite.price_per_unit / 24 AS DECIMAL)
				ELSE inspect_lite.price_per_unit
			END AS inspect_lite_ppv
		   ,CASE
				WHEN inspect_lite.min_billed_unit_count <> 0 AND
					inspect_lite_assets.total_vehicles >= inspect_lite.min_billed_unit_count THEN inspect_lite_assets.total_vehicles
				WHEN inspect_lite.min_billed_unit_count <> 0 AND
					inspect_lite_assets.total_vehicles < inspect_lite.min_billed_unit_count THEN inspect_lite.min_billed_unit_count
				WHEN maint_lite.id IS NOT NULL AND
					inspect_lite.min_billed_unit_count = 0 THEN maint_lite_assets.total_vehicles
				ELSE 0
			END AS inspect_lite_vehicles_count
		   ,maint_lite.min_billed_unit_count AS maintain_lite_min_bill_count
		   ,CASE
				WHEN (v2_businesses.subscription_plan_id = 17 OR
					v2_businesses.subscription_plan_id = 18 OR
					v2_businesses.subscription_plan_id = 26 OR
					v2_businesses.subscription_plan_id = 27) THEN CAST(maint_lite.price_per_unit / 3 AS DECIMAL)
				WHEN (v2_businesses.subscription_plan_id = 19 OR
					v2_businesses.subscription_plan_id = 20) THEN CAST(maint_lite.price_per_unit / 6 AS DECIMAL)
				WHEN (v2_businesses.subscription_plan_id = 21 OR
					v2_businesses.subscription_plan_id = 22) THEN CAST(maint_lite.price_per_unit / 12 AS DECIMAL)
				WHEN v2_businesses.subscription_plan_id = 23 THEN CAST(maint_lite.price_per_unit / 8 AS DECIMAL)
				WHEN v2_businesses.subscription_plan_id = 25 THEN CAST(maint_lite.price_per_unit / 24 AS DECIMAL)
				ELSE maint_lite.price_per_unit
			END AS maintain_lite_ppv
		   ,CASE
				WHEN maint_lite.id IS NOT NULL AND
					maint_lite_assets.total_vehicles > maint_lite.min_billed_unit_count THEN maint_lite_assets.total_vehicles
				WHEN maint_lite.id IS NOT NULL THEN maint_lite.min_billed_unit_count
				ELSE 0
			END AS maintain_lite_vehicles_count
		   ,wallet.min_billed_unit_count AS wallet_min_bill_count
		   ,CASE
				WHEN (v2_businesses.subscription_plan_id = 17 OR
					v2_businesses.subscription_plan_id = 18 OR
					v2_businesses.subscription_plan_id = 26 OR
					v2_businesses.subscription_plan_id = 27) THEN CAST(wallet.price_per_unit / 3 AS DECIMAL)
				WHEN (v2_businesses.subscription_plan_id = 19 OR
					v2_businesses.subscription_plan_id = 20) THEN CAST(wallet.price_per_unit / 6 AS DECIMAL)
				WHEN (v2_businesses.subscription_plan_id = 21 OR
					v2_businesses.subscription_plan_id = 22) THEN CAST(wallet.price_per_unit / 12 AS DECIMAL)
				WHEN v2_businesses.subscription_plan_id = 23 THEN CAST(wallet.price_per_unit / 8 AS DECIMAL)
				WHEN v2_businesses.subscription_plan_id = 25 THEN CAST(wallet.price_per_unit / 24 AS DECIMAL)
				ELSE wallet.price_per_unit
			END AS wallet_ppd
		   ,CASE
				WHEN wallet.id IS NOT NULL THEN b_drivers.total_drivers
				ELSE 0
			END AS wallet_driver_count
		FROM LocalWAProd.dbo.v2_businesses
		LEFT OUTER JOIN LocalWAProd.dbo.b_drivers
			ON dbo.b_drivers.business_id = dbo.v2_businesses.id
		LEFT OUTER JOIN LocalWAProd.dbo.b_assets
			ON dbo.b_assets.business_id = dbo.v2_businesses.id
		LEFT OUTER JOIN LocalWAProd.dbo.maint_assets
			ON dbo.maint_assets.business_id = dbo.v2_businesses.id
		LEFT OUTER JOIN LocalWAProd.dbo.maint_lite_assets
			ON dbo.maint_lite_assets.business_id = dbo.v2_businesses.id
		LEFT OUTER JOIN LocalWAProd.dbo.inspect_assets
			ON dbo.inspect_assets.business_id = dbo.v2_businesses.id
		LEFT OUTER JOIN LocalWAProd.dbo.inspect_lite_assets
			ON dbo.inspect_lite_assets.business_id = dbo.v2_businesses.id
		LEFT OUTER JOIN LocalWAProd.dbo.b_sub_addon AS maint
			ON maint.business_id = dbo.v2_businesses.id
			AND maint.subscription_add_on_id = 1
		LEFT OUTER JOIN LocalWAProd.dbo.b_sub_addon AS inspect_lite
			ON inspect_lite.business_id = dbo.v2_businesses.id
			AND inspect_lite.subscription_add_on_id = 2
		LEFT OUTER JOIN LocalWAProd.dbo.b_sub_addon AS maint_lite
			ON maint_lite.business_id = dbo.v2_businesses.id
			AND maint_lite.subscription_add_on_id = 3
		LEFT OUTER JOIN LocalWAProd.dbo.b_sub_addon AS l_fee
			ON l_fee.business_id = dbo.v2_businesses.id
			AND l_fee.subscription_add_on_id = 4
		LEFT OUTER JOIN LocalWAProd.dbo.b_sub_addon AS wallet
			ON wallet.business_id = dbo.v2_businesses.id
			AND wallet.subscription_add_on_id = 5
		LEFT OUTER JOIN LocalWAProd.dbo.v2_currencies
			ON dbo.v2_currencies.id = dbo.v2_businesses.currency_id
		LEFT OUTER JOIN LocalWAProd.dbo.v2_subscription_plans
			ON dbo.v2_subscription_plans.id = dbo.v2_businesses.subscription_plan_id
		WHERE (dbo.v2_businesses.subscription_plan_id >= 15)
		AND (dbo.v2_businesses.recurly_subscription_uuid IS NOT NULL)
		AND (dbo.v2_businesses.deleted_at IS NULL)) AS data) AS T0
		LEFT OUTER JOIN Salesforce.dbo.App_CDP__c acc ON t0.id = acc.WA_group_Id__c


		WHERE 
		acc.id = 'a1g4p000001yLzWAAU' AND 
		CAST(t0.id AS NVARCHAR) 
+ CAST(isnull(t0.inspect_billed_units, 0)  AS NVARCHAR) 
+ CAST(CAST(isnull(t0.inspect_total_billed, 0) AS DECIMAL (16,2) )  AS NVARCHAR) 
+ CAST(isnull(t0.maintain_billed_units, 0)  AS NVARCHAR) 
+ CAST(CAST(isnull(t0.maintain_total_billed, 0) AS DECIMAL (16,2) )  AS NVARCHAR) 
+ CAST(isnull(t0.inspect_lite_billed_units, 0)  AS NVARCHAR) 
+ CAST(CAST(isnull(t0.inspect_lite_total_billed, 0) AS DECIMAL (16,2) ) AS NVARCHAR) 
+ CAST(isnull(t0.maintain_lite_billed_units, 0)  AS NVARCHAR) 
+ CAST(CAST(isnull(t0.maintain_lite_total_billed, 0) AS DECIMAL (16,2) ) AS NVARCHAR) 
+ CAST(isnull(t0.wallet_billed_units, 0)  AS NVARCHAR) 
+ CAST(CAST(isnull(t0.wallet_total_billed, 0) AS DECIMAL (16,2) ) AS NVARCHAR) 
+ CAST(isnull(t0.total_drivers, 0)  AS NVARCHAR) 
+ CAST(CAST(isnull(t0.actual_MRR, 0) AS DECIMAL (16,2) ) AS NVARCHAR) 
!=  CAST(acc.WA_group_Id__c AS NVARCHAR) 
+ CAST(ISNULL(acc.TC_Inspect_Assets__c, 0) AS NVARCHAR) 
+ CAST(ISNULL(acc.tc_inspect_billed__c, 0) AS NVARCHAR)
+ CAST(isnull(acc.TC_Maintain_Assets__c, 0)  AS NVARCHAR) 
+ CAST(ISNULL(acc.[TC_Maintain_Billed__c], 0) AS NVARCHAR)
+ CAST(isnull(acc.TC_Inspect_Lite_Assets__c, 0)  AS NVARCHAR) 
+ CAST(isnull(acc.TC_Inspect_Lite_Billed__c, 0)  AS NVARCHAR) 
+ CAST(isnull(acc.TC_Maintain_Lite_Assets__c, 0)  AS NVARCHAR) 
+ CAST(isnull(acc.TC_Maintain_Lite_Billed__c, 0)  AS NVARCHAR) 
+ CAST(isnull(acc.TC_Wallet_Users__c, 0)  AS NVARCHAR) 
+ CAST(isnull(acc.[TC_Walled_Billed__c], 0)  AS NVARCHAR) 
+ CAST(isnull(acc.of_Drivers__c, 0)  AS NVARCHAR) 
+ CAST(isnull(acc.Actual_Mrr__c, 0) AS NVARCHAR) 