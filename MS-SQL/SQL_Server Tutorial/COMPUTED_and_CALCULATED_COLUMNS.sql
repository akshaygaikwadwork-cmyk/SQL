-- COMPUTED COLUMNS and CALCULATED COLUMNS

create table employee_payroll
(
EmpId int identity,
EmpName varchar(100),
Designation varchar(50),
[Basic Pay] int,
[House Rent Allowance] int,
[Convence Allowance] int,
[Medical Allowance] int,
[Gross Pay] as [Basic Pay] + [House Rent Allowance] + [Convence Allowance] + [Medical Allowance]  -- this is an computed column
--Note - Gross Pay Column is Non-Persisted Computed Column 
-- Non-Persisted column it will calculate when you execute select queryt then gross salary will calculate otherwise physically it's not insertd in table
);

--Constant on computed column

alter table employee_payroll
add [Company Name] as 'Ak Company'

-- Function on computed column
alter table employee_payroll
add [Date] as getdate()

select * from employee_payroll

insert into employee_payroll values('Akshay','CEO',700000,50000,30000,20000)
insert into employee_payroll values('Ganesh','Manager',35000,20000,11000,12000)
insert into employee_payroll values('Vivek','Sr. Software developer',24000,7000,6000,5000)
insert into employee_payroll values('Pranit','Accountant',20000,3000,2000,1000)
insert into employee_payroll values('Sai','CEO_Assistant',300000,25000,15000,14000)

-- Types of computed columns : -
-- 1) Persisted Computed Column
-- 2) Non-Persisted Computed Column


-- 1) Persisted Computed Column

create table employee_payroll_persisted_ex
(
EmpId int identity,
EmpName varchar(100),
Designation varchar(50),
[Basic Pay] int,
[House Rent Allowance] int,
[Convence Allowance] int,
[Medical Allowance] int,
[Gross Pay] as [Basic Pay] + [House Rent Allowance] + [Convence Allowance] + [Medical Allowance] persisted  -- this is an computed column
--Note - Gross Pay Column is Persisted Computed Column 
-- Persisted column it will calculate physically insertd calulation data in table not like Non-Persisted computed column
);

select * from employee_payroll_persisted_ex

insert into employee_payroll_persisted_ex values('Akshay','CEO',700000,50000,30000,20000)
insert into employee_payroll_persisted_ex values('Ganesh','Manager',35000,20000,11000,12000)
insert into employee_payroll_persisted_ex values('Vivek','Sr. Software developer',24000,7000,6000,5000)
insert into employee_payroll_persisted_ex values('Pranit','Accountant',20000,3000,2000,1000)
insert into employee_payroll_persisted_ex values('Sai','CEO_Assistant',300000,25000,15000,14000)

update employee_payroll_persisted_ex set [Basic Pay] = 36000 where EmpId = 2

select [Gross Pay] from employee_payroll_persisted_ex
select [Gross Pay] from employee_payroll

select * from employee_payroll_persisted_ex where [Gross Pay] > 400000
select * from employee_payroll where [Gross Pay] > 400000

select * from employee_payroll_persisted_ex Order by [Gross Pay] Asc
select * from employee_payroll Order by [Gross Pay] Asc

--NOTE - You cannot insert/update values in computed columns it will insert/update values automatically in computed columns

update employee_payroll_persisted_ex set [Gross Pay] = 36000 where EmpId = 2

-- drop computed columns
alter table employee_payroll
drop column [Gross Pay]

select * from employee_payroll_persisted_ex
-- It will give error like [Computed column 'Gross Pay' in table 'employee_payroll_persisted_ex' is not allowed to be used in another computed-column definition.]
--alter table employee_payroll_persisted_ex
--add Bonus as [Gross Pay] + 2300

----------------------x-----------------------------------x-----------------------------x------------------------------------

create table product_sales
(
	prod_Id int primary key identity,
	prod_Name varchar(100),
	prod_Quantity int,
	prod_Price int,
	prod_Total_Cost as prod_Quantity * prod_Price persisted -- [physically stored if you use non used then when you execute select query then that time it will calculate]
);

select * from product_sales

insert into product_sales values('soap',2,300);
insert into product_sales values('shampoo',2,1300);
insert into product_sales values('brush',8,200);
insert into product_sales values('chips',12,700);
insert into product_sales values('oil',1,250);
insert into product_sales values('face wash',1,900);


----------------------x-----------------------------------x-----------------------------x------------------------------------
--									Index on Computed Columns
----------------------x-----------------------------------x-----------------------------x------------------------------------
-- Note - index only apply on persisted computed column not on non-persisted computed column because non-persisted computed column not sotred physically data in table

create index Ix_product_total_cost
on product_sales (prod_Total_Cost desc)

exec sp_helpindex product_sales

select * from product_sales where prod_Total_Cost>1500



