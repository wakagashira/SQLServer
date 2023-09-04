SELECT        dbo.ProperWebsite(Website) AS Domain, Email, Name, COUNT(Name) AS countofNames
FROM            dbo.leads
WHERE        (Name NOT IN ('[unknown] [unknown]', 'X X', 'x')) AND (Email IS NOT NULL) AND (Website IS NOT NULL)
GROUP BY dbo.ProperWebsite(Website), Email, Name