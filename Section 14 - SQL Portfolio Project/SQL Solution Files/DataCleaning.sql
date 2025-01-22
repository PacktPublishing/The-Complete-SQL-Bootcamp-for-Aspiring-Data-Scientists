--Q1 Establish the relationship between the tables as per the ER diagram.

ALTER TABLE OrderList
ADD CONSTRAINT pk_orderid PRIMARY KEY (OrderID)

ALTER TABLE EachOrderBreakdown
ADD CONSTRAINT fk_orderid FOREIGN KEY (OrderID) REFERENCES OrderList (OrderID)


--Q2. Split City State Country into 3 individual columns namely ‘City’, ‘State’, ‘Country’.
SELECT * FROM OrderList

ALTER TABLE OrderList
ADD City nvarchar(50),
	State nvarchar(50),
	Country nvarchar(50)

UPDATE OrderList
SET Country = PARSENAME(REPLACE(City_State_Country, ',', '.'),1),
	State = PARSENAME(REPLACE(City_State_Country, ',', '.'),2),
	City = PARSENAME(REPLACE(City_State_Country, ',', '.'),3)

ALTER TABLE OrderList
DROP COLUMN City_State_Country

--Q3. Add a new Category Column using the following mapping as per the first 3 characters in the Product Name Column:
--TEC- Technology
--OFS – Office Supplies
--FUR - Furniture 

SELECT * FROM EachOrderBreakdown

ALTER TABLE EachOrderBreakDown
ADD Category nvarchar(50)

UPDATE EachOrderBreakdown
SET Category = CASE WHEN LEFT(ProductName, 3) = 'OFS' THEN 'Office Supplies'
			        WHEN LEFT(ProductName, 3) = 'TEC' THEN 'Technology'	
					WHEN LEFT(ProductName, 3) = 'FUR' THEN 'Furniture'	
			   END

--Q4. Extract the characters after '-' from the ProductName Column.

UPDATE EachOrderBreakdown
SET ProductName = RIGHT(ProductName, LEN(ProductName) -  CHARINDEX('-',ProductName))
 

			   
--Q5. Remove duplicate rows from EachOrderBreakdown table, if all column values are matching

WITH CTE_duplicate AS(
SELECT * , ROW_NUMBER() OVER (PARTITION BY OrderID, ProductName, Discount, Sales, 
								Profit, Quantity, SubCategory, Category ORDER BY OrderID) AS rn
FROM EachOrderBreakdown
)
DELETE FROM CTE_duplicate
WHERE rn > 1


--Q6. Replace blank with NA in OrderPriority Column in OrdersList table

SELECT * FROM OrderList
UPDATE OrderList
SET OrderPriority = 'NA'
WHERE OrderPriority IS NULL;


