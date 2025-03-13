--Câu 71/Quản lý Sinh viên: Xóa tất cả kết quả học tập của Sinh viên 'SV002'
use [QLSV]
delete from [KETQUA] where MaSV='SV002';

--Câu 21/Quản lý Sinh viên: Có bao nhiêu Sinh viên?
use [QLSV]
select count(MSSV) as SoLuongSV
from [dbo].[SINHVIEN];

--Câu 22/BT3:Quản lý hàng hóa: Cho biết mỗi khách hàng đã bỏ ra bao nhiêu tiền để đặt mua hàng
use[QLHH]
select 
	KH.MAKHACHHANG,
	sum(GIABAN*SOLUONG-MUCGIAMGIA) as TONGTIEN
from [dbo].[CTDONHANG] as CTDH
join [dbo].[DONDATHANG] as DDH 
	on DDH.SOHOADON=CTDH.SOHOADON
join [dbo].[KHACHHANG] as KH 
	on DDH.MAKHACHHANG=KH.MAKHACHHANG
GROUP BY KH.MAKHACHHANG;

/*Câu 32/BT4: Quản lý Bóng đá:Khi phân công huấn luyện viên, 
	kiểm tra vai trò của huấn luyện viên chỉ thuộc một trong các vai trò sau:
	HLV chính, HLV phụ, HLV thể lực, HLV thủ môn.*/
use [QLBD]
alter table [dbo].[HLV_CLB]
add constraint VTHLV check ([VAITRO] in (N'HLV Chính', N'HLV Phụ', N'HLV Thể lực',N'HLV Thủ môn'));

