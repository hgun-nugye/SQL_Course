 --Câu 32: Cho biết tên tất cả sinh viên, điểm trung bình, số lượng khóa học đã tham gia
 use QLSV
 SELECT TEN,DIEM,MAKHOAHOC
 FROM SINHVIEN, KETQUA

 --Câu 71: Xóa tất cả kết quả học tập của Sinh viên 'SV002'
use [QLSV]
delete from [KETQUA] where MaSV='SV002';

--Câu 21: Có bao nhiêu Sinh viên?
use [QLSV]
select count(MSSV) as SoLuongSV
from [dbo].[SINHVIEN];

--Câu 49: Cho biết tên môn học, tên sinh viên, điểm của các sinh viên học những môn học có số tín chỉ là thấp nhất
USE [QLSV]  
SELECT mh.TenMH, sv.HoTen, d.Diem  
FROM [dbo].[DIEM] d  
JOIN [dbo].[SINHVIEN] sv ON d.MSSV = sv.MSSV  
JOIN [dbo].[MONHOC] mh ON d.MaMH = mh.MaMH  
WHERE mh.SoTinChi = (SELECT MIN(SoTinChi) FROM [dbo].[MONHOC]);

--Câu 38: Điểm cao nhất mà sinh viên đã đạt được trong các khóa học 
SELECT KQ.MaKhoaHoc, SV.MSSV, SV.Ten, KQ.Diem
FROM KETQUA KQ
JOIN SINHVIEN SV ON KQ.MaSV = SV.MSSV
WHERE KQ.Diem = (
    SELECT MAX(Diem) FROM KETQUA WHERE MaKhoaHoc = KQ.MaKhoaHoc
);

--Câu 41: Cho biết tên khoa có số lượng Cán bộ Giảng dạy ít nhất                                                                                                                                                                                                          SELECT TenKhoa
FROM KHOA
WHERE SL_CBGD = (SELECT MIN(SL_CBGD) FROM KHOA);

--Câu 45
SELECT SV.Ten, KQ.Diem, MH.TenMH
FROM KETQUA AS KQ
JOIN SINHVIEN AS SV ON KQ.MaSV = SV.MSSV
JOIN MONHOC AS MH ON KQ.MaMH = MH.MaMH
WHERE KQ.Diem = (
    SELECT MAX(Diem) 
    FROM KETQUA 
    WHERE MaMH = KQ.MaMH
);

--Câu 43: Cho biết tên Sv có điểm thi môn CSDL cao nhất
SELECT SV.MSSV, SV.Ten, SV.GioiTinh, SV.DiaChi, SV.DienThoai, SV.MaKhoa, KQ.Diem
FROM SINHVIEN SV
JOIN KETQUA KQ ON SV.MSSV = KQ.MaSV
JOIN MONHOC MH ON KQ.MaKhoaHoc = MH.MaMH
WHERE MH.TenMH = 'CSDL' 
  AND KQ.Diem = (
    SELECT MAX(KQ1.Diem)
    FROM KETQUA KQ1
    JOIN MONHOC MH1 ON KQ1.MaKhoaHoc = MH1.MaMH
    WHERE MH1.TenMH = 'CSDL'
  );

--Câu 2: Cho biết tên môn học và số tín chỉ từng môn học
SELECT TenMH, SoTC
FROM MONHOC;

--Câu 52: Cho biết tên các môn học không được tổ chức trong năm 2021 
SELECT DISTINCT TenMH
FROM MONHOC
WHERE MaMH NOT IN (
    SELECT MaMH
    FROM KETQUA
    WHERE Nam = 2021
);

--Câu 29: Cho biết số lượng điểm >=8 của từng sinh viên
SELECT 
    SV.MSSV, 
    SV.Ten, 
    COUNT(KQ.Diem) AS SoLuongDiemCao
FROM 
    SINHVIEN SV
JOIN 
    KETQUA KQ ON SV.MSSV = KQ.MaSV
WHERE 
    KQ.Diem >= 8
GROUP BY 
    SV.MSSV, SV.Ten;

--Câu 35: Cho biết mã, tên, địa chỉ và điểm của các sinh viên có điểm trung bìnhn > 8.5
Select sv.MSSV, sv.Ten, sv.DiaChi, kq.Diem 
From SINHVIEN as sv
Join KETQUA as kq on sv.MSSV = kq.MaSV
Where kq.Diem>8.5

