SELECT icc.type
, CASE WHEN it.name IS NULL THEN 'Unassigned' ELSE it.name END AS TeamName
, ia.name AS AgentName
, DATEPART(HOUR, DATEADD(HOUR, -4, ic.created_at) ) AS hour
, DATEPART(DAY, DATEADD(HOUR, -4, ic.created_at)) AS day
, DATENAME(WEEKDAY, DATEADD(HOUR, -4, ic.created_at)) Weekday
, DATEPART(Month, DATEADD(HOUR, -4, ic.created_at)) Month
,ic.*
  FROM [recurly].[dbo].[intercom_conversations] ic
LEFT OUTER JOIN recurly.[dbo].[intercom_conversation_sources] AS icc ON ic.sourceId = icc.id
LEFT OUTER JOIN recurly.[dbo].[intercom_teams] AS it ON ic.team_assignee_id = it.id
LEFT OUTER JOIN recurly.dbo.intercom_admins ia ON ic.admin_assignee_id = ia.id
WHERE DATEPART(YEAR, ic.created_at) = 2023