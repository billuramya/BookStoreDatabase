create table AdminDetails(
    AdminId int primary key identity(1,1),
	AdminName VARCHAR(max),
    Email VARCHAR(max),
    Password VARCHAR(100),
	)


	CREATE OR ALTER PROCEDURE InsertAdmin
  @AdminName VARCHAR(100),
    @Email VARCHAR(100),
    @Password VARCHAR(100)
AS
BEGIN
    BEGIN TRY
        INSERT INTO AdminDetails(AdminName,Email,Password)
        VALUES (@AdminName,@Email,@Password);
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

exec InsertAdmin 'Ramya','Ramya@gmail.com','Ramya@123'


--adminLogin 

CREATE OR ALTER proc AdminLogin
(
    @Email varchar(100),
	@Password VARCHAR(100)
)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        SELECT * FROM AdminDetails
        WHERE (Email=@Email and Password = @Password)
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
select * from AdminDetails