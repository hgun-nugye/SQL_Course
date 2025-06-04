USE HotelManagement
GO
-- Phần 1: Truy vấn đơn giản: 3 câu - Tiến
	--1. Liệt kê các phòng đang ở trạng thái "Trống": 
SELECT *
FROM Phong
WHERE TrangThai = N'Trống';

	--2. Liệt kê các món có giá từ 50.000 VNĐ trở lên:
SELECT MaMon, TenMon, GiaMon
FROM Mon
WHERE GiaMon >= 50000;

	--3. Liệt kê mã, họ tên và chức vụ của các nhân viên có chức vụ "Lễ tân":
SELECT MaNV, HoTen, ChucVu
FROM NhanVien
WHERE ChucVu = N'Lễ tân';

-- Phần 2: Truy vấn với Aggregate Functions: 7 câu - Nhung
	--1. Khách hàng đã chi tiêu nhiều nhất cho dịch vụ
SELECT TOP 1 KH.HoTen, SUM(D.GiaDV * C.SL_DV) AS TongTienDichVu
FROM KhachHang KH
	JOIN HoaDonDV HD ON KH.MaKH = HD.MaKH
	JOIN CTHDDichVu C ON HD.MaHDDV = C.MaHDDV
	JOIN DichVu D ON C.MaDV = D.MaDV
GROUP BY KH.HoTen
ORDER BY TongTienDichVu DESC;

	-- 2. Trung bình thời gian thuê phòng theo từng loại phòng
SELECT LP.TenLP, AVG(DATEDIFF(DAY, C.NgayNhan, C.NgayTra)) AS ThoiGianThuePhongTB
FROM CTHDPhong C
	JOIN Phong P ON C.MaP = P.MaP
	JOIN LoaiPhong LP ON P.MaLP = LP.MaLP
GROUP BY LP.TenLP;

	--3. Nhân viên có tổng lương nhận thực tế cao nhất (Lương + Thưởng - Phạt + Phụ cấp)
SELECT TOP 1 NV.HoTen, SUM(MucLuong + ISNULL(Thuong,0) - ISNULL(Phat,0) + ISNULL(PhuCap,0)) AS TongLuong
-- ISNULL(Thuong,0) nếu thưởng = Null (không có thưởng) thì lấy giá trị 0 để thực hiện phép tính
FROM NhanVien NV
	JOIN Luong L ON NV.MaNV = L.MaNV
GROUP BY NV.HoTen
ORDER BY TongLuong DESC;

	-- 4. Tháng có tổng tiền dịch vụ cao nhất
SELECT TOP 1 MONTH(C.NgaySD) AS Thang, YEAR(C.NgaySD) AS Nam, 
       SUM(D.GiaDV * C.SL_DV) AS TongTien
FROM CTHDDichVu C
	JOIN DichVu D ON C.MaDV = D.MaDV
GROUP BY YEAR(C.NgaySD), MONTH(C.NgaySD)
ORDER BY TongTien DESC;

	-- 5. Tổng số lượt sử dụng của từng loại dịch vụ
SELECT 
    dv.MaDV,
    dv.TenDV,
    SUM(ctdv.SL_DV) AS TongSoLanDuocSuDung
FROM DichVu dv
JOIN CTHDDichVu ctdv ON dv.MaDV = ctdv.MaDV
GROUP BY dv.MaDV, dv.TenDV
ORDER BY TongSoLanDuocSuDung DESC;

	--6. Phòng chi tiêu cao nhất cho việc Đặt món
SELECT TOP 1 P.MaP, LP.TenLP AS LoaiPhong, KH.HoTen AS TenKhachHang,
    SUM(M.GiaMon * CTHDM.SL_Mon) AS TongTienDatMon,
    COUNT(DISTINCT CTHDM.MaHDM) AS SoLanDatMon
FROM CTHDMon CTHDM
    JOIN Mon M ON CTHDM.MaMon = M.MaMon
    JOIN Phong P ON CTHDM.MaP = P.MaP
    JOIN LoaiPhong LP ON P.MaLP = LP.MaLP
    JOIN HoaDonMon HDM ON CTHDM.MaHDM = HDM.MaHDM
    JOIN KhachHang KH ON HDM.MaKH = KH.MaKH
GROUP BY P.MaP, LP.TenLP, KH.HoTen
ORDER BY TongTienDatMon DESC;

	-- 7.Tổng chi tiêu món và dịch vụ của từng hóa đơn
SELECT KH.HoTen, 
       SUM(ISNULL(DV.GiaDV * DDV.SL_DV, 0) + ISNULL(M.GiaMon * CM.SL_Mon, 0)) AS TongTien