--Câu 36: Cho biết mã khoá học, học kì, năm số lượng sinh viên tham gia cùng những 
--khoá học có số lượng sinh viên tham gia (đã có điểm) từ 2 đến 4 sinh viên.
SELECT GD.MaKhoaHoc, GD.HocKy, GD.Nam, COUNT(KQ.MSSV) AS SoLuongSV
FROM GIANGDAY GD
JOIN KETQUA KQ ON GD.MaKhoaHoc = KQ.MaKhoaHoc
GROUP BY GD.MaKhoaHoc, GD.HocKy, GD.Nam
HAVING COUNT(KQ.MSSV) BETWEEN 2 AND 4;

--Câu 19: Cho biết mã, tên sinh viên có 1 môn học nào đó trên 8 điểm (các môn khác có thể <=8)
select distinct MSSV, Ten
from SINHVIEN 
join KETQUA on SINHVIEN.MSSV=KETQUA.MaSV
where KETQUA.Diem>8

--Câu 69: Thêm các field SLMon, DTB, XL vào table Sinh viên
ALTER TABLE SINHVIEN
ADD  SLMon INT ,
  DTB FLOAT ,
  XL VARCHAR(20) ;

--Câu 53: Tên những khoa chưa có sinh viên theo học 
SELECT K.TENKHOA 
FROM KHOA K
LEFT JOIN SINHVIEN S ON K.MAKH = S.MAKH
WHERE S.MASV IS NULL;

--Câu 3: Cho biết kết quả học tập của sinh viên có mã số 'SV03'
SELECT K.MASV, M.TENMH, K.DIEM 
FROM KETQUA K
JOIN MONHOC M ON K.MAKH = M.MAMH
WHERE K.MASV = 'SV03';

--Câu 7: Cho biết tên các giáo viên có ký tự đầu tiên của họ và tên có các ký tự 'P' hoặc 'L'
SELECT TenGV 
FROM GIAOVIEN
WHERE TenGV LIKE '% P%' OR TenGV LIKE '% L%' 
			OR TenGV  LIKE  'P%' OR  TenGV LIKE 'L%';


--Câu 57: Cho biết tên sinh viên, số lượng môn mà sinh viên chưa học 
SELECT sv.Ten, COUNT(DISTINCT mh.MaMH) AS SoLuongMonChuaHoc
FROM SINHVIEN sv
CROSS JOIN MONHOC mh 
WHERE mh.MaMH NOT IN (
    SELECT gd.MaMH
    FROM KETQUA kq
    JOIN GIANGDAY gd ON kq.MaKhoaHoc = gd.MaKhoaHoc
    WHERE kq.MSSV = sv.MSSV
)
GROUP BY sv.Ten;

--Câu 14: Cho biết tên khoa, tên môn học mà những sinh viên trong khoa đã học 
Select TenKhoa,TenMH
From SINHVIEN SV, KHOA K, GIANGDAY GD, KETQUA KQ, MONHOC MH
Where SV.MaKhoa=K.MaKhoa AND SV.MSSV=KQ.MaSV AND KQ.MaKhoaHoc=GD.MaKhoaHoc AND GD.MaMH=MH.MaMH;

--Câu 64: Cho biết tên sinh viên tham gia đủ các môn học 
SELECT SV.Ten
 FROM KETQUA KQ1, SINHVIEN SV
 WHERE SV.MSSV=KQ1.MSSV AND NOT EXISTS(
  SELECT *
  FROM GIANGDAY GD
  WHERE NOT EXISTS(
   SELECT *
   FROM KETQUA KQ2
   WHERE KQ2.MaKhoaHoc =GD.MaKhoaHoc AND KQ1.MaSV=KQ2.MaSV));

-- Câu 56: Cho biết tên những khoa không có sinh viên theo học  
select khoa.Makhoa, khoa.TenKhoa
from khoa
where khoa.Makhoa not in (
	select distinct SV.makhoa from SINHVIEN SV 
)

--Câu 22: Có bao nhiêu giáo viên 
SELECT COUNT(DISTINCT MaGV) AS SoLuongGiaoVien FROM GIAOVIEN;

--Câu 28: Cho biết mã, tên, địa chỉ và điểm trung bình của từng sinh viên 
SELECT
    SINHVIEN.MSSV,
    SINHVIEN.Ten,
    SINHVIEN.DiaChi,
    AVG(KETQUA.Diem) AS DiemTrungBinh
FROM
    SINHVIEN
JOIN
    KETQUA ON SINHVIEN.MSSV = KETQUA.MSSV
GROUP BY
    SINHVIEN.MSSV,
    SINHVIEN.Ten,
    SINHVIEN.DiaChi;
)

