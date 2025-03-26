--Câu 7:Công ty Việt Tiến đã cung cấp những mặt hàng nào?
SELECT HH.MaHang, HH.TenHang  
FROM HANG_HOA HH  
JOIN CUNG_CAP CC ON HH.MaHang = CC.MaHang  
JOIN NHA_CUNG_CAP NCC ON CC.MaNCC = NCC.MaNCC  
WHERE NCC.TenNCC = N'Việt Tiến';

--Câu 22: Quản lý hàng hóa: Cho biết mỗi khách hàng đã bỏ ra bao nhiêu tiền để đặt mua hàng
use[QLHH]
select KH.MAKHACHHANG, sum(GIABAN*SOLUONG*(1-MUCGIAMGIA)) as TONGTIEN
from [dbo].[CTDONHANG] as CTDH
join [dbo].[DONDATHANG] as DDH
on DDH.SOHOADON=CTDH.SOHOADON
join [dbo].[KHACHHANG] as KH
on DDH.MAKHACHHANG=KH.MAKHACHHANG
GROUP BY KH.MAKHACHHANG;

/*Câu 32: Quản lý Bóng đá: Khi phân công huấn luyện viên,
kiểm tra vai trò của huấn luyện viên chỉ thuộc một trong các vai trò sau:
HLV chính, HLV phụ, HLV thể lực, HLV thủ môn.*/

use [QLBD]
alter table [dbo].[HLV_CLB]
add constraint VTHLV check ([VAITRO] in (N'HLV Chính', N'HLV Phụ', N'HLV Thể lực',N'HLV Thủ môn'));

--CÂU 14. Trong công ty có những nhân viên nào có cùng ngày sinh
SELECT TEN,NGAYSINH
FROM NHANVIEN
WHERE NGAYSINH IN(
 SELECT NGAYSINH
 FROM NHANVIEN
 GROUP BY NGAYSINH
 HAVING COUNT(*)>1
)

/*Câu 34: cập nhật lại dữ liệu trong bảng KHACHHANG 
sao cho nếu tên công ty và tên giao dịch của khách hàng trùng với
tên công ty và tên giao dịch của 1 nhà cung cấp nào đó
thì địa chỉ, điện thoại, fax, emal phải giống nhau*/
USE QLHH
UPDATE KHACHHANG 
SET DIACHI = NHACUNGCAP.DIACHI,
	DIENTHOAI = NHACUNGCAP.DIENTHOAI,
	FAX = NHACUNGCAP.FAX,
	EMAIL = NHACUNGCAP.EMAIL
FROM KHACHHANG, NHACUNGCAP
WHERE KHACHHANG.TENCONGTY = NHACUNGCAP.TENCONGTY
AND KHACHHANG.TENGIAODICH = NHACUNGCAP.TENGIAODICH;

-- Cau 4. Cho biết địa chỉ và điện thoại của nhà cung cấp có tên giao dịch VINAMILK là gì? 
SELECT DIACHI, DIENTHOAI FROM NHACUNGCAP WHERE TENGIAODICH LIKE N'%VINAMILK%';

--Câu 8:Loại hàng thực phẩm do những công ty nào cung cấp và địa chỉ các công ty đó là gì ?
SELECT DISTINCT CT.TenCongTy, CT.DiaChi
FROM CongTy CT
JOIN HangHoa HH ON CT.MaCongTy = HH.MaCongTy
JOIN LoaiHang LH ON HH.MaLoai = LH.MaLoai
WHERE LH.TenLoai = 'Thực phẩm';

--Cau 11: cho biết số tiền lương mà công ty phải trả cho mỗi nhân viên là bao nhiêu(lương cơ bản + phụ cấp )
USE QLHH
SELECT MANHANVIEN,
HO+' '+TEN AS TEN_NHAN_VIEN,
LUONGCOBAN + PHUCAP AS TONGLUONG 
FROM NHANVIEN

--CÂU 40: Cho biết tên của môn học có số tín chỉ nhiều nhất                                                                    
SELECT K.TenKhoa,GD.MaKhoaHoc
FROM GIANGDAY GD
JOIN GIAOVIEN GV ON GD.MaGV = GV.MaGV
JOIN KHOA K ON GV.MaKhoa = K.MaKhoa;

