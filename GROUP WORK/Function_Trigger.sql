USE HotelManagement
GO
--FUNCTION
	--1. Hàm lọc nhân viên trên 40 tuổi
CREATE FUNCTION dbo.LocNhanVienTren40Tuoi()
RETURNS TABLE
AS
RETURN 
(
    SELECT MaNV, HoTen, NgaySinh, GioiTinh, ChucVu
    FROM NhanVien
    WHERE DATEDIFF(YEAR, NgaySinh, GETDATE()) > 40
);

SELECT * FROM dbo.LocNhanVienTren40Tuoi();

	--2. Hàm lấy thông tin khách hàng
CREATE FUNCTION fn_LayThongTinKhachHang
(
    @MaKH NVARCHAR(20)
)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        KH.HoTen,
        KH.SDT_KH,
        KH.Email_KH,
        COUNT(DISTINCT HDP.MaHDP) AS SoLanDatPhong,
        COUNT(DISTINCT HDM.MaHDM) AS SoLanGoiMon,
        COUNT(DISTINCT HDDV.MaHDDV) AS SoLanDungDichVu
    FROM KhachHang KH
    LEFT JOIN HoaDonPhong HDP ON KH.MaKH = HDP.MaKH
    LEFT JOIN HoaDonMon HDM ON KH.MaKH = HDM.MaKH
    LEFT JOIN HoaDonDV HDDV ON KH.MaKH = HDDV.MaKH
    WHERE KH.MaKH = @MaKH
    GROUP BY KH.HoTen, KH.SDT_KH, KH.Email_KH
);

select * from fn_LayThongTinKhachHang('KH001');

	--3. Hàm tìm tổng chi tiêu của khách hàng theo mã khách hàng
CREATE FUNCTION fn_TongChiTieuKhachHang (@MaKH NVARCHAR(20))
RETURNS DECIMAL(18,2)
AS
BEGIN
    DECLARE @TongChiTieu DECIMAL(18,2) = 0;

    SELECT @TongChiTieu = 
        ISNULL(SUM(
            ISNULL(DATEDIFF(DAY, ctp.NgayNhan, ctp.NgayTra) * p.GiaMacDinh, 0) +
            ISNULL(ctm.SL_Mon * m.GiaMon, 0) +
            ISNULL(ctdv.SL_DV * dv.GiaDV, 0)
        ), 0)
    FROM HoaDon hd
    LEFT JOIN CTHD cthd ON hd.MaHD = cthd.MaHD
    LEFT JOIN CTHDPhong ctp ON cthd.MaLoaiCTHD = ctp.MaCTHDP
    LEFT JOIN Phong p ON ctp.MaP = p.MaP
    LEFT JOIN CTHDMon ctm ON cthd.MaLoaiCTHD = ctm.MaCTHDM
    LEFT JOIN Mon m ON ctm.MaMon = m.MaMon
    LEFT JOIN CTHDDichVu ctdv ON cthd.MaLoaiCTHD = ctdv.MaCTHDDV
    LEFT JOIN DichVu dv ON ctdv.MaDV = dv.MaDV
    WHERE hd.MaKH = @MaKH;

    RETURN @TongChiTieu;
END;

select dbo.fn_TongChiTieuKhachHang ('KH009') as TongChiTieu;
select * from HoaDonPhong

	--4. Hàm tính Tổng lương của Nhân viên
CREATE FUNCTION dbo.TinhTongLuong(@MaNV VARCHAR(20))
RETURNS DECIMAL(18, 2)
AS
BEGIN
    DECLARE @TongLuong DECIMAL(18, 2);
    
    SELECT @TongLuong = SUM(MucLuong + ISNULL(Thuong, 0) - ISNULL(Phat, 0) + ISNULL(PhuCap, 0)
                            )
    FROM Luong
    WHERE MaNV = @MaNV;

    RETURN ISNULL(@TongLuong, 0);
END;

SELECT dbo.TinhTongLuong('NV001') AS TongLuongNV;

	--5. Hàm tính tổng doanh thu của tháng bất kì
