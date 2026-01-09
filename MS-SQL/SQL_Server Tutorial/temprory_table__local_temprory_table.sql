-- Temporary Tables/ Local Temporary table
-- Temporary table stored in System Database => tempdb 

/*
 Type of Temporary Tables -

 1) Local Temporary Tables
 2) Global Temporary Tables

*/

-----------------------x----------------------------------x------------------------------x
--										1) Local Temporary Tables
-----------------------x----------------------------------x------------------------------x

create table #temp_tbl_employee -- Note - # must used for to create temp table
(
Id int, 
name varchar(50), 
gender varchar(50)
)

-- Note - this is temp table created in System database => tempdb => Temporary Tables

--You can check this temp Table exist or not in specific Database use following query -

select name from tempdb..sysobjects
where name like '%temp_tbl_employee%'


insert into #temp_tbl_employee values(1,'Akshay','Male'),
(2,'Sai Pallvi','Female'),
(3,'Vivek','Male'),
(4,'Ganesh','Male')

select * from #temp_tbl_employee

/*
Note- 

1)This happen with only same connection window tab it will not showing data in another new window tab 
2)A local temporary table automatically drop when you close connected window tab close then it will drop temp table
3)Single hash (#) must used for to create local temporary table
4)When you create temp table under/in Stored Procedure then it will automatically drop temp table after SP full execution
*/

--drop table #temp_tbl_employee

create proc sp_temp_tbl_Emp
as
begin

create table #temp_tbl_employee -- Note - # must used for to create temp table
(
Id int, 
name varchar(50), 
gender varchar(50)
);

insert into #temp_tbl_employee values(1,'Akshay','Male'),
(2,'Sai Pallvi','Female'),
(3,'Vivek','Male'),
(4,'Ganesh','Male');

select * from #temp_tbl_employee;

end

exec sp_temp_tbl_Emp;

select * from #temp_tbl_employee;


-----------------------x----------------------------------x------------------------------x
--										2) Global Temporary Tables
-----------------------x----------------------------------x------------------------------x


-- 2) Global Temporary Tables

create table ##Global_temp_tbl_employee -- Note - ## must used for to create Global temp table
(
Id int, 
name varchar(50), 
gender varchar(50)
)

select name from tempdb..sysobjects
where name like '%Global_temp_tbl_employee%'


insert into ##Global_temp_tbl_employee values(1,'Nikhi','Male'),
(2,'Pallvi','Female'),
(3,'Neha','Male'),
(4,'Vicky','Male')

select * from ##Global_temp_tbl_employee

/*
Note-
1) In SQL Server, To create the global temporary table, use 2 (##) hash symbols before the name of the table.
2) In SQL Server, Global temporary tables are accessible or visible in all the connections.
3) In SQL Server, Global temporary tables destroyed when the last connection referencing the table is closed.
4) In SQL Server, If you close the connection that has created the global temporary table then that global temporary table will automatically deleted.
5) In SQL Server, We can create the local temporary table with same name in different connections But a global temporary table name has to be unique it means we cannot create the global temporary table with same name in different connections.
6) In the object explorer, there will be no random numbers suffixed at the end of the table name.
7) In SQL Server, Local and global Temporary Tables are Created in TempDB.


DIFFERENCE BETWEEN LOCAL TEMPORARY TABLES & GLOBAL TEMPORARY TABLES IN SQL SERVER
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
LOCAL TEMPORARY TABLES															 |	GLOBAL TEMPORARY TABLES
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
																				 |
In SQL Server, We have Single # Symbol before the name of local temporary table. |	In SQL Server, To create the global temporary table, use 2 (##) hash symbols before the name of the table.
SQL Server appends some random numbers at the end of the local temp table.		 |  SQL Server did not appends random numbers at the end of the global temp table.
In SQL Server, Local temporary tables are only visible to that					 |	In SQL Server, Global temp tables are visible to all SQL
connection / session of the SQL server which has created it.					 |	Server connections / sessions.
In SQL Server, We can create the local temporary table with same name in		 |	In SQL Server, We cannot create the global temporary table with same
different connections															 |	name in different connections.

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

SIMILARITIES -
Both are created in TempDb in system databases.
Both are automatically deleted when the connection is closed.
Both are the types of Temporary tables.

*/