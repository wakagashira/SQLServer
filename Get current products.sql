
select b.id, 
b.salesforce_account_id,
b.name, 
c.name as currency, 
--b.subscription_plan_id, 
--b.subscription_type, 
b.stat_vehicles_count as inspect, 
case when b.sub_cancellation_date is null Then 'Active' else 'Closed' end as Status
        --, b.subscription_starts
        --, b.subscription_ends
        , b.min_billed_unit_count
        , COALESCE(t.maintain_min_billed, 0) as maintain_min_billed
        , COALESCE(t_il.inspect_lite_min_billed, 0) as inspect_lite_min_billed
        , COALESCE(t_ml.maintain_lite_min_billed, 0) as maintain_lite_min_billed
        , COALESCE(b.unit_price_per_vehicle, 0) as unit_price_per_vehicle
        , COALESCE(t.maintain_price_per_unit, 0) as maintain_price_per_unit
        , COALESCE(t_il.inspect_lite_price_per_unit, 0) as inspect_lite_price_per_unit
        , COALESCE(t_ml.maintain_lite_price_per_unit,0) as maintain_lite_price_per_unit
        , case when bs.subscription_add_on_id is not null then 20 else 0 end as license_fee
		, COALESCE(t_wlt.Wallet_price_per_unit,0) as wallet_price_per_unit
		, COALESCE(t_wlt.Wallet_min_billed ,0) as wallet_min_billed

        from v2_businesses b 
        join v2_currencies c on b.currency_id = c.id
        
        --maintain prices 
        left join (select s.business_id, s.created_at, s.subscription_add_on_id as sub, s.price_per_unit as maintain_price_per_unit, s.min_billed_unit_count as maintain_min_billed
        from business_sub_add_ons s 
        where s.deleted_at is null and s.free_trial_start_date is null and s.subscription_add_on_id = 1) t on t.business_id = b.id
        
        --inspect lite prices 
        left join (select s.business_id, s.created_at, s.subscription_add_on_id as sub, s.price_per_unit as inspect_lite_price_per_unit, s.min_billed_unit_count as inspect_lite_min_billed
        from business_sub_add_ons s 
        where s.deleted_at is null and s.free_trial_start_date is null and s.subscription_add_on_id = 2) t_il on t_il.business_id = b.id
        
        --maintain lite prices 
        left join (select s.business_id, s.created_at, s.subscription_add_on_id as sub, s.price_per_unit as maintain_lite_price_per_unit, s.min_billed_unit_count as maintain_lite_min_billed
        from business_sub_add_ons s 
        where s.deleted_at is null and s.free_trial_start_date is null and s.subscription_add_on_id = 3) t_ml on t_ml.business_id = b.id
        
        --license fees 
        left join business_sub_add_ons bs on b.id = bs.business_id 
            and bs.subscription_add_on_id = 4 and bs.deleted_at is null 

		--Maintain Prices 
		LEFT JOIN (SELECT
	s.business_id
   ,s.created_at
   ,s.subscription_add_on_id AS sub
   ,s.price_per_unit AS Wallet_price_per_unit
   ,s.min_billed_unit_count AS Wallet_min_billed
FROM business_sub_add_ons s
WHERE s.deleted_at IS NULL
AND s.free_trial_start_date IS NULL
AND s.subscription_add_on_id = 5) AS T_wlt on t_wlt.business_id = b.id 