--Câu 26: Có bao nhiêu môn học được giảng dạy trong học kỳ 1 năm học 2021
SELECT COUNT(DISTINCT MaMH)
FROM GIANGDAY
WHERE Hocky = 1 AND Nam = 2021;

--Câu 31: Cho biết tên khoa, số lượng khóa học mà giáo viên của khoa có tham gua giảng dạy 
SELECT
    KHOA.TenKhoa,
    COUNT(DISTINCT GIANGDAY.MaKhoaHoc) AS SoLuongKhoaHoc
FROM
    KHOA
JOIN
    GIAOVIEN ON KHOA.MaKhoa = GIAOVIEN.MaKhoa
JOIN
    GIANGDAY ON GIAOVIEN.MaGV = GIANGDAY.MaGV
GROUP BY
    KHOA.TenKhoa;

--Câu 33: Cho biết số lượng tín chỉ mà từng sinh viên đã tham gia (gồm MSSV, tên SV, số lượng tín chỉ)
SELECT
	sv.MSSV,
	sv.TenSV,
	SUM(hp.SoTinChi) AS TongSoTinChi
FROM
	SinhVien sv
JOIN DangKy dk ON sv.MSSV = dk.MSSV
JOIN HocPhan hp On dk.MaHP = hp.MaHP
GROUP BY
	sv.MSSV, sv.TenSV;

--Câu 11: Cho biết điểm của sinh viên theo từng môn học 
select SV.MSSV,SV.Ten as TenSinhVien,MH.MaMH,MH.TenMH,KQ.Diem
from KETQUA KQ
INNER JOIN SINHVIEN SV on KQ.MaSV = SV.MSSV
INNER JOIN GIANGDAY GD on KQ.MaKhoaHoc = GD.MaKhoaHoc
INNER JOIN MONHOC MH on GD.MaMH = MH.MaMH
order by 
MH.TenMH, SV.MSSV;

--Câu 61: Cho biết tên của những giáo viên tham gia dạy đầy đủ các môn 
select COUNT(*) as SoLuongMonHoc from MONHOC;
	select GV.TenGV
	from GIAOVIEN GV
	JOIN GIANGDAY GD on GV.MaGV = GD.MaGV
	group by GV.MaGV, GV.TenGV
	having COUNT(DISTINCT GD.MaMH) = (select COUNT(*) from MONHOC);

--Câu 34: Cho biết tên những sinh viên chỉ thi đúng một môn 
SELECT S.Ten
FROM SINHVIEN S
JOIN KETQUA KQ ON KQ.MaSV = S.MSSV
GROUP BY S.MSSV,S.Ten
HAVING COUNT(KQ.MaKhoaHoc)=1

--Câu 30:Cho biết tên khoa, số lượng sinh viên có trong từng khoa:
SELECT KHOA.TenKhoa, COUNT(SINHVIEN.MSSV) AS SoLuongSinhVien  
FROM KHOA  
LEFT JOIN SINHVIEN ON KHOA.MaKhoa = SINHVIEN.MaKhoa  
GROUP BY KHOA.TenKhoa;

--Câu 15: Cho biết tên khoa , mã khóa học mà giáo viên của khoa có tham gia giảng dạy.
SELECT TenKhoa, MaKhoaHoc
FROM KHOA, GIAOVIEN, GIANGDAY
WHERE KHOA.MaKhoa = GIAOVIEN.MaKhoa
AND GIAOVIEN.MaGV = GIANGDAY.MaGV;

--Câu 37: sinh vien học cả 2 môn CSDL và CTDL co diem cua 1 trong 2 mon >=8*/
SELECT sv.MSSV
from SINHVIEN sv join KETQUA kq on sv.MSSV=kq.MaSV
				 join GIANGDAY gd on kq.MaKhoaHoc=gd.MaKhoaHoc
				 join MONHOC mh on mh.MaMH=gd.MaMH
WHERE mh.MAMH IN ('CSDL', 'CTDL') and Diem>=8
GROUP BY sv.MSSV
HAVING COUNT(DISTINCT mh.MAMH) = 2

--Câu 47: Cho biết tên sinh viên có nhieu diem 7 nhat*/
select b.Ten, COUNT(a.Diem) as SoLuongDiem7
from KETQUA a join SINHVIEN b on a.MaSV=b.MSSV
where a.Diem=7
group by b.Ten
having COUNT(a.Diem)>=all(
	select COUNT(a.Diem)
	from KETQUA a join SINHVIEN b on a.MaSV=b.MSSV
	where Diem=7
	group by a.MaSV
	)

