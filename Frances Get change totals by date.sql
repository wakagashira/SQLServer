select 
business_id,
sum(Maintain) as Maintain,
sum(Inspect) as Inspect,
sum(MaintainLite) as MaintainLite,
sum(InspectLite) as InspectLite

from (
/*Get Maintain Counts */
select business_id,
case when addedRemoved = 'Removed' then sum(convert(int, adjusted_vehicles)) * -1 else sum(convert(int, adjusted_vehicles)) end as Maintain,
0 as Inspect,
0 as MaintainLite,
0 as InspectLite

from 
(SELECT a.*, 
       b.salesforce_account_id,
       CASE
           WHEN a.prorated_price_per_vehicle NOT LIKE '-%'
           THEN 'Added'
           ELSE 'Removed'
       END AS AddedRemoved, --get type of change
       CASE
           WHEN a.description LIKE '%Maintain Lite%'
           THEN 'Maintain Lite'
           WHEN a.description LIKE '%Maintain%'
           THEN 'Maintain'
           WHEN a.description LIKE '%Inspect Lite%'
           THEN 'inspect Lite'
           ELSE 'Inspect'
       END AS Product, --Find Cost of Item
       CASE
           WHEN(CASE
                    WHEN a.description LIKE '%Maintain Lite%'
                    THEN 'Maintain Lite'
                    WHEN a.description LIKE '%Maintain%'
                    THEN 'Maintain'
                    WHEN a.description LIKE '%Inspect Lite%'
                    THEN 'inspect Lite'
                    ELSE 'Inspect'
                END) = 'Inspect'
           THEN b.unit_price_per_vehicle
           ELSE s.price_per_unit
       END AS MRRPerItem, 
       b.Name, 
       b.id as OtherId, 
       b.recurly_account_code, 
       b.currency_id
FROM v2_billing_audits AS a
     INNER JOIN v2_businesses AS b ON a.business_id = b.id
     LEFT OUTER JOIN
(
    SELECT a.*, 
           s.name
    FROM business_sub_add_ons AS a
         LEFT OUTER JOIN subscription_add_ons AS s ON a.subscription_add_on_id = s.id
         INNER JOIN v2_businesses AS b ON a.business_id = b.id
    WHERE a.deleted_at IS NULL
) AS s ON a.business_id = s.business_id
          AND CASE
                  WHEN a.description LIKE '%Maintain Lite%'
                  THEN 'Maintain Lite'
                  WHEN a.description LIKE '%Maintain%'
                  THEN 'Maintain'
                  WHEN a.description LIKE '%Inspect Lite%'
                  THEN 'inspect Lite'
                  ELSE 'Inspect'
              END = s.name
WHERE a.created_at > '2022-03-01 00:00:01'
      AND a.created_at < '2022-04-01 00:00:01') as t0 
	  where t0.Product = 'Maintain'
Group by t0.business_id,
t0.AddedRemoved

union 

/*Get Inspect Counts */
select business_id,
0 as Maintain,
case when addedRemoved = 'Removed' then sum(convert(int, adjusted_vehicles)) * -1 else sum(convert(int, adjusted_vehicles)) end as Inspect,
0 as MaintainLite,
0 as InspectLite

from 
(SELECT a.*, 
       b.salesforce_account_id,
       CASE
           WHEN a.prorated_price_per_vehicle NOT LIKE '-%'
           THEN 'Added'
           ELSE 'Removed'
       END AS AddedRemoved, --get type of change
       CASE
           WHEN a.description LIKE '%Maintain Lite%'
           THEN 'Maintain Lite'
           WHEN a.description LIKE '%Maintain%'
           THEN 'Maintain'
           WHEN a.description LIKE '%Inspect Lite%'
           THEN 'inspect Lite'
           ELSE 'Inspect'
       END AS Product, --Find Cost of Item
       CASE
           WHEN(CASE
                    WHEN a.description LIKE '%Maintain Lite%'
                    THEN 'Maintain Lite'
                    WHEN a.description LIKE '%Maintain%'
                    THEN 'Maintain'
                    WHEN a.description LIKE '%Inspect Lite%'
                    THEN 'inspect Lite'
                    ELSE 'Inspect'
                END) = 'Inspect'
           THEN b.unit_price_per_vehicle
           ELSE s.price_per_unit
       END AS MRRPerItem, 
       b.Name, 
       b.id as OtherId, 
       b.recurly_account_code, 
       b.currency_id
FROM v2_billing_audits AS a
     INNER JOIN v2_businesses AS b ON a.business_id = b.id
     LEFT OUTER JOIN
(
    SELECT a.*, 
           s.name
    FROM business_sub_add_ons AS a
         LEFT OUTER JOIN subscription_add_ons AS s ON a.subscription_add_on_id = s.id
         INNER JOIN v2_businesses AS b ON a.business_id = b.id
    WHERE a.deleted_at IS NULL
) AS s ON a.business_id = s.business_id
          AND CASE
                  WHEN a.description LIKE '%Maintain Lite%'
                  THEN 'Maintain Lite'
                  WHEN a.description LIKE '%Maintain%'
                  THEN 'Maintain'
                  WHEN a.description LIKE '%Inspect Lite%'
                  THEN 'inspect Lite'
                  ELSE 'Inspect'
              END = s.name
WHERE a.created_at > '2022-03-01 00:00:01'
      AND a.created_at < '2022-04-01 00:00:01') as t0 
	  where t0.Product = 'Inspect'
Group by t0.business_id,
t0.AddedRemoved


union 

/*Get Maintain Lite Counts */
select business_id,
0 as Maintain,
0 as Inspect,
case when addedRemoved = 'Removed' then sum(convert(int, adjusted_vehicles)) * -1 else sum(convert(int, adjusted_vehicles)) end as MaintainLite,
0 as InspectLite

from 
(SELECT a.*, 
       b.salesforce_account_id,
       CASE
           WHEN a.prorated_price_per_vehicle NOT LIKE '-%'
           THEN 'Added'
           ELSE 'Removed'
       END AS AddedRemoved, --get type of change
       CASE
           WHEN a.description LIKE '%Maintain Lite%'
           THEN 'Maintain Lite'
           WHEN a.description LIKE '%Maintain%'
           THEN 'Maintain'
           WHEN a.description LIKE '%Inspect Lite%'
           THEN 'inspect Lite'
           ELSE 'Inspect'
       END AS Product, --Find Cost of Item
       CASE
           WHEN(CASE
                    WHEN a.description LIKE '%Maintain Lite%'
                    THEN 'Maintain Lite'
                    WHEN a.description LIKE '%Maintain%'
                    THEN 'Maintain'
                    WHEN a.description LIKE '%Inspect Lite%'
                    THEN 'inspect Lite'
                    ELSE 'Inspect'
                END) = 'Inspect'
           THEN b.unit_price_per_vehicle
           ELSE s.price_per_unit
       END AS MRRPerItem, 
       b.Name, 
       b.id as OtherId, 
       b.recurly_account_code, 
       b.currency_id
FROM v2_billing_audits AS a
     INNER JOIN v2_businesses AS b ON a.business_id = b.id
     LEFT OUTER JOIN
(
    SELECT a.*, 
           s.name
    FROM business_sub_add_ons AS a
         LEFT OUTER JOIN subscription_add_ons AS s ON a.subscription_add_on_id = s.id
         INNER JOIN v2_businesses AS b ON a.business_id = b.id
    WHERE a.deleted_at IS NULL
) AS s ON a.business_id = s.business_id
          AND CASE
                  WHEN a.description LIKE '%Maintain Lite%'
                  THEN 'Maintain Lite'
                  WHEN a.description LIKE '%Maintain%'
                  THEN 'Maintain'
                  WHEN a.description LIKE '%Inspect Lite%'
                  THEN 'inspect Lite'
                  ELSE 'Inspect'
              END = s.name
WHERE a.created_at > '2022-03-01 00:00:01'
      AND a.created_at < '2022-04-01 00:00:01') as t0 
	  where t0.Product = 'Maintain Lite'
Group by t0.business_id,
t0.AddedRemoved

union 

/*Get Maintain Lite Counts */
select business_id,
0 as Maintain,
0 as Inspect,
0 as MaintainLite,
case when addedRemoved = 'Removed' then sum(convert(int, adjusted_vehicles)) * -1 else sum(convert(int, adjusted_vehicles)) end as InspectLite

from 
(SELECT a.*, 
       b.salesforce_account_id,
       CASE
           WHEN a.prorated_price_per_vehicle NOT LIKE '-%'
           THEN 'Added'
           ELSE 'Removed'
       END AS AddedRemoved, --get type of change
       CASE
           WHEN a.description LIKE '%Maintain Lite%'
           THEN 'Maintain Lite'
           WHEN a.description LIKE '%Maintain%'
           THEN 'Maintain'
           WHEN a.description LIKE '%Inspect Lite%'
           THEN 'inspect Lite'
           ELSE 'Inspect'
       END AS Product, --Find Cost of Item
       CASE
           WHEN(CASE
                    WHEN a.description LIKE '%Maintain Lite%'
                    THEN 'Maintain Lite'
                    WHEN a.description LIKE '%Maintain%'
                    THEN 'Maintain'
                    WHEN a.description LIKE '%Inspect Lite%'
                    THEN 'inspect Lite'
                    ELSE 'Inspect'
                END) = 'Inspect'
           THEN b.unit_price_per_vehicle
           ELSE s.price_per_unit
       END AS MRRPerItem, 
       b.Name, 
       b.id as OtherId, 
       b.recurly_account_code, 
       b.currency_id
FROM v2_billing_audits AS a
     INNER JOIN v2_businesses AS b ON a.business_id = b.id
     LEFT OUTER JOIN
(
    SELECT a.*, 
           s.name
    FROM business_sub_add_ons AS a
         LEFT OUTER JOIN subscription_add_ons AS s ON a.subscription_add_on_id = s.id
         INNER JOIN v2_businesses AS b ON a.business_id = b.id
    WHERE a.deleted_at IS NULL
) AS s ON a.business_id = s.business_id
          AND CASE
                  WHEN a.description LIKE '%Maintain Lite%'
                  THEN 'Maintain Lite'
                  WHEN a.description LIKE '%Maintain%'
                  THEN 'Maintain'
                  WHEN a.description LIKE '%Inspect Lite%'
                  THEN 'inspect Lite'
                  ELSE 'Inspect'
              END = s.name
WHERE a.created_at > '2022-03-01 00:00:01'
      AND a.created_at < '2022-04-01 00:00:01') as t0 
	  where t0.Product = 'Inspect Lite'
Group by t0.business_id,
t0.AddedRemoved

) as Z1
Group by business_id