FROM KhachHang KH
	JOIN HoaDon HD ON KH.MaKH = HD.MaKH
	LEFT JOIN CTHDDichVu DDV ON HD.MaLoaiHD = DDV.MaHDDV
	LEFT JOIN DichVu DV ON DDV.MaDV = DV.MaDV
	LEFT JOIN CTHDMon CM ON HD.MaLoaiHD = CM.MaHDM
	LEFT JOIN Mon M ON CM.MaMon = M.MaMon
GROUP BY KH.HoTen;

-- Phần 3: Truy vấn với mệnh đề having: 5 câu - Phát & Hòa
	--1. Tìm khách hàng đã sử dụng nhiều dịch vụ nhất
SELECT KH.MaKH, KH.HoTen, COUNT(CTDV.MaDV) AS SoLuongDichVu
FROM KhachHang KH
JOIN HoaDonDV HDDV ON KH.MaKH = HDDV.MaKH
JOIN CTHDDichVu CTDV ON HDDV.MaHDDV = CTDV.MaHDDV
GROUP BY KH.MaKH, KH.HoTen
HAVING COUNT(CTDV.MaDV) > 3
ORDER BY SoLuongDichVu DESC;

	--2. Tìm tất cả nhân viên có tổng số ngày đi làm hơn 365 ngày
SELECT NV.MaNV, NV.HoTen, COUNT(DISTINCT L.NgayLam) AS TongSoNgayLam
FROM NhanVien NV
JOIN LichLam L ON L.MaNV = NV.MaNV
GROUP BY NV.MaNV, NV.HoTen
HAVING COUNT(DISTINCT L.NgayLam) > 365;

	--3. Tìm các loại phòng có tỷ lệ lấp đầy (số phòng đã đặt/tổng số phòng) trung bình hàng tháng lớn hơn 50%
SELECT LP.TenLP,
    AVG(CAST(CASE WHEN CTHDP.MaP IS NOT NULL THEN 1 ELSE 0 END AS FLOAT)) AS TyLeLapDayTrungBinh
FROM LoaiPhong LP
	JOIN Phong P ON LP.MaLP = P.MaLP
	LEFT JOIN CTHDPhong CTHDP ON P.MaP = CTHDP.MaP
GROUP BY LP.TenLP
HAVING AVG(CAST(CASE WHEN CTHDP.MaP IS NOT NULL THEN 1 ELSE 0 END AS FLOAT)) > 0.5;

	--4. Tìm khách hàng thân thiết, số lần đặt phòng trong khách sạn (số lần lớn hơn 2)
SELECT KH.HoTen,KH.MaKH,KH.SDT_KH, COUNT(HDP.MaKH) AS SoLanĐatPhong 
FROM KhachHang KH  
	JOIN HoaDonPhong HDP ON KH.MaKH = HDP.MaKH 
GROUP BY KH.HoTen,KH.MaKH,KH.SDT_KH
HAVING COUNT(HDP.MaKH) > 2;

	--5. Các loại phòng có số lượng phòng trống (Trạng thái 'Trống') dưới 5 phòng 
SELECT LP.MaLP,LP.TenLP,COUNT(P.MaP) AS SoPhongTrong
FROM LoaiPhong LP JOIN Phong P ON LP.MaLP = P.MaLP
WHERE P.TrangThai = N'Trống'
GROUP BY LP.MaLP, LP.TenLP
HAVING COUNT(P.MaP) < 5;

-- Phần 4: Truy vấn lớn nhất, nhỏ nhất: 3 câu - Hòa
	--1. Hiển thị hóa đơn cao nhất trong tháng 5 năm 2025
WITH TongHoaDon AS (
    SELECT H.MaHD, H.MaKH, H.MaNV, H.NgayXuatHD, 
        SUM(
            COALESCE(CTM.SL_Mon * M.GiaMon, 0)+
            COALESCE(CTHDDV.SL_DV * DV.GiaDV, 0)+
            COALESCE(DATEDIFF(DAY, CTP.NgayNhan, CTP.NgayTra) * P.GiaMacDinh, 0)
        ) AS TongHoaDon
    FROM HoaDon H
    LEFT JOIN CTHD CTHD ON H.MaHD = CTHD.MaHD
    LEFT JOIN CTHDPhong CTP ON CTHD.MaLoaiCTHD = CTP.MaCTHDP
    LEFT JOIN CTHDMon CTM ON CTHD.MaLoaiCTHD = CTM.MaCTHDM
    LEFT JOIN CTHDDichVu CTHDDV ON H.MaHD = CTHDDV.MaHDDV
    LEFT JOIN DichVu DV ON CTHDDV.MaDV = DV.MaDV
    LEFT JOIN Mon M ON CTM.MaMon = M.MaMon
    LEFT JOIN Phong P ON CTP.MaP = P.MaP
    WHERE H.NgayXuatHD BETWEEN '2025-05-01' AND '2025-05-31'
    GROUP BY H.MaHD, H.MaKH, H.MaNV, H.NgayXuatHD
)
SELECT MaHD, MaKH, MaNV, NgayXuatHD, TongHoaDon
FROM TongHoaDon
WHERE TongHoaDon = (SELECT MAX(TongHoaDon) FROM TongHoaDon);

	--2. Hiển thị nhân viên có tổng lương cao nhất trong quý 2 năm 2025