--Câu 33: cập nhật giá trị của trường NOIGIAOHANG bằng địa chỉ của khách hàng đối với những đơn hàng chưa xác định được nơi giao hàng( giá thị trường NOIGIAOHANG bằng NULL)                                                                                                                                                                                             UPDATE DONDATHANG
SET NOIGIAOHANG = KHACHHANG.DIACHI
FROM DONDATHANG
JOIN KHACHHANG ON DONDATHANG.MAKHACHHANG = KHACHHANG.MAKHACHHANG
WHERE DONDATHANG.NOIGIAOHANG IS NULL;

--Câu 20: Tổng số tiền mà khách hàng phải trả cho mỗi đơn đặt hàng là bao nhiêu ?
use QLHH
SELECT [SOHOADON],SUM(GIABAN*SOLUONG*(1-MUCGIAMGIA)) AS "Tổng Tiền"
FROM [dbo].[CTDONHANG]
GROUP BY [SOHOADON];

--Cau 5: Cho biết mã và tên các mặt hàng có giá > 100000 và số lượng hiện có ít hơn 50
select mahang, tenhang from mathang where giahang > 100000 and  soluong < 50;

--Cau 35: Tăng lương lên gấp rưỡi cho những nhân viên bán được số lượng hàng nhiều hơn 100 trong năm 2018..
SELECT MaNV, SUM(SoLuong) AS TongSoLuong
FROM DONDATHANG
WHERE YEAR(NgayDatHang)= 2018
GROUP BY MaNV;

UPDATE NHANVIEN
SET LuongNV = LuongNV *1.5
WHERE MaNV IN (
	SELECT MaNV
	FROM DONDATHANG
	WHERE YEAR(NgayDatHang) = 2018
	GROUP BY MaNV
	HAVING SUM(SoLuong) > 100
);

--Câu43 :Xóa khỏi bảng MATHANG những mặt hàng có số lượng bằng 0 và không được đặt mua trong bất kỳ dơn mặt hàng nào                                                                                                                                                                 
DELETE  FROM  mathang  
WHERE  soluong=0  AND    NOT  EXISTS 
	(SELECT sohoadon 
	FROM chitietdathang WHERE 
	mahang=mathang.mahang)

--Câu38: Giả sử trong bảng DONDATHANG có thêm trường SOTIEN cho biết số tiền mà khách hàng phải trả cho mỗi đơn đặt hàng. Hãy tính giá trị cho trường này.                                                                                                                                     Thêm cột sotien                                                                                                                                                                                         ALTER TABLE DONDATHANG ADD SOTIEN MONEY;                                                                                                                               Tính giá trị                                                                                                                                                 
UPDATE DONDATHANG
SET SOTIEN = (
    SELECT SUM(CTDATHANG.SOLUONG * CTDATHANG.GIABAN * (1 - CTDATHANG.MUCGIAMGIA / 100))
    FROM CTDATHANG
    WHERE CTDATHANG.SOHOADON = DONDATHANG.SOHOADON
);

--câu 30:Thống kê xem mỗi mặt hàng trong mỗi tháng và trong cả năm 2021, bán được với số lượng bao nhiêu.Kết quả được hiển thị dưới dạng bảng, hai cột đầu là mã hàng và tên hàng, các cột còn lạo tương ứng với các tháng từ 1 đến 12 và cả năm
SELECT 
    mh.MAHANG,
    mh.TENHANG,
    MONTH(dd.NGAYDATHANG) AS Thang,
    ctdt.SOLUONG
FROM DONDATHANG dd
JOIN CTDATHANG ctdt ON dd.SOHOADON = ctdt.SOHOADON
JOIN MATHANG mh    ON ctdt.MAHANG  = mh.MAHANG
WHERE YEAR(dd.NGAYDATHANG) = 2021
ORDER BY mh.MAHANG, Thang;

--Cau16 :thực hiện câu truy vấn cho biết tên công ty ,tên giao dịch,địa chỉ và điện thoại của các khách hàng và các nhà cung cấp hàng cho công ty.
SELECT TENCONGTY, TENGIAODICH, DIACHI, DIENTHOAI
FROM KHACHHANG
UNION
SELECT TENCONGTY, TENGIAODICH, DIACHI, DIENTHOAI
FROM NHACUNGCAP;

--Câu 6:Cho biết mỗi mặt hàng trong công ty do ai cung cấp
SELECT NCC.TENCONGTY
FROM MATHANG MH 
LEFT  JOIN  NHACUNGCAP  NCC ON MH.MACONGTY = NCC.MACONGTY;

