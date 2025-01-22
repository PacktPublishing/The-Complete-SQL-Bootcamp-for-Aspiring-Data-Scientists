--Advanced

--1.Find out how many new customers were acquired in the year 2014?
SELECT * FROM OrderList

SELECT COUNT(*) AS NumberofNewCustomers 
FROM (
	SELECT CustomerName, MIN(OrderDate) AS FirstOrderDate
	FROM OrderList
	GROUP By CustomerName
	HAVING YEAR(MIN(OrderDate)) = '2014'
) AS Customer2014


--2.Calculate the percentage of total profit contributed by each sub-category to the overall profit.
SELECT * FROM EachOrderBreakdown

SELECT SubCategory, SUM(Profit) AS TotalProfit, 
	   SUM(Profit)/(SELECT SUM(Profit) FROM EachOrderBreakdown) * 100 AS PercentOfTotalContri
FROM EachOrderBreakdown
GROUP BY SubCategory



--3.Find the average sales per customer, considering only customers who have made more than one order.

WITH CustomerAvgSales AS(
	SELECT CustomerName, COUNT(DISTINCT ol.OrderID) AS NoOfOrders, AVG(Sales) AS AvgSales
	FROM OrderList ol
	JOIN EachOrderBreakdown ob
	ON ol.OrderID = ob.OrderID
	GROUP BY CustomerName
)
seleCT	CustomerName, AvgSales, NoOfOrders
FROM CustomerAvgSales
WHERE NoOfOrders > 10

--4.Identify the top-performing subcategory in each category based on total sales. 
--Include the sub-category name, total sales, and a ranking of sub-category within each category.

WITH TopPerformers AS(
	SELECT Category, SubCategory, SUM(Sales) AS TOtalSales,
			RANK() OVER (PARTITION BY Category ORDER BY SUM(Sales) DESC) AS SubCategoryRank
	FROM EachOrderBreakdown
	GROUP BY Category, SubCategory
)
SELECT *
FROM TopPerformers
WHERE SubCategoryRank = 1
