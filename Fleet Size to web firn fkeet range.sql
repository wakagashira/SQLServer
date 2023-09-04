SELECT [ID]
	  ,case 
	  when [TOTAL_FLEET_SIZE_C] like '%E%' then 'Less than 10 assets'
	  when isnull(Convert(decimal(16,2), [TOTAL_FLEET_SIZE_C] ), 0) <10 then 'Less than 10 assets'
	  when isnull(Convert(decimal(16,2),[TOTAL_FLEET_SIZE_C] ), 0) between 10 and 49 then '10-49 assets' 
      when isnull(Convert(decimal(16,2),[TOTAL_FLEET_SIZE_C] ), 0) between 50 and 149 then '50-149 assets'
	  when isnull(Convert(decimal(16,2),[TOTAL_FLEET_SIZE_C] ), 0) between 150 and 499 then '150-499 assets'
	  when isnull(Convert(decimal(16,2),[TOTAL_FLEET_SIZE_C] ), 0) > 499 then 'More than 500 assets'
	  end as 'Web_Form_Fleet_Range__c' 


  FROM [Whiparound].[dbo].[Lead4822]