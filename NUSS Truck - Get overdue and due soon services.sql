select * from 
openquery(WAPROD , '                SELECT 
				--services.id 
				services.title as Title
				--,services.business_id 
				, case when service_status = 0 then ''Open'' when service_status = 1 then ''Due Soon'' when service_status = 2 then ''Over Due'' end as Status
				,v2_vehicles.Name as Asset
				, v2_teams.name as Team
                   --, CASE WHEN service_status_view.service_status IS NOT NULL THEN service_status_view.service_status                        ELSE                             CASE                                 WHEN services.completion_date is not null then 3                                ELSE 0                             END                       END AS service_status 
                   
                FROM services 
					inner join v2_businesses on services.business_id = v2_businesses.id 
                    INNER JOIN v2_vehicles 
                        on v2_vehicles.id = services.asset_id 
                        and (services.completion_date is not null OR v2_vehicles.subscription_type is null OR v2_vehicles.subscription_type in (''MAINTAIN'', ''MAINTAIN_LITE'')) 
                    LEFT JOIN service_settings_view 
                        on service_settings_view.service_program_id = services.service_program_id 
                        and service_settings_view.asset_id = services.asset_id 
                        and service_settings_view.value is not null 
                    LEFT JOIN service_status_view 
                        on service_status_view.service_id = services.id 
                        AND service_status_view.business_id = v2_businesses.id
                    LEFT JOIN work_order_items 
                            INNER JOIN work_orders 
                                on work_orders.id = work_order_items.work_order_id 
                                and work_orders.deleted_at is null 
                        on work_order_items.service_id = services.id 
                        and work_order_items.deleted_at is null 
                    LEFT JOIN v2_users as completed_user 
                        on completed_user.id = services.completed_by_user_id 
					Left Join v2_teams as v2_teams on v2_vehicles.team_id = v2_teams.id
                
                WHERE  services.deleted_at is NULL 
                  AND v2_vehicles.deleted_at is null 
                and services.business_id = 18475   
                   
                              AND services.completion_date is null 
							  and CASE 
                        WHEN service_status_view.service_status IS NOT NULL THEN service_status_view.service_status 
                        ELSE 
                            CASE 
                                WHEN services.completion_date is not null then 3 
                                ELSE 0 
                            END 
                      END in (1,2)
                GROUP BY services.id 
                    , services.title 
                    , services.ui_number_text 
                    , services.asset_id 
                    , v2_vehicles.name 
                    , service_status_view.service_status 
                    , v2_vehicles.odometer 
                    , v2_vehicles.odometer_updated_at 
                    , v2_vehicles.engine_hours 
                    , v2_vehicles.engine_hours_updated_at 
                    , services.completion_odometer 
                    , services.completion_engine_hours 
                    , services.completion_date 
                    , services.work_order_id 
                    , completed_user.first_name || '' '' || completed_user.last_name 
					,v2_teams.name
                ORDER BY 
                service_status_view.service_status DESC, 
                now() - MAX( 
                    case 
                        when service_settings_view.service_setting_type_code = ''DUE-DATE'' and service_settings_view.value is not null then service_settings_view.value::timestamp 
                        when service_settings_view.service_setting_type_code = ''DUE-DATE'' then now() 
                    end 
                ) DESC NULLS LAST, 
                MAX( 
                    case 
                        when service_settings_view.service_setting_type_code = ''DUE-MILE'' then COALESCE(v2_vehicles.odometer, 0) - COALESCE(service_settings_view.value::float, 0) 
                        when service_settings_view.service_setting_type_code = ''DUE-EH'' then COALESCE(v2_vehicles.engine_hours, 0) - COALESCE(service_settings_view.value::float, 0) 
                        else null 
                    end 
                ) DESC NULLS LAST 
') as b  