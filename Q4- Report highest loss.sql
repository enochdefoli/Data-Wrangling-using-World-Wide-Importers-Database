SELECT cm.CustomerCategoryName,cm.MaxLoss,cl.CustomerName,cl.CustomerID
FROM
 (SELECT CustomerCategoryName,MAX(OrderValueLost) MaxLoss
 FROM
 (SELECT cu.CustomerID,cu.CustomerName,cc.CustomerCategoryName,sum(ol.Quantity*ol.UnitPrice) OrderValueLost
 FROM sales.Customers cu Inner Join Sales.Orders o
 ON cu.CustomerID = o.CustomerID
 Inner Join sales.customercategories cc
 ON cu.CustomerCategoryID = cc.CustomerCategoryID
 Inner Join sales.OrderLines ol
 ON o.OrderID = ol.OrderID
 WHERE o.OrderID NOT IN (SELECT I.OrderID FROM Sales.Invoices I)
 GROUP BY cu.CustomerID,cu.CustomerName,cc.CustomerCategoryName) A
 GROUP BY A.CustomerCategoryName) cm
 Inner Join
 (SELECT cu.CustomerID,cu.CustomerName,cc.CustomerCategoryName,sum(ol.Quantity*ol.UnitPrice) OrderValueLost
 FROM sales.Customers cu Inner Join Sales.Orders o
 ON cu.CustomerID = o.CustomerID
 Inner Join sales.customercategories cc
 ON cu.CustomerCategoryID = cc.CustomerCategoryID
 Inner Join sales.OrderLines ol
 ON o.OrderID = ol.OrderID
 WHERE o.OrderID NOT IN (SELECT I.OrderID FROM Sales.Invoices I)
 GROUP BY cu.CustomerID,cu.CustomerName,cc.CustomerCategoryName) cl
 On cm.CustomerCategoryName = cl.CustomerCategoryName
 And cm.MaxLoss = cl.OrderValueLost
 ORDER BY MaxLoss DESC