--Câu 16 : Cho biết các sinh viên đã học môn 'CSDL' hoặc 'CTDL'
SELECT DISTINCT SV.MSSV, SV.Ten
FROM SINHVIEN SV
JOIN KETQUA KQ ON SV.MSSV = KQ.MaSV
JOIN GIANGDAY GD ON KQ.MaKhoaHoc = GD.MaKhoaHoc
JOIN MONHOC MH ON GD.MaMH = MH.MaMH
WHERE MH.MaMH IN ('CTDL', 'CSDL');

---Câu 66: Cho biết tên sinh viên đã học đủ tất cả các môn học
SELECT SV.MSSV, SV.Ten
FROM SINHVIEN SV
JOIN KETQUA KQ ON SV.MSSV = KQ.MaSV
JOIN GIANGDAY GD ON KQ.MaKhoaHoc = GD.MaKhoaHoc
JOIN MONHOC MH ON GD.MaMH = MH.MaMH
GROUP BY SV.MSSV, SV.Ten
HAVING COUNT(DISTINCT MH.MaMH) = (SELECT COUNT(*) FROM MONHOC);

--Câu 65: Cho biết tên môn học  mà tất cả các sinh viên đều đã học.
SELECT TenMH  
FROM MONHOC, GIANGDAY, KETQUA, SINHVIEN  
WHERE MONHOC.MaMH = GIANGDAY.MaMH  
AND GIANGDAY.MaKhoaHoc = KETQUA.MaKhoaHoc  
AND KETQUA.MaSV = SINHVIEN.MSSV  
GROUP BY TenMH  
HAVING COUNT(DISTINCT MaSV) = (SELECT COUNT(*) FROM SINHVIEN);

--Câu 44: Cho biết tên các môn học có nhiều sinh viên tham gia nhất( tên môn, số lượng sinh viên)
select mh.TenMH, count(kq.MaSV) as [SLSV]
from MONHOC mh, KETQUA kq, GIANGDAY gd
where mh.MaMH= gd.MaMH and kq.MaKhoaHoc=gd.MaKhoaHoc
group by mh.TenMH
Having count(kq.MaSV)>=all(select count (kq.MaSV) from GIANGDAY gd 
							inner join KETQUA kq on gd.MaKhoaHoc=kq.MaKhoaHoc
							group by kq.MaKhoaHoc)


--Câu 50: cho biết tên những giáo viên tham gia giảng dạy nhiều nhất
SELECT TENGV, COUNT(MAKHOAHOC) AS [SO KHOA HOC GIANG DAY]
FROM GIANGDAY GD JOIN GIAOVIEN GV ON GD.MAGV = GV.MAGV
GROUP BY TENGV
HAVING COUNT(MAKHOAHOC) >= ALL (SELECT COUNT(MAKHOAHOC) FROM GIANGDAY GROUP BY MAGV)


--Câu 9: Cho biết danh sách các môn học được dạy trong năm 2020

SELECT MaMH, TenMH 
FROM MONHOC 
WHERE MaMH IN (SELECT MaMH FROM GIANGDAY WHERE Nam = 2020);

--Câu 59: Cho biết tên tất cả các giáo viên cùng với số lượng khóa học mà từng giáo viên đã tham gia giảng dạy

SELECT GV.MaGV, GV.TenGV, COUNT(GD.MaKhoaHoc) AS SoLuongKhoaHoc
FROM GIAOVIEN GV
LEFT JOIN GIANGDAY GD ON GV.MaGV = GD.MaGV
GROUP BY GV.MaGV, GV.TenGV;

--Câu 12: Cho biết các sinh viên học môn 'CSDL' có điểm từ 8 đến 10
SELECT SV.MSSV, SV.Ten, KQ.Diem
FROM SINHVIEN SV
       JOIN KETQUA KQ ON SV.MSSV = KQ.MaSV
      JOIN GIANGDAY GD ON KQ.MakhoaHoc = GD.MakhoaHoc
      JOIN MONHOC MH ON GD.MaMH = MH.MaMH
WHERE MH.TenMH = N'CSDL' AND KQ.Diem BETWEEN 8 AND 10;

--Câu 62: Cho biết tên môn học mà tất cả các giáo viên đều có tham gia giảng dạy 
SELECT MH.TenMH
FROM MONHOC MH
JOIN GIANGDAY GD ON MH.MaMH = GD.MaMH
GROUP BY MH.TenMH
HAVING COUNT(DISTINCT GD.MaGV) = (SELECT COUNT(*) FROM GIAOVIEN);

--Câu 4: Cho biết tên các môn học và số tín chỉ của những môn học 
--có cấu trúc của mã môn học như sau: ký tự thứ 1 là “C", ký tự thứ 3 là “D".
SELECT TenMH, SoTinChi 
FROM mh
WHERE MaMH LIKE 'C_D%';

