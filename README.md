### Using the database Wide World Importers,we are going to answer five(5) main questions using microsoft sql database as the tool.

[The World Wide Importers Sample SQL Database](https://github.com/Microsoft/sql-server-samples/releases/tag/wide-world-importers-v1.0?utm_source=MyTechMantra.com)

#### QUESTION 1
 
Using the database WideWorldImporters, write a SQL query which reports the consistency between orders and their attached invoices.
The resultset should report for each (CustomerID, CustomerName)
 1. the total number of orders: TotalNBOrders
 2. the number of invoices converted from an order: TotalNBInvoices
 3. the total value of orders: OrdersTotalValue
 4. the total value of invoices: InvoicesTotalValue
 5. the absolute value of the difference between c - d: AbsoluteValueDifference
 
  The resultset must be sorted by highest values of AbsoluteValueDifference, then by smallest to highest values of TotalNBOrders and CustomerName is that order.

#### QUESTION 2

For the CustomerId = **1060** (CustomerName = 'Anand Mudaliyar')
Identify the first InvoiceLine of his first Invoice, where "first" means the lowest respective IDs, 
and write an update query increasing the UnitPrice of this InvoiceLine by 20.

#### QUESTION 3

Using the database WideWorldImporters, write a T-SQL stored procedure called ReportCustomerTurnover.
This procedure takes two parameters: Choice and Year, both integers.

When Choice = 1 and Year = <aYear>, ReportCustomerTurnover selects all the customer names and their total monthly turnover (invoiced value) for the year <aYear>.

When Choice = 2 and Year = <aYear>, ReportCustomerTurnover  selects all the customer names and their total quarterly (3 months) turnover (invoiced value) for the year <aYear>.

When Choice = 3, the value of Year is ignored and ReportCustomerTurnover  selects all the customer names and their total yearly turnover (invoiced value).

When no value is provided for the parameter Choice, the default value of Choice must be 1.
When no value is provided for the parameter Year, the default value is 2013. This doesn't impact Choice = 3.

For Choice = 3, the years can be hard-coded within the range of [2013-2016].

NULL values in the resultsets are not acceptable and must be substituted to 0.

All output resultsets are ordered by customer names alphabetically.

#### QUESTION 4

In the database WideWorldImporters, write a SQL query which reports the highest loss of money from orders not being converted into invoices, by customer category.
The name and id of the customer who generated this highest loss must also be identified. The resultset is ordered by highest loss.

In the database SQLPlayground, write a SQL query selecting all the customers' data who have purchased all the products 
AND have bought more than 50 products in total (sum of all purchases).

#### QUESTION 5

In the database SQLPlayground, write a SQL query selecting all the customers' data who have purchased all the products 
AND have bought more than 50 products in total (sum of all purchases).
