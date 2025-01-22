--Beginner

--1.List the top 10 orders with the highest sales from the EachOrderBreakdown table.

SELECT * FROM EachOrderBreakdown

SELECT TOP 10 *
FROM EachOrderBreakdown
ORDER BY Sales DESC

--2.Show the number of orders for each product category in the EachOrderBreakdown table.

SELECT Category, COUNT(*) As TotalOrders
FROM EachOrderBreakdown
GROUP BY Category


--3.Find the total profit for each sub-category in the EachOrderBreakdown table.

SELECT SubCategory, SUM(Profit) AS TotalProfit
FROM EachOrderBreakdown
GROUP BY SubCategory
