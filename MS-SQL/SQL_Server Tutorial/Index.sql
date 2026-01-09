-- Indexes

-- Single column indexes -

select * from product_sales

--This is non-unique and non-clustered
-- Note - you can check index using
--1) Your_Database => Tables folder => Your_Table => Under Indexes Folder
--2) sp_helpindex tbl_employee [table_name]
create index Ix_Filter_Salary
on product_sales (prod_Price ASC);

exec sp_helpindex product_sales

select * from product_sales where prod_Price > 13000 and prod_Price < 24000

drop index product_sales.Ix_Filter_Salary --[table_name.index_name] 

-- NOTE - When you apply index on any table then DML [insert/update/delete] will work slow 
/* 
	=> When you apply index on Id column which is already having primary key then you will get data fast 
       Because primary key is combination of Not Null Constraint and Unique constraint now it's also combination of index

	=> Primary key - When you apply primary key on any column then default clustered index will apply on that column

	=> when should indexes be avoided? 
	   1) On small tables
	   2) Multiple time Insert/Update/Delete executing/frequently you are using then on that column don't apply index
	   3) don't apply index on that column which is having/contain more null values
	   4) don't apply index on that column which is always update/edit 
*/


--------------------------x----------------------------------------x------------------------------------------x---------------------
--												CLUSTERED INDEX
--------------------------x----------------------------------------x------------------------------------------x---------------------
--Ex..  Dictionary 
-- when you create table then insert data without any sequential order but because of id column having primary key default clustered indes that's why it will insert sqeutial as below-

create table tbl_demo
(Id int, Name varchar(300),Age int)

select * from tbl_demo

insert into tbl_demo values(4,'Akshay',23);
insert into tbl_demo values(1,'Vijay',25);
insert into tbl_demo values(3,'Sai',22);
insert into tbl_demo values(5,'Ram',27);
insert into tbl_demo values(2,'Kunal',26);

/* Note - Clustered Index can apply on only one column in each table [i.e each table having only one index column]
		  But Non-Clustered Index can apply on multiple columns in each table [i.e COMPOSITE INDEX]
*/
--Note - If you have unordered data in table without primary key column on ID then you can aapy clusteres index on that column then it will automatically order data of that table
-- Clustered Index
-- For apply clustered index on another column following query is there -
create clustered index Ix_FTE_Id_Clustered
on tbl_demo (Id Asc);
-- Following Query It will give error because only one clustered index can apply on one column in each table
create clustered index Ix_FTE_Id_Clustered1
on tbl_demo (Id Asc, Name Desc);

exec sp_helpindex tbl_demo

--------------------------x----------------------------------------x------------------------------------------x---------------------
--												NON-CLUSTERED INDEX
--------------------------x----------------------------------------x------------------------------------------x---------------------
--Ex.. - Book
--Non-Clustered Index


create table tbl_demo_non_clust
(Id int primary key, Name varchar(300),Age int)

select * from tbl_demo_non_clust

insert into tbl_demo_non_clust values(7,'Nilesh',23);
insert into tbl_demo_non_clust values(2,'Vikrant',25);
insert into tbl_demo_non_clust values(8,'Vivek',22);
insert into tbl_demo_non_clust values(4,'Mira',27);
insert into tbl_demo_non_clust values(1,'Anjali',26);
insert into tbl_demo_non_clust values(3,'Ganesh',22);
insert into tbl_demo_non_clust values(5,'Indra',28);
insert into tbl_demo_non_clust values(9,'Mangal',29);
insert into tbl_demo_non_clust values(6,'Yogesh',21);
insert into tbl_demo_non_clust values(10,'Nikita',23);

-- Note - non-clustered option if you not write then it will take default non-clustered index

create nonclustered index Ix_FTE_Id_non_Clustered
on tbl_demo_non_clust (Name Desc);

--OR

--create index Ix_FTE_Id_non_Clustered
--on tbl_demo_non_clust (Name Desc);

exec sp_helpindex tbl_demo_non_clust
