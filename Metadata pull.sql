SELECT 
data.id AS WA_group_Id__c,
data.name AS AccountName,
data.currency,
data.Theplan,
data.inspect_ppv as TC_Inspect_Price_Per_Vehicle__c ,
case when
      coalesce((case when coalesce(data.inspect_min_bill_count,0) > coalesce(data.inspect_vehicles_count,0) then coalesce(data.inspect_min_bill_count,0) else coalesce(data.inspect_vehicles_count,0) end),0) 
      > coalesce((case when coalesce(data.inspect_lite_min_bill_count,0) > coalesce(data.inspect_lite_vehicles_count,0) then coalesce(data.inspect_lite_min_bill_count,0) else coalesce(data.inspect_lite_vehicles_count,0) end),0)
   THEN coalesce((case when coalesce(data.inspect_min_bill_count,0) > coalesce(data.inspect_vehicles_count,0) then coalesce(data.inspect_min_bill_count,0) else coalesce(data.inspect_vehicles_count,0) end),0) - coalesce((case when coalesce(data.inspect_lite_min_bill_count,0) > coalesce(data.inspect_lite_vehicles_count,0) then coalesce(data.inspect_lite_min_bill_count,0) else coalesce(data.inspect_lite_vehicles_count,0) end),0)
   ELSE coalesce((case when coalesce(data.inspect_lite_min_bill_count,0) > coalesce(data.inspect_lite_vehicles_count,0) then coalesce(data.inspect_lite_min_bill_count,0) else coalesce(data.inspect_lite_vehicles_count,0) end),0) - coalesce((case when coalesce(data.inspect_min_bill_count,0) > coalesce(data.inspect_vehicles_count,0) then coalesce(data.inspect_min_bill_count,0) else coalesce(data.inspect_vehicles_count,0) end),0)
   END as TC_Actual_Billed_Inspect_Vehicles__c,
  (case when
      coalesce((case when coalesce(data.inspect_min_bill_count,0) > coalesce(data.inspect_vehicles_count,0) then coalesce(data.inspect_min_bill_count,0) else coalesce(data.inspect_vehicles_count,0) end),0) 
      > coalesce((case when coalesce(data.inspect_lite_min_bill_count,0) > coalesce(data.inspect_lite_vehicles_count,0) then coalesce(data.inspect_lite_min_bill_count,0) else coalesce(data.inspect_lite_vehicles_count,0) end),0)
   THEN coalesce((case when coalesce(data.inspect_min_bill_count,0) > coalesce(data.inspect_vehicles_count,0) then coalesce(data.inspect_min_bill_count,0) else coalesce(data.inspect_vehicles_count,0) end),0) - coalesce((case when coalesce(data.inspect_lite_min_bill_count,0) > coalesce(data.inspect_lite_vehicles_count,0) then coalesce(data.inspect_lite_min_bill_count,0) else coalesce(data.inspect_lite_vehicles_count,0) end),0)
   ELSE coalesce((case when coalesce(data.inspect_lite_min_bill_count,0) > coalesce(data.inspect_lite_vehicles_count,0) then coalesce(data.inspect_lite_min_bill_count,0) else coalesce(data.inspect_lite_vehicles_count,0) end),0) - coalesce((case when coalesce(data.inspect_min_bill_count,0) > coalesce(data.inspect_vehicles_count,0) then coalesce(data.inspect_min_bill_count,0) else coalesce(data.inspect_vehicles_count,0) end),0)
   END
  
  * coalesce(data.inspect_ppv,0)) as inspect_total_billed,

data.maintain_ppv as maintain_unit_price,
coalesce((case when coalesce(data.maintain_min_bill_count,0) > coalesce(data.maintain_vehicles_count,0) then coalesce(data.maintain_min_bill_count,0) else coalesce(data.maintain_vehicles_count,0) end),0) as maintain_billed_units,
(coalesce((case when coalesce(data.maintain_min_bill_count,0) > coalesce(data.maintain_vehicles_count,0) then coalesce(data.maintain_min_bill_count,0) else coalesce(data.maintain_vehicles_count,0) end),0) * coalesce(data.maintain_ppv,0)) as maintain_total_billed,

