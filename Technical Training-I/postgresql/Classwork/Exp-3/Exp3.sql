-- prerequisite steps
create table schema_violations (
    schema_id serial primary key,
    schema_name varchar(50),
    violation_count int
);

insert into schema_violations (schema_name, violation_count) values
('auth_schema', 0),
('billing_schema', 2),
('reporting_schema', 5),
('admin_schema', 9);

-- step 1
select
    schema_name,
    violation_count,
    case
        when violation_count = 0 then 'No Violation'
        when violation_count between 1 and 3 then 'Minor Violation'
        when violation_count between 4 and 6 then 'Moderate Violation'
        else 'Critical Violation'
    end as violation_status
from schema_violations;

-- step 2
-- Add a new column to store approval status
alter table schema_violations
add column approval_status varchar(20);

-- Update the new column based on violation count using conditional rules
update schema_violations
set approval_status =
    case
        when violation_count = 0 then 'Approved'
        when violation_count between 1 and 3 then 'Needs Review'
        else 'Rejected'
    end;

-- check new column
select * from schema_violations;

-- step 3
do $$
declare
    v_count int := 5;
begin
    if v_count = 0 then
        raise notice 'No violations detected';
    elsif v_count <= 3 then
        raise notice 'Minor violations found';
    elsif v_count <= 6 then
        raise notice 'Moderate violations found';
    else
        raise notice 'Critical violations found';
    end if;
end $$;

-- step 4
-- Create a table to store student names and marks
create table students (
    student_id serial primary key,
    student_name varchar(50),
    marks int
);

insert into students (student_name, marks) values
('Aman', 85),
('Riya', 72),
('Kunal', 58),
('Neha', 42);

-- Classify students into grades based on their marks using conditional logic
select
    student_name,
    marks,
    case
        when marks >= 80 then 'A'
        when marks >= 60 then 'B'
        when marks >= 50 then 'C'
        else 'Fail'
    end as grade
from students;

-- step 5
-- Using CASE for Custom Sorting
select
    schema_name,
    violation_count
from schema_violations
order by
    case
        when violation_count = 0 then 1
        when violation_count between 1 and 3 then 2
        when violation_count between 4 and 6 then 3
        else 4
    end;

