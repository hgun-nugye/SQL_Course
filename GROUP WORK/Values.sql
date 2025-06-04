USE HotelManagement
GO
-- Thêm dữ liệu vào bảng KhachHang
INSERT INTO KhachHang (MaKH, CCCD, SDT_KH, GioiTinh, HoTen, DiaChi, QuocTich, Email_KH)
VALUES
	('KH001', '123456789012', '0912345678', N'Nam', N'Nguyễn Văn An', N'123 Đường Lê Lợi, Q1, TP.HCM', N'Việt Nam', 'nguyenvanan@gmail.com'),
	('KH002', '234567890123', '0923456789', N'Nữ', N'Trần Thị Bình', N'456 Đường Nguyễn Huệ, Q1, TP.HCM', N'Việt Nam', 'tranthibinh@gmail.com'),
	('KH003', '345678901234', '0934567890', N'Nam', N'Lê Hoàng Cường', N'789 Đường Pasteur, Q3, TP.HCM', N'Việt Nam', 'lehoangcuong@gmail.com'),
	('KH004', '456789012345', '0945678901', N'Nữ', N'Phạm Ngọc Diệp', N'321 Đường Cách Mạng Tháng 8, Q10, TP.HCM', N'Việt Nam', 'phamngocdiep@gmail.com'),
	('KH005', '567890123456', '0956789012', N'Nam', N'Vũ Minh Đức', N'654 Đường 3/2, Q10, TP.HCM', N'Việt Nam', 'vuminhduc@gmail.com'),
	('KH006', '678901234567', '0967890123', N'Nữ', N'Hoàng Thị Lan', N'987 Đường Lý Thường Kiệt, Q11, TP.HCM', N'Việt Nam', 'hoangthilan@gmail.com'),
	('KH007', '789012345678', '0978901234', N'Nam', N'Nguyễn Tuấn Hùng', N'159 Đường Bạch Đằng, Q.Bình Thạnh, TP.HCM', N'Việt Nam', 'nguyentuanhung@gmail.com'),
	('KH008', '890123456789', '0989012345', N'Nữ', N'Lý Thị Mai', N'753 Đường Nguyễn Văn Cừ, Q5, TP.HCM', N'Việt Nam', 'lythimai@gmail.com'),
	('KH009', '901234567890', '0990123456', N'Nam', N'Trương Văn Phúc', N'852 Đường Nguyễn Trãi, Q5, TP.HCM', N'Việt Nam', 'truongvanphuc@gmail.com'),
	('KH010', '012345678901', '0901234567', N'Nữ', N'Đặng Kim Ngân', N'963 Đường Lê Văn Sỹ, Q3, TP.HCM', N'Việt Nam', 'dangkimngan@gmail.com');

	-- Thêm dữ liệu vào bảng NhanVien
