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
