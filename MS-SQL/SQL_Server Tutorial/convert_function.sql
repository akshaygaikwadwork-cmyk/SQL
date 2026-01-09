--Convert 
-- Similarities betweeb CAST and CONVERT 

select CAST(23.45 as int); 
select CONVERT(int, 23.45);

declare @num1 decimal = 56.78;
select CAST(@num1 as int);
select CONVERT(int,@num1);

select CAST('2023-10-12' as datetime)
select CONVERT(datetime,'2023-10-12')

-- Note - Convert having one difference that you can format the datetime as per your requirement

/*
Syntax -

CONVERT( data_type([length]) , expression, [style] )

Style Formats -

1 = mm/dd/yy
101 = mm/dd/yyyy
2 = yy.mm.dd
102 = yyyy.mm.dd
3 = dd/mm/yy
103 = dd/mm/yyyy

so on.. check on following microsoft website -


*/

select getdate();

select convert(varchar, GETDATE());

select convert(varchar, GETDATE(),0); -- Default
select convert(varchar, GETDATE(),100); -- Default
select convert(varchar, GETDATE(),1); -- mm/dd/yy
select convert(varchar, GETDATE(),101); -- mm/dd/yyyy
select convert(varchar, GETDATE(),2); -- yy.mm.dd
select convert(varchar, GETDATE(),102); -- yyyy.mm.dd
select convert(varchar, GETDATE(),3); -- dd/mm/yy
select convert(varchar, GETDATE(),103); -- dd/mm/yyyy

select EmpName, CONVERT(varchar, Date, 101) as Date from employee_payroll



