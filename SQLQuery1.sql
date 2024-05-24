
--1
use AdventureWorks2022;
--Wyra¿enie CTE
WITH EmployeeCTE AS (
    SELECT
        e.BusinessEntityID,
        p.FirstName,
        p.LastName,
        e.JobTitle,
        eph.Rate,
        eph.RateChangeDate
    FROM
        HumanResources.Employee e
    INNER JOIN
        Person.Person p ON e.BusinessEntityID = p.BusinessEntityID
    INNER JOIN
        HumanResources.EmployeePayHistory eph ON e.BusinessEntityID = eph.BusinessEntityID
    WHERE
        eph.RateChangeDate = (SELECT MAX(RateChangeDate)
                              FROM HumanResources.EmployeePayHistory
                              WHERE BusinessEntityID = e.BusinessEntityID)
)

-- Tabela tymczasowa tworzenie 
SELECT
    BusinessEntityID,
    FirstName,
    LastName,
    JobTitle,
    Rate,
    RateChangeDate
INTO
    TempEmployeeInfo
FROM
    EmployeeCTE;

-- Wyœwietlenie danych z tabeli tymczasowej
SELECT *
FROM TempEmployeeInfo;

--2
use AdventureWorksLT2022;
WITH CustomerSalesCTE AS (
    SELECT
        soh.CustomerID,
        c.FirstName,
        c.LastName,
        c.CompanyName,
        soh.SalesOrderID,
        soh.TotalDue
    FROM
        SalesLT.SalesOrderHeader soh
    INNER JOIN
        SalesLT.Customer c ON soh.CustomerID = c.CustomerID
)
SELECT
    CustomerID,
    FirstName,
    LastName,
    CompanyName,
    SUM(TotalDue) AS TotalRevenue
FROM
    CustomerSalesCTE
GROUP BY
    CustomerID,
    FirstName,
    LastName,
    CompanyName
ORDER BY
    CompanyName,
    CustomerID;

--3
WITH SalesCTE AS (
    SELECT
        sod.ProductID,
        sod.OrderQty,
        sod.UnitPrice,
        sod.LineTotal,
        pc.Name AS CategoryName
    FROM
        SalesLT.SalesOrderDetail AS sod
    INNER JOIN
        SalesLT.Product AS p ON sod.ProductID = p.ProductID
    INNER JOIN
        SalesLT.ProductCategory AS pc ON p.ProductCategoryID = pc.ProductCategoryID
),
CategorySales AS (
    SELECT
        CategoryName,
        SUM(LineTotal) AS TotalSales
    FROM
        SalesCTE
    GROUP BY
        CategoryName
)
SELECT
    CategoryName,
    TotalSales
FROM
    CategorySales
ORDER BY
    TotalSales DESC;
