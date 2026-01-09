-- Merge Statement
-- We need Source Table and Target table
/*
Syntax -

	merge Target_Table as T
	using Source_Table as S

	on  [Join Condition]

	when matched then
		[update statement]
	when not matched by target then
		[insert statement]
	when not matched by source then
		[delete statement]

*/

create table tbl_source(Id int primary key identity, Name varchar(100), Gender varchar(10))
create table tbl_target(Id int primary key identity, Name varchar(100), Gender varchar(10))

insert into tbl_source values('Akshay','Male'),
('Vivek','Male'),
('Sai','Female'),
('Hruta','Female')

insert into tbl_source values('Arjun','Male'),
('Vivek','Male'),
('Sai','Female'),
('Rutuja','Female')


merge tbl_target as T
	using tbl_source as S

	on  T.Id = S.Id

	when matched then
		update set T.Name = S.Name, T.Gender = S.Gender
	when not matched by target then
		insert (name,gender) values(S.Name,S.Gender)
	when not matched by source then
		Delete;

		select * from tbl_source
		select * from tbl_target

-- IF You dont want to delete data from target table if it is not exist in source then just remove delete freom merge statement

merge tbl_target as T
	using tbl_source as S

	on  T.Id = S.Id

	when matched then
		update set T.Name = S.Name, T.Gender = S.Gender
	when not matched by target then
		insert (name,gender) values(S.Name,S.Gender);