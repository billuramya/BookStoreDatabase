create table Users(
UserId int primary key identity(1,1),
	FullName VARCHAR(100),
    Email VARCHAR(100),
    Password VARCHAR(100),
    MobileNumber BIGINT)


---register

CREATE OR ALTER PROCEDURE InsertUser
    @FullName VARCHAR(100),
    @Email VARCHAR(100),
    @Password VARCHAR(100),
    @MobileNumber BIGINT
AS
BEGIN
    BEGIN TRY
        INSERT INTO Users (FullName, Email, Password, MobileNumber)
        VALUES (@FullName, @Email, @Password, @MobileNumber);
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

select * from Users
exec InsertUser 'Ramya','Ramya@gmail.com','Ramya@123',6304796656


--Getall users
CREATE OR ALTER PROCEDURE GetAllUser
AS
BEGIN
    BEGIN TRY
        SELECT UserId, FullName, Email, Password, MobileNumber
        FROM Users;
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


---Login method
CREATE OR ALTER PROCEDURE LoginUser
    @Email NVARCHAR(MAX),
    @Password NVARCHAR(MAX)
as
begin
    declare @Message VARCHAR(50);
    declare @StatusCode INT;
    declare @ErrorStatus BIT;

    if  exists (select  * from Users where Email = @Email AND Password = @Password)
    begin
        set @Message = 'User Login Successful';
        set @StatusCode = 200;
        set @ErrorStatus = 0;
    end
    else
    begin
        set @Message = 'Try to Login again. Check your email and password once.';
        set @StatusCode = 404;
        set @ErrorStatus = 1;
    end

    if @ErrorStatus = 0
    begin
        select @ErrorStatus as error_status, @Message as message, @StatusCode as statusCode;
    end
    else
    begin
        select @ErrorStatus as error_status, @Message as message, @StatusCode as statusCode;
    end
end;

exec LoginUser 'Ramya@gmail.com','Ramya@123'
