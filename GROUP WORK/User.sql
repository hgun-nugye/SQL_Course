USE HotelManagement
GO

--1. Tạo người dùng và cấp quyền truy cập dữ liệu
	--Tạo login
CREATE LOGIN Customer 
WITH PASSWORD = '123',
CHECK_POLICY = OFF, CHECK_EXPIRATION = OFF,
DEFAULT_DATABASE = HotelManagement;

	--Tạo User
USE HotelManagement;
GO
CREATE USER Customer FOR LOGIN Customer;

	--Cấp quyền truy cập
USE HotelManagement;
GO
GRANT SELECT, INSERT, DELETE
ON KhachHang TO Customer;
 
 --2. Tạo người dùng và cấp quyền quản trị dữ liệu
	 -- Tạo Login
CREATE LOGIN Reception
WITH PASSWORD = '1234',
CHECK_POLICY = OFF, CHECK_EXPIRATION = OFF,
DEFAULT_DATABASE = HotelManagement;

	-- Tạo User
USE HotelManagement;
CREATE USER Reception FOR LOGIN Reception;

	-- Tạo Database Role
CREATE ROLE HotelAppRole;

	-- Cấp quyền cho tất cả các bảng
GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::dbo TO HotelAppRole; 

	-- Thêm người dùng cho các Role
ALTER ROLE HotelAppRole ADD MEMBER Reception; 

--3. Tạo người dùng và cấp quyền quản lý người dùng
	-- Tạo Login
CREATE LOGIN Manager
WITH PASSWORD = '12345',
CHECK_POLICY = OFF, CHECK_EXPIRATION = OFF,
DEFAULT_DATABASE = HotelManagement;

	-- Tạo User
USE HotelManagement;
CREATE USER Manager FOR LOGIN Manager;

	-- Cấp quyền cụ thể cho User
-- Cấp quyền tạo bảng cho User
GRANT CREATE TABLE TO Manager;
GO
-- Cấp quyền tạo mới User
GRANT CREATE USER TO Manager;
GO
-- Cấp quyền sửa User
GRANT ALTER ANY USER TO Manager;
GO
-- Cấp quyền tạo Role
GRANT CREATE ROLE TO Manager;
GO
-- Cấp quyền sửa Role
GRANT ALTER ANY ROLE TO Manager;
GO
-- Cấp quyền để cấp hoặc thu hồi quyền
GRANT ALTER ON SCHEMA::dbo TO Manager WITH GRANT OPTION;
GRANT SELECT ON SCHEMA::dbo TO Manager WITH GRANT OPTION;
GRANT INSERT ON SCHEMA::dbo TO Manager WITH GRANT OPTION;
GRANT UPDATE ON SCHEMA::dbo TO Manager WITH GRANT OPTION;
GRANT DELETE ON SCHEMA::dbo TO Manager WITH GRANT OPTION;
