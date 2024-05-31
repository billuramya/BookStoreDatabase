create table WishList(
UserId int foreign key references Users(UserId),
BookId int foreign key references BookDetails(BookId)
)

drop table WishList
insert into WishList values(1,1)

--add values to wishlist
alter proc spAddtowhishlist
@UserId int,
@BookId int
as
begin
	if @UserId is null or @BookId is null
		begin
			print 'Error:BookId or UserdId not be null'
			return
		end
insert into WishList values(@UserId,@BookId)
end;
exec spAddtowhishlist 1,1
select * from WishList

--get all wishlist details

alter proc spGetWhishlist
@UserId int
as
begin
	if @UserId is null
    begin
        print 'Error: UserId cannot be NULL.';
        return; 
    end

    -- Check if the UserId exists in the Users table (assuming there's a Users table)
    if not exists (select 1 from Users where UserId = @UserId)
    begin
        print 'Error: UserId does not exist.';
        return; -- Exit the procedure
    end
select b.BookId,
        b.Title,
        b.Author,
        b.OriginalPrice,
        b.DiscountPrice,
        b.Description,
        b.Quantity,
        b.Ratting,
        b.RatedPersons,
        b.Image
from BookDetails b inner join WishList w on b.BookId=w.BookId where w.UserId=@UserId
end;
exec spGetWhishlist 1

select * from BookDetails
--delete wishlist
create proc spDeleteWhishlist
@UserId int,
@BookId int
as
begin
	if @UserId is null or @BookId is null
		begin
			print 'Error:BookId or UserdId not be null'
			return
		end
delete from WishList where UserId=@UserId and BookId=@BookId
end