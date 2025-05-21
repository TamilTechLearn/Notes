use [Sample1]
go



create proc spGetEmployeeByGenderAndDepartment
@Gender nvarchar(20),
@DepartmentID int
as
begin
	select a.name,a.gender,a.departmentId from tblEmployee a
	where a.gender=@Gender and a.departmentId=@DepartmentID
end

spGetEmployeeByGenderAndDepartment 'Male' ,101;

spGetEmployeeByGenderAndDepartment @DepartmentID=102 ,@Gender='Male';

sp_helptext spGetEmployeeByGenderAndDepartment;

---alter store procedure
alter proc spGetEmployeeByGenderAndDepartment
@Gender nvarchar(20),
@DepartmentID int
as
begin
	select a.name,a.gender,a.departmentId from tblEmployee a
	where a.gender=@Gender and a.departmentId=@DepartmentID
	order by a.name
end

---output store procedure


create procedure spGetEmployeeCoutnByGender
@Gender nvarchar(20),
@EmployeeCount int output
as
begin
	select @EmployeeCount=COUNT(ID) 
	from tblEmployee where gender =@Gender;
end

declare @TotalCount int
exec spGetEmployeeCoutnByGender 'Male', @TotalCount output
print @TotalCount;


declare @TotalCount int
exec spGetEmployeeCoutnByGender @Gender='Male', @EmployeeCount=@TotalCount out
print @TotalCount;

sp_help spGetEmployeeCoutnByGender;

sp_helptext spGetEmployeeCoutnByGender;

sp_depends spGetEmployeeCoutnByGender;


--- return valuesof store procedure
select * from tblEmployee;

alter procedure spGetNameByID
@id int
as 
begin
	Return (select [name] from tblEmployee where id=@id)
end;

declare @EmployeeName nvarchar(20)
execute @EmployeeName = spGetNameByID 1
print @EmployeeName

select [name] from tblEmployee where id=1