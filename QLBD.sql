﻿CREATE DATABASE QLBD
GO

USE QLBD
GO

CREATE TABLE CAUTHU (
	MACT NUMERIC IDENTITY(1, 1),
	HOTEN NVARCHAR(100) NOT NULL,
	VITRI NVARCHAR(20) NOT NULL,
	NGAYSINH DATETIME,
	DIACHI NVARCHAR(200),
	MACLB VARCHAR(5) NOT NULL,
	MAQG VARCHAR(5) NOT NULL,
	SO INT NOT NULL
)
GO

ALTER TABLE CAUTHU
ADD CONSTRAINT PK_CT PRIMARY KEY (MACT)

GO
CREATE TABLE QUOCGIA (
	MAQG VARCHAR(5) NOT NULL PRIMARY KEY,
	TENQG NVARCHAR(60) NOT NULL
)

GO
CREATE TABLE CAULACBO (
	MACLB VARCHAR(5) NOT NULL PRIMARY KEY,
	TENCLB NVARCHAR(100) NOT NULL,
	MASAN VARCHAR(5) NOT NULL,
	MATINH VARCHAR(5) NOT NULL
)

GO
CREATE TABLE TINH (
	MATINH VARCHAR(5) NOT NULL PRIMARY KEY,
	TENTINH NVARCHAR(100) NOT NULL
)

GO
CREATE TABLE SANVD (
	MASAN VARCHAR(5) NOT NULL PRIMARY KEY,
	TENSAN NVARCHAR(100) NOT NULL,
	DIACHI NVARCHAR(200)
)
GO
CREATE TABLE HUANLUYENVIEN (
	MAHLV VARCHAR(5) NOT NULL PRIMARY KEY,
	TENHLV NVARCHAR(100) NOT NULL,
	NGAYSINH DATETIME,
	DIACHI NVARCHAR(200),
	DIENTHOAI NVARCHAR(20),
	MAQG VARCHAR(5) NOT NULL
)
GO
CREATE TABLE HLV_CLB (
	MAHLV VARCHAR(5) NOT NULL,
	MACLB VARCHAR(5) NOT NULL,
	VAITRO NVARCHAR(100) NOT NULL,
	PRIMARY KEY (MAHLV, MACLB)
)
GO
CREATE TABLE TRANDAU (
	MATRAN NUMERIC NOT NULL IDENTITY(1, 1) PRIMARY KEY,
	NAM INT NOT NULL,
	VONG INT NOT NULL,
	NGAYTD DATETIME NOT NULL,
	MACLB1 VARCHAR(5) NOT NULL,
	MACLB2 VARCHAR(5) NOT NULL,
	MASAN VARCHAR(5) NOT NULL,
	KETQUA VARCHAR(5) NOT NULL
)
GO
CREATE TABLE BANGXH (
	MACLB VARCHAR(5) NOT NULL,
	NAM INT NOT NULL,
	VONG INT NOT NULL,
	SOTRAN INT NOT NULL,
	THANG INT NOT NULL,
	HOA INT NOT NULL,
	THUA INT NOT NULL,
	HIEUSO VARCHAR(5) NOT NULL,
	DIEM INT NOT NULL,
	HANG INT NOT NULL,
	PRIMARY KEY (MACLB, NAM, VONG)
)
GO
ALTER TABLE CAUTHU
ADD CONSTRAINT FK_CT_CLB FOREIGN KEY (MACLB) REFERENCES CAULACBO (MACLB)
ALTER TABLE CAUTHU
ADD CONSTRAINT FK_CT_QG FOREIGN KEY (MAQG) REFERENCES QUOCGIA (MAQG)

ALTER TABLE CAULACBO
ADD CONSTRAINT FK_CLB_SVD FOREIGN KEY (MASAN) REFERENCES SANVD (MASAN)
ALTER TABLE CAULACBO
ADD CONSTRAINT FK_CLB_TINH FOREIGN KEY (MATINH) REFERENCES TINH (MATINH)

ALTER TABLE HUANLUYENVIEN
ADD CONSTRAINT FK_HLV_QG FOREIGN KEY (MAQG) REFERENCES QUOCGIA (MAQG)

ALTER TABLE HLV_CLB
ADD CONSTRAINT FK_HLVCLB_HLV FOREIGN KEY (MAHLV) REFERENCES HUANLUYENVIEN (MAHLV)
ALTER TABLE HLV_CLB
ADD CONSTRAINT FK_HLVCLB_CLB FOREIGN KEY (MACLB) REFERENCES CAULACBO (MACLB)

ALTER TABLE TRANDAU
ADD CONSTRAINT FK_TD_CLB1 FOREIGN KEY (MACLB1) REFERENCES CAULACBO (MACLB)
ALTER TABLE TRANDAU
ADD CONSTRAINT FK_TD_CLB2 FOREIGN KEY (MACLB2) REFERENCES CAULACBO (MACLB)
ALTER TABLE TRANDAU
ADD CONSTRAINT FK_TD_SVD FOREIGN KEY (MASAN) REFERENCES SANVD (MASAN)

ALTER TABLE BANGXH
ADD CONSTRAINT FK_BXH_CLB FOREIGN KEY (MACLB) REFERENCES CAULACBO (MACLB)

