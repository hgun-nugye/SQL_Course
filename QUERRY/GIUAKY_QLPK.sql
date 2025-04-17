create database QLPK
go
use QLPK;
go
create table BENH_NHAN
(
	MSBN varchar(5) not null,
	HoBN nvarchar(20) not null,
	TenBN nvarchar(20) not null, 
	NgaySinh datetime,
	DiaChi nvarchar(50)
);
create table BAC_SI
(
	MSBS varchar(5) not null,
	HoBS nvarchar(20) not null,
	TenBS nvarchar(20) not null, 
	ChuyenKhoa nvarchar(20) not null
);
create table KHAM_BENH
(
	MSBS varchar(5) not null,
	MSBN varchar(5) not null,
	NgayKham datetime not null,
	ChanDoan nvarchar(50) not null
); 
create table DON_THUOC
(
	MSDT varchar(5) not null,
	MSBN varchar(5) not null,
	NgayKeDon datetime not null
);

create table CHI_TIET_DON_THUOC
(
	MSDT varchar(5) not null,
	MaThuoc varchar(10) not null,
	LieuLuong int not null
);

alter table BENH_NHAN
add constraint PK_BN primary key (MSBN);

alter table BAC_SI
add constraint PK_BS primary key (MSBS);

alter table KHAM_BENH
add constraint PK_KB primary key (MSBN, MSBS);
alter table KHAM_BENH
add constraint FK_KB_BS foreign key	(MSBS) references BAC_SI(MSBS);
alter table KHAM_BENH
add constraint FK_KB_BN foreign key	(MSBN) references BENH_NHAN(MSBN);

alter table DON_THUOC 
add constraint PK_DT primary key (MSDT);
alter table DON_THUOC
add constraint FK_DT_BN foreign key (MSBN) references BENH_NHAN(MSBN) on delete cascade;

alter table CHI_TIET_DON_THUOC
add constraint PK_CTDT primary key (MSDT);
alter table CHI_TIET_DON_THUOC
add constraint FK_CTDT_DT foreign key (MSDT) references DON_THUOC(MSDT);

insert into BENH_NHAN
values 
	('BN01', N'NGUYỄN VĂN', N'AN', '2000-1-1', N'12 AN THỚI'),
	('BN02', N'TRẦN VĂN', N'NAM', '2002-1-1', N'12 TRẦN HƯNG ĐẠO'),
	('BN03', N'NGUYỄN VĂN', N'TÂM', '2003-1-1', N'13/A CỦ CHI'),
	('BN04', N'LÊ VĂN', N'XUÂN', '2004-1-1', N'12 AN DƯƠNG VƯƠNG'),
	('BN05', N'NGUYỄN THỊ', N'KIM', '2005-1-1', N'15 QUẬN 1');

insert into BAC_SI
values
	('BS01', N'NGUYỄN VĂN', N'XUÂN', N'TIM'),
	('BS02', N'TRẦN', N'NHẬT', N'PHỔI'),
	('BS03', N'DƯƠNG', N'PHONG', N'THẦN KINH'),
	('BS04', N'NGUYỄN', N'ANH', N'TIM'),
	('BS05', N'HỒ LÊ', N'TÚ', N'SẢN');

insert into KHAM_BENH
values
	('BS01', 'BN05', '2000-12-10', N'BÌNH THƯỜNG'),
	('BS02', 'BN05', '2000-12-10', N'BÌNH THƯỜNG'),
	('BS03', 'BN05', '2000-12-10', N'BÌNH THƯỜNG'),
	('BS04', 'BN05', '2000-12-10', N'BÌNH THƯỜNG'),
	('BS05', 'BN05', '2000-12-10', N'BÌNH THƯỜNG'),
	('BS02', 'BN02', '2023-12-12', N'NẶNG'),
	('BS03', 'BN03', '2024-11-10', N'BÌNH THƯỜNG'),
	('BS04', 'BN04', '2025-11-15', N'BÌNH THƯỜNG'),
	('BS01', 'BN02', '2023-12-10', N'BÌNH THƯỜNG'),
	('BS02', 'BN03', '2023-12-12', N'NẶNG'),
	('BS03', 'BN04', '2023-11-10', N'BÌNH THƯỜNG'),
	('BS04', 'BN05', '2023-11-15', N'BÌNH THƯỜNG'),
	('BS05', 'BN02', '2023-11-15', N'BÌNH THƯỜNG'),
	('BS05', 'BN05', '2024-12-09', N'BÌNH THƯỜNG');
insert into DON_THUOC
values
	('DT01', 'BN01', '2021-12-10'),
	('DT02', 'BN02', '2022-12-12'),
	('DT03', 'BN03', '2023-11-10'),
	('DT04', 'BN02', '2024-11-15'),
	('DT05', 'BN05', '2025-12-09');

insert into CHI_TIET_DON_THUOC
values
	('DT01', 'T01', 2),
	('DT02', 'T02', 1),
	('DT03', 'T03', 2),
	('DT04', 'T04', 1),
	('DT05', 'T05', 5);
	