data.inspect_lite_ppv as inspect_lite_unit_price,
coalesce((case when coalesce(data.inspect_lite_min_bill_count,0) > coalesce(data.inspect_lite_vehicles_count,0) then coalesce(data.inspect_lite_min_bill_count,0) else coalesce(data.inspect_lite_vehicles_count,0) end),0) as inspect_lite_billed_units,
(coalesce((case when coalesce(data.inspect_lite_min_bill_count,0) > coalesce(data.inspect_lite_vehicles_count,0) then coalesce(data.inspect_lite_min_bill_count,0) else coalesce(data.inspect_lite_vehicles_count,0) end),0) * coalesce(data.inspect_lite_ppv,0)) as inspect_lite_total_billed,

data.maintain_lite_ppv as maintain_lite_unit_price,
coalesce((case when coalesce(data.maintain_lite_min_bill_count,0) > coalesce(data.maintain_lite_vehicles_count,0) then coalesce(data.maintain_lite_min_bill_count,0) else coalesce(data.maintain_lite_vehicles_count,0) end),0) as maintain_lite_billed_units,
(coalesce((case when coalesce(data.maintain_lite_min_bill_count,0) > coalesce(data.maintain_lite_vehicles_count,0) then coalesce(data.maintain_lite_min_bill_count,0) else coalesce(data.maintain_lite_vehicles_count,0) end),0) * coalesce(data.maintain_lite_ppv,0)) as maintain_lite_total_billed,

data.wallet_ppd as wallet_unit_price,
coalesce((case when coalesce(data.wallet_min_bill_count,0) > coalesce(data.wallet_driver_count,0) then coalesce(data.wallet_min_bill_count,0) else coalesce(data.wallet_driver_count,0) end),0) as wallet_billed_units,
(coalesce((case when coalesce(data.wallet_min_bill_count,0) > coalesce(data.wallet_driver_count,0) then coalesce(data.wallet_min_bill_count,0) else coalesce(data.wallet_driver_count,0) end),0) * coalesce(data.wallet_ppd,0)) as wallet_total_billed,
data.total_drivers AS of_Drivers__c,
data.license_fee as license_fee,