--Cau 37: Giảm 25% lương của các nhân viên không có đơn hàng nào vào năm 2018
UPDATE NHANVIEN
SET LUONGCOBAN = LUONGCOBAN * 0.75
WHERE MANV NOT IN (
    SELECT MANV
    FROM DONDATHANG
    WHERE YEAR(NGAYDATHHANG) = 2018
)

--Cau 7: Công ty Việt Tiến đã cung cấp những mặt hàng nào?
Select MH. TENHANG
From MATHANG MH
Join NHACUNGCAP NCC On MH. MACONGTY=NCC. MACONGTY
Where NCC. TENCONGTY= ‘Việt Tiến’;

--Câu 17: Những mặt hàng nào chưa từng được khách hàng đặt mua ?
SELECT M.MAHANG, M.TENHANG
FROM MATHANG M
LEFT JOIN CTDATHANG C ON M.MAHANG = C.MAHANG
WHERE C.MAHANG IS NULL;

--câu 15: Những đơn đặt hàng nào yêu cầu giao hàng ngay tại công ty đặt hàng và những đơn đó là của công ty nào? 
SELECT D.SOHOADON, N.TENCONGTY 
FROM DONDATHANG D
JOIN KHACHHANG K ON D.MAKHACHHANG = K.MAKHACHHANG
JOIN NHACUNGCAP N ON K.TENGIAODICH = N.TENGIAODICH
WHERE D.NOIGIAOHANG = N.DIACHI;

--CÂU40: Xoá những đơn đặt hàng trước năm 2022 ra khỏi cơ sở dữ liệu.           
DELETE FROM dondathang WHERE ngaydathang<'1/1/2022'

--câu 1: cho biết danh sách các đối tác cung cấp hàng cho công ty
SELECT * FROM NHACUNGCAP;

--câu 2: cho biết mã hàng tên hàng và số lượng các mặt hàng hiện có trong công ty
SELECT MAHANG, TENHANG, SOLUONG 
FROM MATHANG;

--câu 12 thống kê số lượng cầu thủ nước ngoài quốc tịch khác Việt Nam của mỗi câu lạc bộ
SELECT CLB.TENCLB, COUNT(*) AS SoLuongCauThuNuocNgoai
FROM CAUTHU CT
JOIN CAULACBO CLB ON CT.MACLB = CLB.MACLB
WHERE CT.MAQG <> 'VN'
GROUP BY CLB.TENCLB;

--Câu 13: Hãy cho biết những khách hàng nào lại chính là đối tác cung cấp hàng cho công ty ( tức là có cùng tên giao dịch)

SELECT KH.MAKHACHHANG, KH.TENCONGTY AS TEN_KHACHHANG, KH.TENGIAODICH
FROM KHACHHANG KH
JOIN NHACUNGCAP NCC ON KH.TENGIAODICH = NCC.TENGIAODICH;

--Câu 23: Mỗi một nhân viên của công ty đã lập bao nhiêu đơn đặt hàng ( nếu nhân viên chưa hề lập một hóa đơn nào thì cho kết quả là 0 )
SELECT NV.MANHANVIEN, NV.HO + ' ' + NV.TEN AS HOTEN, 
COUNT(DDH.SOHOADON) AS SO_DON_DAT_HANG
FROM NHANVIEN NV
LEFT JOIN DONDATHANG DDH ON NV.MANHANVIEN = DDH.MANHANVIEN
GROUP BY NV.MANHANVIEN, NV.HO, NV.TEN
ORDER BY SO_DON_DAT_HANG DESC;

--Cau 41:Xoá khỏi bảng LOAIHANG những loại hàng hiện không có mặt hàng 
DELETE FROM LOAIHANG
WHERE MALOAIHANG NOT IN (
    SELECT DISTINCT MALOAIHANG
    FROM MATHANG
);

--Cau 6. Cho biết mỗi mặt hàng trong công ty do ai cung cấp. 
SELECT M.MAHANG, M.TENHANG, N.TENCONGTY 
FROM MATHANG M
JOIN NHACUNGCAP N ON M.MACONGTY = N.MACONGTY;

--Cau 27 : Nhân viên nào của công ty bán được số lượng mặt hàng nhiều nhất và số lượng mặt hàng bán được của nhân viên này là bao nhiêu?. 
SELECT
    NV.MANHANVIEN,
    NV.HO,
    NV.TEN,
    SUM(CTDH.SOLUONG) AS TONGDABAN
FROM
    NHANVIEN NV
JOIN
    DONDATHANG DDH ON NV.MANHANVIEN = DDH.MANHANVIEN