WITH LuongCaoNhat AS (
    SELECT NV.MaNV, NV.HoTen, 
        SUM(L.MucLuong + COALESCE(L.Thuong, 0) + COALESCE(L.PhuCap, 0) - COALESCE(L.Phat, 0)) AS TongLuong
    FROM Luong L
    JOIN NhanVien NV ON L.MaNV = NV.MaNV
    WHERE YEAR(L.ThangLuong) = 2025 
			AND MONTH(L.ThangLuong) BETWEEN 4 AND 6
    GROUP BY NV.MaNV, NV.HoTen
)
SELECT MaNV, HoTen, TongLuong
FROM LuongCaoNhat
WHERE TongLuong = (SELECT MAX(TongLuong) FROM LuongCaoNhat);

	--3. Phòng đắt nhất
SELECT TOP 1 p.MaP, lp.TenLP, p.GiaMacDinh
FROM Phong p
JOIN LoaiPhong lp ON p.MaLP = lp.MaLP
ORDER BY p.GiaMacDinh DESC;

-- Phần 5: Truy vấn Không/chưa có: (Not In và left/right join) - Hương
	-- 1. Truy vấn phòng chưa từng được đặt
SELECT P.*
FROM [dbo].[Phong] P
WHERE P.MaP NOT IN (
    SELECT CTHDP.MaP
    FROM [dbo].[CTHDPhong] CTHDP
);

	-- 2.  Truy vấn nhân viên chưa từng xử lý hóa đơn
SELECT NV.*
FROM [dbo].[NhanVien] NV
	LEFT JOIN [dbo].[HoaDon] HD ON NV.MaNV = HD.MaNV
		AND HD.MaLoaiHD IS NOT NULL
WHERE HD.MaHD IS NULL;

	--3. Khách chưa thanh toán
SELECT KH.*
FROM [dbo].[KhachHang] KH
	LEFT JOIN [dbo].[HoaDon] HD ON KH.MaKH = HD.MaKH
WHERE HD.TrangThai=N'Chưa thanh toán';

	--4. Dịch vụ chưa được sử dụng
SELECT DV.*
FROM  [dbo].[DichVu] DV
	LEFT JOIN [dbo].[CTHDDichVu] CTHDDV ON DV.MaDV = CTHDDV.MaDV
WHERE CTHDDV.MaDV IS NULL;

	--5. Món ăn chưa từng được đặt
SELECT M.*
FROM Mon M
	LEFT JOIN CTHDMon CTHDM ON M.MaMon = CTHDM.MaMon
WHERE CTHDM.MaCTHDM IS NULL;

-- Phần 6: Truy vấn Hợp/Giao/Trừ: 3 câu - Phát
	-- 1. Doanh thu chưa thanh toán: Tổng hợp các hóa đơn phòng, món, dịch vụ chưa thanh toán
-- Hóa đơn phòng chưa thanh toán
SELECT
    HDP.MaHDP AS MaHoaDon,
    KH.HoTen AS TenKhachHang,
    N'Hóa đơn phòng' AS LoaiHoaDon,
    HDP.NgayDat
FROM HoaDonPhong HDP JOIN KhachHang KH ON HDP.MaKH = KH.MaKH
WHERE EXISTS (SELECT 1 FROM CTHDPhong WHERE MaHDP = HDP.MaHDP AND TrangThai = N'Chưa thanh toán')
UNION ALL
-- Hóa đơn món chưa thanh toán
SELECT
    HDM.MaHDM AS MaHoaDon,
    KH.HoTen AS TenKhachHang,
    N'Hóa đơn món' AS LoaiHoaDon,
    HDM.NgayDat
FROM HoaDonMon HDM JOIN KhachHang KH ON HDM.MaKH = KH.MaKH
WHERE EXISTS (SELECT 1 FROM CTHDMon WHERE MaHDM = HDM.MaHDM AND TrangThai = N'Chưa thanh toán')
UNION ALL
-- Hóa đơn dịch vụ chưa thanh toán
SELECT
    HDDV.MaHDDV AS MaHoaDon,
    KH.HoTen AS TenKhachHang,
    N'Hóa đơn dịch vụ' AS LoaiHoaDon,
    HDDV.NgayDat
