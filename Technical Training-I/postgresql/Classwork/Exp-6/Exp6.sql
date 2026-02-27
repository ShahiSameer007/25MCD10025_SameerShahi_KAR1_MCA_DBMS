-- Query 1

-- Create Employee table
CREATE TABLE IF NOT EXISTS Employee (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50),
    Salary INT,
    Status VARCHAR(20)
);

-- Insert sample data
INSERT INTO Employee VALUES (1, 'Rahul', 30000, 'Active')
ON CONFLICT (EmpID) DO NOTHING;

INSERT INTO Employee VALUES (2, 'Priya', 35000, 'Inactive')
ON CONFLICT (EmpID) DO NOTHING;

INSERT INTO Employee VALUES (3, 'Amit', 40000, 'Active')
ON CONFLICT (EmpID) DO NOTHING;

-- Create View to show only Active Employees
CREATE OR REPLACE VIEW ActiveEmployees AS
SELECT EmpID, EmpName, Salary
FROM Employee
WHERE Status = 'Active';

-- Query the View
SELECT * FROM ActiveEmployees;

------------------------------------------------------------------------------------------------------------------------

-- Query 2

-- Create Department table
CREATE TABLE IF NOT EXISTS Department (
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(50)
);

-- Insert sample departments
INSERT INTO Department VALUES (101, 'HR')
ON CONFLICT (DeptID) DO NOTHING;

INSERT INTO Department VALUES (102, 'IT')
ON CONFLICT (DeptID) DO NOTHING;

INSERT INTO Department VALUES (103, 'Finance')
ON CONFLICT (DeptID) DO NOTHING;

-- Add DeptID column to Employee table
ALTER TABLE Employee
ADD COLUMN IF NOT EXISTS DeptID INT;

-- Assign departments to employees
UPDATE Employee SET DeptID = 101 WHERE EmpID = 1;
UPDATE Employee SET DeptID = 102 WHERE EmpID = 2;
UPDATE Employee SET DeptID = 103 WHERE EmpID = 3;

-- Create View joining Employee and Department
CREATE OR REPLACE VIEW EmployeeDepartmentView AS
SELECT 
    e.EmpID,
    e.EmpName,
    e.Salary,
    d.DeptName
FROM Employee e
JOIN Department d
ON e.DeptID = d.DeptID;

-- Query the View
SELECT * FROM EmployeeDepartmentView;

---------------------------------------------------------------------------------------------------------------------------------------------

-- Query 3
-- Create summarization view showing department statistics
CREATE OR REPLACE VIEW DepartmentSummaryView AS
SELECT 
    d.DeptName,
    COUNT(e.EmpID) AS TotalEmployees,
    AVG(e.Salary) AS AverageSalary,
    SUM(e.Salary) AS TotalSalary
FROM Employee e
JOIN Department d
ON e.DeptID = d.DeptID
GROUP BY d.DeptName;

-- Query the View
SELECT * FROM DepartmentSummaryView;