SELECT
		SFOppID = JSON_VALUE([pandadoc__InputJSON_EV2__c], '$.data.metadata."salesforce.opportunity_id"')
	   ,SFAcctID = JSON_VALUE([pandadoc__InputJSON_EV2__c], '$.data.metadata."salesforce.account_id"')
	   ,Template = JSON_VALUE([pandadoc__InputJSON_EV2__c], '$.data.template.name')
	   ,Product = JSON_VALUE([pandadoc__InputJSON_EV2__c], '$.data.products[0].name')
	   ,Qty = JSON_VALUE([pandadoc__InputJSON_EV2__c], '$.data.products[0].qty')
	   ,Price = JSON_VALUE([pandadoc__InputJSON_EV2__c], '$.data.products[0].price')
	FROM [Salesforce].[dbo].[pandadoc__PandaDocDocument__c] AS pd
	-- cross apply openjson(pd.[pandadoc__InputJSON_EV2__c]) as j
	WHERE Id = 'a2f4p000000Ax0sAAC'
	AND pd.pandadoc__Status__c = 'document.completed'
	AND JSON_VALUE([pandadoc__InputJSON_EV2__c], '$.data.products[0].name') IS NOT NULL
	UNION
	SELECT
		SFOppID = JSON_VALUE([pandadoc__InputJSON_EV2__c], '$.data.metadata."salesforce.opportunity_id"')
	   ,SFAcctID = JSON_VALUE([pandadoc__InputJSON_EV2__c], '$.data.metadata."salesforce.account_id"')
	   ,Template = JSON_VALUE([pandadoc__InputJSON_EV2__c], '$.data.template.name')
	   ,Product = JSON_VALUE([pandadoc__InputJSON_EV2__c], '$.data.products[1].name')
	   ,Qty = JSON_VALUE([pandadoc__InputJSON_EV2__c], '$.data.products[1].qty')
	   ,Price = JSON_VALUE([pandadoc__InputJSON_EV2__c], '$.data.products[1].price')
	FROM [Salesforce].[dbo].[pandadoc__PandaDocDocument__c] AS pd
	-- cross apply openjson(pd.[pandadoc__InputJSON_EV2__c]) as j
	WHERE pd.pandadoc__Status__c = 'document.completed'
	AND JSON_VALUE([pandadoc__InputJSON_EV2__c], '$.data.products[1].name') IS NOT NULL
	UNION
	SELECT
		SFOppID = JSON_VALUE([pandadoc__InputJSON_EV2__c], '$.data.metadata."salesforce.opportunity_id"')
	   ,SFAcctID = JSON_VALUE([pandadoc__InputJSON_EV2__c], '$.data.metadata."salesforce.account_id"')
	   ,Template = JSON_VALUE([pandadoc__InputJSON_EV2__c], '$.data.template.name')
	   ,Product = JSON_VALUE([pandadoc__InputJSON_EV2__c], '$.data.products[2].name')
	   ,Qty = JSON_VALUE([pandadoc__InputJSON_EV2__c], '$.data.products[2].qty')
	   ,Price = JSON_VALUE([pandadoc__InputJSON_EV2__c], '$.data.products[2].price')
	FROM [Salesforce].[dbo].[pandadoc__PandaDocDocument__c] AS pd
	-- cross apply openjson(pd.[pandadoc__InputJSON_EV2__c]) as j
	WHERE pd.pandadoc__Status__c = 'document.completed'
	AND JSON_VALUE([pandadoc__InputJSON_EV2__c], '$.data.products[2].name') IS NOT NULL
	UNION
	SELECT
		SFOppID = JSON_VALUE([pandadoc__InputJSON_EV2__c], '$.data.metadata."salesforce.opportunity_id"')
	   ,SFAcctID = JSON_VALUE([pandadoc__InputJSON_EV2__c], '$.data.metadata."salesforce.account_id"')
	   ,Template = JSON_VALUE([pandadoc__InputJSON_EV2__c], '$.data.template.name')
	   ,Product = JSON_VALUE([pandadoc__InputJSON_EV2__c], '$.data.products[3].name')
	   ,Qty = JSON_VALUE([pandadoc__InputJSON_EV2__c], '$.data.products[3].qty')
	   ,Price = JSON_VALUE([pandadoc__InputJSON_EV2__c], '$.data.products[3].price')
	FROM [Salesforce].[dbo].[pandadoc__PandaDocDocument__c] AS pd
	-- cross apply openjson(pd.[pandadoc__InputJSON_EV2__c]) as j
	WHERE pd.pandadoc__Status__c = 'document.completed'
	AND JSON_VALUE([pandadoc__InputJSON_EV2__c], '$.data.products[3].name') IS NOT NULL
	UNION
	SELECT
		SFOppID = JSON_VALUE([pandadoc__InputJSON_EV2__c], '$.data.metadata."salesforce.opportunity_id"')
	   ,SFAcctID = JSON_VALUE([pandadoc__InputJSON_EV2__c], '$.data.metadata."salesforce.account_id"')
	   ,Template = JSON_VALUE([pandadoc__InputJSON_EV2__c], '$.data.template.name')
	   ,Product = JSON_VALUE([pandadoc__InputJSON_EV2__c], '$.data.products[4].name')
	   ,Qty = JSON_VALUE([pandadoc__InputJSON_EV2__c], '$.data.products[4].qty')
	   ,Price = JSON_VALUE([pandadoc__InputJSON_EV2__c], '$.data.products[4].price')
	FROM [Salesforce].[dbo].[pandadoc__PandaDocDocument__c] AS pd
	-- cross apply openjson(pd.[pandadoc__InputJSON_EV2__c]) as j
	WHERE pd.pandadoc__Status__c = 'document.completed'
	AND JSON_VALUE([pandadoc__InputJSON_EV2__c], '$.data.products[4].name') IS NOT NULL
	UNION
	SELECT
		SFOppID = JSON_VALUE([pandadoc__InputJSON_EV2__c], '$.data.metadata."salesforce.opportunity_id"')
	   ,SFAcctID = JSON_VALUE([pandadoc__InputJSON_EV2__c], '$.data.metadata."salesforce.account_id"')
	   ,Template = JSON_VALUE([pandadoc__InputJSON_EV2__c], '$.data.template.name')
	   ,Product = JSON_VALUE([pandadoc__InputJSON_EV2__c], '$.data.products[5].name')
	   ,Qty = JSON_VALUE([pandadoc__InputJSON_EV2__c], '$.data.products[5].qty')
	   ,Price = JSON_VALUE([pandadoc__InputJSON_EV2__c], '$.data.products[5].price')
	FROM [Salesforce].[dbo].[pandadoc__PandaDocDocument__c] AS pd
	-- cross apply openjson(pd.[pandadoc__InputJSON_EV2__c]) as j
	WHERE pd.pandadoc__Status__c = 'document.completed'
	AND JSON_VALUE([pandadoc__InputJSON_EV2__c], '$.data.products[5].name') IS NOT NULL
	UNION
	SELECT
		SFOppID = JSON_VALUE([pandadoc__InputJSON_EV2__c], '$.data.metadata."salesforce.opportunity_id"')
	   ,SFAcctID = JSON_VALUE([pandadoc__InputJSON_EV2__c], '$.data.metadata."salesforce.account_id"')
	   ,Template = JSON_VALUE([pandadoc__InputJSON_EV2__c], '$.data.template.name')
	   ,Product = JSON_VALUE([pandadoc__InputJSON_EV2__c], '$.data.products[6].name')
	   ,Qty = JSON_VALUE([pandadoc__InputJSON_EV2__c], '$.data.products[6].qty')
	   ,Price = JSON_VALUE([pandadoc__InputJSON_EV2__c], '$.data.products[6].price')
	FROM [Salesforce].[dbo].[pandadoc__PandaDocDocument__c] AS pd
	-- cross apply openjson(pd.[pandadoc__InputJSON_EV2__c]) as j
	WHERE pd.pandadoc__Status__c = 'document.completed'
	AND JSON_VALUE([pandadoc__InputJSON_EV2__c], '$.data.products[6].name') IS NOT NULL
	UNION
	SELECT
		SFOppID = JSON_VALUE([pandadoc__InputJSON_EV2__c], '$.data.metadata."salesforce.opportunity_id"')
	   ,SFAcctID = JSON_VALUE([pandadoc__InputJSON_EV2__c], '$.data.metadata."salesforce.account_id"')
	   ,Template = JSON_VALUE([pandadoc__InputJSON_EV2__c], '$.data.template.name')
	   ,Product = JSON_VALUE([pandadoc__InputJSON_EV2__c], '$.data.products[7].name')
	   ,Qty = JSON_VALUE([pandadoc__InputJSON_EV2__c], '$.data.products[7].qty')
	   ,Price = JSON_VALUE([pandadoc__InputJSON_EV2__c], '$.data.products[7].price')
	FROM [Salesforce].[dbo].[pandadoc__PandaDocDocument__c] AS pd
	-- cross apply openjson(pd.[pandadoc__InputJSON_EV2__c]) as j
	WHERE pd.pandadoc__Status__c = 'document.completed'
	AND JSON_VALUE([pandadoc__InputJSON_EV2__c], '$.data.products[7].name') IS NOT NULL