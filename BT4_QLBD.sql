--Câu 1: Cho biết thông tin của tất cả cầu thủ
select MACT, HOTEN, SO, VITRI, NGAYSINH, DIACHI from CAUTHU

--CÂU 24: Cho biết tên câu lạc bộ có huấn luyện viên trưởng sinh vào ngày 20 tháng 5.
SELECT TENHLV
FROM HUANLUYENVIEN
WHERE MONTH(NGAYSINH)='5'AND DAY(NGAYSINH)='20';

/* Câu 10: cho biết mã huấn luyện viên, họ tên, 
ngày sinh, địa chỉ, vai trò và tên CLB 
đang làm việc mà câu lạc bộ đó đóng ở Bình Dương*/
USE QLBD
SELECT HUANLUYENVIEN.MAHLV, TENHLV, NGAYSINH, DIACHI, VAITRO, TENCLB
FROM HUANLUYENVIEN, HLV_CLB, CAULACBO, TINH
WHERE HUANLUYENVIEN.MAHLV = HLV_CLB.MAHLV
AND HLV_CLB.MACLB = CAULACBO.MACLB
AND CAULACBO.MATINH = TINH.MATINH
AND TENTINH = 'Bình Dương';

--Cau 14. Cho biết tên tỉnh, số lượng cầu thủ đang thi đấu ở vị trí tiền đạo trong các câu lạc bộ thuộc địa bàn tỉnh đó quản lý.
SELECT TINH.TENTINH, COUNT(CAUTHU.MACT) AS SO_LUONG_CAUTHU_TIEN_DAO
FROM TINH
JOIN CAULACBO ON TINH.MATINH = CAULACBO.MATINH
JOIN CAUTHU ON CAULACBO.MACLB = CAUTHU.MACLB
WHERE CAUTHU.VITRI = N'Tiền đạo'
GROUP BY TINH.TENTINH;

--Câu 27: Cho biết tên câu lạc bộ, tên tỉnh mà CLB đang đóng có hiệu số bàn thắng bại cao nhất 2021
SELECT CLB.TenCLB, TT.TenTinh, (XH.BanThang - XH.BanThua) AS HieuSo
FROM CauLacBo CLB
JOIN TinhThanh TT ON CLB.MaTinh = TT.MaTinh
JOIN XepHang XH ON CLB.MaCLB = XH.MaCLB
WHERE XH.MuaGiai = 2021
ORDER BY HieuSo DESC
LIMIT 1;

-- Cau 21: cho biết mã số, họ tên, ngày sinh của những cầu thủ có họ lót là "Công"
USE QLBongDa
SELECT MACT, HOTEN, NGAYSINH
FROM CAUTHU
WHERE HOTEN LIKE N'%Công%'

--CÂU 16: Cho biết các sinh viên đã học môn 'CSDL' hoặc 'CTDL'                                                                  SELECT S.TenSinhVienFROM SINHVIEN S
JOIN KETQUA K ON S.MaSinhVien = K.MaSinhVien
WHERE K.MaKhoaHoc IN ('CSDL', 'CTDL');

--Câu 30: Cho biết mã câu lạc bộ, tên câu lạc bộ đã tham gia thi đấu với tất cả các câu lạc bộ còn lại (chỉ tính sân nhà) trong mùa giải năm 2021
use QLBD
SELECT CLB.MACLB,CLB.TENCLB
FROM [dbo].[CAULACBO] CLB
JOIN [dbo].[TRANDAU] TD ON CLB.MACLB=TD.MACLB1
WHERE TD.NAM=2021
GROUP BY CLB.MACLB,CLB.TENCLB
HAVING COUNT(DISTINCT TD.MACLB2) = (SELECT COUNT(*)-1 FROM CAULACBO);

