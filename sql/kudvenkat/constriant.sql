use [Sample1] 
go

select * from tblGender;

select * from tblPerson;

insert into tblGender (ID,Gender) values(3,'Unknow');

alter table tblPerson add constraint DF_tblPerson_GenderId
default 3 for GenderId;

insert into tblPerson(ID,Name,Email,GenderId,age) values(4,'Ramya','k@k.com',2,25);

alter table tblPerson add age int not null
constraint DF_tblPerson_age default 20;

alter table tblPerson add constraint DF_tblPerson_age default 20 for age;

alter table tblPerson
drop constraint DF_tblPerson_age;

delete from tblGender where ID=3;
delete from tblPerson where ID=4;


alter table tblPerson
add constraint CK_tblPerson_Age check (age >0 and age <150)

alter table tblPerson
add constraint UQ_tblPerson_Email unique (email);

delete from tblPerson where Id=4;

select * from tblPerson where Email LIKE '[JK]%';

select top 1 * from tblPerson;
select top 1 percent * from tblPerson;