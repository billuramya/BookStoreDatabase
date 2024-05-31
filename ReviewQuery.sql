create table Review(Id bigint identity(1,1) primary key,
Review varchar(max) not null,
Stats int,
BookId int Foreign Key references BookDetails(BookId),
UserId int Foreign Key references Users(UserId))


--add Review
alter procedure spAddReview
@UserId bigint,
@BookId int,
@Review varchar(max),
@Stars int
as
begin
    -- Check if Stars is within valid range
    if @Stars between 1 and 5
    begin
        -- Insert the review into the Review table
        insert into Review(Review,Stars,BookId,UserId) values(@Review,@Stars,@BookId,@UserId)
        select 'Review added successfully.' as Status
    end
    else
    begin
        -- Stars value is outside the valid range, raise an error or handle accordingly
        select 'Stars value should be between 1 and 5.' as Error
    end
end

exec spAddReview 1,1,'Nice BOOk',3

-- get all reviews
create proc GetReviewsForBook
@BookId int
as
begin
if not exists (select 1 from BookDetails where BookId = @BookId)
    begin
        print 'Invalid BookId.'
        return;
    end

    -- Check if there are any reviews available for the given book
    if not exists (select 1 from Review where BookId = @BookId)
    begin
        print 'No reviews available for the given book.'
        return;
    end
select r.Review,r.Stars,u.FullName
from Users u inner join Review r on u.UserId=r.UserId
where r.BookId=@BookId
end;

--delete review 

create proc spDeleteReview
@UserId int,
@BookId int
as
begin
	if @UserId is null or @BookId is null
		begin
			print 'Error:BookId or UserdId not be null'
			return
		end
delete from Review where UserId=@UserId and BookId=@BookId
end