--Cau 4, hiển thị thông tin tất cả các câu thủ có quốc tịch iệt Nam thuộc câu lạc bộ Becamex Binh Dương
SELECT 
CAUTHU.MACT, CAUTHU.HOTEN, CAUTHU.VITRI, CAUTHU.NGAYSINH, CAUTHU.DIACHI, CAUTHU.MACLB, CAUTHU.MAQG, CAUTHU.SO
FROM CAUTHU
JOIN CAULACBO ON CAUTHU.MACLB = CAULACBO.MACLB
WHERE CAUTHU.MAQG = 'VN' AND CAULACBO.MACLB = 'BBD';

--Câu 9: lấy 3 câu lạc bộ có điểm cao nhất sau vòng 3 năm 2023
SELECT TOP 3 MACLB, DIEM
FROM BANGXH
WHERE NAM = 2023 AND VONG = 3
ORDER BY DIEM DESC;

--Cau 15: Cho biết tên câu lạc bộ, tên tỉnh mà CLB đang đóng nằm ở vị trí cao nhất của bảng xếp hạng, của vòng 3, năm 2023
select clb.tenclb, tinh.tentinh from caulacbo clb join bangxh bxh on clb.maclb = bxh.maclb 
join tinh on tinh.matinh = clb.matinh
where bxh.vong = 3 and bxh.nam = 2023 and bxh.hang = 1

--Câu19: Cho biết danh sách các trận đấu (NGAYTD, TENSAN, TEN CLB1, TEN CLB2, KETQUA) của câu lạc bộ đang xếp hạng cao nhất tính đến hết vòng 3 năm 2023 .                                                                                                           
SELECT 
    td.NGAYTD, 
    svd.TENSAN, 
    clb1.TENCLB AS tenclb1, 
    clb2.TENCLB AS tenclb2,
    td.KETQUA
FROM 
    TRANDAU td, 
    CAULACBO clb1, 
    CAULACBO clb2, 
    SANVD svd
WHERE 
    td.MACLB1 = clb1.MACLB 
    AND td.MACLB2 = clb2.MACLB 
    AND td.MASAN = svd.MASAN
    AND (
        SELECT BANGXH.MACLB 
        FROM BANGXH 
        WHERE BANGXH.VONG = 3 
          AND BANGXH.NAM = 2023
          AND BANGXH.HANG = 1
    ) IN (td.MACLB1, td.MACLB2)

--câu 6: Cho biết danh sách (độc giả, sách được mượn) những độc giả đã được mượn quá hạn
SELECT 
    dg.Ma_DocGia,
    dg.Ho + ' ' + dg.TenLot + ' ' + dg.Ten AS HoTenDocGia,
    ts.TuaSach,
    qtm.NgayMuon,
    qtm.NgayHetHan
FROM QuaTrinhMuon AS qtm
    JOIN DocGia    AS dg ON qtm.Ma_DocGia = dg.Ma_DocGia
    JOIN CuonSach  AS cs ON qtm.ISBN = cs.ISBN 
                         AND qtm.Ma_CuonSach = cs.Ma_CuonSach
    JOIN DauSach   AS ds ON ds.ISBN = cs.ISBN
    JOIN TuaSach   AS ts ON ts.Ma_TuaSach = ds.Ma_TuaSach
WHERE qtm.NgayHetHan < GETDATE()  
  AND qtm.NgayTra IS NULL
ORDER BY dg.Ma_DocGia;

--Câu2 :Hiển thị thông tin tất cả các cầu thủ mang áo số 7 chơiở vị trí tiền vệ
SELECT * 
FROM CAUTHU
WHERE SO = '7' AND VITRI = 'Tiền vệ';

--cau26:cho biết mã câu lạc bộ ,tên câu lạc bộ, tên sân vận động ,địa chỉ và lượng cầu thủ nước ngoài (có quốc tịch khác "Việt Nam") tương ứng của các câu lạc bộ có nhiều hơn 2 cầu thủ nước ngoài
SELECT C.MACLB, C.TENCLB, S.TENSAN, S.DIACHI, 
       COUNT(CT.MACT) AS LUONG_CAUTHU_NGOAI