CREATE FUNCTION fn_DoanhThuThang (
    @Month INT,
    @Year INT
)
RETURNS DECIMAL(12, 2)
AS
BEGIN
    DECLARE @TongDoanhThu DECIMAL(12, 2);

    -- Doanh thu phòng
    SELECT @TongDoanhThu = ISNULL((
        SELECT SUM(DATEDIFF(day, cthdp.NgayNhan, cthdp.NgayTra) * p.GiaMacDinh)
        FROM CTHDPhong cthdp
        JOIN Phong p ON cthdp.MaP = p.MaP
        JOIN HoaDonPhong hdp ON cthdp.MaHDP = hdp.MaHDP
		JOIN HoaDon hd ON hdp.MaHDP = hd.MaLoaiHD
        WHERE YEAR(hd.NgayXuatHD) = @Year
          AND MONTH(hd.NgayXuatHD) = @Month
		  AND cthdp.TrangThai = N'Đã thanh toán'
    ), 0);

    -- Doanh thu món
    SELECT @TongDoanhThu = @TongDoanhThu + ISNULL((
        SELECT SUM(cthdm.SL_Mon * m.GiaMon)
        FROM CTHDMon cthdm
        JOIN Mon m ON cthdm.MaMon = m.MaMon
        JOIN HoaDonMon hdm ON cthdm.MaHDM = hdm.MaHDM
		JOIN HoaDon hd ON hdm.MaHDM = hd.MaLoaiHD
        WHERE YEAR(hd.NgayXuatHD) = @Year
          AND MONTH(hd.NgayXuatHD) = @Month
		  AND cthdm.TrangThai = N'Đã thanh toán'
    ), 0);

    -- Doanh thu dịch vụ
    SELECT @TongDoanhThu = @TongDoanhThu + ISNULL((
        SELECT SUM(cthddv.SL_DV * dv.GiaDV)
        FROM CTHDDichVu cthddv
        JOIN DichVu dv ON cthddv.MaDV = dv.MaDV
        JOIN HoaDonDV hddv ON cthddv.MaHDDV = hddv.MaHDDV
		JOIN HoaDon hd ON hddv.MaHDDV = hd.MaLoaiHD
        WHERE YEAR(hd.NgayXuatHD) = @Year
          AND MONTH(hd.NgayXuatHD) = @Month
		  AND cthddv.TrangThai = N'Đã thanh toán'
    ), 0);

    RETURN @TongDoanhThu;
END;

select dbo.fn_DoanhThuThang(5, 2025) as TongDoanhThuThang;

--TRIGGER
	--1. Trigger kiểm tra mức lương không âm trong bảng Luong 
-- Trigger kiểm tra các dòng mới thêm hoặc cập nhật trong inserted.
-- Nếu có bất kỳ mức lương nào < 0, thì hủy thao tác và thông báo lỗi.)
CREATE TRIGGER trg_KiemTraLuongKhongAm
ON Luong
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted
        WHERE MucLuong < 0
    )
    BEGIN
        RAISERROR(N'Mức lương không được âm.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;

Update Luong set MucLuong=-200000 where MaNV='NV001';
select * from Luong;

	--2. Cập nhật trạng thái phòng về 'Trống' khi hóa đơn phòng đã thanh toán
CREATE TRIGGER trg_CapNhatTrangThaiPhongSauThanhToan
ON CTHDPhong
AFTER UPDATE
AS
BEGIN
    IF UPDATE(TrangThai)
    BEGIN
        UPDATE Phong
        SET TrangThai = N'Trống'
        FROM Phong p
        INNER JOIN inserted i ON p.MaP = i.MaP
        WHERE i.TrangThai = N'Đã thanh toán';
    END
END;

SELECT * FROM CTHDPhong;
UPDATE CTHDPhong SET TrangThai= N'Đã thanh toán' WHERE MaP='P102';
SELECT * FROM Phong;

	--3. Trigger để đảm bảo trạng thái phòng được cập nhật khi phòng được đặt
CREATE TRIGGER trg_UpdateRoomStatusOnBooking
ON CTHDPhong
AFTER INSERT
AS
BEGIN
    UPDATE Phong
SET TrangThai = N'Đã đặt'
WHERE MaP IN (SELECT MaP FROM inserted)
AND TrangThai NOT IN (N'Đã đặt', N'Đang sử dụng');
END;

INSERT INTO CTHDPhong (MaCTHDP, MaHDP, MaP, NgayNhan, NgayTra, TrangThai)
VALUES
	('CTHDP011', 'HDP001', 'P401', '2025-01-01', '2025-01-03', N'Đã thanh toán')
select * from CTHDPhong;
select * from Phong;
