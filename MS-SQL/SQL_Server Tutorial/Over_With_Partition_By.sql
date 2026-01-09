-- Over clause with Partition By

/*
Syntax -
		function(----) OVER (Partition By col1, col2....)
*/

select * from employee_payroll;

select Gender, COUNT(*) as genderWiseCount from employee_payroll group by Gender;


select EmpId, EmpName, [Basic Pay], employee_payroll.Gender as gender, genders.genderTotal from employee_payroll
inner join 
(select Gender, COUNT(*) as genderTotal from employee_payroll group by Gender) as genders
on employee_payroll.Gender = genders.Gender


select EmpId, EmpName, [Basic Pay], employee_payroll.Gender as gender, genders.genderTotal, genders.max_salary, genders.min_salary, genders.avg_salary from employee_payroll
inner join 
(
select Gender, COUNT(*) as genderTotal, 
MAX([Basic Pay]) as max_salary, 
MIN([Basic Pay]) as min_salary, 
AVG([Basic Pay]) as avg_salary 
from employee_payroll group by Gender
) as genders
on employee_payroll.Gender = genders.Gender

select EmpId, EmpName, [Basic Pay], COUNT(Gender) over (Partition by gender) as gedner_count from employee_payroll

select EmpId, EmpName, [Basic Pay], 
COUNT(Gender) over (Partition by gender) as gedner_count,
MAX([Basic Pay]) over (Partition by gender) as max_salary, 
MIN([Basic Pay]) over (Partition by gender) as min_salary, 
AVG([Basic Pay]) over (Partition by gender) as avg_salary
from employee_payroll