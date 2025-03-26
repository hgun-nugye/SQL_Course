--câu 82: cho biết có bao nhiêu đề án ở thành phố Hồ Chí Minh
 use QLDA
 SELECT TENDA
 FROM DEAN
 WHERE DDIEM_DA ='TPHCM'

--Câu 103: Tên đề án thuộc các phòng ban có địa điểm ở TP.HCM
SELECT DISTINCT D.TENDA
FROM DEAN D
JOIN DDIEMPB D1 ON D.MAPB = D1.MAPB
WHERE D1.DIADIEM LIKE '%Hà Nội%';

--Câu 103:  Nhân viên là trưởng phòng và cư ngụ ở TP.HCM
SELECT NV.HONV, NV.TENLOT, NV.TENNV
FROM NHANVIEN NV
JOIN PHONGBAN PB ON NV.MANV = PB.TRUONGPHONG
WHERE NV.DIACHI LIKE '%TPHCM%';

--Câu 106: Thêm vào quan hệ PHANCONG các bộ là các đề án mà NV3 chưa được phân công
insert into PHANCONG (MANV, MADA, THOIGIAN)
select  'NV3', DA.MADA, null
from dean DA where DA.MADA not in(
	select PC.MADA from PHANCONG PC where MANV = 'NV3'

--Câu 3: Cho biết những người có họ 'Le' và tên bắt đầu bằng ký tự 'N'
SELECT * 
FROM NHANVIEN 
WHERE HONV = 'LE' 
AND TENNV LIKE 'N%';

/*--Câu 73:  
SELECT 
	dh.MaDH,
	kh.TenKH AS TenKhachHang,
	nv.TenNV AS TenNhanVienLap,
	dh.NgayLap,
	dh.DiaDiemGiaoHang
FROM DonHang dh
JOIN KhachHang kh ON dh.MaKH = kh.MaKH
JOIN NhanVien nv ON dh.MaNV = nv.MaNV
WHERE dh.MaDH = 'DH01';*/

--Câu 21:Tên phòng ban có trưởng phòng là nhân viên nữ
SELECT p.TENPB
FROM PHONGBAN p
JOIN NHANVIEN nv ON p.TRUONGPHONG = nv.MANV
WHERE nv.PHAI = 'Nữ';


--Câu 99: Đối với từng phòng ban, cho biết tên phòng ban, lương trung bình của nữ nhân viên, lương trung bình của nam nhân viên
USE [QLDA]  
SELECT pb.TenPB,  
       AVG(CASE WHEN nv.GioiTinh = 'Nu' THEN nv.Luong END) AS LuongTB_Nu,  
       AVG(CASE WHEN nv.GioiTinh = 'Nam' THEN nv.Luong END) AS LuongTB_Nam  
FROM [dbo].[NHANVIEN] nv  
JOIN [dbo].[PHONGBAN] pb ON nv.MaPB = pb.MaPB  
GROUP BY pb.TenPB;

--Câu 32: Phòng ban nào chỉ phụ trách các đề án ở Hà Nội
select distinct mapb
from dean
where ddiem_da = N'Ha Noi'

--câu 84: Cho biết số năm thâm niên của từng trưởng phòng 
SELECT MAPB, TENPB, TRUONGPHONG, 
       DATEDIFF(YEAR, NG_NHANCHUC, GETDATE()) AS SoNamLamViec
FROM PHONGBAN;

--câu 79:Cho biét số đề án được phân công của từng nhân viên (gồm mã số, tên, số lượng đề án được phân công)
SELECT 
    NV.MANV, 
    CONCAT(NV.HONV, ' ', NV.TENLOT, ' ', NV.TENNV) AS HOTEN,
    COUNT(PC.MADA) AS SO_LUONG_DE_AN
FROM 
    NHANVIEN NV
LEFT JOIN 
    PHANCONG PC ON NV.MANV = PC.MANV
GROUP BY 
    NV.MANV, HOTEN;

--Câu 86: Cho biết có bao nhiêu tên đề án là " sản phẩm ".
SELECT COUNT(*) AS SoLuongDeAn
FROM DEAN
WHERE TENDA LIKE '%san pham%';

--Câu 85: Cho biết số lượng địa điểm của từng phòng ban
SELECT MAPB, COUNT(*) AS SoLuongDiaDiem
FROM DDIEMPB
Group by MAPB

--Câu 107: Liệt kê tên phòng ban, tên trưởng phòng của các phòng ban có nhiều nhân viên nữ nhất
SELECT TOP 1 pb.TENPB, tp.TENNV AS TENTRUONGPHOONG --COUNT(nv.MANV) AS SoLuongNu
FROM PHONGBAN pb
JOIN NHANVIEN nv ON pb.MAPB = nv.MAPB
JOIN NHANVIEN tp ON tp.MANV = pb.TRUONGPHONG  
WHERE nv.PHAI = 'NU' 
GROUP BY pb.TENPB, tp.TENNV 
ORDER BY COUNT(nv.MANV) DESC

--Câu 78: Cho biết những người có ngày sinh trong quý 3
SELECT *
FROM NHANVIEN
WHERE MONTH(NGAYSINH) BETWEEN 7 AND 9;

--Câu 81: Tên nhân viên >=30 tuổi được phân công làm việc ở TP.HCM
SELECT
    NV.TENNV
FROM
    NHANVIEN NV
JOIN
    PHANCONG PC ON NV.MANV = PC.MANV
JOIN
    DEAN DA ON PC.MADA = DA.MADA
WHERE
    DATEDIFF(YEAR, NV.NGAYSINH, GETDATE()) >= 30
    AND DA.DDIEM_DA = 'TPHCM';

--Câu 90: Mã nhân viên 'NV5' có mức lương cao nhất hay không? (trả về có hoặc không)
select
	case 
		when exists(
			select 1 from NHANVIEN 
			where MaNV='NV5' and LUONG >= (select max(LUONG) from NHANVIEN)
		)
		then 'Yes'
		else 'No'
	end as MaxLuong_NV5;

--Câu 84: cho biet so nam tham nien (so nam lam viec) cua tung truong phong
SELECT PB.TENPB, PB.TRUONGPHONG, DATEDIFF(YEAR,NG_NHANCHUC,GETDATE()) AS NAM_LAM_VIEC
FROM PHONGBAN PB
WHERE PB.TRUONGPHONG IS NOT NULL;

--Câu 100: Tăng 10% lương đối với các nhân viên là nữ và được phân công làm việc cho đề án ở Vũng Tàu hay Nha Trang
UPDATE NHANVIEN
SET LUONG = LUONG * 1.1
WHERE MANV IN (
    SELECT DISTINCT nv.MANV
    FROM NHANVIEN nv
    JOIN PHANCONG pc ON nv.MANV = pc.MANV
    JOIN DEAN da ON pc.MADA = da.MADA
    WHERE nv.PHAI = 'Nữ' 
    AND (da.DDIEM_DA = 'Vũng Tàu' OR da.DDIEM_DA = 'Nha Trang')
);

--Câu 109: Tên nhân viên được phân công làm việc cho tất cả các đề án của P2
Use QLDA; 
Select NV.TENNV 
From NHANVIEN NV 
Join PHANCONG PC On NV.MANV = PC.MANV 
Join DEAN DA On PC.MADA = DA.MADA 
Where DA.MAPB = 'P2' 
Group By NV.MANV, NV.TENNV 
Having Count(Distinct DA.MADA) = ( 
	Select Count(*) 
	From DEAN 	
	Where MAPB = 'P2' 
);

--Câu 74: Cho biết tên ,tuổi của từng nhân viên
SELECT TenNV, YEAR(CURDATE()) - YEAR(NgaySinh) AS Tuoi
FROM NhanVien;

--Câu 89: xoá các nhân viên có số thân nhân >=3
SELECT * 
FROM NHANVIEN
WHERE MANV IN (
    SELECT MANV
    FROM THANNHAN
    GROUP BY MANV
    HAVING COUNT(*) >= 3
);

--Câu 87: Cho biết tên phòng ban, địa điểm phòng, tên đề án,
--địa điểm đề án của những đề án có địa điểm của đề án trùng với địa điểm của phòng

SELECT   PB.TENPB AS Ten_Phong,
    DPB.DIADIEM AS Dia_Diem_Phong,
    DA.TENDA AS Ten_De_An,
    DA.DDIEM_DA AS Dia_Diem_De_An
FROM DEAN DA
JOIN DDIEMPB DPB ON DA.DDIEM_DA = DPB.DIADIEM
JOIN PHONGBAN PB ON DA.MAPB = PB.MAPB;

--Câu 75: Cho biết thông tin về những người có phái là nam và địa chỉ trên đường "Tran Hung Dao"
SELECT * FROM NHANVIEN
WHERE phai = 'Nam' AND diachi = 'Tran Hung Dao';

--câu 104:Truy vấn tên nhân viên là trưởng phòng có ngày nhận chức sau cùng.
SELECT NV.HONV, NV.TENLOT, NV.TENNV, PB.NG_NHANCHUC
FROM PHONGBAN PB
JOIN NHANVIEN NV ON PB.TRUONGPHONG = NV.MANV
ORDER BY PB.NG_NHANCHUC DESC
LIMIT 1;

--Câu 98: Nhân viên có mã số 'NV4' lớn tuổi nhất hay không? (trả lời có hoặc không)
SELECT ngaysinh
FROM NHANVIEN
WHERE maNV = 'NV4'
AND ngaysinh = (SELECT MIN(ngaysinh) FROM NHANVIEN);

--Câu 92: Cho biết tên nhân viên, tên đề án, số giờ làm việc nhiều nhất của từng đề án
select NV.HONV, NV.TENLOT, NV.TENNV, DA.TENDA, PC.THOIGIAN
from PHANCONG PC
join NHANVIEN NV on PC.MANV=NV.MANV
join DEAN DA on PC.MADA=DA.MADA
where PC.THOIGIAN=(
	select max(PC1.THOIGIAN)
	from PHANCONG PC1
	where PC1.MADA=PC.MADA
)
--Câu 109: cho biết tên đề án, tên nhân viên, số giờ của từng đề án được phân cống và số giờ làm việc nhiều nhất
SELECT 
    DEAN.TENDA AS TenDeAn,
    NHANVIEN.TENNV AS TenNhanVien,
    PHANCONG.THOIGIAN AS SoGioLamViec,
    MAX_THOIGIAN.SoGioLamViecNhieuNhat
FROM 
    PHANCONG
JOIN 
    DEAN ON PHANCONG.MADA = DEAN.MADA
JOIN 
    NHANVIEN ON PHANCONG.MANV = NHANVIEN.MANV
JOIN 
    (SELECT TENDA, MAX(THOIGIAN) AS SoGioLamViecNhieuNhat
     FROM PHANCONG
     JOIN DEAN ON PHANCONG.MADA = DEAN.MADA
     GROUP BY TENDA) AS MAX_THOIGIAN
ON DEAN.TENDA = MAX_THOIGIAN.TENDA;

--Câu 77: cho biết những người có ngày sinh trong tháng 7 năm 1978:
SELECT*FROM NHAN VIEN
WHERE MONTH(NGAYSINH)=7
AND YEAR(NGAYSINH)=1978

--Câu 110: đối với từng nhân viên :Cho biết tên nhân viên, mã phòng ban và tên trưởng phòng 
SELECT NV.TENNV, NV.MAPB, TP.TENNV AS TEN_TRUONGPHONG
FROM NHANVIEN NV
JOIN PHONGBAN PB ON NV.MAPB = PB.MAPB
JOIN NHANVIEN TP ON PB.TRUONGPHONG = TP.MANV;

--Câu 95: de an, so nhan vien tham gia, tong so gio de an
select MADA, count(MANV) as TongNV, sum(THOIGIAN) as TongSoGio
from PHANCONG
group by MADA

--Câu 106: Thêm vào quan hệ PHANCONG các bộ là đề án mà NV3 chưa được phân công
insert into PHANCONG (MANV, MADA, THOIGIAN)
select  'NV3', DA.MADA, null
from DEAN DA where not exists(
	select 1
	from PHANCONG PC 
	where PC.MANV = 'NV3' and PC.MADA = DA.MADA
)

-- check NV3 đã đc thêm các đề án chưa
select mada from phancong where manv = 'nv3'

--Câu 78: Cho biết người có ngày sinh trong quý 3. 
SELECT *
FROM NHANVIEN
WHERE MONTH(NGAYSINH) BETWEEN 7 AND 9;

--Câu 81: Tên nhân viên >= 30 tuổi được phân công cho đề án ở TPHCM 
SELECT
    NV.TENNV
FROM
    NHANVIEN NV
JOIN
    PHANCONG PC ON NV.MANV = PC.MANV
JOIN
    DEAN DA ON PC.MADA = DA.MADA
WHERE
    DATEDIFF(YEAR, NV.NGAYSINH, GETDATE()) >= 30
    AND DA.DDIEM_DA = 'TPHCM';

--Câu 84: cho biết số năm thâm niên của từng trưởng phòng
SELECT MAPB, TENPB, TRUONGPHONG, 
       DATEDIFF(YEAR, NG_NHANCHUC, GETDATE()) AS SoNamLamViec
FROM PHONGBAN;

--Câu 91: Tên nhân viên đã có gia đình (thân nhân) nhưng chưa có con  
select [TENNV]                                                                                                                                                                                      SELECT DISTINCT NV.MANV, NV.HONV, NV.TENLOT, NV.TENNV
FROM NHANVIEN NV
JOIN THANNHAN TN ON NV.MANV = TN.MANV
WHERE TN.QUANHE <> 'Con';

--câu 101: Tên và địa chỉ các nhân viên làm việc cho một đề án ở thành phố
-- nhưng địa điểm phòng ban mà họ trực thuộc đều không ở trong thành phố đó
SELECT HONV, TENLOT, TENNV, DIACHI
FROM PHANCONG 
JOIN NHANVIEN ON MANV = MANV
JOIN DEAN ON MADA = MADA
JOIN PHONGBAN ON MAPB = MAPB
WHERE DDIEM_DA <> DIADIEM;

--Câu 92: Đối với từng đề án, cho biết tên nhân viên, tên đề án, số giờ làm việc nhiều nhất
select NV.HONV, NV.TENLOT, NV.TENNV, DA.TENDA, PC.THOIGIAN
from PHANCONG PC
join NHANVIEN NV on PC.MANV=NV.MANV
join DEAN DA on PC.MADA=DA.MADA
where PC.THOIGIAN=(
	select max(PC1.THOIGIAN)
	from PHANCONG PC1
	where PC1.MADA=PC.MADA
)

--Câu 102: Tên các đề án thuộc các phòng ban có địa điểm ở Hà Nội 
SELECT DISTINCT D.TENDA
FROM DEAN D
JOIN DDIEMPB D1 ON D.MAPB = D1.MAPB
WHERE D1.DIADIEM LIKE '%Hà Nội%';