FROM HoaDonDV HDDV JOIN KhachHang KH ON HDDV.MaKH = KH.MaKH
WHERE EXISTS (SELECT 1 FROM CTHDDichVu WHERE MaHDDV = HDDV.MaHDDV AND TrangThai = N'Chưa thanh toán');

	--2. Tìm khách hàng đặt phòng nhưng không sử dụng dịch vụ và đặt món 
SELECT KH.MaKH, KH.HoTen, KH.SDT_KH, KH.Email_KH, KH.DiaChi
FROM KhachHang KH
WHERE KH.MaKH IN (
    SELECT MaKH FROM HoaDonPhong
    EXCEPT
    (SELECT MaKH FROM HoaDonDV
     UNION
     SELECT MaKH FROM HoaDonMon)
);

	--3.  Kiểm tra phòng trống/sẵn sàng: Các phòng đang ở trạng thái 'Trống' và không có booking nào trong 1 tuần 
SELECT P.MaP, LP.TenLP
FROM Phong P JOIN LoaiPhong LP ON P.MaLP = LP.MaLP
WHERE P.TrangThai = N'Trống'
EXCEPT
SELECT P.MaP, LP.TenLP
FROM Phong P JOIN LoaiPhong LP ON P.MaLP = LP.MaLP JOIN CTHDPhong CTP ON P.MaP = CTP.MaP
WHERE CTP.NgayNhan BETWEEN GETDATE() AND DATEADD(day, 7, GETDATE()) AND CTP.TrangThai = N'Chưa thanh toán';

-- Phần 7: Truy vấn Update, Delete - Tiến & Nhung
	--1. Tăng GiaMacDinh của tất cả các phòng thuộc loại phòng có SucChua lớn hơn 2 lên 10%
UPDATE Phong
SET GiaMacDinh = GiaMacDinh * 1.1
WHERE MaLP IN (
	SELECT MaLP FROM LoaiPhong WHERE SucChua > 2
);

	--2. Cập nhật trạng thái phòng thành 'Đang dọn dẹp' cho các phòng có giá mặc định lớn hơn 2 triệu
UPDATE Phong
SET TrangThai = N'Đang dọn dẹp'
WHERE GiaMacDinh > 2000000;

	--3. Cập nhật TrangThai_Mon của bảng Mon cho những món không còn phục vụ 
UPDATE Mon
SET TrangThai_Mon = 'not available'
WHERE MaMon = 'M005';

select * from Mon;

	--4. Tăng PhuCap thêm 200.000 cho nhân viên có chức vụ là 'Lễ tân'
UPDATE Luong
SET PhuCap = ISNULL(PhuCap, 0) + 200000
WHERE MaNV IN (
	SELECT MaNV FROM NhanVien WHERE ChucVu = N'Lễ tân'
);

select * from Luong

	--5. Cập nhật mức lương của nhân viên
UPDATE Luong
SET MucLuong = 20000000,ThangLuong = '2025-05-01'
WHERE MaNV = 'NV001';

select * from NhanVien;
select * from Luong;

	--5.Xóa các món ăn không còn phục vụ nữa
DELETE FROM Mon
WHERE TrangThai_Mon = 'not available';

	--7.  Xóa các khách hàng đã hơn 5 năm chưa thuê phòng hoặc khách hàng chưa hình thành hóa đơn
DELETE FROM KhachHang
WHERE MaKH IN (
    SELECT DISTINCT KH.MaKH
    FROM KhachHang KH
    LEFT JOIN HoaDonPhong HDP ON KH.MaKH = HDP.MaKH
    WHERE HDP.NgayDat IS NULL OR HDP.NgayDat < DATEADD(YEAR, -5, GETDATE()));

select * from HoaDonPhong;
select * from KhachHang;

-- Phần 8: Truy vấn sử dụng phép Chia - Phát & Hòa
	--1.  Tìm món ăn có trong mọi hóa đơn món ăn 
SELECT M.MaMon, M.TenMon
FROM Mon M
WHERE NOT EXISTS (
    SELECT HDM.MaHDM
    FROM HoaDonMon HDM
    WHERE NOT EXISTS (
            SELECT CTM.MaCTHDM
            FROM CTHDMon CTM
            WHERE CTM.MaHDM = HDM.MaHDM AND CTM.MaMon = M.MaMon
        )
);

	--2. Tìm dịch vụ có trong mọi hóa đơn dịch vụ
SELECT DV.MaDV, DV.TenDV
FROM DichVu DV
WHERE NOT EXISTS (
    SELECT *
    FROM HoaDon HD
    WHERE NOT EXISTS (
        SELECT *
        FROM HoaDonDV HDDV
        JOIN CTHDDichVu CT ON HDDV.MaHDDV = CT.MaHDDV
        WHERE CT.MaDV = DV.MaDV AND HDDV.MaHDDV = HD.MaLoaiHD
    )
);




