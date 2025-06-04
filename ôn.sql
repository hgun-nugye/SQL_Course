create database QuanLyKS
go
use QuanLyKS
go

create table KhachSan(
 MaKhachSan varchar(5) not null,
 TenKhachSan nvarchar(20) not null,
 DiaChi nvarchar(20) not null
);
go
create table Phong
(
 MaPhong varchar(5) not null,
 MaKhachSan varchar(5) not null,
 LoaiPhong nvarchar(10) not null,
 GiaPhong money not null
);
go
create table KhachHang
(
 MaKhachHang varchar(5) not null,
 HoTen nvarchar(50) not null,
 CMND varchar(10) not null,
 DiaChi nvarchar(50)
);
go 
create table DatPhong 
(
 MaDatPhong varchar(5) not null,
 MaKhachHang varchar(5) not null,
 MaPhong varchar(5) not null,
 NgayDen datetime not null,
 NgayDi datetime not null,
 SoNguoi int not null
);

alter table KhachSan
add constraint PK_KS primary key (MaKhachSan);

alter table Phong
add constraint PK_P primary key (MaPhong);
alter table Phong
add constraint FK_P_KS foreign key (MaKhachSan) references KhachSan(MaKhachSan);

alter table KhachHang
add constraint PK_KH primary key (MaKhachHang);

alter table DatPhong
add constraint PK_DP primary key (MaDatPhong);
alter table DatPhong
add constraint FK_DP_KH foreign key (MaKhachHang) references KhachHang(MaKhachHang);

--Nhap du lieu
insert into KhachSan
values
 ('KS1', N'AQUARIUS', N'02 LÝ THÁI TỔ'),
 ('KS2', N'YAYE', N'10 MAI AN TIÊ,'),
 ('KS3', N'SUNRISE', N'11 TRẦN HƯNG ĐẠO'),
 ('KS4', N'TOPY', N'05 AN DƯƠNG VƯƠNG'),
 ('KS5', N'BLUE', N'12/A TAM QUAN');

insert into Phong
values
 ('P01', 'KS1', N'Tiêu chuẩn', 200000),
 ('P02', 'KS2', N'VIP', 2000000),
 ('P03', 'KS5', N'Tiêu chuẩn', 350000),
 ('P04', 'KS3', N'Tiêu chuẩn', 250000),
 ('P05', 'KS4', N'VIP', 2000000);

insert into KhachHang
values
 ('KH1', N'NGUYỄN XUÂN TÂM', '0987654321', N'12 AN DƯƠNG VƯƠNG'),
 ('KH2', N'MAI XUÂN AN', '0987654322', N'12 LÝ MAN ĐẾ'),
 ('KH3', N'TRẦN NHẬT NAM', '0987654323', N'13/A TRẦN HƯNG ĐẠO'),
 ('KH4', N'VÕ LÊ MI', '0987654324', N'03 LÊ LAI'),
 ('KH5', N'TRẦN HẢO', '0987654325', N'11 AN DƯƠNG VƯƠNG');

insert into DatPhong
values
 ('DP1', 'KH2', 'P03', '2024-12-12', '2025-1-1', 4),
 ('DP2', 'KH1', 'P02', '2024-12-1', '2022-12-10', 1),
 ('DP3', 'KH5', 'P01', '2025-1-1', '2025-1-5', 3),
 ('DP4', 'KH3', 'P05', '2024-11-11', '2024-12-1', 2),
 ('DP5', 'KH2', 'P04', '2025-1-12', '2025-1-14', 5);


--3.Liệt kê danh sách khách hàng đã đặt phòng trong tháng 6/2024.
-- Bao gồm thông tin: Họ tên, CMND, Tên khách sạn, Loại phòng.
select [HoTen],[CMND], [TenKhachSan], [LoaiPhong]
from KhachHang kh, KhachSan ks, Phong p, DatPhong dp
where kh.MaKhachHang=dp.MaKhachHang 
 and dp.MaPhong=p.MaPhong
 and p.MaKhachSan=ks.MaKhachSan
 and year(dp.NgayDen)=2024
 and month(dp.NgayDen)=4;

--4.Tính tổng doanh thu của từng khách sạn trong năm 2024.
select [TenKhachSan], sum([GiaPhong]) as N'Tổng tiền năm 2024'
from KhachSan ks, [dbo].[Phong] p, DatPhong dp
where ks.MaKhachSan=p.MaKhachSan
 and year(dp.NgayDi)=2024
group by [TenKhachSan];

--5.Xác định khách sạn có tổng doanh thu cao nhất trong năm 2024.
select top 1 [TenKhachSan],sum([GiaPhong]) as N'Ks doanh thu cao nhất năm 2024'
 from KhachSan ks, [dbo].[Phong] p, DatPhong dp
 where ks.MaKhachSan=p.MaKhachSan
  and year(dp.NgayDi)=2024
 group by [TenKhachSan]
 order by sum([GiaPhong]) desc;

