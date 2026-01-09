-- After Triggers

--1)
alter trigger tr_emp_forInsert
on tbl_employee
after insert
as
begin
	--print 'Data inserted successfully in Employee Table'
	-- OR
	select * from inserted 
	-- OR
	declare @id int
	select @id = id from inserted
	
	insert into auditLog values('Employee with id ' + CAST(@id as varchar(50)) + ' is added successfully at ' + CAST(GETDATE() as varchar(50)))  -- CAST is use for int to varchar


end
-- when you execute insert query then see the message description it will show our triggers message when insert command execute
-- Note see the auditLog table as well 
insert into tbl_employee values('Varun Desai',23,14000.89,7876789890)


--2)
alter trigger tr_emp_forUpdate
on tbl_employee
after update
as
begin
	--print 'Data updated successfully in Employee Table'
	-- OR
	select * from inserted
	select * from deleted
end
-- when you execute update query then see the message description it will show our triggers message when update command execute
update tbl_employee set EmpName='Varun Desai' where Id=15

--3)
alter trigger tr_emp_forDelete
on tbl_employee
after delete
as
begin
	--print 'Data deleted successfully from Employee Table'
	-- OR
	select * from deleted 
	-- OR
	declare @id int
	select @id = id from deleted
	
	insert into auditLog values('Employee with id ' + CAST(@id as varchar(50)) + ' is deleted successfully at ' + CAST(GETDATE() as varchar(50)))  -- CAST is use for int to varchar

end

-- when you execute delete query then see the message description it will show our triggers message when delete command execute
delete from tbl_employee  where Id=15
select * from tbl_employee


----------------------x-----------------------------x--------------------------------x-----------------------------x------------------

-- Note - [Insted of insert/update/delete triggers apply only on one table . You cannot create insert/update/delete triggers on same table ]

-- Instead Triggers

--		i) Instead of Insert Trigger
--		ii) Instead of Update Trigger
--		iii) Instead of Delete Trigger

--	i) Instead of Insert Trigger

create trigger tr_emp_insteadOf_insert
on tbl_employee
instead of insert
as
begin
	print 'You are not allowed to insert data in this table !!';
end

insert into tbl_employee values('Sahil Patil',27,17000.49,9087789890)

-- Note - when you execute it will not allow you to insert data and see the one row affected as well because

--	ii) Instead of Update Trigger

create trigger tr_emp_insteadOf_update
on tbl_employee
instead of update
as
begin
	print 'You are not allowed to update data in this table !!';
end

update tbl_employee set EmpName='Varun Desai' where Id=15

-- Note - when you execute it will not allow you to update data and see the one row affected as well because


--	iii) Instead of Delete Trigger

create trigger tr_emp_insteadOf_delete
on tbl_employee
instead of delete
as
begin
	print 'You are not allowed to delete data in this table !!';
end

delete from tbl_employee  where Id=15

-- Note - when you execute it will not allow you to delete data and see the one row affected as well because

-----------x------------------------x------------------------------x--------------------------------x---------------------------
-- ActivityLog table
-- Created new Activitylog table to view activity on insert,update,delete command
-- create table tbl_activityLog (Id int primary key identity(1,1), ActivityInfo varchar(MAX))
-- 1)
alter trigger tr_emp_insteadOf_insertActivityLog
on tbl_employee
instead of insert
as
begin
	insert into tbl_activityLog values('Someone tries to insert data in Employee Table at ' + CAST(GETDATE() as varchar(50)))
end

-- Note -[it will give error because instead triggers apply on one table so for that delete all trigger which is applied on this table]
-- drop trigger tr_emp_insteadOf_insert
-- Now this trigger has been created

insert into tbl_employee values('Sahil Patil',27,17000.49,9087789890)

--2)
create trigger tr_emp_insteadOf_updateActivityLog
on tbl_employee
instead of update
as
begin
	insert into tbl_activityLog values('Someone tries to update data in Employee Table at ' + CAST(GETDATE() as varchar(50)))
end

update tbl_employee set EmpName='Varun Desai' where Id=15

-- Note -[it will give error because instead triggers apply on one table so for that delete all trigger which is applied on this table]
-- drop trigger tr_emp_insteadOf_update
-- Now this trigger has been created
-- Note - when you execute it will not allow you to update data and see the one row affected as well because

--3)
create trigger tr_emp_insteadOf_deleteActivityLog
on tbl_employee
instead of delete
as
begin
	insert into tbl_activityLog values('Someone tries to delete data in Employee Table at ' + CAST(GETDATE() as varchar(50)))
end

delete from tbl_employee  where Id=15

-- Note -[it will give error because instead triggers apply on one table so for that delete all trigger which is applied on this table]
-- drop trigger tr_emp_insteadOf_delete
-- Now this trigger has been created
-- Note - when you execute it will not allow you to delete data and see the one row affected as well because


--			   [You cannot view trigger/SP when you using with encryption]
---------------Note - If you want to hide trigger/Stored Procedure from user then you can use [with encryption]----------------

---------------Note - If you want to unhide trigger/Stored Procedure from user then just remove [with encryption] from Triggers/SP----------------

--like

alter trigger tr_emp_insteadOf_deleteActivityLog
on tbl_employee
with encryption -- to decrypt just remove this line
instead of delete
as
begin
	insert into tbl_activityLog values('Someone tries to delete data in Employee Table at ' + CAST(GETDATE() as varchar(50)))
end

select * from tbl_ActivityLog


------------------------------x-----------------------------------x--------------------------------------------x-----------------------
------------------------------x-----------------------------------x--------------------------------------------x-----------------------

-- DDL Statement triggers -

--1) On table
create trigger tr_ddl_table
on database
for create_table, alter_table, drop_table
as 
begin
	print 'You have just CREATED, ALTERED, OR DOPED a Table';
end

create table tbl_sbc(id int)
alter table tbl_sbc alter column id bigint
drop table tbl_sbc

-- 2) On SP
create trigger tr_ddl_sp_create
on database
for create_procedure
as 
begin
	-- print 'You have just CREATED a new PROCEDURE';
	-- OR
	ROLLBACK
	print 'You are not allowed to create a stored procedure !!'
end

create procedure sp_abc
as
begin
print 'Hey this message from sp_abc procedure';
end

-- NOTE - for enable and disable trigger you can use like this -
disable trigger tr_ddl_sp_create on database 


