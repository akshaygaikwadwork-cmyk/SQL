-- Note - when we using string function then we loss our column name in output you need to use alise [as]

--1) ASCII
select ASCII('A')
select ASCII('Z')
select ASCII('z')
select ASCII('a')
select ASCII(';')

--2) Character

select CHAR(65)

-- for print from A to Z -
declare @start int 
set @start = 65
while(@start <= 90)
begin
	print CHAR(@start);
	set @start = @start + 1;
end

-- for print from a to z -
declare @start1 int 
set @start1 = 97
while(@start1 <= 122)
begin
	print CHAR(@start1);
	set @start1 = @start1 + 1;
end

-- for print from 0 to 9 -
declare @start2 int 
set @start2 = 48
while(@start2 <= 57)
begin
	print CHAR(@start2);
	set @start2 = @start2 + 1;
end

--3) LTRIM (Left Trim - Remove left side space)
--Before Using LTRIM
select '             hi     '
--After Using LTRIM
select LTRIM('             hi     ')


--3) RTRIM (Right Trim - Remove right side space)
--Before Using RTRIM
select '             hi     '
--After Using RTRIM
select RTRIM('             hi     ')


-- Note - when we using string function then we loss our column name in output you need to use alise [as]

--4) UPPER
--Before use UPPER
select 'hi this is upper function for capital letter all text'
--After use UPPER
select UPPER('hi this is upper function for capital letter all text')


--5) LOWER
--Before use LOWER
select 'hi this is lower function for small letter all text'
--After use LOWER
select UPPER('hi this is lower function for small letter all text')

--6) REVERSE
--Before use REVERSE
select 'hey welcome'
--After use REVERSE
select REVERSE('hey welcome')

--7) LENGTH
--Before use LENGTH
select 'hey welcome'
--After use LENGTH
select LEN('hey welcome')