--6.Liệt kê họ tên của khách hàng đã đặt phòng ở tất cả các khách sạn trong hệ thống.
select kh.HoTen
from KhachHang kh, DatPhong dp, Phong p, KhachSan ks
where kh.MaKhachHang=dp.MaKhachHang
 and dp.MaPhong=p.MaPhong
 and ks.MaKhachSan=p.MaKhachSan
group by  kh.HoTen
having count(p.MaKhachSan)=(select count(p.MaKhachSan) from Phong p);

--7.Tạo thủ tục cho phép chèn dữ liệu vào bảng DatPhong. Cho ví dụ minh họa.
create proc Insert_DP
 (@MaDatPhong varchar(5),
 @MaKhachHang varchar(5),
 @MaPhong varchar(5),
 @NgayDen datetime,
 @NgayDi datetime ,
 @SoNguoi int)
as 
begin
 insert into DatPhong
 values 
 (@MaDatPhong,@MaKhachHang,@MaPhong,@NgayDen,@NgayDi,@SoNguoi)
end;

exec Insert_DP 'DP6', 'KH1', 'P03', '2025-1-12', '2025-1-14', 5;

--8.Tạo hàm trả về danh sách đặt phòng của một khách hàng theo CMND.
-- Cho ví dụ minh họa.
alter function DS_DP 
(@CMND varchar(10))
returns table 
as
 return 
 (select dp.MaPhong from DatPhong dp
 join KhachHang kh
 on dp.MaKhachHang=kh.MaKhachHang
 where kh.CMND=@CMND);

select * from DS_DP ('0987654321')
--9.Tạo hàm trả cho phép nhập vào một mã khách hàng và liệt kê tổng số phòng mà khách hàng đã đặt.
create function Tong_Phong
 (@MKH varchar(5))
returns int
as 
begin
 return (select count(p.MaPhong)
 from Phong p, KhachHang kh, DatPhong dp
 where p.MaPhong=dp.MaPhong
  and dp.MaKhachHang=kh.MaKhachHang
  and dp.MaKhachHang=@MKH)
end;

select dbo.Tong_Phong ('KH1') as N'Tổng phòng đã đặt'

--10.Tạo trigger kiểm tra số người đặt phòng không vượt quá 4 người cho loại phòng tiêu chuẩn.
alter trigger More4P
on [dbo].[DatPhong]
for insert, update
as
begin
 if exists (select 1 from inserted i
    join Phong p
    on i.MaPhong=p.MaPhong
    join DatPhong dp
    on dp.MaPhong=p.MaPhong
    where dp.MaPhong=p.MaPhong
     and i.SoNguoi>4
     and p.LoaiPhong=N'Tiêu chuẩn')
 begin
  rollback tran
  print(N'Số người nhập vào không hợp lệ cho phòng tiêu chuẩn!')
 end
end;

insert into DatPhong
values ('DP16', 'KH2', 'P04', '2025-1-12', '2025-1-14', 1);

--hàm hiển thị thông tin tất cả Nhân viên
create function InforNV()
returns table
as return (select * from [dbo].[NHANVIEN]);

select * from dbo.InforNV();

--hàm hiển thị thông tin Nhân viên
create function InforNVMaNV(@MANV varchar(5))
returns table
as return (select * from [dbo].[NHANVIEN] where [MANV]=@MANV);

select * from dbo.InforNVMaNV('NV3');

--Trigger Luong TP lon hon luong NV
create trigger LuongTPCaoHonNV
on [dbo].[NHANVIEN]
for insert
as
begin
 declare @MaNV varchar(5), @Luong decimal(10,2)
 select @MaNv=[MANV], @Luong=[LUONG]
 from inserted i, [dbo].[PHONGBAN] pb
 where i.[MANV]=pb.[TRUONGPHONG]

 if (@MaNV is null) return;

 if exists (select 1 from [dbo].[NHANVIEN] nv
    join [dbo].[PHONGBAN] pb
    on nv.[MAPB]=pb.[MAPB]
    where @MaNV!= [TRUONGPHONG]
    and @Luong<=[LUONG])

 begin 
  rollback tran
  print(N'Lương trưởng phòng phải cao hơn nhân viên')
 end
end;

insert into[dbo].[NHANVIEN]
values ('NV10',N' VO',N' THANH',N' TUNG',' 1975-08-12',N' 638 Tran Hung Dao','NAM ',400000,'P3')


--stored procedure
/*create proc (ten procedure) (tham so)
as
begin
 (cau lenh luu tru)
end;*/

--function
/*
create function (ten ham) (tham so)
returns (kieu DL)
as
begin

end;
------------------------
create function (ten ham) (tham so truyen)
returns table
as 
begin

end;
----------------------------
create function (ten ham) (tham so truyen)
return (ten bien bang) table (dinh nghia bang)
as
begin

end;
*/
--trigger
/*
create trigger (ten trigger) (tham so truyen)
on (ten bang thuc hien)
for(hanh dong )
as
begin
 if exists (...)
end;
*/