INSERT INTO NhanVien (MaNV, CCCD, HoTen, NgaySinh, GioiTinh, ChucVu, SDT_NV, Email_NV, DiaChi, SoBHYT, SoHopDong, NamBatDau, MaSoThueCaNhan)
VALUES
    ('NV001', '112233445566', N'Nguyễn Ngọc An', '2000-01-01', N'Nam', N'Quản lý', '0911223344', 'nguyenngocan@hotel.com', N'111 Đường Nguyễn Thị Minh Khai, Q1, TP.HCM', 'BHYT001', 'HD001', 2020, 'MST001'),
    ('NV002', '223344556677', N'Trần Văn Bảo', '1998-02-01', N'Nam', N'Lễ tân', '0922334455', 'tranvanbao@hotel.com', N'222 Đường Lê Duẩn, Q1, TP.HCM', 'BHYT002', 'HD002', 2021, 'MST002'),
    ('NV003', '334455667788', N'Lê Thị Cẩm', '2001-03-01', N'Nữ', N'Lễ tân', '0933445566', 'lethicam@hotel.com', N'333 Đường Hai Bà Trưng, Q1, TP.HCM', 'BHYT003', 'HD003', 2021, 'MST003'),
    ('NV004', '445566778899', N'Phạm Đức Dũng', '1991-05-01', N'Nam', N'Buồng phòng', '0944556677', 'phamducdung@hotel.com', N'444 Đường Đồng Khởi, Q1, TP.HCM', 'BHYT004', 'HD004', 2022, 'MST004'),
    ('NV005', '556677889900', N'Vũ Thị Em', '1995-01-12', N'Nữ', N'Buồng phòng', '0955667788', 'vuthiem@hotel.com', N'555 Đường Nam Kỳ Khởi Nghĩa, Q3, TP.HCM', 'BHYT005', 'HD005', 2022, 'MST005'),
    ('NV006', '667788990011', N'Hoàng Văn Phúc', '1995-01-01', N'Nam', N'Bếp', '0966778899', 'hoangvanphuc@hotel.com', N'666 Đường Võ Văn Tần, Q3, TP.HCM', 'BHYT006', 'HD006', 2023, 'MST006'),
    ('NV007', '778899001122', N'Nguyễn Thị Hương', '1997-01-02', N'Nữ', N'Bếp', '0977889900', 'nguyenthihuong@hotel.com', N'777 Đường Trần Hưng Đạo, Q5, TP.HCM', 'BHYT007', 'HD007', 2023, 'MST007'),
    ('NV008', '889900112233', N'Trần Minh Khôi', '1989-01-01', N'Nam', N'Bảo vệ', '0988990011', 'tranminhkhoi@hotel.com', N'888 Đường Nguyễn Trãi, Q5, TP.HCM', 'BHYT008', 'HD008', 2024, 'MST008'),
    ('NV009', '990011223344', N'Lý Thị Mai', '1990-01-23', N'Nữ', N'Kế toán', '0999001122', 'lythimai@hotel.com', N'999 Đường Lê Hồng Phong, Q10, TP.HCM', 'BHYT009', 'HD009', 2024, 'MST009'),
    ('NV010', '001122334455', N'Đặng Văn Nam', '1989-12-14', N'Nam', N'Quản lý', '0900112233', 'dangvannam@hotel.com', N'1010 Đường 3/2, Q10, TP.HCM', 'BHYT010', 'HD010', 2020, 'MST010');

	-- Thêm dữ liệu vào bảng LichLam
INSERT INTO LichLam (NgayLam, MaNV, CaLam)
VALUES
	('2025-05-01', 'NV001', N'Sáng'),
	('2025-05-01', 'NV002', N'Chiều'),
	('2025-05-01', 'NV003', N'Tối'),
	('2025-05-02', 'NV004', N'Sáng'),
	('2025-05-02', 'NV005', N'Chiều'),
	('2025-05-02', 'NV006', N'Tối'),
	('2025-05-03', 'NV007', N'Sáng'),
	('2025-05-03', 'NV008', N'Chiều'),
	('2025-05-03', 'NV009', N'Tối'),
	('2025-05-04', 'NV010', N'Sáng');
	-- Thêm dữ liệu vào bảng Luong
INSERT INTO Luong (MaNV, MucLuong, Thuong, Phat, PhuCap, ThangLuong)
VALUES
	('NV001', 15000000, 2000000, 0, 3000000, '2025-04-01'),
	('NV002', 8000000, 500000, 0, 1000000, '2025-04-01'),
	('NV003', 8000000, 500000, 200000, 1000000, '2025-04-01'),
	('NV004', 7000000, 300000, 0, 800000, '2025-04-01'),
	('NV005', 7000000, 300000, 100000, 800000, '2025-04-01'),
	('NV006', 9000000, 400000, 0, 1200000, '2025-04-01'),
	('NV007', 9000000, 400000, 0, 1200000, '2025-04-01'),
	('NV008', 6000000, 200000, 0, 500000, '2025-04-01'),
	('NV009', 10000000, 1000000, 0, 2000000, '2025-04-01'),
	('NV010', 12000000, 1500000, 0, 2500000, '2025-04-01');
	
	-- Thêm dữ liệu vào bảng LoaiPhong
INSERT INTO LoaiPhong (MaLP, TenLP, SucChua, SoGiuong, DienTich, TienNghi)
VALUES
	('LP001', N'Phòng Đơn', 1, 1, 20.00, N'Điều hòa, TV, Wifi, Bàn làm việc'),
	('LP002', N'Phòng Đôi', 2, 1, 25.00, N'Điều hòa, TV, Wifi, Mini bar'),
	('LP003', N'Phòng Twin', 2, 2, 25.00, N'Điều hòa, TV, Wifi, 2 giường đơn'),
	('LP004', N'Phòng Gia đình', 4, 2, 35.00, N'Điều hòa, TV, Wifi, 1 giường đôi + 2 giường đơn'),
	('LP005', N'Phòng VIP', 2, 1, 30.00, N'Điều hòa, TV màn hình phẳng, Wifi tốc độ cao, Mini bar, Bồn tắm'),
	('LP006', N'Phòng Suite', 2, 1, 40.00, N'Điều hòa, TV màn hình phẳng, Wifi tốc độ cao, Mini bar, Bồn tắm, Phòng khách'),
	('LP007', N'Phòng Deluxe', 2, 1, 28.00, N'Điều hòa, TV, Wifi, Mini bar, View đẹp'),
	('LP008', N'Phòng Executive', 2, 1, 32.00, N'Điều hòa, TV màn hình phẳng, Wifi, Mini bar, Bàn làm việc'),
	('LP009', N'Phòng President', 2, 1, 50.00, N'Điều hòa, TV màn hình phẳng, Wifi tốc độ cao, Mini bar đầy đủ, Phòng khách riêng'),
	('LP010', N'Phòng Honeymoon', 2, 1, 30.00, N'Điều hòa, TV, Wifi, Mini bar, Trang trí đặc biệt');