JOIN
    CHITIETDATHANG CTDH ON DDH.SOHOADON = CTDH.SOHOADON
GROUP BY
    NV.MANHANVIEN, NV.HO, NV.TEN
ORDER BY
    TONGDABAN DESC LIMIT 1;

--Câu 42: Xóa khỏi bảng khách hàng những khách hàng hiện không có bất kì đơn đặt hàng nào cho công ty
delete k from KHACHHANG k 
left join DONDATHANG d on d.MAKHACHHANG=k.MAKHACHHANG 
where d.MAKHACHHANG is null;

--Câu 10: Cho biết đơn hàng số 1 do ai đặt và do nhân viên nào lập, thời gian và địa điểm giao hàng ở đâu?
SELECT 
    DDH.SOHOADON, 
    KH.TENGIAODICH AS TEN_KHACH_HANG, 
    NV.HO + ' ' + NV.TEN AS TEN_NHAN_VIEN, 
    DDH.NGAYDATHANG, 
    DDH.NGAYGIAOHANG, 
    DDH.NOIGIAOHANG
FROM DONDATHANG DDH
JOIN KHACHHANG KH ON DDH.MAKHACHHANG = KH.MAKHACHHANG
JOIN NHANVIEN NV ON DDH.MANHANVIEN = NV.MANHANVIEN
WHERE DDH.SOHOADON = '1';

--Câu 20: Tổng số tiền mà khách hàng phải trả cho mỗi đơn đặt hàng là bao nhiêu?
SELECT 
    CTDH.SOHOADON,
    SUM(CTDH.GIABAN * CTDH.SOLUONG * (1 - CTDH.MUCGIAMGIA)) AS TONG_TIEN
FROM CTDATHANG CTDH
GROUP BY CTDH.SOHOADON;

--Câu 25: hãy cho biết tổng số tiền lời mà công ty thu được từ mỗi mặt hàng trong năm 2021
SELECT 
     mh.TenMH, 
     SUM((cthd.SoLuong * mh.GiaBan) - (cthd.SoLuong * mh.GiaNhap)) AS TongTienLoi 
 FROM 
     MatHang mh 
 JOIN 
     ChiTietHoaDon cthd ON mh.MaMH = cthd.MaMH 
 JOIN 
     HoaDon hd ON cthd.MaHD = hd.MaHD 
 WHERE 
     YEAR(hd.NgayLap) = 2021 
 GROUP BY 
     mh.TenMH;

--Câu 19: Những nhân viên nào của công ty có lương cơ bản nhiều nhất ?
SELECT * 
FROM NHANVIEN 
WHERE LUONGCOBAN = (SELECT MAX(LUONGCOBAN) FROM NHANVIEN);

-- Câu 29: Số tiền nhiều nhất mà mỗi khách hàng đã từng bỏ ra để đặt hàng trong các đơn đặt hàng là bao nhiêu ?
SELECT DONDATHANG.MAKHACHHANG, MAX(TONG_TIEN) AS SO_TIEN_NHIEU_NHAT
FROM (
    SELECT DONDATHANG.SOHOADON, DONDATHANG.MAKHACHHANG, 
           SUM(CTDATHANG.SOLUONG * CTDATHANG.GIABAN) AS TONG_TIEN
    FROM DONDATHANG
    JOIN CTDATHANG ON DONDATHANG.SOHOADON = CTDATHANG.SOHOADON
    GROUP BY DONDATHANG.SOHOADON, DONDATHANG.MAKHACHHANG
) AS DON_HANG
GROUP BY DONDATHANG.MAKHACHHANG;

--Cau 21: trong năm 2021, những mặt hàng nào chỉ được đặt mua đúng một lần
Select CT_MAHANG, MH_TENHANG
from CTDATHANG CT
join DONDATHANG DD on CT_SOHOADON = DD_SOHOADON
join MATHANG MH on CT_MATHANG = MH_MATHANG
where year(DD_NGAYDATHANG) = 2021
group by CT_MAHANG, MH_TENHANG
having count(CT_SOHOADON) = 1;

--Cau 31: cập nhật lại giá trị trường NGAYCHUYENHANG của những bản ghi có NGAYCHUYENHANG chưa xác định(NULL) trong bảng DONDATHANG bằng với giá trị của trường NGAYDATHANG
update DONDATHANG
set NGAYCHUYENHANG = NGAYDATHANG
where NGAYCHUYENHANG is NULL;