--Câu 54: Cho biết tên những môn học chưa được tổ chức cho các khóa học
SELECT mh.TenMH 
FROM mh
LEFT JOIN gd ON mh.MaMH= gd.MaMH
WHERE gd.MaMH IS NULL

--Câu 14: Cho biết tên khoa, tên môn học mà những sinh viên trong khoa đã học
Select TenKhoa,TenMH
From SINHVIEN SV, KHOA K, GIANGDAY GD, KETQUA KQ, MONHOC MH
Where SV.MaKhoa=K.MaKhoa AND SV.MSSV=KQ.MaSV AND KQ.MaKhoaHoc=GD.MaKhoaHoc AND GD.MaMH=MH.MaMH;

--Câu 64: Cho biết tên những sinh viên tham gia đủ tất cả các khóa học
SELECT SV.Ten
 FROM KETQUA KQ1, SINHVIEN SV
 WHERE SV.MSSV=KQ1.MSSV AND NOT EXISTS(
  SELECT *
  FROM GIANGDAY GD
  WHERE NOT EXISTS(
   SELECT *
   FROM KETQUA KQ2
   WHERE KQ2.MaKhoaHoc =GD.MaKhoaHoc AND KQ1.MaSV=KQ2.MaSV));

--Câu 8: Cho biết tên, địa chỉ của những sinh viên có địa chỉ trên đường “Cống Quỳnh”
Use  QLSV;
Select Ten, DiaChi
From SINHVIEN
Where DiaChi like ‘%CONG QUYNH%’;

--Câu 58: Cho biết các sinh viên chưa học môn ‘LTC trên Windows’ 
Select SV.MSSV, SV.Ten 
From SINHVIEN SV 
Where SV.MSSV NOT IN ( 
	Select KQ.MaSV
	 From KETQUA KQ 
	Join GIANGDAY GD On KQ.MaKhoaHoc = GD.MaKhoaHoc
	Join MONHOC MH On GD.MaMH = MH.MaMH 
	Where MH.TenMH = N' LẬP TRÌNH C TRÊN WINDOW' 
);

--câu 24:Có bao nhiêu giáo viên khoa CNTT 
SELECT COUNT(*) AS SoLuongGiaoVien
FROM GiaoVien
WHERE MaKhoa = (SELECT MaKhoa FROM Khoa WHERE TenKhoa = 'CNTT');

--Câu 39: Trong các môn học, số tín chỉ nhỏ nhất là bao nhiêu?
SELECT MIN(SoTC) AS SoTinChiNhoNhat
FROM MONHOC;

--Câu 25: Có bao nhiêu sinh viên học môn CSDL
SELECT COUNT(DISTINCT SINHVIEN.MSSV) AS SoLuongSinhVien
FROM SINHVIEN
JOIN KETQUA ON SINHVIEN.MSSV = KETQUA.MaSV
JOIN GIANGDAY ON KETQUA.MaKhoaHoc = GIANGDAY.MaKhoaHoc
JOIN MONHOC ON GIANGDAY.MaMH = MONHOC.MaMH
WHERE MONHOC.TenMH = 'CSDL';

--Cau 23: Co bao nhieu sinh vien co gioi tinh nu va thuoc khoa CNTT
select count(*) as [So sinh vien nu thuoc khoa CNTT]
from SINHVIEN
where GioiTinh='Nu' and MaKhoa='CNTT'

--Cau 73: Xoa nhung khoa khong co sinh vien theo hoc
DELETE FROM KHOA 
WHERE MaKhoa NOT IN (SELECT DISTINCT MaKhoa FROM SINHVIEN)

--Câu 48: Cho biết tên các sinh viên có số lượng tín chỉ nhiều nhất (tên SV, số lượng tín chỉ)
SELECT sv.ten, total.tong_tin_chi
FROM sinhvien sv
JOIN (
    SELECT kq.masv, SUM(mh.sotc) AS tong_tin_chi
    FROM ketqua kq
    JOIN giangday gd ON kq.makh = gd.makhoahoc
    JOIN monhoc mh ON gd.mamh = mh.mamonhoc
    GROUP BY kq.masv
) AS total ON sv.masosinhvien = total.masv
WHERE total.tong_tin_chi = (
    SELECT MAX(tong_tin_chi)
    FROM (
        SELECT kq.masv, SUM(mh.sotc) AS tong_tin_chi
        FROM ketqua kq
        JOIN giangday gd ON kq.makh = gd.makhoahoc
        JOIN monhoc mh ON gd.mamh = mh.mamonhoc
        GROUP BY kq.masv
    ) AS max_tin_chi
);

