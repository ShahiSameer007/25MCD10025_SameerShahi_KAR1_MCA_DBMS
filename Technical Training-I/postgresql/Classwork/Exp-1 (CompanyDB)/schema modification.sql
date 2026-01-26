-- 4. Schema Modification
-- Adding Column to employee table
alter table employee
add column phone_num varchar(10) unique;

-- Dropping project table
drop table project;