FROM CAULACBO C
JOIN SANVD S ON C.MASAN = S.MASAN
JOIN CAUTHU CT ON C.MACLB = CT.MACLB
WHERE CT.MAQG <> 'VN'
GROUP BY C.MACLB, C.TENCLB, S.TENSAN, S.DIACHI
HAVING COUNT(CT.MACT) > 2;

--Câu 16: Cho biết tên huán luyện viên đnag nắm giữ  1 vị trí  trong 1 clb mà chưa có sdt
SELECT DISTINCT HLV.TENHLV
FROM HUANLUYENVIEN HLV 
LEFT  JOIN  HLV_CLB ON HLV.MAHLV = HLV_CLB.MAHLV
WHERE HLV.DIENTHOAI IS  NULL

--Cau 13: Tìm các tác giả có hơn 5 đầu sách trong thư viện
SELECT TUASACH.TACGIA, COUNT(DAUSACH.ISBN) AS SoDauSach
FROM TUASACH
JOIN DAUSACH ON TUASACH.MA_TUASACH = DAUSACH.MA_TUASACH
GROUP BY TUASACH.TACGIA
HAVING COUNT(DAUSACH.ISBN) > 5

--Cau 17: Liệt kê các huấn luyện viên thuộc quốc gia Việt Nam chưa làm công tác huấn luyện tại bất kỳ một câu lạc bộ nào
Select HLV. TENHLV
From HUANLUYENVIEN HLV
Join QUOCGIA QG On HLV. MAQG=QG. MAQG
Left Join HLV_CLB HC On HLV. MAHLV=HC. MAHLV
Where QG. TENQG=’Việt Nam’ And HC. MAHVL IS NULL;

--Câu 27 : Cho biết tên câu lạc bộ, tên tỉnh mà CLB đang đóng có hiệu số bảng thắng bại cao nhất năm 2021.
SELECT C.TENCLB, T.TENTINH, B.HIEUSO
FROM BANGXH B
JOIN CAULACBO C ON B.MACLB = C.MACLB
JOIN TINH T ON C.MATINH = T.MATINH
WHERE B.NAM = 2021 AND B.HIEUSO = (SELECT MAX(HIEUSO) FROM BANGXH WHERE NAM = 2021);

--câu 25. Cho biết tên câu lạc bộ, tên tỉnh mà CLB đang đóng có số bàn thắng nhiều nhất tỉnh đến hết vòng 3 năm 2021.
SELECT TOP 1 CAULACBO.TENCLB, TINH.TENTINH
FROM CAULACBO
JOIN TINH ON CAULACBO.MATINH = TINH.MATINH
JOIN BANGXH ON CAULACBO.MACLB = BANGXH.MACLB
WHERE BANGXH.NAM = 2021 AND BANGXH.VONG = 3
ORDER BY BANGXH.THANG DESC

--CÂU16: Cho biết tên huấn luyện viên đang nắm giữ một vị trí trong câu lạc bộ mà chưa có số điện thoại bằng sql.             SELECT HLV.TENHLV
FROM HUANLUYENVIEN HLV
JOIN HLV_CLB H ON HLV.MAHLV = H.MAHLV
WHERE HLV.DIENTHOAI IS NULL OR HLV.DIENTHOAI = '';

--Cau 17:Tìm các ngày có hơn 3 lượt mượn sách
SELECT NgayMuon, COUNT(*) AS SoLuotMuon
FROM QuaTrinhMuon
GROUP BY NgayMuon
HAVING COUNT(*) > 3;

--Câu 5: Cho biết mã số, họ tên, ngày sinh, địa chỉ và vị trí của các cầu thủ thuộc đội bóng "SHB Đà Nẵng" có quốc tịch "Bra-xin"
SELECT CT.MACT, CT.HOTEN, CT.NGAYSINH, CT.DIACHI, CT.VITRI
FROM CAUTHU CT
JOIN CAULACBO CLB ON CT.MACLB = CLB.MACLB
WHERE CLB.TENCLB = 'SHB Đà Nẵng' AND CT.MAQG = 'BRA';