--Câu 18: Cho biết tên môn học mà giáo viên " Tran Van Tien" tham gia giảng dạy trong học kỳ 1 năm học 2020.
SELECT TenMH 
FROM MonHoc 
WHERE MaMH IN (
    SELECT MaMH 
    FROM GiangDay 
    WHERE MaGV = 'GV03' 
    AND HocKy = 1 
    AND Nam = 2020
);

--Câu 68: Cho biết tên các giáo viên dạy tất cả những môn học mà giáo viên 'GV03' đã dạy.
SELECT TenGV 
FROM GiaoVien  
WHERE MaGV IN (
    SELECT MaGV 
    FROM GiangDay 
    WHERE MaMH IN (
        SELECT MaMH 
        FROM GiangDay 
        WHERE MaGV = 'GV03'
    )
    GROUP BY MaGV
    HAVING COUNT(DISTINCT MaMH) = (
        SELECT COUNT(DISTINCT MaMH) 
        FROM GiangDay  
        WHERE MaGV = 'GV03'
    )
);

--Câu 42: Tên sinh viên có điểm cao nhất môn "Kỹ thuật lập trình"
select SV1.Ten
from KETQUA KQ1
join GIANGDAY GD1 on KQ1.MaKhoaHoc=GD1.MaKhoaHoc
join SINHVIEN SV1 on KQ1.MaSV=SV1.MSSV
join MONHOC MH1 on GD1.MaMH=MH1.MaMH
where MH1.TenMH='KY THUAT LAP TRINH'
and KQ1.Diem=(
	select max(KQ2.Diem)
	from KETQUA KQ2
	join GIANGDAY GD2 on KQ2.MaKhoaHoc=GD2.MaKhoaHoc
	join MONHOC MH2 on GD2.MaMH=MH2.MaMH
	where MH2.TenMH='KY THUAT LAP TRINH'
)

--Cau27:cho biết điểm trung bình của sinh viên có mã số 'SV004'
SELECT DIEM 
FROM KETQUA 
WHERE MSSV = 'SV004';

--Câu 17: Cho biết tên những giáo viên tham gia giảng dạy môn "Ky Thuat lap trinh".
SELECT gv.TenGV.    FROM GiangVien gv
JOIN GiangVien_MonHoc gvmh ON gv.MaGV = gvmh.MaGV
JOIN MonHoc mh ON gvmh.MaMonHoc = mh.MaMonHoc
WHERE mh.TenMonHoc = 'Ky Thuat Lap Trinh';

--Câu 67: ﻿﻿﻿﻿Cho biết tên những sinh viên đã học tất cả những môn mà sinh viên 'SV001' đã học.
SELECT sv.TenSV
FROM SinhVien sv
WHERE NOT EXISTS (
    SELECT mh.MaMonHoc
    FROM SinhVien_MonHoc svm
    JOIN MonHoc mh ON svm.MaMonHoc = mh.MaMonHoc
    WHERE svm.MaSV = 'SV001'
    AND NOT EXISTS (
        SELECT 1
        FROM SinhVien_MonHoc svm2
        WHERE svm2.MaSV = sv.MaSV
        AND svm2.MaMonHoc = mh.MaMonHoc
    )
);

--Câu 60: ten sv, ten mon mà sinh viên chua hoc
select SINHVIEN.Ten, MONHOC.TenMH
from SINHVIEN, MONHOC
except
(
	select sv.Ten, mh.TenMH
	from SINHVIEN sv join KETQUA kq 
	on sv.MSSV=kq.MaSV join GIANGDAY gd on kq.MaKhoaHoc=gd.MaKhoaHoc 
	join MONHOC mh on gd.MaMH=mh.MaMH
)

--Câu 20: Cho biết mã, tên các sinh viên có kết quả các môn học đều trên 8 điểm
SELECT SV.MSSV, SV.Ten 
FROM SINHVIEN SV
JOIN KETQUA KQ ON SV.MSSV = KQ.MaSV
GROUP BY SV.MSSV, SV.Ten
HAVING MIN(KQ.Diem) >8

--Câu 70: cập Nhật thông tin cho các field vừa tạo theo yêu cầu:
SLMon: tổng số lượng môn học mà sinh viên đã kiểm tra(có điểm)
DTB: bằng tổng điểm sinh viên đã đạt được chia cho tổng số môn đã kiểm tra
XepLoai: nếu điểm < 5.0 : Yếu
5.0 <= điểm < 6.5 : Trung Bình
6.5 <= điểm < 8.0 : Khá
8.0 <= điểm < 9.0 : Giỏi
9.0 <= điểm <= 10.0 : Xuất sắc
UPDATE SINHVIEN SV
SET SLMon = (
 SELECT COUNT(*)
 FROM KETQUA KQ
 WHERE KQ.MaSV = SV.MSSV
);

