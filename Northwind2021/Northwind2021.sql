--Display a list of all customers
select * from Customer;

--Display a list of all Supplier
select * from Supplier;

--Display a FirstName ,LastName and Phone for Customer
select firstname, lastname,phone from Customer;

--Display a ProductName and UnitPrice for Product
select productname , unitprice from Product ;

--For customers who live in 'Mexico', display a list of their full name and phone.
select firstname +''+ lastname "Full Name" , phone from Customer
where Country = 'Mexico';

--For products with prices over 50$, display the product name, package and price after Taxes .
--Note: taxes = %15;
select [ProductName],[Package],(UnitPrice*1.15)"Price After Taxes" from Product
where unitprice>50;

--For suppliers, outside 'USA' and 'UK', display a list of company name, city and phone.
select [CompanyName], [City] , [Phone] from [dbo].[Supplier]
where [Country] not in ('USA','UK');

--For suppliers located in 'USA', display a list of company name,
--product names and unitPrice sorted Alphabetically.
select companyname , productname , unitprice 
from supplier s join product p  
on s.[Id]=p.[SupplierId]
where Country='USA'
order by companyname desc; 

--For each customer, display a list of customer full name and 
--how many orders he made and how much he totally paid.
select firstname +''+ lastname "Full Name" ,count(*)"No Of Order" ,
sum(totalamount) "Total Amount Paid"
from Customer c join Orders o 
on c.Id = o.CustomerId
group by firstname , lastname
order by sum(totalamount)desc ;

--or suppliers, who supplied more than 5 products,display a list of company name and
--how m any products it supplied,sorted by the number of products in descending order.
select companyname , COUNT(*) 
from Supplier s join Product p
on s.Id = p.SupplierId
group by companyname
having COUNT(*) >2
order by COUNT(*) desc ; 

--Display a top 5 list of the most expensive products.
select top 5 productname , unitprice 
from product 
order by unitprice desc ;

--Display a list of the top 3 best-selling products
select top 3 productid , count(*)
from OrderItem
group by productid
order by count(*) desc ; 

--Display a list of products with prices more than the average price.
select * from Product 
where UnitPrice>(select AVG(UnitPrice) from Product) ;

--Display a list of customers and ProductName who bought one or more products that Mr "Horst' already bought.
select distinct  firstname +''+ lastname "Full Name",ProductId,OrderId,ProductName
from Customer c join Orders o
on c.Id = o.CustomerId join OrderItem oi
on oi.ProductId = o.Id join Product p on p.Id = oi.ProductId
where oi.ProductId in (select distinct oi.ProductId from Customer c join Orders o
on c.Id = o.CustomerId join OrderItem oi on oi.OrderId = o.Id and firstname = 'Horst' )

SELECT DISTINCT firstname
FROM Customer c
JOIN Orders o ON c.Id = o.CustomerId
JOIN OrderItem oi ON oi.ProductId = o.Id
WHERE oi.ProductID IN (
    SELECT oi2.ProductId
    FROM Customer c2
    JOIN Orders o2 ON c2.Id= o2.CustomerId
    JOIN OrderItem oi2 ON o2.Id = oi2.OrderId
    WHERE c2.firstname = 'Horst'
)
AND c.firstname != 'Horst';