--CÂU 39: xoá khỏi bảng NHANVIEN những nhân viên đã làm việc trong công ty quá 40 năm : 
DELETE FROM NHANVIEN
WHERE DATEDIFF(YEAR, NGAYVAOLAM, GETDATE()) > 40;

--Cau 3: cho biết họ tên, địa chỉ và năm bắt đầu làm việc của các nhân viên trong công ty 
SELECT HO + ' ' + TEN AS HOTEN, DIACHI, YEAR(NGAYLAMVIEC) AS NAM_BAT_DAU
FROM NHANVIEN;

--Câu 33:Cập nhật giá trị của trường NOIGIAOHANG trong bang DONDATHANG bằng địa chỉ của khách hành đối với những đơn đặt hàng chưa xác định được nơi giao hàng (giá trị trường NOIGIAOHANG bằng NULL)
UPDATE DONDATHANG
SET NOIGIAOHANG = (
    SELECT DIACHI
    FROM KHACHHANG
    WHERE DONDATHANG.MAKHACHHANG = KHACHHANG.MAKHACHHANG
)
WHERE NOIGIAOHANG IS NULL;

--câu 26: Hãy cho biết tổng số lượng hàng của mỗi mặt hàng mà công ty đã có (tổng số hàng hiện tại và đã bán).

SELECT 
    MH.MAHANG, 
    MH.TENHANG, 
    IFNULL(MH.SOLUONG, 0) AS SoLuongHienTai, 
    IFNULL(SUM(CT.SOLUONG), 0) AS SoLuongDaBan,
    (IFNULL(MH.SOLUONG, 0) + IFNULL(SUM(CT.SOLUONG), 0)) AS TongSoLuong
FROM MATHANG MH
LEFT JOIN CTDATHANG CT ON MH.MAHANG = CT.MAHANG
GROUP BY MH.MAHANG, MH.TENHANG, MH.SOLUONG;

--Câu 18: Những nhân viên nào của công ty chưa từng lập bất kỳ một hóa đơn đặt hàng nào?
SELECT N.MaNV, N.TenNV
FROM NhanVien N
LEFT JOIN HoaDonDatHang H ON N.MaNV = H.MaNV
WHERE H.MaHD IS NULL;

--Câu 28: 
--Bước 1: Tìm câu lạc bộ có thứ hạng thấp nhất ở vòng 3
SELECT MaCLB
FROM BangXepHang
WHERE Nam = 2021 AND Vong = 3
ORDER BY ThuHang DESC
LIMIT 1;

--Bước 2: Lấy danh sách các trận đấu của câu lạc bộ này
SELECT T.NgayTD, T.TenSan, C1.TenCLB AS TenCLB1, C2.TenCLB AS TenCLB2, T.KetQua
FROM TranDau T
JOIN CLB C1 ON T.MaCLB1 = C1.MaCLB
JOIN CLB C2 ON T.MaCLB2 = C2.MaCLB
WHERE (T.MaCLB1 = (SELECT MaCLB
FROM BangXepHang
WHERE Nam = 2021 AND Vong = 3
ORDER BY ThuHang DESC
LIMIT 1)
OR T.MaCLB2 = (SELECT MaCLB
FROM BangXepHang
WHERE Nam = 2021 AND Vong = 3
ORDER BY ThuHang DESC
LIMIT 1));

-- Câu 36: Tăng phụ cấp lên bằng 50% lương cho những nhân viên bán được nhiều hàng nhất --
UPDATE NHANVIEN SET PHUCAP = LUONGCOBAN*0.5
WHERE MANHANVIEN IN( SELECT TOP 1 MANHANVIEN
					 FROM DONDATHANG DDH INNER JOIN CTDONHANG CTDH ON DDH.SOHOADON = CTDH.SOHOADON
					 GROUP BY MANHANVIEN
					 ORDER BY SUM(SOLUONG) DESC)

--cau12:Cho biết đơn đặt hàng số 3 đã mua những mặt hàng nào và số tiền mà khách hàng phải trả cho mỗi mặt hàng la bao nhiêu (TIENPHAITRA = SOLUONG xGIABAN-SOLUONGxGIABANxMUCGIAMGIA/100)
SELECT 
    CTDATHANG.MAHANG,
    MH.TENHANG,
    CTDATHANG.SOLUONG,
    CTDATHANG.GIABAN,
    CTDATHANG.MUCGIAMGIA,
    (CTDATHANG.SOLUONG * CTDATHANG.GIABAN - CTDATHANG.SOLUONG * CTDATHANG.GIABAN * CTDATHANG.MUCGIAMGIA / 100) AS TIENPHAITRA
