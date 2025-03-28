--câu 1: có bao nhiêu phiếu mượn sách thư viện trong năm qua?
SELECT
    COUNT(*) AS SoLuongPhieuMuon
FROM
    PhieuMuon
WHERE
    YEAR(NgayMuon) = YEAR(CURDATE()) - 1;
/*Câu 26.Cập nhật tình trạng sách bị hỏng thành "Đang sửa"*/
UPDATE CuonSach
SET TinhTrang = N'Đang sửa'
WHERE TinhTrang = N'Hỏng';

--Cau 23, Lấy danh sách tất cả độc giả cả người lớn và trẻ em
SELECT 
    DocGia.Ma_DocGia, 
    DocGia.Ho, 
    DocGia.TenLot, 
    DocGia.Ten, 
    DocGia.NgaySinh,
    NguoiLon.SoNha, 
    NguoiLon.Duong, 
    NguoiLon.Quan, 
    NguoiLon.DienThoai, 
    NguoiLon.HanSuDung,
    TreEm.Ma_DocGia_NguoiLon
FROM 
    DocGia
LEFT JOIN 
    NguoiLon ON DocGia.Ma_DocGia = NguoiLon.Ma_DocGia
LEFT JOIN 
    TreEm ON DocGia.Ma_DocGia = TreEm.Ma_DocGia;

--Câu 28. Xóa tất cả độc giả chưa từng mượn sách:
DELETE FROM DocGia
WHERE Ma_DocGia NOT IN (
    SELECT DISTINCT Ma_DocGia
    FROM Muon
);

--Câu14: Tìm các độc giả đã mượn hơn 3 cuốn sách 
SELECT Ma_DocGia, COUNT(*) AS SoLuongSachDaMuon
FROM Muon
GROUP BY Ma_DocGia
HAVING COUNT(*) > 3;

--câu 21:Tìm sách chưa được ai đăng ký mượn
SELECT DauSach.ISBN, DauSach.Ma_TuaSach, DauSach.NgonNgu, DauSach.Bia, DauSach.TrangThai
FROM DauSach
WHERE DauSach.ISBN NOT IN (
    SELECT ISBN 
    FROM DangKy
);

--Câu 24: lấy danh sách độc giả vừa đăng kí vừa mượn sách
SELECT DG.MADG, DG.HOTEN, DG.NGAYSINH, DG.DIACHI, DG.SDT
FROM DOCGIA DG
JOIN MUONSACH MS ON DG.MADG = MS.MADG;

--Câu 20: Tìm độc giả chưa từng mượn sách
select DG.Ma_DocGia, DG.Ho, DG.Ten, DG.Ten
from DocGia DG left join Muon M on DG.Ma_DocGia=M.Ma_DocGia
where M.Ma_DocGia=null

--Cau 15: tìm các đầu sách có hơn 2 cuốn sách bị hỏng
SELECT DS.Ma_TuaSach, TS.TuaSach, COUNT(CS.Ma_CuonSach) AS SoLuongBiHong
FROM DauSach DS
JOIN CuonSach CS ON DS.ISBN = CS.ISBN
JOIN TuaSach TS ON DS.Ma_TuaSach = TS.Ma_TuaSach
WHERE CS.TinhTrang = 'Hong'
GROUP BY DS.Ma_TuaSach, TS.TuaSach
HAVING COUNT(CS.Ma_CuonSach) > 2;

--Cau 29. Cập nhật số điện thoại của độc giả có mã số là 5 thành 0909123456
UPDATE NguoiLon
SET DienThoai = 0909123456
WHERE Ma_DocGia = 'DG005';

--Câu 12: Tìm số lượng sách của từng tác giả--
SELECT TacGia, COUNT(*) AS SoLuongSach
FROM TuaSach
GROUP BY TacGia;

--Câu 8:Bạn đọc mượn sách nhiều nhất là ngày nào?                                                                                                                 SELECT TOP 1 NgayMuon, COUNT(*) AS SoLuotMuon
FROM MUON_SACH
GROUP BY NgayMuon
ORDER BY SoLuotMuon DESC;

--câu 5: Cho biết danh sách (độc giả, sách được mượn) những độc giả đã được mượn quá hạn
SELECT
    DG.MaDocGia,
    DG.Ho || ' ' || DG.TenLot || DG.Ten AS HoTenDocGia,
    TS.TuaSach,
    M.NgayMuon,
    M.NgayHetHan
FROM
    DocGia DG
JOIN
    Muon M ON DG.MaDocGia = M.MaDocGia
JOIN
    DauSach DS ON M.ISBN = DS.ISBN
JOIN
    TuaSach TS ON DS.MaTuaSach = TS.MaTuaSach
WHERE
    M.NgayHetHan < GETDATE();

--câu 7: số lượng sách nhiều nhất mà một người đã mượn                                                                                  SELECT TOP 1 Ma_DocGia, COUNT(*) AS SoLuongSachMuon
FROM Muon
GROUP BY Ma_DocGia
ORDER BY SoLuongSachMuon DESC;

--cau11:tính số lượng sách trung bình đọc giả đã mượn 
select COUNT(Muon.ISBN) * 1.0 / COUNT(DISTINCT Muon.Ma_DocGia) AS SoLuongSachTrungBinh
from Muon;

--Cau 25. Lấy danh sách độc giả chỉ đăng ký nhưng chưa mượn sách 
SELECT *
FROM DocGia DG
LEFT JOIN DangKy DK ON DG.Ma_DocGia = DK.Ma_DocGia
LEFT JOIN Muon M ON DK.ISBN = M.ISBN AND DK.Ma_DocGia = M.Ma_DocGia
WHERE M.ISBN IS NULL;