update  NewLeadCompany
set NewLeadCompany.[LeadSource] = GetFirstLeadSource.[LeadSource],
NewLeadCompany.firstleadsourcedate = GetFirstLeadSource.LeadsourceDate


from 
 NewLeadCompany   
 inner join GetFirstLeadSource on NewLeadCompany.website = GetFirstLeadSource.website
