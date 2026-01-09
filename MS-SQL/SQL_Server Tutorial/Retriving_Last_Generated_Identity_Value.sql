-- Retriving Last Generated Identity Value

/*
There are 3 ways - to get last identity column values
1) Scope_Identity()  => Function
2) @@Identity		 => Global Variable
3) Ident_Current()	 => Function

*/


--1) Scope Identity()
select * from tbl_activityLog
insert into tbl_activityLog values('hi');
--1)
select SCOPE_IDENTITY();  -- it will return the last rows identity column values [ i.e. Last Id Column Value because this column having Identity ]

--Note - this funtion will return data in all windows tab

--2)
select @@IDENTITY;

--Note - this funtion will not return data in all windows tab. This is only in within operational page will show the data

create table emp_details
(
id int identity,
date_time datetime
)

select * from emp_details
select * from employee_payroll
insert into emp_details values(GETDATE())


--3) 
select IDENT_CURRENT('emp_details');
-- here we are created a new trigger i.e new scope under a session [ i.e for to test @@identity ]
create trigger tr_insertforEmp_Details
on employee_payroll
after insert
as
begin
	insert into emp_details values(GETDATE())
end



/*

1) The Scope_Indentity() - function returns the last identity created in the same session and the same scope.

2) The @@Identity - returns the last identity created in the same session and in any scope.

3) The ident_current(table_name) - returns the last identity created for a specific table or view in any session.

*/
 