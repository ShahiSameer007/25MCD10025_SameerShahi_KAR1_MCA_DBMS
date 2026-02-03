-- 1. create table
create table orders (
    order_id serial primary key,
    customer_name varchar(50),
    product varchar(50),
    quantity int,
    price numeric(10,2),
    order_date date
);

-- insert sample data
insert into orders (customer_name, product, quantity, price, order_date) values
('Amit','Laptop',1,55000,'2024-01-10'),
('Riya','Mobile',2,30000,'2024-01-12'),
('Sameer','Laptop',1,60000,'2024-01-15'),
('Neha','Tablet',3,45000,'2024-01-18'),
('Rahul','Mobile',1,15000,'2024-01-20');

-- Step 2: Filtering Data Using Conditions
select * from orders
where price > 40000;

-- Step 3: Sorting Query Results
select * from orders
order by price asc;

-- sorting descending
select * from orders
order by price desc;

-- multiple column sorting
select * from orders
order by product asc, price desc;

-- Step 4: Grouping Data for Aggregation
select product, sum(price) as total_sales
from orders
group by product;

-- average price per product
select product, avg(price) as avg_price
from orders
group by product;

-- count orders per product
select product, count(*) as total_orders
from orders
group by product;

-- Step 5: Applying Conditions on Aggregated Data
select product, sum(price) as total_sales
from orders
group by product
having sum(price) > 50000;

-- Step 6: Conceptual Understanding of Filtering vs Aggregation Conditions
-- Incorrect: condition applied before grouping (using where)
select product, sum(price) as total_sales
from orders
where price > 20000
group by product;

-- Correct: condition applied after grouping (using having)
select product, sum(price) as total_sales
from orders
where price > 20000
group by product
having sum(price) > 50000;
