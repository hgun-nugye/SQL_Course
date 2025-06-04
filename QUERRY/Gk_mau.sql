create database Hotel;

use Hotel

create table KhachSan
(
	MaKhachSan varchar(5) not null,
	TenKhachSan nvarchar(20) not null,
	DiaChi nvarchar(50)
)

go

create table Phong
(
	MaPhong varchar(5) not null,
	MaKhachSan varchar(5) not null,
	LoaiPhong varchar(10) not null,
	GiaPhong money
)

go

create table KhachHang
(
	MaKhachHang varchar(5) not null,
	HoTen nvarchar(50) not null,
	CMND varchar(10) not null unique,
	DiaChi nvarchar(50)
)

go

create table DatPhong
(
	MaDatPhong varchar(5) not null,
	MaKhachHang varchar(5) not null,
	MaPhong varchar(5) not null,
	NgayDen Date not null,
	NgayDi Date not null,
	SoNguoi int not null
)

alter table KhachSan
add constraint PK_KS primary key (MaKhachSan);

alter table Phong
add constraint PK_Phong primary key (MaPhong, MaKhachSan);

alter table Phong
add constraint FK_Phong_KS foreign key (MaKhachSan) references KhachSan(MaKhachSan)

alter table KhachHang
add constraint PK_KH primary key (MaKhachHang)

alter table DatPhong
add constraint PK_DP primary key (MaDatPhong);
alter table DatPhong
add constraint FK_KH foreign key (MaKhachHang) references KhachHang(MaKhachHang);
alter table DatPhong
add constraint FK_Phong foreign key (MaPhong) references Phong(MaPhong);

insert into KhachSan
values
	('KS1', N'Anh Mai', N'12 Hoàn Kiếm Hà Nội'),
	('KS2', N'Hoàng Quân', N'12 An Dương Vương, TPHCM'),
	('KS3', N'Nam Giang', N'113 Trần Hưng Đạo, TPHCM'),
	('KS4', N'Yoshi', N'26-7 Tố Hữu, Quận 1'),
	('KS5', N'Sunrise', N'13A Nghi, Hà Nội');

go

insert into Phong
values
	('P1','KS1','Thuong', 250000),
	('P2','KS1','VIP', 550000),
	('P3','KS1','VIP', 750000),
	('P5','KS2','Thuong', 250000),
	('P4','KS3','VIP', 300000),
	('P2','KS2','VIP', 550000),
	('P3','KS3','VIP', 750000),
	('P5','KS5','Thuong', 250000),
	('P4','KS4','VIP', 300000);

insert into KhachHang (MaKhachHang, HoTen, CMND, DiaChi)
values
	('KH1', N'Nguyễn An', '0123456789',N'12 An Dương Vương, TPHCM'),
	('KH2', N'Dương Anh', '0987654321',N'12 Ngô Tất Tố, TPHCM'),
	('KH3', N'Trần Trọng', '0123457698',N'13A Mộc Bài, HN'),
	('KH4', N'Ngô Chí', '0987654123',N'16 Lý Nam Đàn'),
	('KH5', N'Lê Nam', '0123654987',N'Quận 5, TPHCM');

go

INSERT INTO DatPhong
VALUES
    ('DP1', 'KH1', 'P3', '2021-12-10', '2021-12-15', 5),
    ('DP2', 'KH2', 'P1', '2024-12-12', '2024-12-15', 1),
    ('DP3', 'KH3', 'P2', '2024-12-12', '2024-12-15', 2),
    ('DP4', 'KH4', 'P1', '2023-12-12', '2023-12-15', 3),
    ('DP5', 'KH5', 'P2', '2024-12-12', '2024-12-15', 2),
	('DP6', 'KH5', 'P3', '2021-12-10', '2021-12-15', 5),
    ('DP7', 'KH1', 'P2', '2024-12-12', '2024-12-15', 1),
    ('DP8', 'KH1', 'P4', '2024-12-12', '2024-12-15', 2),
    ('DP9', 'KH1', 'P5', '2023-12-12', '2023-12-15', 3),
    ('DP10','KH1', 'P1', '2024-12-12', '2024-12-15', 2);


--3.Liệt kê danh sách khách hàng đã đặt phòng trong tháng 6-2024. 
--Bao gồm thông tin: Họ tên, CMND, Tên khách sạn, Loại phòng.
select [HoTen],[CMND],[TenKhachSan],[LoaiPhong]
from [dbo].[KhachHang]KH, [dbo].[KhachSan] KS, [dbo].[Phong] P, [dbo].[DatPhong] DP
where KS.MaKhachSan=P.MaKhachSan and P.MaPhong=DP.MaPhong and DP.MaKhachHang=KH.MaKhachHang
and year([NgayDen])=2024 and month([NgayDen])=6;

--4.Tính tổng doanh thu của từng khách sạn trong năm 2024.
select [TenKhachSan], sum(P.GiaPhong) DoanhThu
from [dbo].[KhachSan] KS,[dbo].[Phong] P, [dbo].[DatPhong] DP
where year([NgayDi])=2024 and P.MaKhachSan=KS.MaKhachSan and DP.MaPhong=P.MaPhong
group by [TenKhachSan];
-----
SELECT 
    KS.TenKhachSan, 
    SUM(P.GiaPhong) AS DoanhThu
FROM 
    dbo.KhachSan KS
JOIN 
    dbo.Phong P ON P.MaKhachSan = KS.MaKhachSan
