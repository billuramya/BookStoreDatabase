CREATE TABLE Cart (
    CartId INT IDENTITY(1,1) PRIMARY KEY,
    UserId INT NOT NULL,
    BookId INT NOT NULL,
    Quantity INT NOT NULL,
     FOREIGN KEY (UserId) REFERENCES Users(UserId),
    FOREIGN KEY (BookId) REFERENCES BookDetails(BookId)
);

--add cart

CREATE OR ALTER PROCEDURE spAddToCart
    @UserId INT,
    @Quantity INT,
    @BookId INT
AS
BEGIN
    BEGIN TRY
        INSERT INTO Cart(UserId,Quantity,BookId)
        VALUES (@UserId,@Quantity,@BookId);
    END TRY
    BEGIN CATCH
        
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

       
        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

       
        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;
exec spAddToCart 1,2,1 

--get all cart
CREATE OR ALTER PROCEDURE spGet_cart
    @UserId INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        b.BookId,
        b.Title,
        b.Author,
        b.OriginalPrice,
        b.DiscountPrice,
        b.Description,
        c.Quantity,
        b.Ratting,
        b.RatedPersons,
        b.Image
    FROM 
        Cart c
    INNER JOIN 
        BookDetails b ON c.BookId = b.BookId
    WHERE 
        c.UserId = @UserId;
END;
exec spGet_cart 1
select * from BookDetails
select * from Users
select * from Cart




alter proc spAddToCart
@UserId int,
@BookId int,
@Quantity int
as
begin
	if @UserId is null or @BookId is null
		begin
			print 'Error:BookId or UserdId not be null'
			return
		end
	if @Quantity<=0
	begin
		print 'Error: Quantity must be greater than 0.'
		return
	end
insert into Cart values(@Quantity,@UserId,@BookId)
end


create proc spDelete_cart
@UserId int,
@BookId int
as
begin
	if @UserId is null or @BookId is null
		begin
			print 'Error:BookId or UserdId not be null'
			return
		end
delete from Cart where UserId=@UserId and BookId=@BookId
end



alter proc spGet_cart
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
	
 SELECT 
        b.BookId,
        b.Title,
        b.Author,
        b.OriginalPrice,
        b.DiscountPrice,
        b.Description,
        c.Quantity,
        b.Ratting,
        b.RatedPersons,
        b.Image
    FROM 
        Cart c
    INNER JOIN 
        BookDetails b ON c.BookId = b.BookId
    WHERE 
        c.UserId = @UserId;
end


--delete cart
create proc spDelete_cart
@UserId int,
@BookId int
as
begin
	if @UserId is null or @BookId is null
		begin
			print 'Error:BookId or UserdId not be null'
			return
		end
delete from Cart where UserId=@UserId and BookId=@BookId
end


--update cart
create proc spUpdateQuantity
@Userid int,
@BookId int,
@Quantity int
as
begin
	if @UserId is null or @BookId is null
		begin
			print 'Error:BookId or UserdId not be null'
			return
		end
	if @Quantity<=0
	begin
		print 'Error: Quantity must be greater than 0.'
		return
	end
update Cart set Quantity=@Quantity where UserId=@UserId and BookId=@BookId
end

drop proc spUpdateQuantity 
drop proc spDelete_cart
select * from Users;
select * from Book;