UPDATE SINHVIEN SV
SET DTB = (
 SELECT AVG(KQ.Diem)
 FROM KETQUA KQ
 WHERE KQ.MaSV = SV.MSSV
);

UPDATE SINHVIEN
SET XepLoai =
 CASE
  WHEN DTB < 5.0 THEN 'Yếu'
  WHEN DTB >= 5.0 AND DTB < 6.5 THEN 'Trung Bình'
  WHEN DTB >= 6.5 AND DTB < 8.0 THEN 'Khá'
  WHEN DTB >= 8.0 AND DTB < 9.0 THEN 'Giỏi'
  WHEN DTB >= 9.0 AND DTB <= 10.0 THEN 'Xuất Sắc'
 END;


--Câu 6: Cho biết tên những môn học có chữ chữ "DU"  
select *from MONHOC where TenMH like '%DU%';

--Câu 56: Cho biết tên những khoa không có sinh viên theo học
select Makhoa, TenKhoa
from khoa
where khoa.Makhoa not in (
	select distinct SV.makhoa from SINHVIEN SV 
)

--Câu 31: cho biết tên khoa số lượng khoá học mà giáo viên của khoa tham gia giảng dạy 
SELECT
    KHOA.TenKhoa,
    COUNT(DISTINCT GIANGDAY.MaKhoaHoc) AS SoLuongKhoaHoc
FROM
    KHOA
JOIN
    GIAOVIEN ON KHOA.MaKhoa = GIAOVIEN.MaKhoa
JOIN
    GIANGDAY ON GIAOVIEN.MaGV = GIANGDAY.MaGV
GROUP BY
    KHOA.TenKhoa;

--câu 41: Cho biết tên khoa có số lượng cán bộ ít nhất                                                                                                SELECT TenKhoa
FROM KHOA
WHERE SL_CBGD = (SELECT MIN(SL_CBGD) FROM KHOA);

--câu 43: cho biết thông tin sinh viên có điểm thi môn CSDL lớn nhất
SELECT SV.MSSV, SV.Ten, SV.GioiTinh, SV.DiaChi, SV.DienThoai, SV.MaKhoa, KQ.Diem
FROM SINHVIEN SV
JOIN KETQUA KQ ON SV.MSSV = KQ.MaSV
JOIN MONHOC MH ON KQ.MaKhoaHoc = MH.MaMH
WHERE MH.TenMH = 'CSDL' 
  AND KQ.Diem = (
    SELECT MAX(KQ1.Diem)
    FROM KETQUA KQ1
    JOIN MONHOC MH1 ON KQ1.MaKhoaHoc = MH1.MaMH
    WHERE MH1.TenMH = 'CSDL'
  );

--câu 33: Cho biết số lượng tín chỉ mà từng sinh viên đã tham gia (gồm MSSV, tên SV, Số lượng tín chỉ).
SELECT
 sv.MSSV,
 sv.TenSV,
 SUM(hp.SoTinChi) AS TongSoTinChi
FROM
 SinhVien sv
JOIN DangKy dk ON sv.MSSV = dk.MSSV
JOIN HocPhan hp On dk.MaHP = hp.MaHP
GROUP BY
 sv.MSSV, sv.TenSV;

--câu 10:  Cho biết đơn đặt hàng số 1 do ai đặt và do nhân viên nào lập, thời gian và địa điểm giao hàng ở đâu?
SELECT 
 dh.MaDH,
 kh.TenKH AS TenKhachHang,
 nv.TenNV AS TenNhanVienLap,
 dh.NgayLap,
 dh.DiaDiemGiaoHang
FROM DonHang dh
JOIN KhachHang kh ON dh.MaKH = kh.MaKH
JOIN NhanVien nv ON dh.MaNV = nv.MaNV
WHERE dh.MaDH = 'DH01';

--Câu 1: cho biết tên, địa chỉ, điện thoại của tất cả các sinh viên
SELECT Ten, Gioitinh, DienThoai
FROM SINHVIEN;

--Câu 51: Tên các gv không tham gia giảng dạy trong năm 2021
SELECT DISTINCT TenGV
FROM GIAOVIEN
WHERE MaGV NOT IN (
    SELECT MaGV
    FROM GIANGDAY
    WHERE Nam = 2021
);