GO
INSERT INTO DBO.QUOCGIA VALUES
 ('VN',N'Việt Nam'),
 ('ANH', N'Anh Quốc'),
 ('TBN',N'Tây Ban Nha'),
 ('BDN', N'Bồ Đầu Nha'),
 ('BRA',N'Bra-xin'),
 ('ITA',N'Ý'),
 ('THA',N'Thái Lan')

 GO
 INSERT INTO DBO.SANVD VALUES
 ('GD',N'Gò Đậu',N'123 QL1,TX Thủ Dầu Một,Bình Dương'),
 ('PL',N'Pleuku',N'22 Hồ Tùng Mậu, Thống Nhất,Thị xã Pleiku,Gia Lai'),
 ('CL',N'Chi Lăng',N'127 Võ Văn Tần, Đà Nẵng'),
 ('NT',N'Nha Trang',N'128 Phan Chu Trinh, Nha Trang, Khánh Hòa'),
 ('TH',N'Tuy Hòa',N'57 Trường Chinh, Tuy Hòa, Phú Yên'),
 ('LA',N'Long An',N'102 Hùng Vương, Tp Tân An, Long An')

 GO
INSERT INTO DBO.TINH VALUES
 ('BD',N'Bình Dương'),
 ('GL',N'Gia Lai'),
 ('DN',N'Đà Nẵng'),
 ('KH',N'Khánh Hòa'),
 ('PY',N'Phú Yên'),
 ('LA',N'Long An')
 
 GO
 INSERT INTO DBO.CAULACBO VALUES
 ('BBD',N'BECAMEX BÌNH DƯƠNG','GD','BD'),
 ('HAGL',N'HOÀNG ANH GIA LAI','PL','GL'),
 ('SDN',N'SHB ĐÀ NẴNG','CL','DN'),
 ('KKH',N'KHATOCO KHÁNH HÒA','NT','KH'),
 ('TPY',N'THÉP PHÚ YÊN','TH','PY'),
 ('GDT',N'GẠCH ĐỒNG TÂM LONG','LA','LA')

 GO
 INSERT INTO DBO.CAUTHU VALUES
 (N'Nguyễn Vũ Phong',N'Tiền vệ','1990/02/20',NULL,'BBD','VN',17),
 (N'Nguyễn Công Vinh',N'Tiền đạo','1992/03/10',NULL,'HAGL','VN',9),
 (N'Trần Tấn Tài',N'Tiền vệ','1989/11/12',NULL,'BBD','VN',8),
 (N'Phan Hồng Sơn',N'Thủ môn','1991/06/10',NULL,'HAGL','VN',1),
 (N'Ronaldo',N'Tiền Vệ','1991/06/10',NULL,'SDN','BRA',7),
 (N'Robinho',N'Tiền vệ','1989/10/12',NULL,'SDN','BRA',8),
 (N'Vidic',N'Hậu vệ','1987/10/11',NULL,'HAGL','ANH',3),
 (N'Trần Văn Santos',N'Thủ môn','1990/10/21',NULL,'BBD','BRA',1),
 (N'Nguyễn Trường Sơn',N'Hậu vệ','1993/8/26',NULL,'BBD','VN',4)

 GO
 INSERT INTO DBO.HUANLUYENVIEN VALUES 
 ('HLV01',N'Vital','1975/10/15',NULL,N'0918011075','BDN'),
 ('HLV02',N'Lê Huỳnh Đức','1972/05/20',NULL,N'01223456789','VN'),
 ('HLV03',N'Kiatisuk','1970/12/11',NULL,N'01990123456','THA'),
 ('HLV04',N'Hoàng Tuấn Anh','1970/06/10',NULL,N'0989112233','VN'),
 ('HLV05',N'Trần Công Minh','1973/07/07',NULL,N'0909099990','VN'),
 ('HLV06',N'Trần Văn Phúc','1975/03/02',NULL,N'01650101234','VN')

INSERT INTO DBO.HLV_CLB VALUES 
('HLV01','BBD',N'HLV Chính'),
('HLV02','SDN',N'HLV Chính'),
('HLV03','HAGL',N'HLV Chính'),
('HLV04','KKH',N'HLV Chính'),
('HLV05','GDT',N'HLV Chính'),
('HLV06','BBD',N'HLV Thủ môn');

use [QLBD]
alter table [dbo].[HLV_CLB]
add constraint VTHLV check ([VAITRO] in (N'HLV Chính', N'HLV Phụ', N'HLV Thể lực',N'HLV Thủ môn'));

GO
INSERT INTO DBO.TRANDAU VALUES 
(2019,1,'2019/02/07','BBD','SDN','GD','3-0'),
(2019,1,'2019/02/07','KKH','GDT','NT','1-1'),
(2019,2,'2019/02/16','SDN','KKH','CL','2-2'),
(2019,2,'2019/02/16','TPY','BBD','TH','5-0'),
(2019,3,'2019/03/1','TPY','GDT','TH','0-2'),
(2019,3,'2019/03/1','KKH','BBD','NT','0-1'),
(2019,4,'2019/03/7','KKH','TPY','NT','1-0'),
(2019,4,'2019/03/7','BBD','GDT','GD','2-2')

GO
INSERT INTO BANGXH VALUES ('BBD', 2019, 1, 1, 1, 0, 0, '3-0', 3, 1)
INSERT INTO BANGXH VALUES ('BBD', 2019, 2, 2, 1, 0, 1, '3-5', 3, 2)
INSERT INTO BANGXH VALUES ('BBD', 2019, 3, 3, 2, 0, 1, '4-5', 6, 1)
INSERT INTO BANGXH VALUES ('BBD', 2019, 4, 4, 2, 1, 1, '6-7', 7, 1)
INSERT INTO BANGXH VALUES ('GDT', 2019, 1, 1, 0, 1, 0, '1-1', 1, 3)
INSERT INTO BANGXH VALUES ('GDT', 2019, 2, 1, 0, 1, 0, '1-1', 1, 4)