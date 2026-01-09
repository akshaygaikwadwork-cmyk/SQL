-- Cusrsor
/*
Methods of cursors-

1) Next
2) Prior
3) First
4) Last
5) Absolute n
6) Relative n

We can use cursors in 2 ways - 
1. With cursor variables
2. Without cursor variables

*/

-- 1. With cursor variable -
select * from tbl_employee;

declare myCursor cursor scroll for select Id, EmpName, EmpAge from tbl_employee
declare @emp_Id int, @emp_Name varchar(100), @emp_Age int
open myCursor
fetch first from myCursor into @emp_Id, @emp_Name, @emp_Age -- first
print 'Employee Id is:- ' + CAST(@emp_Id as VARCHAR(100))  +' name is:- '+ @emp_Name +' and his age is :- '+ CAST(@emp_Age as VARCHAR(100))

fetch next from myCursor into @emp_Id, @emp_Name, @emp_Age -- next
print 'Employee is: ' + CAST(@emp_Id as VARCHAR(100))  +' name is:- '+ @emp_Name +' and his age is :- '+ CAST(@emp_Age as VARCHAR(100))

fetch last from myCursor into @emp_Id, @emp_Name, @emp_Age -- last
print 'Employee is: ' + CAST(@emp_Id as VARCHAR(100))  +' name is:- '+ @emp_Name +' and his age is :- '+ CAST(@emp_Age as VARCHAR(100))

fetch prior from myCursor into @emp_Id, @emp_Name, @emp_Age -- prior [it will show before last query records according]
print 'Employee is: ' + CAST(@emp_Id as VARCHAR(100))  +' name is:- '+ @emp_Name +' and his age is :- '+ CAST(@emp_Age as VARCHAR(100))

fetch absolute 4 from myCursor into @emp_Id, @emp_Name, @emp_Age -- absolute n [it will show 4th row number records]
print 'Employee is: ' + CAST(@emp_Id as VARCHAR(100))  +' name is:- '+ @emp_Name +' and his age is :- '+ CAST(@emp_Age as VARCHAR(100))

fetch relative 4 from myCursor into @emp_Id, @emp_Name, @emp_Age -- relative n [it will show as per absolute methos records come then it will return 7 records from it it will add 3 after 4 i.e 4 + 3 =7]
print 'Employee is: ' + CAST(@emp_Id as VARCHAR(100))  +' name is:- '+ @emp_Name +' and his age is :- '+ CAST(@emp_Age as VARCHAR(100))

fetch relative -3 from myCursor into @emp_Id, @emp_Name, @emp_Age
print 'Employee is: ' + CAST(@emp_Id as VARCHAR(100))  +' name is:- '+ @emp_Name +' and his age is :- '+ CAST(@emp_Age as VARCHAR(100))

close myCursor
deallocate myCursor;



-- 2. Without cursor variable -
select * from tbl_employee;

declare myCursor cursor scroll for select * from tbl_employee
open myCursor
fetch first from myCursor -- first
fetch next from myCursor -- next
fetch last from myCursor -- last
fetch prior from myCursor -- prior [it will show before last query records according]
fetch absolute 4 from myCursor -- absolute n [it will show 4th row number records]
fetch relative 4 from myCursor -- relative n [it will show as per absolute methos records come then it will return 7 records from it it will add 3 after 4 i.e 4 + 3 =7]
fetch relative -3 from myCursor
close myCursor
deallocate myCursor;

--Note - In cursor every line depending on before line

