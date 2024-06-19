SELECT
	 o.order_id,
	 c.first_name+' ' +c.last_name "fullname",
	 c.city, c.state,
	 o.order_date,
	 SUM (oi.quantity) AS 'total_units',
	 SUM (oi.quantity * oi.list_price) AS 'revenue' ,
	 p.product_name ,
	 ca.category_name,
	 s.[store_name],
	 st.first_name+' ' +st.last_name "staffname"
FROM 
	sales.orders o
	JOIN sales.customers c
	ON o.customer_id = c.customer_id
	JOIN sales.order_items oi
	ON o.order_id = oi.order_id
	join production.products p on oi.product_id = p.product_id
	join production.categories ca on ca.category_id= p.category_id
	join [sales].[stores] s on s.[store_id] = o.[store_id]
	join [sales].[staffs] st on st.[store_id] = o.[store_id]
GROUP BY
	o.order_id,
	 c.first_name,c.last_name ,
	c.city, c.state, o.order_date , p.product_name ,ca.category_name,
	s.[store_name] ,
	st.first_name ,st.last_name
order by revenue desc ;
