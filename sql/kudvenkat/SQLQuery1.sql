use [Sample1]
go

create table tblGender(
ID int not null primary key,
Gender varchar(20) not null
)

select * from tblperson;
select * from tblGender;

/* Forign key*/

ALTER TABLE tblPerson
ADD CONSTRAINT tblPerson_genderID_fk
FOREIGN KEY (GenderID) REFERENCES tblGender(ID);