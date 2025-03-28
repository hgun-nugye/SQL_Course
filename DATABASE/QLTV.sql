 create database QLTV
 go
 use QLTV
 go
 create table DocGia(
	Ma_DocGia varchar(10) not null primary key,
	Ho nvarchar(10) not null,
	TenLot nvarchar(10) not null,
	Ten nvarchar(10) not null,
	NgaySinh date 
	
 );
 go
 create table NguoiLon(
	 Ma_DocGia varchar(10) not null primary key,
	 SoNha varchar(20) not null,
	 Duong varchar(30) not null,
	 Quan varchar(30) not null,
	 DienThoai varchar(15) not null,
	 HanSuDung datetime not null,
	 foreign key (Ma_DocGia) references DocGia(Ma_DocGia)
 );
 go
 create table TreEm(
	Ma_DocGia varchar(10) not null primary key,
	Ma_DocGiaNguoiLon varchar(10) not null,
	foreign key (Ma_DocGiaNguoiLon) references NguoiLon(Ma_DocGia),
	foreign key (Ma_DocGia) references DocGia(Ma_DocGia)

);
go
create table TuaSach(
	Ma_TuaSach varchar(10) not null primary key,
	TuaSach nvarchar(20) not null,
	TacGia nvarchar(20) not null,
	TomTat nvarchar(100)
);
go
create table DauSach(
	ISBN varchar(20) not null primary key,
	Ma_TuaSach varchar(10) not null,
	NgonNgu varchar(20) ,
	Bia nvarchar(10),
	TrangThai varchar(10) not null,
	foreign key (Ma_TuaSach) references TuaSach(Ma_TuaSach)
);
go
create table DangKy (
	ISBN varchar(20) not null ,
	Ma_DocGia varchar(10) not null,
	NgayDK datetime not null,
	GhiChu nvarchar(255),
	primary key(ISBN,Ma_DocGia),
	foreign key (Ma_DocGia) references DocGia(Ma_DocGia)
);
go
create table Muon(
	ISBN varchar(20) not null ,
	Ma_CuonSach varchar(10) not null,
	Ma_DocGia varchar(10) not null,
	NgayMuon date not null,
	NgayHetHan date not null,
	primary key (ISBN,Ma_CuonSach),
	foreign key (Ma_DocGia) references DocGia(Ma_DocGia)
);
go
create table CuonSach(
	ISBN varchar(20) not null ,
	Ma_CuonSach varchar(10) not null,
	TinhTrang varchar(10) not null,
	primary key (ISBN, Ma_CuonSach),
	foreign key (ISBN) references DauSach(ISBN),

);
alter table CuonSach add foreign key (ISBN, Ma_CuonSach) references Muon(ISBN,Ma_CuonSach)
go
create table QuaTrinhMuon
(
	ISBN varchar(20) not null , 
	Ma_CuonSach varchar(10) not null,
	NgayMuon date not null,
	NgayHetHan date not null,
	Ma_DocGia varchar(10) not null,
	NgayTra date not null,
	TienMuon smallint not null,
	TienDaTra smallint not null,
	TienDatCoc smallint not null,
	GhiChu nvarchar(255),
	primary key (Ma_CuonSach,ISBN,NgayMuon),
	foreign key (ISBN, Ma_CuonSach) references CuonSach(ISBN,Ma_CuonSach),
	foreign key (Ma_DocGia) references DocGia(Ma_DocGia)
	
);
alter table CuonSach add foreign key (ISBN, Ma_CuonSach) references Muon(ISBN,Ma_CuonSach);
go
insert into DocGia
values	
	('NL001', N'Nguyễn', N'Văn', N'An', '1985-06-15'),
	('NL002', N'Trần', N'Thi', N'Bi', '1990-07-20'),
	('te001', N'Trần', N'Thi', N'Binh', '2010-07-20'),
	('NL003', N'Lê', N'Thị',N'Chang', '2005-03-30'),
	('te002', N'Lê', N'Thị',N'Chung', '2015-03-30'),
	('NL004', N'Phạm', N'Văn', N'Dân', '1978-12-25'),
	('NL005', N'Hòang', N'Thi', N'Én', '2010-02-10'),
	('te003', N'Hòang', N'Thi', N'Anh', '2015-02-10');
