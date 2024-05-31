create table UserAddress(
Id int identity(1,1) primary key,
FullAddress nvarchar(max),
City nvarchar(max),
State nvarchar(max),
Type varchar(50),
UserId int Foreign key references  Users(UserId))

---add Adress
exec spAddAddress 1,'H.No 1-22 Tirupathi','Chitttor','Andhra pradesh','Home'
CREATE PROCEDURE spAddAddress
    @UserId BIGINT,
    @FullAddress NVARCHAR(MAX),
    @City NVARCHAR(MAX),
    @State NVARCHAR(MAX),
    @Type VARCHAR(50)
AS
BEGIN
    INSERT INTO UserAddress (FullAddress, City, State, UserId, Type)
    VALUES (@FullAddress, @City, @State, @UserId, @Type);
END;

--get all data
create proc spGetAddress
@UserId int
as
begin
select * from UserAddress where UserId=@UserId
end;

alter proc spUpdateAddress
@UserId int,
@AdId int,
@FullAddress nvarchar(max),
@City nvarchar(max),
@State nvarchar(max),
@Type varchar(50)
as
begin
update UserAddress set FullAddress=@FullAddress,City=@City,State=@State,Type=@Type where UserId=@UserId and Id=@AdId
end;
