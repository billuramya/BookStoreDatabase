create table Orders(
OrderId int primary key identity(1,1),
Quantity int not null,
BookId int foreign key references BookDetails(BookId),
UserId int foreign key references Users(UserId)
)


create proc spGetOrders
@UserId int
as
begin
select b.BookId,b.Title,b.Price,b.Author,b.Description,O.Quantity,b.Image
from Orders O inner join Book B on O.BookId=B.BookId where O.UserId=@UserId
end;

create proc spAddOrder
@UserId int,
@BookId int,
@Quantity int
as
begin
	if @Quantity<=0
	begin
		print 'Error: Quantity must be greater than 0.'
		return
	end
insert into Orders values(@Quantity,@BookId,@UserId)
end;

