create table tbl_guidIdTable (Id UniqueIdentifier primary key default NEWID(), description varchar(100) )

insert into tbl_guidIdTable values(default,'Hey welcome to GUID table'),
(default,'Good to go'),
(default,'Nice to meet you');

select * from tbl_guidIdTable order by id desc

-- Data insert into two different database tables in one single table in primary key column 

--INSERT INTO Students1
--SELECT * FROM EngDB.dbo.EnglishStudents1
--UNION ALL
--SELECT * FROM MathDB.dbo.MathStudents1

--Note - 
-- You can see that using GUID, we are able to insert a union of records from two different databases into a 
-- new table without any “Violation of PRIMARY KEY constraint” error.