--câu 11:Cho biết điểm của các sinh viên theo từng môn học
select SV.MSSV,SV.Ten as TenSinhVien,MH.MaMH,MH.TenMH,KQ.Diem
	from KETQUA KQ
	INNER JOIN SINHVIEN SV on KQ.MaSV = SV.MSSV
    INNER JOIN GIANGDAY GD on KQ.MaKhoaHoc = GD.MaKhoaHoc
    INNER JOIN MONHOC MH on GD.MaMH = MH.MaMH
	order by 
    MH.TenMH, SV.MSSV;


--câu 61: Cho biết tên những giáo viên tham gia dạy đủ các môn học
select COUNT(*) as SoLuongMonHoc from MONHOC;
	select GV.TenGV
	from GIAOVIEN GV
	JOIN GIANGDAY GD on GV.MaGV = GD.MaGV
	group by GV.MaGV, GV.TenGV
	having COUNT(DISTINCT GD.MaMH) = (select COUNT(*) from MONHOC);

--câu 42: Tên các sinh viên có điểm cao nhất trong môn "Kỹ thuật lập trình"
select SV1.Ten
from KETQUA KQ1
join GIANGDAY GD1 on KQ1.MaKhoaHoc=GD1.MaKhoaHoc
join SINHVIEN SV1 on KQ1.MaSV=SV1.MSSV
join MONHOC MH1 on GD1.MaMH=MH1.MaMH
where MH1.TenMH='KY THUAT LAP TRINH'
and KQ1.Diem=(
	select max(KQ2.Diem)
	from KETQUA KQ2
	join GIANGDAY GD2 on KQ2.MaKhoaHoc=GD2.MaKhoaHoc
	join MONHOC MH2 on GD2.MaMH=MH2.MaMH
	where MH2.TenMH='KY THUAT LAP TRINH'
)

--Câu 13. Cho biết bảng điểm của dinh viên có tên là: 'Tung'
	SELECT Ten,TenMH,Diem
	FROM SINHVIEN SV,KETQUA KQ,GIANGDAY GD, MONHOC MH
	WHERE SV.Ten LIKE N'%TUNG%'AND  KQ.MaSV = SV.MSSV AND KQ.MaKhoaHoc=GD.MaKhoaHoc AND GD.MaMH=MH.MaMH;

--Câu 63. Cho biết khóa học mà tất cả các sinh viên đều tham gia
	SELECT TenMH
	FROM KETQUA KQ1, GIANGDAY GD, MONHOC MH
	WHERE KQ1.MaKhoaHoc=GD.MaKhoaHoc AND GD.MaMH=MH.MaMH AND NOT EXISTS(
		SELECT *
		FROM SINHVIEN SV
		WHERE NOT EXISTS(
			SELECT *
			FROM KETQUA KQ2
			WHERE KQ2.MaSV =SV.MSSV AND KQ1.MaKhoaHoc=KQ2.MaKhoaHoc));
--Câu 55: Cho biết tên những sinh viên chưa có điểm kiểm tra 
select distinct Ten 
from SINHVIEN as SV full join KETQUA as KQ on KQ.MaSV = SV.MSSV
WHERE KQ.MaSV IS NULL; 
--Câu 5: Cho biết tên giáo viên có ký tự thứ 3 là 'A' select TenGV 
from GIAOVIEN where TenGV like '__A%'  --Câu 10:Cho biết mã, tên, địa chỉ của các sinh viên theo từng Khoa sắp xếp theo thứ tự A-Z của tên sinh viên
USE QLSV
SELECT SV.MSSV, SV.Ten, SV.diachi, K.TenKhoa
FROM SINHVIEN SV
JOIN KHOA K ON SV.MaKhoa= K.MaKhoa
ORDER BY K.TenKhoa ASC, SV.Ten ASC;

--Câu 60: giả sử quy định mỗi sinh viên phải học đủ tất cả các môn học. Cho biết tên sinh viên, tên môn học mà sinh viên chưa học
SELECT SV.Ten, MH.TenMH
FROM SINHVIEN SV
JOIN KETQUA KQ ON SV.MSSV = KQ.MaSV
JOIN GIANGDAY GD ON KQ.MaKhoaHoc = GD.MaKhoaHoc
JOIN MONHOC MH ON GD.MaMH = MH.MaMH
WHERE KQ.MaSV IS NULL;

--Câu 40: Cho biết tên môn học có số tín chỉ nhiều nhất 
select TenMH as MaxTC_TenMH from MONHOC where SoTC = (select max(SoTC) from MONHOC);