-- Thêm dữ liệu vào bảng Phong
INSERT INTO Phong (MaP, MaLP, TrangThai, GiaMacDinh)
VALUES
    ('P101', 'LP001', N'Trống', 800000.00),
    ('P102', 'LP001', N'Đã đặt', 800000.00),
    ('P103', 'LP001', N'Trống', 800000.00),
    ('P104', 'LP001', N'Trống', 800000.00),
    ('P105', 'LP001', N'Đang dọn dẹp', 800000.00),
    ('P106', 'LP001', N'Trống', 800000.00),
    ('P107', 'LP001', N'Đang dọn dẹp', 800000.00),
    ('P108', 'LP001', N'Trống', 800000.00),
    ('P109', 'LP001', N'Trống', 800000.00),
    ('P110', 'LP001', N'Đang dọn dẹp', 800000.00),
    ('P201', 'LP002', N'Đang sử dụng', 1200000.00),
    ('P202', 'LP002', N'Đang sử dụng', 1200000.00),
    ('P203', 'LP002', N'Trống', 1200000.00),
    ('P204', 'LP002', N'Đang dọn dẹp', 1200000.00),
    ('P205', 'LP002', N'Trống', 1200000.00),
    ('P206', 'LP002', N'Đang dọn dẹp', 1200000.00),
    ('P207', 'LP002', N'Trống', 1200000.00),
    ('P208', 'LP002', N'Trống', 1200000.00),
    ('P209', 'LP002', N'Trống', 1200000.00),
    ('P210', 'LP002', N'Trống', 1200000.00);
	-- Thêm dữ liệu vào bảng Mon
INSERT INTO Mon (MaMon, TenMon, GiaMon, TrangThai_Mon)
VALUES
	('M001', N'Phở bò', 50000.00, N'available'),
	('M002', N'Bún bò Huế', 55000.00, N'not available'),
	('M003', N'Bánh mì thịt', 30000.00, N'available'),
	('M004', N'Cơm gà xối mỡ', 60000.00, N'available'),
	('M005', N'Bún chả Hà Nội', 50000.00, N'available'),
	('M006', N'Pizza hải sản', 150000.00, N'available'),
	('M007', N'Spaghetti bò bằm', 120000.00, N'not available'),
	('M008', N'Salad cá ngừ', 80000.00, N'available'),
	('M009', N'Súp cua', 45000.00, N'not available'),
	('M010', N'Bò lúc lắc', 180000.00, N'available');
	-- Thêm dữ liệu vào bảng DichVu
INSERT INTO DichVu (MaDV, TenDV, GiaDV, Loai_DV)
VALUES
	('DV001', N'Massage thư giãn', 500000.00, N'Spa'),
	('DV002', N'Xông hơi', 300000.00, N'Spa'),
	('DV003', N'Giặt ủi', 100000.00, N'Giặt là'),
	('DV004', N'Thuê xe đưa đón', 800000.00, N'Vận chuyển'),
	('DV005', N'Đặt tour du lịch', 1500000.00, N'Du lịch'),
	('DV006', N'Dịch vụ phòng', 200000.00, N'Phòng'),
	('DV007', N'Cho thuê xe đạp', 150000.00, N'Vận chuyển'),
	('DV008', N'Dịch vụ trông trẻ', 250000.00, N'Chăm sóc'),
	('DV009', N'Đặt vé xem phim', 300000.00, N'Giải trí'),
	('DV010', N'Thuê phòng họp', 1000000.00, N'Hội nghị');

	-- Thêm dữ liệu vào bảng HoaDonPhong
