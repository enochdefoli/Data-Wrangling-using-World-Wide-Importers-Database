CREATE OR ALTER   PROCEDURE [dbo].[ReportCustomerTurnover](@Choice INT = 1, @Year INT = 2013)
AS 
BEGIN
  SET nocount ON;
  ---------------------------------------CHOICE 1--------------------------------
  IF (@Choice = 1)
  BEGIN
    SELECT CustomerName,
	CASE WHEN Jan is null  then 0.00 ELSE Jan  END AS Jan,
	CASE WHEN Feb is null  then 0.00 ELSE Feb  END AS Feb,
	CASE WHEN Mar is null  then 0.00 ELSE Mar  END AS Mar,
	CASE WHEN Apr is null  then 0.00 ELSE Apr  END AS Apr,
	CASE WHEN May is null  then 0.00 ELSE May  END AS May,
	CASE WHEN Jun is null  then 0.00 ELSE Jun  END AS Jun,
	CASE WHEN July is null then 0.00 ELSE July END AS July,
	CASE WHEN Aug is null then 0.00  ELSE Aug  END AS Aug,
	CASE WHEN Sep is null then 0.00  ELSE Sep  END AS Sep,
	CASE WHEN Oct is null then 0.00  ELSE Oct  END AS Oct,
	CASE WHEN Nov is null then 0.00  ELSE Nov  END AS Nov,
	CASE WHEN Dec is null then 0.00  ELSE Dec  END AS Dec
	FROM
	(SELECT *
	FROM
	(
	SELECT Cus.CustomerName,COALESCE(Invl.unitprice*Invl.quantity, 0) InvoicesTotalValue,FORMAT(INV.invoicedate,'MMM') MonthInvoiceDate
	FROM   Sales.InvoiceLines AS INVL 
	Inner Join Sales.Invoices AS INV
	On INVL.Invoiceid = INV.InvoiceID
	Inner Join 
	Sales.Customers CUS
	On CUS.CustomerID = INV.CustomerID
	Where YEAR(INV.invoicedate) = @Year
	) SourceTable
	PIVOT
	(
	 SUM(InvoicesTotalValue) FOR MonthInvoiceDate IN ([Jan],[Feb],[Mar],[Apr],[May],[Jun],[July],[Aug],[Sep],[Oct],[Nov],[Dec] )
	) PivotTable) A
	ORDER BY CustomerName 
  END;
  ---------------------------------------- CHOICE 2--------------------------------------
   IF (@Choice = 2)
   BEGIN
	SELECT CustomerName,
	CASE WHEN Q1 is null THEN 0.00 ELSE Q1 END Q1,
	CASE WHEN Q2 is null THEN 0.00 ELSE Q2 END Q2,
	CASE WHEN Q3 is null THEN 0.00 ELSE Q3 END Q3,
	CASE WHEN Q4 is null THEN 0.00 ELSE Q4 END Q4
	FROM
	(SELECT * FROM
	(
	SELECT Cus.CustomerName,COALESCE(Invl.unitprice*Invl.quantity, 0) InvoicesTotalValue,
	 CASE 
		 WHEN DATENAME(quarter,INV.invoicedate) = 1 THEN 'Q1' 
		 WHEN DATENAME(quarter,INV.invoicedate) = 2 THEN 'Q2'
		 WHEN DATENAME(quarter,INV.invoicedate) = 3 THEN 'Q3'
		 WHEN DATENAME(quarter,INV.invoicedate) = 4 THEN 'Q4'
	 END QuarterInvoiceDate
	FROM   Sales.InvoiceLines AS INVL 
	Inner Join Sales.Invoices AS INV
	On INVL.Invoiceid = INV.InvoiceID
	Inner Join 
	Sales.Customers CUS
	On CUS.CustomerID = INV.CustomerID
	Where YEAR(INV.invoicedate) = @Year
	) SourceTable
	PIVOT
	(
	 SUM(InvoicesTotalValue) FOR QuarterInvoiceDate IN([Q1],[Q2],[Q3],[Q4])
	) PivotTable) A
	ORDER BY CustomerName
   END;
   ------------------------------------------CHOICE 3-----------------------------------------------
   IF(@Choice = 3)
   BEGIN
    SELECT *
	FROM
	(
	SELECT Cus.CustomerName,COALESCE(Invl.unitprice*Invl.quantity, 0) InvoicesTotalValue,YEAR(INV.invoicedate) YearInvoiceDate
	FROM   Sales.InvoiceLines AS INVL 
	Inner Join Sales.Invoices AS INV
	On INVL.Invoiceid = INV.InvoiceID
	Inner Join 
	Sales.Customers CUS
	On CUS.CustomerID = INV.CustomerID
	Where YEAR(INV.invoicedate) Between 2013 and 2016
	) SourceTable
	PIVOT 
	(
	 SUM(InvoicesTotalValue) FOR YearInvoiceDate IN ([2013],[2014],[2015],[2016])
	) PivotTable
	ORDER BY CustomerName
   END;
END;