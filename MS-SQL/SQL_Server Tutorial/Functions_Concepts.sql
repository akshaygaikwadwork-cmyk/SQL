--1) Scalar function  [it's created in scala-vlaued functions]

-- without parameter
alter function showMessage()
returns varchar(100)
as
begin
return 'He! welcome to akshay db'
end

select dbo.showMessage();

--with parameter
alter function addition(@num1 as int, @num2 as int)
returns int
begin
return (@num1+isnull(@num2,6));
end

select CONCAT('Addition of two number is ', dbo.addition(4,7))

--with parameter and if else condition
create function checkAgeForVote(@age int)
returns varchar(100)
begin
	declare @str varchar(100)
	if(@age>=18)
	begin
	set @str='You are eligible for vote'
	end
	else
	begin
	set @str='You are not eligible for vote'
	end
return @str
end

select dbo.checkAgeForVote(17)
select dbo.checkAgeForVote(18)

--call function inside function()
create function getCurrentDate()
returns datetime
as
begin
return getdate()
end

select dbo.getCurrentDate()

-------------------------------x------------------------------------x----------------------------------------------x---------------------

-- 2) Inline function [it's created  in table-valued function]

-- without parameter
create function getEmployeeData()
returns table
as
return (select * from tbl_employee)

select * from dbo.getEmployeeData()

-- with parameter
alter function getEmployeeDataByAge(@age int)
returns table
as
return (select * from tbl_employee where EmpAge<=@age)

select * from dbo.getEmployeeDataByAge(23)

-- join with function

select * from dbo.getEmployeeDataByAge(20) as A
--inner join tbl_TDepartment as B
--on A.Department_id = B. DId;

-----------------------------x--------------------------------------x---------------------------------------x-------------------------

-- 3) Multi-statement table-valued

alter function fn_getEmpData(@Id int) --[it's created  in table-valued function]
returns @table1 table (empName varchar(100), empAge int, empSalary Decimal(10,2), empMobile bigint)
as
begin
	insert into @table1
	select EmpName,EmpAge,EmpSalary,EmpMobile from tbl_employee where Id = 9
	return
end

select * from dbo.fn_getEmpData(9)

