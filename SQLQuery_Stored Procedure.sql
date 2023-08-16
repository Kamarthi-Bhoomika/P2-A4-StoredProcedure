create database Assignment04Db
use Assignment04Db

drop table Products

create table Products
(PId int primary key identity(500,1),
PName nvarchar(50) not null,
PPrice float,
PTax as PPrice*0.10 persisted,
PCompany nvarchar(50),
PQty int check(PQty >= 1) default 10,
constraint PCompany check(PCompany in('Samsung','Apple','Redmi','HTC','RealMe','Xiaomi'))
)

insert into Products(PName,PPrice,PCompany,PQty) values('SmartPhone',50000,'Samsung',5)
insert into Products(PName,PPrice,PCompany,PQty) values('MAC Book',340000,'Apple',15)
insert into Products(PName,PPrice,PCompany,PQty) values('EarPhones',34000,'Redmi',8)
insert into Products(PName,PPrice,PCompany,PQty) values('SmartPhone',34000,'HTC',3)
insert into Products(PName,PPrice,PCompany) values('SmartPhone',34000,'RealMe')
insert into Products(PName,PPrice,PCompany,PQty) values('TV',34000,'Xiaomi',12)
insert into Products(PName,PPrice,PCompany,PQty) values('Washing Machine',34000,'Samsung',25)
insert into Products(PName,PPrice,PCompany,PQty) values('Laptop',34000,'Samsung',5)
insert into Products(PName,PPrice,PCompany,PQty) values('Tablet',34000,'Xiaomi',15)
insert into Products(PName,PPrice,PCompany) values('IPad',34000,'Apple')

select * from Products

drop proc details

create proc details
with encryption
as
select PId, PName, PPrice+PTax 'PPriceWithTax',
PCompany,PQty*(PPrice+PTax) as 'TotalPrice' from Products

exec details

drop proc TotalCompanyTax

create proc TotalCompanyTax
@pcompany nvarchar(50),
@totaltax float output
with encryption
as
select @totaltax = sum(PTax) from Products where PCompany =@pcompany

declare @companyTotalTax float
execute TotalCompanyTax 'Apple',@companyTotalTax output
print @companyTotalTax
