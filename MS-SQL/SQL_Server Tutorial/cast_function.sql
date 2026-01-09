--CAST() 

/*
Syntax -

CAST (expression AS datatype( [length] ))  [] means it's optional

*/

select CAST(23.45 as int) as cast_value; 
select CAST('2023-10-20' as datetime) as datetime_value;

select * from product_sales
-- If yyou want to concatinate two column values into one column then you cannot use the following code-
select prod_Id +  ' - ' + prod_Name  from product_sales

--You need to use following code for concatinate two column values in single column-
select CAST(prod_Id as varchar(100)) +  ' - ' + prod_Name as concatinate_column_value from product_sales

insert into product_sales values('Earphone' + CAST(34 as varchar),2,5600.78)

select EmpId,EmpName,CAST(Date as date) as joining_Date from employee_payroll
where CAST(Date as date) = '2023-10-01';

select CAST(Date as date)  as joining_Date, COUNT(EmpId) as total_Emp from employee_payroll
group by CAST(Date as date);

select * from product_sales
select * from employee_payroll


