create database  db_retail_sales;    --  1. creating a database 

use db_retail_sales;        --    2 . accesing the data base 

CREATE TABLE retail_sales        --   3 .creating a table 
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);



select * from db_retail_sales.retail_sales;  -- 4 . Retriving the table data

describe db_retail_sales.retail_sales;  --  5. checking for data type 


ALTER TABLE retail_sales    --  5 .converting the text type to data type data 
MODIFY sale_date DATE;


ALTER TABLE retail_sales    --  6 .converting the text type to Time type data 
MODIFY sale_time Time;


describe retail_sales;        -- 7. Rechecking the data type after converting the  columns to required data types.


select * from retail_sales;

describe retail_sales;

ALTER TABLE retail_sales RENAME COLUMN  quantiy TO quantity;  -- Renaming the column 

select * from retail_sales;

ALTER TABLE retail_sales RENAME COLUMN ï»¿transactions_id  TO   transactions_id ;  -- Renaming the column name of Transactions




ALTER TABLE retail_sales -- promoting the column to primary key
ADD PRIMARY KEY (transactions_id) ;


select * from retial_sales;

ALTER TABLE retail_sales    --   .converting the int type to float  type data 
MODIFY price_per_unit FLOAT;


ALTER TABLE retail_sales    --   .converting the int type to float  type data 
MODIFY cogs FLOAT;

ALTER TABLE retail_sales    --   .converting the int type to float  type data 
MODIFY total_sale FLOAT;

describe retail_sales;
 -- now data is cleaned and prepared for exploratory analysis --
 
 
 -- number of records in data set --
 
 SELECT COUNT(*) FROM retail_sales;
 
 -- UNIQUE COSTUMERS COUNT--
 SELECT COUNT(DISTINCT customer_id)  as unique_customers_count FROM retail_sales;
 
 -- Unique Category --
 SELECT DISTINCT category FROM retail_sales;  
 -- checking for NULL --
 SELECT * FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
    
    
    -- deleting the null values -- 
    DELETE FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
    
    
    --  Data Analysis and Findings -- 
  -- 1. Write a SQL query to retrieve all columns for sales made on '2022-11-05:  -- 
  SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';

-- Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022: -- 
SELECT * FROM retail_sales
WHERE category = 'Clothing' AND sale_date  BETWEEN '2022-01-01' AND '2023-12-31'  -- Between 2022 and 2023
    AND EXTRACT(YEAR FROM sale_date) = 2022           -- Specific year 2022
    AND EXTRACT(MONTH FROM sale_date) = 11    AND quantity >= 4  ;
   
   -- Write a SQL query to calculate the total sales (total_sale) for each category.: -- 
   
   
   SELECT 
    category, SUM(total_sale) as net_sale,
    COUNT(*) as total_orders FROM retail_sales
                    GROUP BY 1 ;
                    
     
   -- Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:   --           
                    
                    SELECT
                      ROUND(AVG(age), 2) as avg_ag FROM retail_sales
                        WHERE category = 'Beauty';
                        
-- Write a SQL query to find all transactions where the total_sale is greater than 1000.: --
SELECT * FROM retail_sales
WHERE total_sale > 1000;

-- Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
SELECT category,gender, COUNT(*) as total_trans FROM retail_sales
GROUP BY category, gender  ORDER BY 1;

-- Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:

select month(sale_date) as month,year(sale_date) as year  ,round(avg(total_sale)) as Avg_sale ,
rank()  over(partition by year(sale_date) order by avg(total_sale) desc )    from  retail_sales 
group by month, year  limit 1
;

-- Write a SQL query to find the number of unique customers who purchased items from each category.: --
SELECT 
    category,    
    COUNT(DISTINCT customer_id) as cnt_unique_cs
FROM retail_sales
GROUP BY category;

-- Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
 
WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift


	




