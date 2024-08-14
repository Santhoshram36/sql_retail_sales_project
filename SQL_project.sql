SELECT [transactions_id]
      ,[sale_date]
      ,[sale_time]
      ,[customer_id]
      ,[gender]
      ,[age]
      ,[category]
      ,[quantiy]
      ,[price_per_unit]
      ,[cogs]
      ,[total_sale]
  FROM [sql_project_p2].[dbo].[retail_sales]
  where transactions_id is null
  or
       sale_date is null
  or
       sale_time is null
  or
       age is null
  or
       quantiy is null
  or
       quantiy is not null
  or
       total_sale is null

--HOW MANY SALES WE HAVE
select count(*) as total_sale from retail_sales

--HOW MANY UNIQUE CUSTOMERS WE HAVE
select count(distinct customer_id) as total_sales from retail_sales

select distinct category 
from retail_sales

--DATA ANALYSIS

--Write a SQL query to retrieve all columns for sales made on '2022-11-05'
select *
from retail_sales
where sale_date='2022-11-05'

--Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of the Nov-2022
SELECT *
FROM retail_sales
WHERE category = 'Clothing' 
  AND CONVERT(VARCHAR(7), sale_date, 126) = '2022-11'
  AND quantiy >= 4;

--Write a SQL query to calculate the total sales (total_sale) for each category.
select category,sum(total_sale), count(*) as total_orders
from retail_sales
group by category 
order by category desc

--Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select category,avg(age) as avg_age
from retail_sales
where category='Beauty'
group by category;

--Write a SQL query to find all transactions where the total_sale is greater than 1000.
select *
from retail_sales
where total_sale > 1000;

--Write a SQL query to find the total number of transactions made by each gender in each category.
SELECT category, gender, COUNT(*) as transaction_count
FROM retail_sales
GROUP BY category, gender;

--Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.
select * 
from
(
select year(sale_date) as sale_year,
       month(sale_date)as sale_month,
	   avg(total_sale) as avg_sale,
	   rank() over(partition by year(sale_date) order by avg(total_sale) desc) as rank
from retail_sales
group by year(sale_date), month(sale_date)
) as t1
where rank = 1
order by sale_year,sale_month;

--Write a SQL query to find the top 5 customers based on the highest total sale.
select top 5 customer_id, sum(total_sale) as total_sales
from retail_sales
group by customer_id
order by total_sales desc;

--Write a SQL query to find the number of unique customers who purchased items from each category.
select category, count(distinct customer_id) as unique_customer
from retail_sales
group by category;

--Write a SQL query to create each shift amd number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17).
with hourly_sale
as
(
SELECT *,
    CASE 
        WHEN DATEPART(HOUR, sale_time) < 12 THEN 'Morning'
        WHEN DATEPART(HOUR, sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS shift
FROM retail_sales
)
select shift ,
       count(*) as total_orders
from hourly_sale
group by shift







