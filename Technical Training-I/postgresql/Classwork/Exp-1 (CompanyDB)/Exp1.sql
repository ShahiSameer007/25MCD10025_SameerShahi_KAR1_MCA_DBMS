-- 1. Data Definition Language
-- create department table
create table department (
	dept_id int primary key,
	dept_name varchar(50) unique,
	location varchar(50),
	budget int check(budget>0)
);

-- create employee table
create table employee (
	emp_id varchar(50) primary key,
	emp_name varchar(50) not null,
	email varchar(50) unique,
	salary decimal(10,2) not null,
	hire_date date not null,
	dept_id int, 
	foreign key(dept_id) references department(dept_id)
);

-- create project table
create table project (
	proj_id varchar(50) primary key,
	proj_name varchar(50) unique,
	start_date date not null,
	end_date date not null,
	dept_id int,
	foreign key(dept_id) references department(dept_id)
);

-- 2. Data Manipulation Language
-- inserting data 
insert into department values
	(10,'Human Resources','New Delhi',2500000),
	(20,'Engineering','Bengaluru',12000000),
	(30,'Finance','Mumbai',5000000),
	(40,'Marketing','Gurugram',3500000);

insert into employee values
	('E101','Rajesh Sharma','sharmarajesh@comp.com',75000,'2021-06-15',20),
	('E102','Ananya Verma','ananyaverma10@comp.com',68000,'2022-01-10',20),
	('E103','Kartik Mctavish','mctavishk11@comp.com',90000,'2020-03-01',30),
	('E104','Nina Martin','ninamart13@comp.com',55000,'2023-06-26',10),
	('E105','Sheldon Nord','nordicsheldon45@comp.com',120000,'2022-10-09',40);

insert into project values
	('P201','Payroll Automation','2023-01-01','2023-06-30',30),
	('P202','Employee Onboarding App','2023-03-15','2023-09-15',10),
	('P203','E-Commerce Platform','2022-08-01','2024-02-28',20),
	('P204','Brand Awareness Campaign','2023-05-01','2023-10-31',40);

select * from employee;

select * from project;

select * from department;

-- updating employee records
update employee 
set email = 'vermaananya99@comp.com'
where emp_id = 'E102';

update project 
set proj_name = 'Bargo 100k awareness'
where proj_id = 'P204';

-- deleting a project record
delete from project
where end_date<'2023-08-15';

-- 3. Data Control Language
-- create new role of Head Manager
create user Head_Manager 
with password 'managerpassord123';

-- grant select permissions to Head Manager
grant select on department to Head_Manager;
grant select on employee to Head_Manager;
grant select on project to Head_Manager;

-- explicitly revoke create privilege
revoke create on schema public from Head_Manager;

-- 4. Schema Modification
-- Adding Column to employee table
alter table employee
add column phone_num varchar(10) unique;

-- Dropping project table
drop table project;