INSERT INTO HoaDonPhong (MaHDP, MaNV, MaKH, NgayDat)
VALUES
	('HDP001', 'NV002', 'KH001', '2025-04-30'),
	('HDP002', 'NV003', 'KH002', '2025-05-01'),
	('HDP003', 'NV003', 'KH009', '2025-05-08');
	-- Thêm dữ liệu vào bảng CTHDPhong
INSERT INTO CTHDPhong (MaCTHDP, MaHDP, MaP, NgayNhan, NgayTra, TrangThai)
VALUES
	('CTHDP001', 'HDP001', 'P201', '2025-05-01', '2025-05-03', N'Chưa thanh toán'),
	('CTHDP002', 'HDP002', 'P102', '2025-05-02', '2025-05-04', N'Chưa thanh toán'),
	('CTHDP003', 'HDP003', 'P202', '2025-05-09', '2025-05-12', N'Chưa thanh toán');
	-- Thêm dữ liệu vào bảng HoaDonMon
INSERT INTO HoaDonMon (MaHDM, MaNV, MaKH, NgayDat)
VALUES
	('HDM001', 'NV002', 'KH003', '2025-05-03'),
	('HDM002', 'NV003', 'KH009', '2025-05-04'),
	('HDM003', 'NV002', 'KH008', '2025-05-08');
	-- Thêm dữ liệu vào bảng CTHDMon
INSERT INTO CTHDMon (MaCTHDM, MaHDM, MaP, MaMon, SL_Mon, NgaySD,  TrangThai)
VALUES
	('CTHDM001', 'HDM001', 'P201', 'M001', 2, '2025-05-03', N'Đã thanh toán'),
	('CTHDM002', 'HDM003', 'P204', 'M003', 1, '2025-05-03',N'Đã thanh toán'),
	('CTHDM003', 'HDM002', 'P102', 'M005', 3, '2025-05-04', N'Chưa thanh toán');
	-- Thêm dữ liệu vào bảng HoaDonDV
INSERT INTO HoaDonDV (MaHDDV, MaKH, MaNV, NgayDat)
VALUES
	('HDDV001', 'KH005', 'NV002', '2025-05-05'),
	('HDDV002', 'KH009', 'NV003', '2025-05-07'),
	('HDDV003', 'KH010', 'NV002', '2025-05-10');
	-- Thêm dữ liệu vào bảng CTHDDichVu
INSERT INTO CTHDDichVu (MaCTHDDV, MaHDDV, MaDV, SL_DV, MaP, NgaySD,  TrangThai)
VALUES
	('CTHDDV001', 'HDDV001', 'DV001', 1, 'P201', '2025-05-05',  N'Đã thanh toán'),
	('CTHDDV002', 'HDDV002', 'DV003', 2, 'P102', '2025-05-07',  N'Đã thanh toán'),
	('CTHDDV003', 'HDDV003', 'DV005', 1, 'P107', '2025-05-10',  N'Chưa thanh toán');
	-- Thêm dữ liệu vào bảng HoaDon
INSERT INTO HoaDon (MaHD, MaKH, MaNV, MaLoaiHD, NgayXuatHD, TrangThai)
VALUES
    ('HD001', 'KH001', 'NV002', 'HDP001', '2025-05-01', N'Chưa thanh toán'),
    ('HD002', 'KH002', 'NV003', 'HDP002', '2025-05-02', N'Chưa thanh toán'),
	('HD003', 'KH009', 'NV002', 'HDP003', '2025-05-04', N'Chưa thanh toán'),
    ('HD003', 'KH009', 'NV003', 'HDM002', '2025-05-05', N'Chưa thanh toán'),
    ('HD003', 'KH009', 'NV003', 'HDDV002','2025-05-05',N'Chưa thanh toán');
	-- Thêm dữ liệu vào bảng CTHD
INSERT INTO CTHD (MaCTHD, MaHD, MaLoaiHD, MaKH, MaLoaiCTHD)
VALUES
    ('CTHD001', 'HD001', 'HDP001', 'KH001', 'CTHDP001'),
    ('CTHD002', 'HD002', 'HDP002', 'KH002', 'CTHDP002'),
    ('CTHD003', 'HD003', 'HDP003', 'KH009', 'CTHDP003'),
    ('CTHD004', 'HD003', 'HDM002', 'KH009', 'CTHDM002'),
    ('CTHD005', 'HD003', 'HDDV002', 'KH009', 'CTHDDV002');

-- Cập nhật trạng thái phòng
UPDATE Phong SET TrangThai = N'Đang sử dụng' WHERE MaP IN ('202', 'P102');

