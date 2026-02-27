-- Query 1
-- Create Employee table
CREATE TABLE IF NOT EXISTS Employee (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50),
    Salary INT
);

-- Insert sample data
INSERT INTO Employee VALUES (1, 'Rahul', 30000)
ON CONFLICT (EmpID) DO NOTHING;

INSERT INTO Employee VALUES (2, 'Priya', 35000)
ON CONFLICT (EmpID) DO NOTHING;

INSERT INTO Employee VALUES (3, 'Amit', 40000)
ON CONFLICT (EmpID) DO NOTHING;

-- Cursor block
DO $$
DECLARE
    emp_record RECORD;
    emp_cursor CURSOR FOR
        SELECT EmpID, EmpName, Salary FROM Employee;
BEGIN
    OPEN emp_cursor;

    LOOP
        FETCH emp_cursor INTO emp_record;
        EXIT WHEN NOT FOUND;

        RAISE NOTICE 'ID: %, Name: %, Salary: %',
        emp_record.EmpID,
        emp_record.EmpName,
        emp_record.Salary;

    END LOOP;

    CLOSE emp_cursor;
END $$;

------------------------------------------------------------------------------------------------
-- Query 2

-- Add Experience column
ALTER TABLE Employee
ADD COLUMN IF NOT EXISTS Experience INT;

-- Update sample experience values
UPDATE Employee SET Experience = 2 WHERE EmpID = 1;
UPDATE Employee SET Experience = 5 WHERE EmpID = 2;
UPDATE Employee SET Experience = 8 WHERE EmpID = 3;

-- Cursor to update salary based on experience
DO $$
DECLARE
    emp_record RECORD;
    emp_cursor CURSOR FOR
        SELECT EmpID, Salary, Experience FROM Employee;
BEGIN
    OPEN emp_cursor;

    LOOP
        FETCH emp_cursor INTO emp_record;
        EXIT WHEN NOT FOUND;

        -- Salary update logic
        IF emp_record.Experience >= 7 THEN
            UPDATE Employee
            SET Salary = Salary + 5000
            WHERE EmpID = emp_record.EmpID;

        ELSIF emp_record.Experience >= 4 THEN
            UPDATE Employee
            SET Salary = Salary + 3000
            WHERE EmpID = emp_record.EmpID;

        ELSE
            UPDATE Employee
            SET Salary = Salary + 1000
            WHERE EmpID = emp_record.EmpID;

        END IF;

    END LOOP;

    CLOSE emp_cursor;
END $$;

-- View updated table
SELECT * FROM Employee;

--------------------------------------------------------------------------------------------------------------
-- Query 3

DO $$
DECLARE
    emp_record RECORD;
    emp_cursor CURSOR FOR
        SELECT EmpID, EmpName, Salary FROM Employee;
BEGIN
    OPEN emp_cursor;

    -- Check if cursor has data
    FETCH emp_cursor INTO emp_record;

    IF NOT FOUND THEN
        RAISE NOTICE 'No records found in Employee table.';
    ELSE
        LOOP
            RAISE NOTICE 'Processing Employee ID: %, Name: %, Salary: %',
            emp_record.EmpID,
            emp_record.EmpName,
            emp_record.Salary;

            FETCH emp_cursor INTO emp_record;
            EXIT WHEN NOT FOUND;
        END LOOP;
    END IF;

    CLOSE emp_cursor;

EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'An error occurred: %', SQLERRM;
END $$;