create table BookDetails(
    BookId int primary key identity(1,1),
	Title VARCHAR(max),
    Author VARCHAR(max),
    Description VARCHAR(100),
	OriginalPrice bigint ,
	DiscountPrice bigint,
	Ratting decimal(2,1),
	RatedPersons int,
	Quantity int,
	Image nvarchar(max))

--insert the books
CREATE OR ALTER PROCEDURE InsertBook
   @Title VARCHAR(max),
    @Author VARCHAR(max),
    @Description VARCHAR(100),
	@OriginalPrice bigint ,
	@DiscountPrice bigint,
	@Ratting decimal(2,1),
	@RatedPersons int,
	@Quantity int,
	@Image nvarchar(max)
AS
BEGIN
    BEGIN TRY
        INSERT INTO BookDetails(Title,Author,Description,OriginalPrice,DiscountPrice,Ratting,RatedPersons,Quantity,Image)
        VALUES (@Title,@Author,@Description,@OriginalPrice,@DiscountPrice,@Ratting,@RatedPersons,@Quantity,@Image);
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

--get All Books
CREATE OR ALTER PROCEDURE GetAllBooks
AS
BEGIN
    BEGIN TRY
        SELECT BookId, Title,Author,Description,OriginalPrice,DiscountPrice,Ratting,RatedPersons,Quantity,Image
        FROM BookDetails;
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


--get by Book By Title
CREATE OR ALTER proc GetBookByTitle
(
    @Title NVARCHAR(255)
)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        SELECT * FROM BookDetails
        WHERE Title = @Title;
    END TRY
    BEGIN CATCH
        -- Error handling code
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END

EXEC GetBookByTitle @Title = 'Don''t Make Me Think';



--update

CREATE OR ALTER proc UpdateBook
(@BookId int,
   @Title VARCHAR(max),
    @Author VARCHAR(max),
    @Description VARCHAR(100),
	@OriginalPrice bigint ,
	@DiscountPrice bigint,
	@Ratting decimal(2,1),
	@RatedPersons int,
	@Quantity int,
	@Image nvarchar(max)
)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        update BookDetails
		set Title=@Title,
		Author=@Author ,
    Description=@Description ,
	OriginalPrice=@OriginalPrice  ,
	DiscountPrice=@DiscountPrice,
	Ratting=@Ratting,
	RatedPersons=@RatedPersons,
	Quantity=@Quantity,
	Image=@Image
	where BookId=@BookId
    END TRY
    BEGIN CATCH
        -- Error handling code
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END




--Deleteby Id
CREATE OR ALTER proc DeleteById
(
    @BookId int
)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        Delete from BookDetails where BookId=@BookId
    END TRY
    BEGIN CATCH
        -- Error handling code
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END

exec DeleteById 2


--get book by Id
CREATE OR ALTER proc GetBookById
(
    @BookId int
)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        SELECT * FROM BookDetails
        WHERE BookId=@BookId
    END TRY
    BEGIN CATCH
        -- Error handling code
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END

exec GetAllBooks
select * from BookDetails



CREATE OR ALTER PROCEDURE countBooks
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
        COUNT(*) AS BookCount, 
        b.Ratting,
        b.RatedPersons,
        b.Image
    FROM 
        Cart c
    INNER JOIN 
        BookDetails b ON c.BookId = b.BookId
    INNER JOIN 
        Orders o ON b.BookId = o.BookId
    WHERE 
        c.UserId = @UserId
    GROUP BY 
        b.BookId,
        b.Title,
        b.Author,
        b.OriginalPrice,
        b.DiscountPrice,
        b.Description,
        b.Ratting,
        b.RatedPersons,
        b.Image;
END;



CREATE OR ALTER PROCEDURE countBooks


    @BookId INT
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
        COUNT(*) AS BookCount,
        b.Ratting,
        b.RatedPersons,
        b.Image
    FROM 
        Cart c
    INNER JOIN 
        BookDetails b ON c.BookId = b.BookId
    INNER JOIN 
        Orders o ON b.BookId = o.BookId
    WHERE 
        c.BookId = @BookId
    GROUP BY 
        b.BookId,
        b.Title,
        b.Author,
        b.OriginalPrice,
        b.DiscountPrice,
        b.Description,
        b.Ratting,
        b.RatedPersons,
        b.Image;
END; 

select * from Orders
exec countBooks 1

CREATE OR ALTER proc GetBookByTtle
(
    @Title NVARCHAR(255)
)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        SELECT * FROM BookDetails
        WHERE Title = @Title;
    END TRY
    BEGIN CATCH
        -- Error handling code
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END



Alter PROCEDURE countBooks
    @UserId INT
AS
BEGIN
    SELECT 
        bd.BookId,
        bd.Title,
        bd.Author,
        bd.Description,
        bd.OriginalPrice,
        bd.DiscountPrice,
        bd.Ratting,
        bd.RatedPersons,
        bd.Quantity,
        bd.Image,
        COUNT(*) AS BookCount
    FROM 
        BookDetails bd
    INNER JOIN 
        Cart c ON bd.BookId = c.BookId
    INNER JOIN 
        Orders o ON bd.BookId = o.BookId
    WHERE 
        c.UserId = @UserId
        AND o.UserId = @UserId
    GROUP BY 
        bd.BookId,
        bd.Title,
        bd.Author,
        bd.Description,
        bd.OriginalPrice,
        bd.DiscountPrice,
        bd.Ratting,
        bd.RatedPersons,
        bd.Quantity,
        bd.Image;
END
exec  countBooks 1