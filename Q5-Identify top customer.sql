Select d.CustomerId,d.CustomerName
From
(Select CustomerId,CustomerName,Count(ProductId) ProductPurchase
From
(Select a.CustomerId,a.CustomerName,b.ProductId,b.Qty
From SQLPlayground.dbo.Customer a Inner Join SQLPlayground.dbo.Purchase b
On a.CustomerId = b.CustomerId) c
Group by CustomerId,CustomerName) d
 Inner Join
(Select a.CustomerId,a.CustomerName,b.ProductId,b.Qty
From SQLPlayground.dbo.Customer a Inner Join SQLPlayground.dbo.Purchase b
On a.CustomerId = b.CustomerId
Where Qty > 50) e
On d.CustomerId = e.CustomerId