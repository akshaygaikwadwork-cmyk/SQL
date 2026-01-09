-- CUBE() - Aggregate Operator

select * from employee_payroll

alter table employee_payroll
add Gender varchar(10)

alter table employee_payroll
add City varchar(50) 

update employee_payroll set City = 'Mumbai' where EmpId = 1
update employee_payroll set City = 'Pune' where EmpId = 2
update employee_payroll set City = 'Mumbai' where EmpId = 3
update employee_payroll set City = 'Pune' where EmpId = 4
update employee_payroll set City = 'Satara' where EmpId = 5


select * from employee_payroll
select Gender,SUM([Basic Pay]) as Total_basic_salary from employee_payroll
group by Gender

select * from employee_payroll
select Gender, City, SUM([Basic Pay]) as Total_basic_salary from employee_payroll
group by Gender,City

-- CUBE Function Used
select * from employee_payroll
select Gender, City, SUM([Basic Pay]) as Total_basic_salary from employee_payroll
group by CUBE(Gender,City)

-- OR

select * from employee_payroll
select Gender, City, SUM([Basic Pay]) as Total_basic_salary from employee_payroll
group by Gender,City With CUBE

/*
returns total of Basic Pay amount of
1) Male [Gender]
2) Female [Gender]
3) Mumbai [City]
4) Pune [City]
5) Satara [City]
6) All Gender and All City
*/

----------------------x-----------------------------------x-----------------------------x------------------------------------

-- Rollup() - Aggregate Operator

-- ROLLUP Function Used
select * from employee_payroll
select Gender, City, SUM([Basic Pay]) as Total_basic_salary from employee_payroll
group by ROLLUP(Gender,City)

-- OR

select * from employee_payroll
select Gender, City, SUM([Basic Pay]) as Total_basic_salary from employee_payroll
group by Gender,City With ROLLUP
/*
returns total of Basic Pay amount of
Parent => Child
Gender -> City
and it return data alphabetically order
1) Male [Gender]
2) Female [Gender]
3) Mumbai [City]
4) Pune [City]
5) Satara [City]
6) All Gender and All City
*/


----------------------x-----------------------------------x-----------------------------x------------------------------------
--											GROUPING SETS
----------------------x-----------------------------------x-----------------------------x------------------------------------


select * from employee_payroll
select Gender, City, SUM([Basic Pay]) as Total_basic_salary from employee_payroll
group by 
GROUPING SETS
(
	(City,Gender),
	(City),
	(Gender),
	()
)
order by grouping(City), grouping(Gender)

----------------------x-----------------------------------x-----------------------------x------------------------------------

select Gender, City, SUM([Basic Pay]) as Total_basic_salary from employee_payroll
group by City,Gender

UNION ALL

select City, null, SUM([Basic Pay]) as Total_basic_salary from employee_payroll
group by City

UNION ALL

select null, Gender, SUM([Basic Pay]) as Total_basic_salary from employee_payroll
group by Gender

UNION ALL

select null, null, SUM([Basic Pay]) as Total_basic_salary from employee_payroll
-- OR 
select null, null, SUM([Basic Pay]) as Total_basic_salary from employee_payroll
group by ()
