SELECT CustomerID,CustomerName,COUNT(TotalNbOrders) TotalNbOrders,COUNT(TotalNbInvoices) TotalNbInvoices,
 SUM(OrdersTotalValue) OrdersTotalValue,SUM(InvoicesTotalValue) InvoicesTotalValue,
 (SUM(OrdersTotalValue) - SUM(InvoicesTotalValue)) AbsoluteValueDifference
 FROM
 (SELECT OrderID,InvoiceID,CustomerID,CustomerName,COUNT(CustomerOrderCost) TotalNbOrders,
 SUM(CustomerOrderCost) OrdersTotalValue,COUNT(CustomerOrderInvoice) TotalNbInvoices,SUM(CustomerOrderInvoice) InvoicesTotalValue
 FROM
 (SELECT Orders.*,Invoices.CustomerOrderInvoice
 FROM 
 (SELECT o.OrderID,Inv.InvoiceID,ol.StockItemID,cu.CustomerID,cu.CustomerName,ol.Quantity*ol.UnitPrice CustomerOrderCost
 FROM sales.Customers cu Inner Join Sales.Orders o
 ON cu.CustomerID = o.CustomerID
 Inner Join sales.OrderLines ol
 ON o.OrderID = ol.OrderID
 Inner Join Sales.Invoices Inv
 ON ol.OrderID = Inv.OrderID) Orders
 Inner Join
 (SELECT Inv.OrderID,Invl.InvoiceID,Invl.StockItemID,Quantity*UnitPrice CustomerOrderInvoice
 FROM Sales.InvoiceLines Invl
 Inner Join Sales.Invoices Inv
 ON Invl.InvoiceID = Inv.InvoiceID) Invoices
 ON Orders.OrderID = Invoices.OrderID
 And Orders.InvoiceID = Invoices.InvoiceID
 And Orders.StockItemID = Invoices.StockItemID) A
 GROUP BY OrderID,InvoiceID,CustomerID,CustomerName) B
 GROUP BY CustomerID,CustomerName
 ORDER BY AbsoluteValueDifference DESC,TotalNbOrders,CustomerName