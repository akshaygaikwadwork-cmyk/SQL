-- TCL ( Transfer Control Language ) - 
-- 1) COMMIT
-- 2) ROLLBACK 
-- 3) SAVEPOINT

------------------------- Implicit Transaction [Software doing by own self] ---------------
select * from tbl_employee;

update tbl_employee set EmpName='Ganya' where Id=1;

-------------------------- Explicit Transaction - [You need to do everything] ----------------
-- Begin Transaction
select * from tbl_employee;

begin transaction
update tbl_employee set EmpName='Ganya' where Id=1;
delete from tbl_employee where Id=7;

rollback transaction; -- undo

commit transaction; -- permanent save in table

/*
Defining Transaction: A Logical unit of work must exhibit four properties, 
called the atomicity, consistency, isolation, and durability(ACID) properties, 
to qualify transaction.

1) Atomicity: If the transaction has many operations then all should be committed. It means ALL or NONE. It manages by Transaction Manager. Example of 2 accounts. A —- B
Ex- 1) If we withrawing money from atm if failed from machine it will automatically failed all transaction it will  not give money to next user 
 2) If we are transafering money online through then some time we get some network issue that's why transafer get failed then it will automatically failed all transaction

2) Consistency: The sequence of operations must be consistent.
A = 3000, B = 4000 = 7000 – before transaction
A = 3000 – 1000 = 2000
B = 4000 + 1000 = 5000

3) Isolation: The operations that are performed must be isolated from the other operations on the same server or on the same database. It means each transaction must be executed without knowing what is happening to other transactions.

4) Durability: The operations that are performed on the database must be saved and stored in the database permanently.

Note- When a transaction is started on a connection, all TransactSQL statements are executed on the same connection and are a part of the connection until the transaction ends.
Transactions are managed at the connection level.


-- You can check begin transction update/insert/deleted data into another connection./ new page as well with select query :-
Setting the isolaton level to read uncommited by default its read commited.
SYNTAX: SET TRANSACTION ISOLATION LEVEL READ UNCOMMITED.

*/