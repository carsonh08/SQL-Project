use restaurant_db;

#1 - number of items on menu

select count(*)
from menu_items;

#2 - least and most expensive items

Select *
from menu_items
order by price;

#3 - how many italian dishes

Select category, count(*) num_italian
From menu_items
where category = 'Italian';

#4 - least and most expensive italian dishes

Select item_name, category, price
From menu_items
where category = 'Italian'
Order by price;

#5 - how many dishes in each category

Select category, count(*) num_dishes
From menu_items
Group By category;

#6 - average dish price in each category

Select category, avg(price)
from menu_items
Group by category;

#Orders table

#1- date range of the table

Select min(order_date) min_date, max(order_date) max_date
From order_details;

#2- How many orders were made within the date range? 
Select  count(distinct order_id)
From order_details;

#3 - How many items were ordered within the date range?

Select count(*) 
From order_details;

#4- Which orders had the most number of items?

Select order_id, count(item_id) tot_items
From order_details
Group By order_id
Order By tot_items desc;

#5- how many orders had more than 12 items? 

Select count(*)
From
(Select order_id, count(item_id) tot_items
From order_details
Group By order_id
Having tot_items>12
Order by tot_items desc) num_orders;

#Goal is to find the menu items doing the best/worst and what the top customers order the most.
#1 - combine order_details and menu_items tables

Select *
From order_details od
	Left Join menu_items mi
    On od.item_id = mi.menu_item_id;

#2 - Least and most ordered items and their categories

Select item_name, category, count(order_details_id) num_purchases
From order_details od
	Left Join menu_items mi
    On od.item_id = mi.menu_item_id
Group By item_name, category
Order by num_purchases desc;

#3 - Top 5 orders that spent the most money

Select order_id, sum(price) tot_spent
From order_details od
	Left Join menu_items mi
    On od.item_id = mi.menu_item_id
Group by order_id
Order by tot_spent desc
Limit 5;

#4 - Details of the highest spend order.

Select category, count(*)
From order_details od
	Left Join menu_items mi
    On od.item_id = mi.menu_item_id
Where order_id = 440
Group By category;

#5 - details of the top 5 highest spend orders

Select order_id, category, count(*)
From order_details od
	Left Join menu_items mi
    On od.item_id = mi.menu_item_id
where order_id In (440, 2075, 1957, 330, 2675)
Group By order_id, category;