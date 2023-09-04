/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000)
datepart(Month, a.created_at) Month
, datepart(Year, a.created_at) Year
, c.id as AccountId
,c.code as Acctcode
,c.company
,f.name
, sum(a.subtotal) as total
	, sum(a.subtotal * b.Multiplier) as TotalM
	, sum((a.subtotal / f.PaymentDivider) * b.Multiplier) as TotalMWithPD
   ,  sum((g.subtotal / f.PaymentDivider) * b.Multiplier) as InvItemsTotal
FROM [Recurly].[dbo].[recurly_invoices] as a
  Left outer join [Exchange Rate] as b on a.currency = b.CountryCode
  inner join [dbo].[recurly_accounts] as c on a.accountId = c.id
left outer join Recurly_Billing_Count as d on c.id = d.id
Inner Join [dbo].[recurly_subscriptions] as E on c.id = e.accountId
Inner join dbo.PlanPaymentDivider as f on e.id = f.SubId
inner join [dbo].[recurly_invoice_items] as g on a.id = g.invoiceId
where 
  --accountId = 'qfi826dfc6y8'
  datepart(Month, a.created_at) = 2 and 
 datepart(Year, a.created_at) = 2022 and 
 --
 d.BillingCount = 1
 --and a.previousInvoiceId is null 
 -- company = 'Conexwest'
 Group by c.company,
 c.code,
  c.id,
  e.total_billing_cycles,
datepart(Month, a.created_at)
, datepart(Year, a.created_at)
, F.name
having  sum(a.subtotal) != 0
order by Company