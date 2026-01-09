-- Try Catch Block
-- Note - Check error message in message not in results
-- 1)
begin try
--select 20/5
select 10/0;
select * from product_sales -- it will not execute because before that error will occur then it will go in catch block
end try

begin catch
	print 'you cannot divide a number by zero' 
end catch

-- 2)
select * from product_sales
-- If you update empAge with varchar then it will give error then try catch will handle and it will show custom message

begin try
update product_sales set prod_Quantity = 'soap' where prod_Id=1
end try

begin catch
	print 'You cannot insert/update prod_Quantity with string value you need to insert/update integer value'
end catch

-- 3)

begin try
update product_sales set prod_Quantity = 'abc' where prod_Id=1
end try

begin catch
	
	select Error_number() as [Error Number],
	ERROR_SEVERITY() as [Error Severity],
	ERROR_STATE() as [Error State Number],
	ERROR_PROCEDURE() as [Stored Procedure Name], -- it will show null next example you can see for get value you need to create SP 
	ERROR_LINE() as [Error on Line],
	ERROR_MESSAGE() as [Error Message]

end catch

-- 4) Exception handling with SP Name

create proc MyProc_WithExcHand1
as
begin
begin try
update product_sales set prod_Quantity = 'abc' where prod_Id=1
end try

begin catch
	
	select Error_number() as [Error Number],
	ERROR_SEVERITY() as [Error Severity],
	ERROR_STATE() as [Error State Number],
	ERROR_PROCEDURE() as [Stored Procedure Name], 
	ERROR_LINE() as [Error on Line],
	ERROR_MESSAGE() as [Error Message]

end catch
end

exec MyProc_WithExcHand1


-----------------------x----------------------------------x------------------------------x
--								 Transaction With Try Catch
-----------------------x----------------------------------x------------------------------x
select * from product_sales

-- Transaction With Try Catch

begin try

begin transaction
	
	insert into product_sales values('Fan',2,14000.89)
	insert into product_sales values('TV',3,120000.79)
	insert into product_sales values('Mobile',5,'abc')

	commit transaction -- permanent data save
	print 'Transaction Successfully Done!!!'

end try

begin catch

	rollback transaction
	print 'Transaction Failed'
	select ERROR_MESSAGE() as [Error Message]

end catch

select * from product_sales