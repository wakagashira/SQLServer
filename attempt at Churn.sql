 /*  select *
    , case when length_days_of_sub < 60 or subscription_plan_id = 15 then unit_price_per_vehicle
            when length_days_of_sub < 100 then unit_price_per_vehicle::float/3 
            when length_days_of_sub < 190 then unit_price_per_vehicle::float/2
            when length_days_of_sub = 365 then unit_price_per_vehicle::float/12 end as unit_price_per_vehicle_adj
    , case when length_days_of_sub < 60 or subscription_plan_id = 15 then maintain_price_per_unit
            when length_days_of_sub < 100 then maintain_price_per_unit::float/3
            when length_days_of_sub < 190 then maintain_price_per_unit::float/6 
            when length_days_of_sub = 365 then maintain_price_per_unit::float/12 end as maintain_price_per_unit_adj
    , case when length_days_of_sub < 60 or subscription_plan_id = 15 then inspect_lite_price_per_unit
            when length_days_of_sub < 100 then inspect_lite_price_per_unit::float/3 
            when length_days_of_sub < 190 then inspect_lite_price_per_unit::float/6
            when length_days_of_sub = 365 then inspect_lite_price_per_unit::float/12 end as inspect_lite_price_per_unit_adj
    , case when length_days_of_sub < 60 or subscription_plan_id = 15 then maintain_lite_price_per_unit
            when length_days_of_sub < 100 then maintain_lite_price_per_unit::float/3 
            when length_days_of_sub < 190 then maintain_lite_price_per_unit::float/6
            when length_days_of_sub = 365 then maintain_lite_price_per_unit::float/12 end as maintain_lite_price_per_unit_adj
    from 
	(
*/	
	
	select t0.id,
	 a.maintain_min_billed,
	 a.maintain_price_per_unit,
	 a.sub as Asub,
	 b.inspect_lite_min_billed,
	 b.inspect_lite_price_per_unit,
	 b.sub as bsub,
	 c.maintain_lite_min_billed,
	 c.maintain_lite_price_per_unit,
	 c.sub as CSub,
	 a.sub + b.sub + c.sub as totalSub

	 from 
openquery(WAPROD , 'select id, subscription_plan_id, sub_cancellation_date, subscription_starts, subscription_ends from [v2_businesses]') as t0
Left outer Join 
	 (--maintain prices 
select s.business_id, s.created_at, s.subscription_add_on_id as sub, s.price_per_unit as maintain_price_per_unit, s.min_billed_unit_count as maintain_min_billed
        from [WAPROD].[whiparound_andrew].[public].business_sub_add_ons s 
        where s.deleted_at is null and s.free_trial_start_date is null and s.subscription_add_on_id = 1) as A on t0.Id = a.business_id
        
		Left outer join (
        --inspect lite prices 
        select s.business_id, s.created_at, s.subscription_add_on_id as sub, s.price_per_unit as inspect_lite_price_per_unit, s.min_billed_unit_count as inspect_lite_min_billed
        from [WAPROD].[whiparound_andrew].[public].business_sub_add_ons s 
        where s.deleted_at is null and s.free_trial_start_date is null and s.subscription_add_on_id = 2 ) as B on t0.Id = b.business_id
        
		Left outer join (
        --maintain lite prices 
        select s.business_id, s.created_at, s.subscription_add_on_id as sub, s.price_per_unit as maintain_lite_price_per_unit, s.min_billed_unit_count as maintain_lite_min_billed
        from [WAPROD].[whiparound_andrew].[public].business_sub_add_ons s 
        where s.deleted_at is null and s.free_trial_start_date is null and s.subscription_add_on_id = 3
        ) as c  on t0.Id = c.business_id
   --license fees 
        left join [WAPROD].[whiparound_andrew].[public].business_sub_add_ons bs on t0.id = bs.business_id 
            and bs.subscription_add_on_id = 4 and bs.deleted_at is null 
        
        where 
		t0.sub_cancellation_date > t0.subscription_starts 
		and dateadd(hour, -4, t0.subscription_ends) > dateadd(hour, -16, getdate()) 
        and dateadd(hour, -4, t0.subscription_ends) < dateadd(month, +2, dateadd(HOUR, -16, getdate())) 
        and t0.subscription_plan_id > 14
		
		and ( a.business_id is not null or b.business_id is not null or c.business_id is not null)
	--	) as Z1