--Cau2.a: Hien thi danh sach benh nhan kham boi BS chuyen khoa "tim mach" trong nam 2024
select (bn.[HoBN]+' '+bn.TenBN) as HoTen
from [dbo].[BENH_NHAN] bn
	inner join [dbo].[KHAM_BENH] kb
	on bn.MSBN=kb.MSBN
	inner join [dbo].[BAC_SI] bs
	on bs.MSBS=kb.MSBS
	where bs.ChuyenKhoa=N'TIM'
	and year(kb.[NgayKham])=2024;

--Cau2.b: liet ke danh sach benh nhan, bac si kham, chan doan benh trong quy 4 nam 2024
select kb.[MSBN], kb.[MSBS],kb.[ChanDoan]
from [dbo].[KHAM_BENH] kb 
	join [dbo].[BENH_NHAN] bn 
	on  kb.MSBN=bn.MSBN 
	join [dbo].[BAC_SI] bs 
	on bs.MSBS=kb.MSBS 
where month([NgayKham])=10 or month([NgayKham])=11 or month([NgayKham])=12
	and year([NgayKham])=2024;

--Cau2.c: Thong ke so luong benh nhan kham benh theo tung bac si trong nam 2023
select bs.[MSBS], count(kb.[MSBN]) as SoLuongBN
from [dbo].[BAC_SI] bs, [dbo].[KHAM_BENH] kb
where bs.MSBS=kb.MSBS and year([NgayKham])=2023
group by bs.[MSBS]

--Cau2.d: Xoa nhung benh nhan chua tung kham benh trong 10 nam gan day
delete from [dbo].[KHAM_BENH]
where datediff(yyyy, getdate(),[NgayKham])>10;



--Cau2.e: Tim ho ten benh nhan da duoc kham boi tat ca cac bac si
select (bn.[HoBN] +' '+ bn.[TenBN]) as HoTenBN
from [dbo].[BENH_NHAN] bn, [dbo].[BAC_SI] bs,[dbo].[KHAM_BENH] kb
where bn.MSBN=kb.MSBN and bs.MSBS=kb.MSBS
group by bn.[HoBN], bn.[TenBN]
having count(distinct kb.[MSBS])= (select count(bs.[MSBS]) from  [dbo].[BAC_SI] bs);

--Cau3.a: Tao thu tuc thong ke cac loai thuoc va tong lieu luong thuoc ma moi benh nhan da su dung
create proc ThongKeThuoc (@MSBN varchar(5))
as 
begin
	select bn.MSBN,ctdt.[MaThuoc], sum(ctdt.[LieuLuong]) as TongLieuLuong
	from [dbo].[CHI_TIET_DON_THUOC] ctdt, [dbo].[BENH_NHAN] bn, [dbo].[DON_THUOC] dt
	where bn.MSBN=dt.MSBN and dt.MSDT=ctdt.MSDT and bn.MSBN=@MSBN
	group by bn.MSBN,ctdt.[MaThuoc]
end;

exec ThongKeThuoc 'BN01'

--Cau 3.b-----------------------------------------
--Tao ham liet ke ten benh nhan va tong so lan kham cua benh nhan do theo nam bat ky, cho vi du minh hoa
alter function KhamBenh(@NamKhamBenh int )
returns @SL_KhamBenh
table (HoTen nvarchar(40) not null, TongSLKham int  not null)
as
begin
	insert into @SL_KhamBenh
	select (bn.[HoBN]+' '+bn.[TenBN]),
			 count(kb.[MSBN])
	from [dbo].[KHAM_BENH] kb 
		join[dbo].[BENH_NHAN] bn
		on kb.MSBN=bn.MSBN 
	where @NamKhamBenh=year(kb.NgayKham)
	group by bn.[HoBN],bn.[TenBN]	
	return
end;

select * from KhamBenh(2024);

--Cau 3.c: Tao trigger kiem tra du lieu khi them don thuoc, sao cho moi benh nhan khong duoc ke qua 10 don mot lan
create trigger DonThuocQua10
on [dbo].[DON_THUOC]
for insert
as
begin
	declare @count int =0;
	select @count = count(i.[MSDT]) 
	from inserted i, [dbo].[BENH_NHAN] bn
	group by bn.MSBN
	if(@count>10)
	begin
		rollback tran
		print(N'Không được nhập quá 10 đơn thuốc 1 lần cho bệnh nhân');
	end
end;

insert into DON_THUOC
values
	('DT011', 'BN01', '2024-12-10'),
	('DT012', 'BN01', '2024-11-10'),
	('DT014', 'BN01', '2024-11-15'),
	('DT015', 'BN01', '2024-12-09'),
	('DT016', 'BN01', '2024-12-09'),
	('DT017', 'BN01', '2024-12-09'),
	('DT018', 'BN01', '2024-12-09'),
	('DT019', 'BN01', '2024-12-09'),
	('DT020', 'BN01', '2024-12-09'),
	('DT021', 'BN01', '2024-12-09'),
	('DT022', 'BN01', '2024-12-09');
