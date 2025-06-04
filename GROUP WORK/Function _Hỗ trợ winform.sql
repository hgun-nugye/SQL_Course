USE HotelManagement;
GO
CREATE TABLE DoanhThu
(
	MaHD VARCHAR(20) NOT NULL,
	MaLoaiHD VARCHAR(20) NOT NULL,
	NgayXuatHD DATE NOT NULL,
	TongTien DECIMAL(10, 2) NOT NULL,
	CONSTRAINT PK_DoanhThu PRIMARY KEY (MaHD, MaLoaiHD),
	CONSTRAINT FK_DoanhThu_HoaDon FOREIGN KEY (MaHD, MaLoaiHD) REFERENCES HoaDon(MaHD, MaLoaiHD) ON DELETE CASCADE
)

GO
--Tự động cập nhật Mã Khách hàng
CREATE FUNCTION dbo.GenerateMaKH()
RETURNS VARCHAR(20)
AS
BEGIN
    DECLARE @NewMaKH VARCHAR(20);
    DECLARE @MaxId INT;

    -- Lấy ID lớn nhất hiện có
    SELECT @MaxId = COALESCE(MAX(CAST(SUBSTRING(MaKH, 3, LEN(MaKH) - 2) AS INT)), 0)
    FROM KhachHang;

    -- Tạo mã mới
    SET @NewMaKH = 'KH' + RIGHT('000' + CAST(@MaxId + 1 AS VARCHAR(3)), 3);
    
    RETURN @NewMaKH;
END;
GO
--Tự động cập nhật Mã Hóa đơn
CREATE FUNCTION dbo.GenerateMaHD()
RETURNS VARCHAR(20)
AS
BEGIN
    DECLARE @NewMaHD VARCHAR(20);
    DECLARE @MaxId INT;

    -- Lấy ID lớn nhất hiện có
    SELECT @MaxId = COALESCE(MAX(CAST(SUBSTRING(MaHD, 3, LEN(MaHD) - 2) AS INT)), 0)
    FROM HoaDon;

    -- Tạo mã mới
    SET @NewMaHD = 'HD' + RIGHT('000' + CAST(@MaxId + 1 AS VARCHAR(3)), 3);
    
    RETURN @NewMaHD;
END;
GO
--Tự động cập nhật Mã Chi tiết Hóa đơn
CREATE FUNCTION dbo.GenerateMaCTHD()
RETURNS VARCHAR(20)
AS
BEGIN
    DECLARE @NewMaCTHD VARCHAR(20);
    DECLARE @MaxId INT;

    -- Lấy ID lớn nhất hiện có
    SELECT @MaxId = COALESCE(MAX(CAST(SUBSTRING(MaCTHD, 6, LEN(MaCTHD) - 5) AS INT)), 0)
    FROM CTHD;

    -- Tạo mã mới
    SET @NewMaCTHD = 'CTHD' + RIGHT('000' + CAST(@MaxId + 1 AS VARCHAR(3)), 3);
    
    RETURN @NewMaCTHD;
END;
GO
--Tự động cập nhật Mã Hóa đơn Phòng
CREATE FUNCTION dbo.GenerateMaHDP()
RETURNS VARCHAR(20)
AS
BEGIN
    DECLARE @NewMaHDP VARCHAR(20);
    DECLARE @MaxId INT;

    -- Lấy ID lớn nhất hiện có
    SELECT @MaxId = COALESCE(MAX(CAST(SUBSTRING(MaHDP, 5, LEN(MaHDP) - 4) AS INT)), 0)
    FROM HoaDonPhong;

    -- Tạo mã mới
    SET @NewMaHDP = 'HDP' + RIGHT('000' + CAST(@MaxId + 1 AS VARCHAR(3)), 3);
    
    RETURN @NewMaHDP;
END;
GO
--Tự động cập nhật Mã Hóa đơn Món
CREATE FUNCTION dbo.GenerateMaHDM()
RETURNS VARCHAR(20)
AS
BEGIN
    DECLARE @NewMaHDM VARCHAR(20);
    DECLARE @MaxId INT;

    -- Lấy ID lớn nhất hiện có
    SELECT @MaxId = COALESCE(MAX(CAST(SUBSTRING(MaHDM, 5, LEN(MaHDM) - 4) AS INT)), 0)
    FROM HoaDonMon;

    -- Tạo mã mới
    SET @NewMaHDM = 'HDM' + RIGHT('000' + CAST(@MaxId + 1 AS VARCHAR(3)), 3);
    
    RETURN @NewMaHDM;
END;
GO
--Tự động cập nhật Mã Hóa đơn Dịch vụ
CREATE FUNCTION dbo.GenerateMaHDDV()
RETURNS VARCHAR(20)
AS
BEGIN
    DECLARE @NewMaHDDV VARCHAR(20);
    DECLARE @MaxId INT;

    -- Lấy ID lớn nhất hiện có
    SELECT @MaxId = COALESCE(MAX(CAST(SUBSTRING(MaHDDV, 6, LEN(MaHDDV) - 5) AS INT)), 0)
    FROM HoaDonDV;

    -- Tạo mã mới
    SET @NewMaHDDV = 'HDDV' + RIGHT('000' + CAST(@MaxId + 1 AS VARCHAR(3)), 3);
    
    RETURN @NewMaHDDV;
END;
GO
----Tự động cập nhật Mã CTHDP
CREATE FUNCTION dbo.GenerateMaCTHDP()
RETURNS VARCHAR(20)
AS
BEGIN
    DECLARE @NewMaCTHDP VARCHAR(20);
    DECLARE @MaxId INT;

    -- Lấy ID lớn nhất hiện có
    SELECT @MaxId = COALESCE(MAX(CAST(SUBSTRING(MaCTHDP, 6, LEN(MaCTHDP) - 5) AS INT)), 0)
    FROM CTHDPhong;

    -- Tạo mã mới
    SET @NewMaCTHDP = 'CTHDP' + RIGHT('000' + CAST(@MaxId + 1 AS VARCHAR(3)), 3);
    
    RETURN @NewMaCTHDP;
END;
GO
----Tự động cập nhật Mã CTHDM
CREATE FUNCTION dbo.GenerateMaCTHDM()
RETURNS VARCHAR(20)
AS
BEGIN
    DECLARE @NewMaCTHDM VARCHAR(20);
    DECLARE @MaxId INT;

    SELECT @MaxId = COALESCE(MAX(CAST(SUBSTRING(MaCTHDM, 6, LEN(MaCTHDM) - 5) AS INT)), 0)
    FROM CTHDMon;

    SET @NewMaCTHDM = 'CTHDM' + RIGHT('000' + CAST(@MaxId + 1 AS VARCHAR(3)), 3);
    
    RETURN @NewMaCTHDM;
END;
GO
----Tự động cập nhật Mã CTHDDV
CREATE FUNCTION dbo.GenerateMaCTHDDV()
RETURNS VARCHAR(20)
AS
BEGIN
    DECLARE @NewMaCTHDDV VARCHAR(20);
    DECLARE @MaxId INT;

    SELECT @MaxId = COALESCE(MAX(CAST(SUBSTRING(MaCTHDDV, 6, LEN(MaCTHDDV) - 5) AS INT)), 0)
    FROM CTHDDichVu;

    SET @NewMaCTHDDV = 'CTHDDV' + RIGHT('000' + CAST(@MaxId + 1 AS VARCHAR(3)), 3);
    
    RETURN @NewMaCTHDDV;
END;

