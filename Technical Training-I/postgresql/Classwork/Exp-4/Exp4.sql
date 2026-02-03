-- Example 1: FOR Loop – Simple Iteration
do $$
declare
    i integer;
begin
    for i in 1..5 loop
        raise notice 'iteration number: %', i;
    end loop;
end $$;

-- Example 2: FOR Loop with Query (Row-by-Row Processing)
create table employee (
    emp_id serial primary key,
    emp_name varchar(50),
    salary numeric(10,2)
);

insert into employee (emp_name, salary) values
('arjun', 45000),
('meera', 72000),
('rohan', 88000),
('kavya', 60000),
('sameer', 95000);

do $$
declare
    rec record;
begin
    for rec in
        select emp_id, emp_name from employee order by emp_id
    loop
        raise notice 'emp id: %, name: %', rec.emp_id, rec.emp_name;
    end loop;
end $$;

-- Example 3: WHILE Loop – Conditional Iteration
do $$
declare
    counter integer := 1;
begin
    while counter <= 5 loop
        raise notice 'counter value: %', counter;
        counter := counter + 1;
    end loop;
end $$;

-- Example 4: LOOP with EXIT WHEN
do $$
declare
    num integer := 1;
begin
    loop
        raise notice 'number: %', num;
        num := num + 1;

        exit when num > 5;
    end loop;
end $$;

-- Example 5: Salary Increment Using FOR Loop
update employee set salary =
    case emp_name
        when 'arjun' then 45000
        when 'meera' then 72000
        when 'rohan' then 88000
        when 'kavya' then 60000
        when 'sameer' then 95000
    end;

do $$
declare
    rec record;
begin
    for rec in
        select emp_id from employee
    loop
        update employee
        set salary = salary + 5000
        where emp_id = rec.emp_id;

        raise notice 'salary incremented for emp id: %', rec.emp_id;
    end loop;
end $$;

-- Example 6: Combining LOOP with IF Condition
do $$
declare
    rec record;
begin
    for rec in
        select emp_id, salary from employee
    loop
        if rec.salary >= 80000 then
            raise notice 'emp id % classified as high income', rec.emp_id;
        else
            raise notice 'emp id % classified as regular income', rec.emp_id;
        end if;
    end loop;
end $$;
