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