JOIN 
    dbo.DatPhong DP ON DP.MaPhong = P.MaPhong
WHERE 
    YEAR(DP.NgayDi) = 2024
GROUP BY 
    KS.TenKhachSan;

--5.Xác định khách sạn có tổng doanh thu cao nhất trong năm 2024.
select top 1[TenKhachSan], sum(P.GiaPhong) DoanhThu
from [dbo].[KhachSan] KS,[dbo].[Phong] P, [dbo].[DatPhong] DP
where year([NgayDi])=2024 and P.MaKhachSan=KS.MaKhachSan and DP.MaPhong=P.MaPhong
group by [TenKhachSan]
order by DoanhThu desc;
-----------
SELECT top 1
		KS.TenKhachSan, 
		SUM(P.GiaPhong) AS DoanhThu
	FROM 
		dbo.KhachSan KS
	JOIN 
		dbo.Phong P ON P.MaKhachSan = KS.MaKhachSan
	JOIN 
		dbo.DatPhong DP ON DP.MaPhong = P.MaPhong
	WHERE 
		YEAR(DP.NgayDi) = 2024
	GROUP BY 
		KS.TenKhachSan
	order by DoanhThu desc

--6.Liệt kê họ tên của khách hàng đã đặt phòng ở tất cả các khách sạn trong hệ thống.
SELECT KH.HoTen
FROM dbo.KhachHang KH
JOIN dbo.DatPhong DP ON KH.MaKhachHang = DP.MaKhachHang
JOIN dbo.Phong P ON P.MaPhong = DP.MaPhong
GROUP BY KH.HoTen
HAVING COUNT(DISTINCT P.MaKhachSan) = (SELECT COUNT(DISTINCT MaKhachSan) FROM dbo.KhachSan);

--7.Tạo thủ tục cho phép chèn dữ liệu vào bảng DatPhong. Cho ví dụ minh họa.
create procedure Insert_DatPhong
	@MaDatPhong varchar(5) ,
	@MaKhachHang varchar(5),
	@MaPhong varchar(5),
	@NgayDen DateTime,
	@NgayDi DateTime ,
	@SoNguoi int 
as 
begin
	insert into DatPhong
	values 
	(@MaDatPhong,
	@MaKhachHang,
	@MaPhong,
	@NgayDen ,
	@NgayDi,
	@SoNguoi)
end;

exec Insert_DatPhong'DP2', 'KH1', 'P3', '10-12-2024', '11-12-2024',2;
select * from [dbo].[DatPhong]

--8.Tạo hàm trả về danh sách đặt phòng của một khách hàng theo CMND. Cho ví dụ minh họa.
create function DS_DatPhong	(@CMND varchar(10))
	returns @DSDatPhong
	table(@MaDatPhong varchar(5),
	@MaKhachHang varchar(5),
	@MaPhong varchar(5),
	@NgayDen Date,
	@NgayDi Date,
	@SoNguoi int)
as 
begin
	insert into @DSDatPhong
	select DP.[MaDatPhong], DP.[MaKhachHang], DP.MaPhong, DP.NgayDen, DP.NgayDi, DP.SoNguoi
	from [DatPhong] DP
	join KhachHang KH
		on KH.MaKhachHang=DP.MaKhachHang
	where @CMND=KH.CMND
return
end;

--9.Tạo hàm trả cho phép nhập vào một mã khách hàng và liệt kê tổng số phòng mà khách hàng đã đặt.
create FUNCTION TongPhong (@MaKhachHang VARCHAR(5))
RETURNS INT
AS
BEGIN
    DECLARE @TongPhong INT;
    IF EXISTS (SELECT 1 FROM KhachHang WHERE MaKhachHang = @MaKhachHang)
    BEGIN
        SELECT @TongPhong = COUNT(DP.MaPhong)
        FROM DatPhong DP
        WHERE DP.MaKhachHang = @MaKhachHang;
    END
    ELSE
    BEGIN
        SET @TongPhong = 0; -- Hoặc NULL, tùy vào yêu cầu
    END;

    RETURN @TongPhong;
END;
go
select dbo.TongPhong('KH3') as TONGSOPHONGDAT


--10.Tạo trigger kiểm tra số người đặt phòng không vượt quá 4 người cho loại phòng tiêu chuẩn.

create trigger SoNguoiQua4
on [dbo].[DatPhong]
for insert
as
begin
	declare @SoNguoi int =0
	select @SoNguoi=SoNguoi
	from [dbo].[DatPhong] DP, [dbo].[Phong] P
	where P.[MaPhong]=DP.[MaPhong] and [LoaiPhong]='Thuong'
	if(@SoNguoi>4)
		begin
			print N'Số người không vượt quá 4 cho phòng thường'
			rollback tran
		end
end;
go
create trigger check_Songuoi
on [dbo].[DatPhong]
for update
as
begin
	if exists (select 1 
				from DatPhong DP, Phong where  DP.MaPhong=Phong.MaPhong and SoNguoi>4 and Phong.LoaiPhong='Thuong')
	begin
		rollback tran
		print (N'Khong duoc vuot qua 4 nguoi cho phong thuong')
	end
end

INSERT INTO DatPhong
VALUES
    ('DP10', 'KH1', 'P5', '2023-12-10', '2023-12-15', 10),
    ('DP12', 'KH3', 'P5', '2021-12-10', '2021-12-15', 5);
