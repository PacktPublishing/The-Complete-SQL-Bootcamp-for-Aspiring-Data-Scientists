--Intermediate
--1.Identify the customer with the highest total sales across all orders.
SELECT * FROM OrderList
SELECT * FROM EachOrderBreakdown

SELECT TOP 1 CustomerName, SUM(Sales) as TotalSales
FROM OrderList ol
JOIN EachOrderBreakdown ob
ON ol.OrderID = ob.OrderID
GROUP BY CustomerName
ORDER BY TotalSales DESC

--2.Find the month with the highest average sales in the OrdersList table.

SELECT MONTH(OrderDate) AS MonthOrder, AVG(Sales) AS AverageSales
FROM OrderList ol
JOIN EachOrderBreakdown ob
ON ol.OrderID = ob.OrderID
GROUP BY MONTH(OrderDate)
ORDER BY AverageSales DESC



--3.Find out the average quantity ordered by customers whose first name starts with an alphabet 's'?

SELECT AVG(Quantity) as AvgQuantity
FROM OrderList ol
JOIN EachOrderBreakdown ob
ON ol.OrderID = ob.OrderID
WHERE LEFT(Customername,1) = 'S'
