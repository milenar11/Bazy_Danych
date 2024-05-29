USE AdventureWorks2022;

--1
BEGIN TRANSACTION;

--Aktualizacja
UPDATE Production.Product
SET ListPrice = ListPrice * 1.10
WHERE ProductID = 680;

COMMIT TRANSACTION;

--2
BEGIN TRANSACTION;

-- Usuni�cie klucza obcego
ALTER TABLE Sales.SalesOrderDetail
DROP CONSTRAINT FK_SalesOrderDetail_Product_ProductID;

-- Usuni�cie produktu o ProductID r�wnym 707
DELETE FROM Production.Product
WHERE ProductID = 707;

-- Przywr�cenie klucza obcego
ALTER TABLE Sales.SalesOrderDetail
ADD CONSTRAINT FK_SalesOrderDetail_Product_ProductID FOREIGN KEY (ProductID)
REFERENCES Production.Product(ProductID);

COMMIT TRANSACTION;


--3
BEGIN TRANSACTION;

--Dodanie nowego produktu do tabeli
INSERT INTO Production.Product (Name, ProductNumber, MakeFlag, FinishedGoodsFlag, Color, SafetyStockLevel, ReorderPoint, StandardCost, ListPrice, Size, SizeUnitMeasureCode, WeightUnitMeasureCode, Weight, DaysToManufacture, ProductLine, Class, Style, ProductSubcategoryID, ProductModelID, SellStartDate, SellEndDate, DiscontinuedDate, rowguid, ModifiedDate)
VALUES ('New Product', 'NEW123', 1, 1, NULL, 100, 50, 10.00, 20.00, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, 1, 1, GETDATE(), NULL, NULL, NEWID(), GETDATE());

COMMIT TRANSACTION;

SELECT * FROM [AdventureWorks2022].[Production].[Product] WHERE ProductNumber = 'NEW123';

--4
BEGIN TRANSACTION;

--Aktualizacja StandardCost o 10%
UPDATE Production.Product
SET StandardCost = StandardCost * 1.10;

--Sprawdzenie czy suma po aktualizacji nie przekracza 5000
DECLARE @TotalStandardCost MONEY;
SELECT @TotalStandardCost = SUM(StandardCost) FROM Production.Product;

IF @TotalStandardCost <= 50000
BEGIN
	--Je�li suma mniejsza ni� 50000
	COMMIT;
	PRINT 'Transakcja zatwierdzona.Suma StandardCost wynosi: ' + CAST(@TotalStandardCost AS NVARCHAR(50));
END
ELSE
BEGIN
	--Je�li suma wi�ksza niz 50000
	ROLLBACK;
	PRINT 'Transakcja wycofana';
END;

--5
BEGIN TRANSACTION;

DECLARE @ProductID INT = '1';

IF NOT EXISTS(SELECT 1 FROM Production.Product WHERE @ProductID = ProductID)
BEGIN
	INSERT INTO Production.Product (Name, ProductNumber, MakeFlag, FinishedGoodsFlag, Color, SafetyStockLevel, ReorderPoint, StandardCost, ListPrice, Size, SizeUnitMeasureCode, WeightUnitMeasureCode, Weight, DaysToManufacture, ProductLine, Class, Style, ProductSubcategoryID, ProductModelID, SellStartDate, SellEndDate, DiscontinuedDate, rowguid, ModifiedDate)
	VALUES ('New Product', 'NEW123', 1, 1, NULL, 100, 50, 10.00, 20.00, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, 1, 1, GETDATE(), NULL, NULL, NEWID(), GETDATE());
	COMMIT TRANSACTION;
END
ELSE 
BEGIN
	ROLLBACK TRANSACTION;
END;

--6
BEGIN TRANSACTION;


IF EXISTS (SELECT 1 FROM Sales.SalesOrderDetail WHERE OrderQty = 0)
BEGIN
	PRINT 'Transakcja odrzucona'
    ROLLBACK TRANSACTION;
END
ELSE
BEGIN
	UPDATE Sales.SalesOrderDetail
	SET OrderQty = OrderQty + 1;
	PRINT 'Transakcja wykonana'
    COMMIT TRANSACTION;
END;


--7
BEGIN TRANSACTION; -- Rozpoczyna now� transakcj�

-- Deklaracja zmiennej do przechowywania �redniego kosztu standardowego
DECLARE @AvgStandardCost DECIMAL(19, 4);
-- Deklaracja zmiennej do przechowywania liczby usuni�tych rekord�w
DECLARE @CountDeleted INT;

-- Obliczenie �redniego kosztu standardowego wszystkich produkt�w
SELECT @AvgStandardCost = AVG(StandardCost) FROM Production.Product;

-- Usuni�cie produkt�w, kt�rych koszt standardowy jest wi�kszy od �redniego kosztu
DELETE FROM Production.Product
WHERE StandardCost > @AvgStandardCost;

-- Zapisanie liczby usuni�tych rekord�w
SET @CountDeleted = @@ROWCOUNT;

-- Warunkowe zatwierdzenie lub wycofanie transakcji
IF @CountDeleted <= 10
BEGIN
    COMMIT TRANSACTION; -- Zatwierdza transakcj�, je�li usuni�to 10 lub mniej produkt�w
END
ELSE
BEGIN
    ROLLBACK TRANSACTION; -- Wycofuje transakcj�, je�li usuni�to wi�cej ni� 10 produkt�w
END;