go
insert into NguoiLon
values
	('NL001', '123', 'Le Lai', 'Quan 1', '0123456789', '2025-12-31'),
	('NL002', '456', 'Nguyen Hue', 'Quan 2', '0987654321', '2025-11-30'),
	('NL004', '789', 'Tran Hung Dao', 'Quan 3', '0112233445', '2025-10-20');
go
insert into TreEm
values
	('te003', 'NL001'),  
	('te001', 'NL002');  
go

insert into TuaSach (Ma_TuaSach, TuaSach, TacGia, TomTat)
values
	('TS001', 'Cuộc Đời Của Pi', 'Yann Martel', 'Câu chuyện về một cậu bé sống sót sau một vụ đắm tàu biển.'),
	('TS002', '1984', 'George Orwell', 'Một tác phẩm kinh điển về xã hội kiểm soát và sự giám sát.'),
	('TS003', 'Đắc Nhân Tâm', 'Dale Carnegie', 'Hướng dẫn về nghệ thuật giao tiếp và cách tạo mối quan hệ.'),
	('TS004', 'Nhà Giả Kim', 'Paulo Coelho', 'Hành trình tìm kiếm giấc mơ và ý nghĩa cuộc sống.'),
	('TS005', 'Sapiens', 'Yuval Noah Harari', 'Khảo sát lịch sử loài người từ thời nguyên thủy đến hiện đại.');
go

insert into DauSach
values
	('ISBN001', 'TS001', 'Tieng Viet', N'Cứng', 'Con'),
	('ISBN002', 'TS002', 'Tieng Anh', N'Mềm', 'Dang Muon'),
	('ISBN003', 'TS003', 'Tieng Phap',N'Cứng', 'Con'),
	('ISBN004', 'TS004', 'Tieng Viet', N'Mềm', 'Con'),
	('ISBN005', 'TS005', 'Tieng Duc', N'Cứng', 'Dang Muon');
go

insert into DangKy
values
	('ISBN001', 'NL001', '2023-01-15 10:00:00', 'Đăng ký lần đầu'),
	('ISBN002', 'NL002', '2023-02-20 14:30:00', 'Đăng ký mới'),
	('ISBN003', 'te003', '2023-03-05 09:15:00', 'Đăng ký bổ sung'),
	('ISBN004', 'NL004', '2023-04-10 11:45:00', 'Gia hạn đăng ký'),
	('ISBN005', 'NL005', '2023-05-18 16:00:00', 'Đăng ký lần đầu');
go

insert into Muon
values 
	('ISBN001', 'CS001', 'te001', '2023-01-15', '2023-02-15'),
	('ISBN002', 'CS002', 'NL002', '2023-02-20', '2023-03-20'),
	('ISBN003', 'CS003', 'NL003', '2023-03-05', '2023-04-05'),
	('ISBN004', 'CS004', 'NL004', '2023-04-10', '2023-05-10'),
	('ISBN005', 'CS005', 'NL005', '2023-05-18', '2023-06-18');
go

insert into Cuonsach
values
	('ISBN001', 'CS001', 'Con'),
	('ISBN002', 'CS002', 'Dang Muon'),
	('ISBN003', 'CS003', 'Con'),
	('ISBN004', 'CS004', 'Con'),
	('ISBN005', 'CS005', 'Khong Con');
go
insert into QuaTrinhMuon
values
	('ISBN001', 'CS001', '2023-01-15', '2023-02-15', 'NL001', '2023-02-14', 10000, 10000, 2000, 'Trả đúng hạn'),
	('ISBN002', 'CS002', '2023-02-20', '2023-03-20', 'NL002', '2023-03-19', 15000, 15000, 3000, 'Trả đúng hạn'),
	('ISBN003', 'CS003', '2023-03-05', '2023-04-05', 'NL003', '2023-04-04', 12000, 12000, 2500, 'Trả đúng hạn'),
	('ISBN004', 'CS004', '2023-04-10', '2023-05-10', 'NL004', '2023-05-09', 8000, 8000, 1000, 'Trả đúng hạn'),
	('ISBN005', 'CS005', '2023-05-18', '2023-06-18', 'NL005', '2023-06-17', 9000, 9000, 1500, 'Trả đúng hạn');