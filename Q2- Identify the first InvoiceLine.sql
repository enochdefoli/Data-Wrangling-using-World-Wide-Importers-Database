Update [Sales].[InvoiceLines] Set UnitPrice =  UnitPrice + 20
 Where InvoiceLineID = (Select TOP(1) InvoiceLineID
 From [Sales].[InvoiceLines]
 Where InvoiceID = (Select  TOP(1) InvoiceID 
 From Sales.CustomerTransactions
 Where CustomerID = 1060 and InvoiceID is not null
 order by InvoiceID)
 Order by InvoiceLineID)