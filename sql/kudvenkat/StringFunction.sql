use[Sample1]
go

select ASCII('a');

select char(65);

declare @start int;
set @start=97 
while(@start<=122)
begin
	print char(@start)
	set @start=@start+1
end

select LEFT('abc',1);
select right('abc',1);
select charindex('@','t@t.com');

select REPLICATE(2,3);

select  * from tblPeople;


select name,email,substring(email,1,3) + REPLICATE('*',4) + substring(email,CHARINDEX('@',email),len(email)-CHARINDEX('@',email)+1) as userEmail
from tblPeople

select name+space(4)+name from tblPeople;

select email, PATINDEX('%@example.com',email) as firstOccurence
from tblPeople
where PATINDEX('%@example.com',email)>0

---Replace
select email, REPLACE(email,'.com','.net') as  convertedEmail
from tblPeople;

select email,STUFF(email,2,3,'****') as StuffedEmail
from tblPeople;

SELECT STUFF('SQL Tutorial!', 13, 1, ' is fun!');

select len('SQL Tutorial!');