(coalesce(data.license_fee,0) 
+ (
case when
      coalesce((case when coalesce(data.inspect_min_bill_count,0) > coalesce(data.inspect_vehicles_count,0) then coalesce(data.inspect_min_bill_count,0) else coalesce(data.inspect_vehicles_count,0) end),0) 
      > coalesce((case when coalesce(data.inspect_lite_min_bill_count,0) > coalesce(data.inspect_lite_vehicles_count,0) then coalesce(data.inspect_lite_min_bill_count,0) else coalesce(data.inspect_lite_vehicles_count,0) end),0)
   THEN coalesce((case when coalesce(data.inspect_min_bill_count,0) > coalesce(data.inspect_vehicles_count,0) then coalesce(data.inspect_min_bill_count,0) else coalesce(data.inspect_vehicles_count,0) end),0) - coalesce((case when coalesce(data.inspect_lite_min_bill_count,0) > coalesce(data.inspect_lite_vehicles_count,0) then coalesce(data.inspect_lite_min_bill_count,0) else coalesce(data.inspect_lite_vehicles_count,0) end),0)
   ELSE coalesce((case when coalesce(data.inspect_lite_min_bill_count,0) > coalesce(data.inspect_lite_vehicles_count,0) then coalesce(data.inspect_lite_min_bill_count,0) else coalesce(data.inspect_lite_vehicles_count,0) end),0) - coalesce((case when coalesce(data.inspect_min_bill_count,0) > coalesce(data.inspect_vehicles_count,0) then coalesce(data.inspect_min_bill_count,0) else coalesce(data.inspect_vehicles_count,0) end),0)
   END

* coalesce(data.inspect_ppv,0))
+ (coalesce((case when coalesce(data.maintain_min_bill_count,0) > coalesce(data.maintain_vehicles_count,0) then coalesce(data.maintain_min_bill_count,0) else coalesce(data.maintain_vehicles_count,0) end),0) * coalesce(data.maintain_ppv,0))
+ (coalesce((case when coalesce(data.inspect_lite_min_bill_count,0) > coalesce(data.inspect_lite_vehicles_count,0) then coalesce(data.inspect_lite_min_bill_count,0) else coalesce(data.inspect_lite_vehicles_count,0) end),0) * coalesce(data.inspect_lite_ppv,0))
+ (coalesce((case when coalesce(data.maintain_lite_min_bill_count,0) > coalesce(data.maintain_lite_vehicles_count,0) then coalesce(data.maintain_lite_min_bill_count,0) else coalesce(data.maintain_lite_vehicles_count,0) end),0) * coalesce(data.maintain_lite_ppv,0))
+ (coalesce((case when coalesce(data.wallet_min_bill_count,0) > coalesce(data.wallet_driver_count,0) then coalesce(data.wallet_min_bill_count,0) else coalesce(data.wallet_driver_count,0) end),0) * coalesce(data.wallet_ppd,0))
) as actual_MRR
FROM (


select
v2_businesses.id,
v2_businesses.name,
b_assets.total_vehicles,
v2_subscription_plans.recurly_code AS ThePlan,
v2_businesses.activated_at,
v2_currencies.name as currency,
b_drivers.total_drivers,
CASE
      WHEN (v2_businesses.subscription_plan_id = 17 or  v2_businesses.subscription_plan_id = 18 or  v2_businesses.subscription_plan_id = 26 or v2_businesses.subscription_plan_id = 27)  THEN cast(v2_businesses.stat_bill_last_amount/3  AS DECIMAL)
      WHEN (v2_businesses.subscription_plan_id = 19 or  v2_businesses.subscription_plan_id = 20)  THEN cast(v2_businesses.stat_bill_last_amount/6  AS DECIMAL)
      WHEN (v2_businesses.subscription_plan_id = 21 or  v2_businesses.subscription_plan_id = 22)  THEN cast(v2_businesses.stat_bill_last_amount/12  AS DECIMAL)
      WHEN v2_businesses.subscription_plan_id = 23 THEN cast(v2_businesses.stat_bill_last_amount/8  AS DECIMAL)
      WHEN v2_businesses.subscription_plan_id = 25  THEN cast(v2_businesses.stat_bill_last_amount/24  AS DECIMAL)
      ELSE v2_businesses.stat_bill_last_amount end as last_month_payment,
    CASE
      WHEN (v2_businesses.subscription_plan_id = 17 or  v2_businesses.subscription_plan_id = 18 or  v2_businesses.subscription_plan_id = 26 or v2_businesses.subscription_plan_id = 27)  THEN cast(l_fee.price_per_unit/3 AS DECIMAL)
      WHEN (v2_businesses.subscription_plan_id = 19 or  v2_businesses.subscription_plan_id = 20)  THEN cast(l_fee.price_per_unit/6  AS DECIMAL)
      WHEN (v2_businesses.subscription_plan_id = 21 or  v2_businesses.subscription_plan_id = 22)  THEN cast(l_fee.price_per_unit/12  AS DECIMAL)
      WHEN v2_businesses.subscription_plan_id = 23 THEN cast(l_fee.price_per_unit/8  AS DECIMAL)
      WHEN v2_businesses.subscription_plan_id = 25  THEN Cast(l_fee.price_per_unit/24  AS DECIMAL)
      ELSE l_fee.price_per_unit end as license_fee,

    case
      WHEN v2_businesses.min_billed_unit_count = 0 THEN maint.min_billed_unit_count ELSE v2_businesses.min_billed_unit_count END as inspect_min_bill_count,
    CASE
      WHEN (v2_businesses.subscription_plan_id = 17 or  v2_businesses.subscription_plan_id = 18 or  v2_businesses.subscription_plan_id = 26 or v2_businesses.subscription_plan_id = 27)  THEN cast(v2_businesses.unit_price_per_vehicle/3 AS DECIMAL)
      WHEN (v2_businesses.subscription_plan_id = 19 or  v2_businesses.subscription_plan_id = 20)  THEN cast(v2_businesses.unit_price_per_vehicle/6 AS DECIMAL)
      WHEN (v2_businesses.subscription_plan_id = 21 or  v2_businesses.subscription_plan_id = 22)  THEN cast(v2_businesses.unit_price_per_vehicle/12 AS DECIMAL)
      WHEN v2_businesses.subscription_plan_id = 23 THEN cast(v2_businesses.unit_price_per_vehicle/8 AS DECIMAL)
      WHEN v2_businesses.subscription_plan_id = 25  THEN cast(v2_businesses.unit_price_per_vehicle/24 AS DECIMAL)
      ELSE v2_businesses.unit_price_per_vehicle end as inspect_ppv,

      case
         WHEN maint.id is not null and  v2_businesses.min_billed_unit_count = 0 and inspect_assets.total_vehicles >= v2_businesses.min_billed_unit_count THEN  inspect_assets.total_vehicles
         WHEN maint.id is not null and  v2_businesses.min_billed_unit_count <> 0 and inspect_assets.total_vehicles < v2_businesses.min_billed_unit_count THEN  v2_businesses.min_billed_unit_count
         ELSE b_assets.total_vehicles END as inspect_vehicles_count,


     maint.min_billed_unit_count as maintain_min_bill_count,
     CASE
         WHEN (v2_businesses.subscription_plan_id = 17 or  v2_businesses.subscription_plan_id = 18 or  v2_businesses.subscription_plan_id = 26 or v2_businesses.subscription_plan_id = 27)  THEN cast(maint.price_per_unit/3 AS DECIMAL)
         WHEN (v2_businesses.subscription_plan_id = 19 or  v2_businesses.subscription_plan_id = 20)  THEN cast(maint.price_per_unit/6 AS DECIMAL)
         WHEN (v2_businesses.subscription_plan_id = 21 or  v2_businesses.subscription_plan_id = 22)  THEN cast(maint.price_per_unit/12 AS DECIMAL)
         WHEN v2_businesses.subscription_plan_id = 23 THEN cast(maint.price_per_unit/8 AS DECIMAL)
         WHEN v2_businesses.subscription_plan_id = 25  THEN cast(maint.price_per_unit/24 AS DECIMAL)
         ELSE maint.price_per_unit end as maintain_ppv,
     case
        WHEN maint.id is not null and v2_businesses.min_billed_unit_count = 0 THEN b_assets.total_vehicles
        WHEN maint.id is not null and  maint_assets.total_vehicles > maint.min_billed_unit_count THEN  maint_assets.total_vehicles
        WHEN maint.id is not null THEN maint.min_billed_unit_count
        ELSE 0 END as maintain_vehicles_count,


     case
        WHEN inspect_lite.min_billed_unit_count = 0 THEN maint_lite.min_billed_unit_count ELSE inspect_lite.min_billed_unit_count END as inspect_lite_min_bill_count,
     CASE
        WHEN (v2_businesses.subscription_plan_id = 17 or  v2_businesses.subscription_plan_id = 18 or  v2_businesses.subscription_plan_id = 26 or v2_businesses.subscription_plan_id = 27)  THEN cast(inspect_lite.price_per_unit/3 AS DECIMAL)
        WHEN (v2_businesses.subscription_plan_id = 19 or  v2_businesses.subscription_plan_id = 20)  THEN cast(inspect_lite.price_per_unit/6 AS DECIMAL)
        WHEN (v2_businesses.subscription_plan_id = 21 or  v2_businesses.subscription_plan_id = 22)  THEN cast(inspect_lite.price_per_unit/12 AS DECIMAL)
        WHEN v2_businesses.subscription_plan_id = 23 THEN cast(inspect_lite.price_per_unit/8 AS DECIMAL)
        WHEN v2_businesses.subscription_plan_id = 25  THEN cast(inspect_lite.price_per_unit/24 AS DECIMAL)
        ELSE inspect_lite.price_per_unit end as inspect_lite_ppv,
     case
        WHEN inspect_lite.min_billed_unit_count <> 0 and inspect_lite_assets.total_vehicles >= inspect_lite.min_billed_unit_count THEN  inspect_lite_assets.total_vehicles
        WHEN inspect_lite.min_billed_unit_count <> 0 and inspect_lite_assets.total_vehicles < inspect_lite.min_billed_unit_count THEN  inspect_lite.min_billed_unit_count
        WHEN maint_lite.id is not null and  inspect_lite.min_billed_unit_count = 0 THEN  maint_lite_assets.total_vehicles
       ELSE 0 END as inspect_lite_vehicles_count,


     maint_lite.min_billed_unit_count as maintain_lite_min_bill_count,
     CASE
        WHEN (v2_businesses.subscription_plan_id = 17 or  v2_businesses.subscription_plan_id = 18 or  v2_businesses.subscription_plan_id = 26 or v2_businesses.subscription_plan_id = 27)  THEN cast(maint_lite.price_per_unit/3 AS DECIMAL)
        WHEN (v2_businesses.subscription_plan_id = 19 or  v2_businesses.subscription_plan_id = 20)  THEN cast(maint_lite.price_per_unit/6 AS DECIMAL)
        WHEN (v2_businesses.subscription_plan_id = 21 or  v2_businesses.subscription_plan_id = 22)  THEN cast(maint_lite.price_per_unit/12 AS DECIMAL)
        WHEN v2_businesses.subscription_plan_id = 23 THEN cast(maint_lite.price_per_unit/8 AS DECIMAL)
        WHEN v2_businesses.subscription_plan_id = 25  THEN cast(maint_lite.price_per_unit/24 AS DECIMAL)
        ELSE maint_lite.price_per_unit end as maintain_lite_ppv,
      case
        WHEN maint_lite.id is not null and  maint_lite_assets.total_vehicles > maint_lite.min_billed_unit_count THEN  maint_lite_assets.total_vehicles
        WHEN maint_lite.id is not null THEN maint_lite.min_billed_unit_count
        ELSE 0 END as maintain_lite_vehicles_count,


     wallet.min_billed_unit_count as wallet_min_bill_count,
    CASE
      WHEN (v2_businesses.subscription_plan_id = 17 or  v2_businesses.subscription_plan_id = 18 or  v2_businesses.subscription_plan_id = 26 or v2_businesses.subscription_plan_id = 27)  THEN cast(wallet.price_per_unit/3 AS DECIMAL)
      WHEN (v2_businesses.subscription_plan_id = 19 or  v2_businesses.subscription_plan_id = 20)  THEN cast(wallet.price_per_unit/6 AS DECIMAL)
      WHEN (v2_businesses.subscription_plan_id = 21 or  v2_businesses.subscription_plan_id = 22)  THEN cast(wallet.price_per_unit/12 AS DECIMAL)
      WHEN v2_businesses.subscription_plan_id = 23 THEN cast(wallet.price_per_unit/8 AS DECIMAL)
      WHEN v2_businesses.subscription_plan_id = 25  THEN cast(wallet.price_per_unit/24 AS DECIMAL)
      ELSE wallet.price_per_unit end as wallet_ppd,
    case
        WHEN wallet.id is not null THEN  b_drivers.total_drivers
        ELSE 0 END as wallet_driver_count

from v2_businesses
left join b_drivers
        on b_drivers.business_id = v2_businesses.id
left join b_assets
        on b_assets.business_id = v2_businesses.id
left join maint_assets
        on maint_assets.business_id = v2_businesses.id
left join maint_lite_assets
        on maint_lite_assets.business_id = v2_businesses.id
left join inspect_assets
        on inspect_assets.business_id = v2_businesses.id
left join inspect_lite_assets
        on inspect_lite_assets.business_id = v2_businesses.id
Left join b_sub_addon as maint
    on maint.business_id = v2_businesses.id and maint.subscription_add_on_id = 1
Left join b_sub_addon as inspect_lite
    on inspect_lite.business_id = v2_businesses.id and inspect_lite.subscription_add_on_id = 2
Left join b_sub_addon as maint_lite
    on maint_lite.business_id = v2_businesses.id and maint_lite.subscription_add_on_id = 3
 Left join b_sub_addon as l_fee
    on l_fee.business_id = v2_businesses.id and l_fee.subscription_add_on_id = 4
Left join b_sub_addon as wallet
    on wallet.business_id = v2_businesses.id and wallet.subscription_add_on_id = 5
Left join v2_currencies 
    on v2_currencies.id = v2_businesses.currency_id 
Left join v2_subscription_plans  
    on v2_subscription_plans.id = v2_businesses.subscription_plan_id     
where
   v2_businesses.subscription_plan_id >=15
   and v2_businesses.recurly_subscription_uuid is not null
   and v2_businesses.deleted_at is null
) AS data
LEFT OUTER JOIN Salesforce.dbo.App_CDP__c acc ON DATA.id = 