FROM CHITIETDATHANG CTDATHANG
JOIN MATHANG MH ON CTDATHANG.MAHANG = MH.MAHANG
WHERE CTDATHANG.SOHOADON = '3';

--câu 8: loại hàng thực phẩm do những công ty nào cung cấp và địa chỉ của các công ty đó là gì
SELECT DISTINCT NC.MACONGTY, NC.TENCONGTY, NC.DIACHI
FROM NHACUNGCAP NC
JOIN MATHANG MH ON NC.MACONGTY = MH.MACONGTY
JOIN LOAIHANG LH ON MH.MALOAIHANG = LH.MALOAIHANG
WHERE LH.TENLOAIHANG = 'Thực phẩm';

--câu 18 liệt kê các cầu thủ đang thi đấu trong các câu lạc bộ có thứ hạng ở vòng 3 năm 2021 lớn hơn 5 hoặc nhỏ hơn 3
SELECT CT.MACT, CT.HOTEN, CT.VITRI, CLB.TENCLB, BXH.HANG
FROM CAUTHU CT
JOIN CAULACBO CLB ON CT.MACLB = CLB.MACLB
JOIN BANGXH BXH ON CLB.MACLB = BXH.MACLB
WHERE BXH.NAM = 2021 
    AND BXH.VONG = 3
    AND (BXH.HANG > 5 OR BXH.HANG < 3)

--Câu 29: Số tiền nhiều nhất mà mỗi khách hàng đã từng bỏ ra để đặt hàng trong các đơn đặt hàng là bao nhiêu?
SELECT 	KH.MAKHACHHHANG,
	MAX(TONGTIENDH) AS SOTIENLONNHAT
FROM KHACHHANG KH
JOIN DONDATHANG DDH ON KH.MAKHACHHANG = DDH.MAKHACHHANG
JOIN (
	SELECT	CTDH.SOHOADON,
		SUM((CTDH.SOLUONG * CTDH.GIABAN) * (1 - CTDH.MUCGIAMGIA)) AS TONGTIENDH
	FROM 	CHITIETDATHANG CTDH
	GROUP BY CTDH.SOHOADON
	) AS TONGTIEN ON DDH.SOHOADON = TONGTIEN.SOHOADON
GROUP BY KH.MAKHACHHANG;

--Cau 24: Cho biet tong so tien hang ma cua hang thu duoc trong moi thang cua nam 2021(thoi gian duoc tinh theo ngay dat hang)
 select month(dh.ngaydathang) as THANG, SUM(ct.soluong*ct.giaban-ct.soluong*ct.giaban*ct.mucgiamgia/100) as TONGTIEN
 from DONDATHANG dh join CTDATHANG ct on dh.SOHOADON=ct.SOHOADON
 group by dh.NGAYDATHANG

--Cau28:Đơn Đặt hàng nào có số lượng mặt hàng được đặt mua ít nhất:
SELECT SOHOADON
FROM CHITIETDATHANG
WHERE SOLUONG=(SELECT MIN(SOLUONG)FROM CHITIETDATHANG);

--câu 31: cập nhật lại giá trị trường NGAYCHUYENHANG của những bản ghi có NGAYCHUYENHANG chưa xác nhận (null) trong bảng DONDATHANG bằng với giá trị của trường NGAYDATHANG                                               UPDATE DONDATHANG
SET NGAYCHUYENHANG = NGAYDATHANG
WHERE NGAYCHUYENHANG IS NULL;

--Câu 32:Tăng số lượng hàng của những mặt hàng do công ty VINAMILK cung cấp lên gấp đôi.
UPDATE HANG_HOA
SET SoLuong = SoLuong * 2
FROM HANG_HOA AS HH
JOIN CUNG_CAP AS CC ON HH.MaHang = CC.MaHang
JOIN NHA_CUNG_CAP AS NCC ON CC.MaNCC = NCC.MaNCC

--Cau 29. Số tiền nhiều nhất mà mỗi khách hàng đã từng bỏ ra để đặt hàng trong các đơn đặt hàng là bao nhiêu?
select d.MAKHACHHANG, max(C.SOLUONG * (C.GIABAN * (1-MUCGIAMGIA/100)) as SO_TIEN_NHIEU_NHAT
from DONDATHANG d join CTDONHANG c on d.SOHOADON=c.SOHOADON group by d.MAKHACHHANG;