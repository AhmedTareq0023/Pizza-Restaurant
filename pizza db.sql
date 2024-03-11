select * from pizza_sales;

-- Cleaning ..
alter table pizza_sales
alter column pizza_id int;
			 
alter table pizza_sales
alter column order_id int;

alter table pizza_sales
alter column quantity int;

alter table pizza_sales
alter column order_date date;

alter table pizza_sales
alter column order_time datetime;

alter table pizza_sales
drop column order_time;

select distinct pizza_size from pizza_sales;  -- S,L,XL,XXL,M

update pizza_sales
set pizza_size = 
	case
		when pizza_size ='S' then 'Regular'
		when pizza_size ='L' then 'Large'
		when pizza_size ='XL' then 'X-Large'
		when pizza_size ='XXL' then 'XX-Large'
		when pizza_size ='M' then 'Medium'
	end;

//---------------------------------------------------------------------------//

//---------------------------------------------------------------------------//

//---------------------------------------------------------------------------//

-------------//Requirements-------------//

-- Total Revenue : sum of tatal price of all pizza orders
select round(sum(total_price),2) as Total_Revenue
from pizza_sales;

-- Average Order Value : sum of tatal price of all pizza orders / no. of orders
select round((sum(total_price) / count(distinct order_id)),2) as Avg_Order_Value
from pizza_sales;

-- Total Pizzas Sold : sum of quantity 
select sum(quantity) as Tot_Pizzas_Sold
from pizza_sales;

-- Total Orders
select count(distinct order_id) as Count_of_Orders
from pizza_sales;

-- Number of Pizza Per Order
select cast( cast(count(pizza_id) as decimal(10,2)) /
	   cast(count(distinct order_id) as decimal(10,2)) as decimal(10,2) ) as Avg_Pizzas_per_Order
from pizza_sales;

-- Daily Trend For Total Orders
select datename(dw,order_date) as Order_Day , count(distinct order_id) as Total_Orders
from pizza_sales
group by datename(dw,order_date);

-- Monthly Trend For Total Orders
select datename(month,order_date) as Month_Name , count(distinct order_id) as Total_Orders
from pizza_sales
group by datename(month,order_date)
order by Total_Orders desc;

-- Percentage of order quantity By Pizza Category

select * from pizza_sales;
select distinct pizza_category from pizza_sales;

select pizza_category , round(sum(quantity)*100 / (select sum(quantity) from pizza_sales),2) as PCT_Order_Quantity_for_Category
from pizza_sales
group by pizza_category;

-- Percentage of Sales By Pizza Category
select pizza_category , round(sum(total_price)*100 / (select sum(total_price) from pizza_sales),2) as PCT_Sales_for_Category
from pizza_sales
group by pizza_category;

-- Percentage of Sales By Pizza Category in month January 
select pizza_category , cast( sum(total_price)*100 / (select sum(total_price) from pizza_sales where month(order_date) = 1) as decimal(10,2)) as PCT_Jan
from pizza_sales
where month(order_date) = 1
group by pizza_category;

-- Percentage of Sales By Pizza Category in Quarter 4
select pizza_category , cast( sum(total_price)*100 / (select sum(total_price) from pizza_sales where datepart(quarter,order_date) = 4) as decimal(10,2)) as
PCT_Quarter_4
from pizza_sales
where datepart(quarter,order_date) = 4
group by pizza_category;

-- Percentage of Sales By Pizza Size
select pizza_size , cast( sum(total_price)*100 / (select sum(total_price) from pizza_sales) as decimal(10,2)) as PCT_Sales_For_Size
from pizza_sales
group by pizza_size
order by PCT_Sales_For_Size desc;

-- Total Pizzas Sold By Pizza Category
select pizza_category , sum(quantity) as Total_Amount
from pizza_sales
group by pizza_category
order by Total_Amount desc;

-- Top 5 Best Sellers By Revenue , Total Quantity , Total Orders
select * from pizza_sales;

-- according to price -- desc
select top 5 with ties pizza_name , pizza_category , cast( sum(total_price) as decimal(10,2) ) as Total_Revenue, sum(quantity) as Total_Quantity ,
count(distinct order_id) as Total_Orders
from pizza_sales
group by pizza_name, pizza_category
order by Total_Revenue desc;

-- according to quantity of pizza -- desc
select top 5 with ties pizza_name , pizza_category , cast( sum(total_price) as decimal(10,2) ) as Total_Revenue, sum(quantity) as Total_Quantity ,
count(distinct order_id) as Total_Orders
from pizza_sales
group by pizza_name, pizza_category
order by Total_Quantity desc;

-- according to count of orders -- desc
select top 5 with ties pizza_name , pizza_category , cast( sum(total_price) as decimal(10,2) ) as Total_Revenue, sum(quantity) as Total_Quantity ,
count(distinct order_id) as Total_Orders
from pizza_sales
group by pizza_name, pizza_category
order by Total_Orders desc;






