_bài 3 câu 7:Công ty Việt Tiến đã cung cấp những mặt hàng nào?
SELECT HH.MaHang, HH.TenHang  
FROM HANG_HOA HH  
JOIN CUNG_CAP CC ON HH.MaHang = CC.MaHang  
JOIN NHA_CUNG_CAP NCC ON CC.MaNCC = NCC.MaNCC  
WHERE NCC.TenNCC = N'Việt Tiến';