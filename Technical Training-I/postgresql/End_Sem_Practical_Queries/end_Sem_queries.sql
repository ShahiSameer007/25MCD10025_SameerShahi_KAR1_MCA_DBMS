
-- Queries
-- Question 1

SELECT p.prod_name,
(CASE WHEN o.qty IS NULL THEN 0 ELSE o.qty END) AS Quantity
FROM Tbl_Products p 
LEFT JOIN Tbl_Orders o 
ON p.prod_id = o.prod_id;

--Question 2


CREATE TRIGGER QuantCheck 
BEFORE INSERT ON Tbl_Orders
FOR EACH ROW
BEGIN
	IF NEW.qty > (SELECT stock_qty FROM Tbl_Products)
	THEN NEW.qty ==   NULL
	END IF
END;

INSERT INTO Tbl_Orders VALUES
(9009, 501, 101, '2026-02-26', 16)