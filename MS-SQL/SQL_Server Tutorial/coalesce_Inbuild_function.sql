-- Coalesce
 
 -- It will return first not null value

select Coalesce(Null,Null,'Akshay',Null,'Gaikwad')

select Coalesce(Null,'',Null,'Gaikwad')

select Coalesce('Vivek',Null,Null,Null,'Rekame')

--Get first not null values from table
select prod_Id, Coalesce(prod_Quantity,prod_Price) from product_sales;


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--									IsNull
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

select * from product_sales

select ISNULL(prod_Quantity,prod_Total_Cost) from product_sales
select coalesce(prod_Quantity,prod_Total_Cost) from product_sales

-- Note - Data type must be same of the column that you want to check is null or to get first null vlaue in 


