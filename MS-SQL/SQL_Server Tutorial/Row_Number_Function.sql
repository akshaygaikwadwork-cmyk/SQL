-- Row Number Funtion

/*
Syntax - 
		ROW_Number() OVER (ORDER BY Column_Name)
*/

select * from employee_payroll;

select *, ROW_NUMBER() over (order by EmpName asc) from employee_payroll

select *, ROW_NUMBER() over (order by EmpName desc) from employee_payroll
--using partition on gender
select *, ROW_NUMBER() over (partition by Gender order by EmpName desc) from employee_payroll
--using partition on city
select *, ROW_NUMBER() over (partition by City order by EmpName desc) from employee_payroll