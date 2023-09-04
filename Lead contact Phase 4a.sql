SELECT        Domain, Email, MAX(countofNames) AS CountNames
FROM            (SELECT        dbo.ProperWebsite(Website) AS Domain, Email, Name, COUNT(Name) AS countofNames
                          FROM            dbo.leads
                          GROUP BY dbo.ProperWebsite(Website), Email, Name) AS a
GROUP BY Domain, Email