--Câu 3: Cho biết tên, ngày sinh, địa chỉ, điện thoại của tất cả các huấn luyện viên. 
SELECT 
    TENHLV, 
    NGAYSINH, 
    DIACHI, 
    DIENTHOAI 
FROM 
    HUANLUYENVIEN;

--câu 18. Liệt kê các cầu thủ đang thi đấu trong các câu lạc bộ có thứ hạng ở vòng 3 năm 2021 lớn hơn 6 hoặc nhỏ hơn 3
select DISTINCT ct.*
from BANGXH b 
join CAULACBO c on c.MACLB = b.MACLB 
join CAUTHU ct on ct.MACLB=c.MACLB
where b.HANG>6 or b.HANG<3 and b.VONG=3 and b.NAM=2021;

--Cau 13: cho biết mã câu lạc bộ, tên câu lạc bộ, tên sân vận động, địa chỉ và số lượng cầu thủ nước ngoài tương ứng của các câu lạc bộ có nhiều hơn 2 cầu thủ nước ngoài
SELECT CLB.MACLB, CLB.TENCLB, SVD.TENSAN, SVD.DIACHI, COUNT(CT.MACT) AS SOLUONG_CAU_THU_NUOC_NGOAI
FROM CAULACBO CLB
JOIN SANVD SVD ON CLB.MASAN =SVD.MASAN
JOIN CAUTHU CT ON CLB.MACLB =CT.MACLB
JOIN QUOCGIA QG ON CT.MAQG =QG.MAQG
WHERE QG.TENQG <> N'Việt Nam'
GROUP BY CLB.MACLB, CLB.TENCLB, SVD.TENSAN, SVD.DIACHI
HAVING COUNT(CT.MACT) >2;

--Câu 9: Lấy tên 3 câu lạc bộ điểm cao nhất sau vòng 3 trong năm 2023
SELECT TOP 3 clb.TENCLB
FROM BANGXH bx
JOIN CAULACBO clb ON bx.MACLB = clb.MACLB
WHERE  bx.VONG = 3 AND bx.NAM = 2023
ORDER BY bx.DIEM DESC;

--câu 2: Hãy cho biết danh sách số ngày mượn sách của các lần đã mượn sách.
SELECT 
    ISBN, 
    Ma_CuonSach, 
    Ma_DocGia, 
    NgayMuon, 
    NgayTra, 
    DATEDIFF(IFNULL(NgayTra, CURDATE()), NgayMuon) AS SoNgayMuon
FROM QuaTrinhMuon;

--Câu 10: Cho biết mã huấn luyện viên , họ tên, ngày sinh, địa chỉ, vai trò và tên CLB đang làm việc mà câu lạc bộ đó đóng ở Bình Dương*/
SELECT H.maHLV, H.tenHLV, H.ngaysinh, H.diachi, C.tenCLB, HC.vaitro
FROM HLV H
JOIN HLVCLB HC ON H.maHLV = HC.maHLV
JOIN CAULACBO C ON HC.maCLB = C.maCLB
JOIN TINH T ON C.maTINH = T.maTINH
WHERE T.tenTINH = N'Bình Dương';

--cau22:Cho biết mã huấn luyện viên , họ tên, ngày sinh, địa chỉ của những huấn luyện viên Việt Nam có tuổi nằm trong khoảng 35-40
SELECT 
    MAHLV, 
    TENHLV, 
    NGAYSINH, 
    DIACHI
FROM HUANLUYENVIEN
WHERE MAQG = 'VN' 
AND DATEDIFF(YEAR, NGAYSINH, GETDATE()) BETWEEN 35 AND 40;

--cau 34: Kiem tra ket qua tran dau co dang so_ban_thang-so_ban_thua
ALTER TABLE BANGXH
ADD CHECK (HIEUSO LIKE '%-%')

--Cau 4: Hiển thị thông tin tất cả các cầu thủ có quốc tịch Việt Nam thuộc câu lạc bộ Becamex Bình Dương:
SELECT*FROM CAUTHU
WHERE MAQG=VN
AND MACLB=BBD;
