use master
go

-- Tạo csdl
drop database if exists QuanLiNhanSu;
go

create database QuanLiNhanSu;
go

-- Tạo các bảng
use QuanLiNhanSu;
go

-- Table PhongBan
if OBJECT_ID('PhongBan') is not null
	drop table PhongBan;
go
create table PhongBan
(
	ID int not null,
	TenPhong nvarchar(50),
	TruongPhong int,
	constraint pk_PhongBan primary key (ID),
);
go
insert into PhongBan values
(1,'Nhân Sự',1),
(2,'Kỹ Thuật',2),
(3,'Tài Chính',3),
(4,'Điều Hành',4)
go
-- Table NhanVien
if OBJECT_ID('NhanVien') is not null
	drop table NhanVien;
go
create table NhanVien 
(
	ID int not null,
	HoVaTen nvarchar(50),
	NgaySinh date,
	DiaChi nvarchar(50),
	SDT nvarchar(20),
	GioiTinh nvarchar(5),
	Phong int not null,
	NgayLamTrongThang int,
	NgayLamGanNhat date,
	NgayGiaNhap date,
	TrangThai int,
	constraint pk_NhanVien primary key (ID),
);
go
declare @i int = 1;
while @i <= 100
begin
declare @TenNV nvarchar(50),
		@DiaChi nvarchar(100),
		@SDT nvarchar(20),
		@Gioi nvarchar(5),
		@Phong int,
		@gianhap date;
--random họ
DECLARE @ho nvarchar(20)
SET @ho = (SELECT c1 AS [text()] FROM (SELECT TOP (1) c1 FROM (VALUES
      (N'Nguyễn'), (N'Trần'), (N'Lê'), (N'Phạm'), (N'Hoàng'), (N'Huỳnh'), (N'Phan'), (N'Vũ'), (N'Võ'), (N'Đặng'),
      (N'Bùi'), (N'Đỗ'), (N'Hồ'), (N'Ngô'), (N'Dương'), (N'Lý')
	  ) AS T1(c1)
	ORDER BY ABS(CHECKSUM(NEWID()))) AS T2 FOR XML PATH(''))
--random tên đệm
DECLARE @tenlot nvarchar(20)
SET @tenlot = (SELECT c1 AS [text()] FROM (SELECT TOP (1) c1 FROM (VALUES
      (N'Xuân'), (N'Thu'), (N'Cẩm'), (N'Văn'), (N'Thị'), (N'Châu'), (N'Hồng'), (N'Đức'), (N'Hạnh'), (N'Đình'),
      (N'Đại'), (N'Bá'), (N'Mạnh'), (N'Trọng'), (N'Gia'), (N'Kim'), (N'Duy')
	  ) AS T1(c1)
	ORDER BY ABS(CHECKSUM(NEWID()))) AS T2 FOR XML PATH(''))
--random tên
DECLARE @ten nvarchar(20)
SET @ten = (SELECT c1 AS [text()] FROM (SELECT TOP (1) c1 FROM (VALUES
      (N'Tuấn'), (N'Sơn'), (N'Hạnh'), (N'Thảo'), (N'Hiền'), (N'Dung'), (N'Anh'), (N'Bình'), (N'Nguyệt'), (N'Tuệ'),
      (N'Hiệp'), (N'Ly'), (N'Khánh'), (N'Long'), (N'Quốc'), (N'Loan'), (N'Hùng'), (N'Đạt'), (N'Diệu')
	  ) AS T1(c1)
	ORDER BY ABS(CHECKSUM(NEWID()))) AS T2 FOR XML PATH(''))
	set @TenNV = @ho + ' ' + @tenlot +' '+ @ten		
	--random địa chỉ
SET @DiaChi = (SELECT c1 AS [text()] FROM (SELECT TOP (1) c1 FROM (VALUES
      (N'An Giang'), (N'Bà Rịa - Vũng Tàu'), (N'Bạc Liêu'), (N'Bắc Cạn'), (N'Bắc Giang'), (N'Bắc Ninh'), (N'Bến Tre'), (N'Bình Dương'), (N'Bình Định'), (N'Bình Phước'),
      (N'Bình Thuận'), (N'Cà Mau'), (N'Cao Bằng'), (N'Cần Thơ'), (N'Đà Nẵng'), (N'Đắk Lắk'), (N'Đắk Nông'), (N'Đồng Nai'), (N'Đồng Tháp'), (N'Đồng Tháp'), (N'Điện Biên'),
	  (N'Gia Lai'), (N'Hà Giang'), (N'Hà Nam'), (N'Hà Nội'), (N'Hà Tĩnh'), (N'Hải Dương'), (N'Hải Phòng'), (N'Hòa Bình'), (N'Hậu Giang'), (N'Hưng Yên'), (N'Hồ Chí Minh'),
	  (N'Khánh Hòa'), (N'Kiên Giang'), (N'Kon Tum'), (N'Lai Châu'), (N'Lào Cai'), (N'Lạng Sơn'), (N'Lâm Đồng'), (N'Long An'), (N'Nam Định'), (N'Nghệ An'), (N'Ninh Bình'),
	  (N'Ninh Thuận'), (N'Phú Thọ'), (N'Phú Yên'), (N'Quảng Bình'), (N'Quảng Nam'), (N'Quảng Ngãi'), (N'Quảng Ninh'), (N'Quảng Trị'), (N'Sóc Trăng'), (N'Sơn La'), (N'Tây Ninh'),
	  (N'Thái Bình'), (N'Thái Nguyên'), (N'Thanh Hóa'), (N'Thừa Thiên Huế'), (N'Tiền Giang'), (N'Trà Vinh'), (N'Tuyên Quang'), (N'Vĩnh Long'), (N'Vĩnh Phúc'), (N'Yên Bái')
	  ) AS T1(c1)
	ORDER BY ABS(CHECKSUM(NEWID()))) AS T2 FOR XML PATH(''))
	--random số diện thoại
DECLARE @temp2 INT
SELECT @temp2 = FLOOR(RAND()*(999999999-100000000)+100000000)
SELECT @SDT = '0' + CAST(@temp2 AS VARCHAR(13))

-- Random giới tính
SET @Gioi = (SELECT c1 AS [text()] FROM (SELECT TOP (1) c1 FROM (VALUES
      (N'Nam'), (N'Nữ') ) AS T1(c1)
	  ORDER BY ABS(CHECKSUM(NEWID()))) AS T2 FOR XML PATH(''));
-- Random PhongBan
set @Phong = cast((rand() * 4 + 1) as int);
-- Set ngày gia nhập
set @gianhap = GETDATE();
	---------------------------------------
	insert into NhanVien(ID, HoVaTen, DiaChi,SDT, GioiTinh, Phong, NgayGiaNhap, TrangThai)
	values (@i, @TenNV, @DiaChi, @SDT, @Gioi, @Phong, @gianhap, 1)
	set @i = @i +1
end
go
-- Table Luong
if OBJECT_ID('Luong') is not null
	drop table Luong;
go
create table Luong
(
	ID int not null,
	LuongCoBan int,
	LuongThuong int,	
	constraint pk_Luong primary key (ID),
);
go
declare @j int = 1;
while @j <= 100
begin 
	declare @LuongCB int,
			@LuongT int;
	set @LuongCB = (SELECT c1 AS [text()] FROM (SELECT TOP (1) c1 FROM (VALUES
      (7000000), (8000000), (9000000), (10000000), (11000000), (12000000) , (13000000), (14000000) , (15000000) ) AS T1(c1)
	  ORDER BY ABS(CHECKSUM(NEWID()))) AS T2 FOR XML PATH(''));
	set @LuongT = (SELECT c1 AS [text()] FROM (SELECT TOP (1) c1 FROM (VALUES
      (1000000),(1500000), (2000000), (2500000)) AS T1(c1)
	  ORDER BY ABS(CHECKSUM(NEWID()))) AS T2 FOR XML PATH(''));
	----------------------
	insert into Luong (ID, LuongCoBan, LuongThuong)
	values (@j,@LuongCB,@LuongT);
	set @j = @j +1;
end
go
-- Table DuAn
if OBJECT_ID('DuAn') is not null
	drop table DuAn;
go
create table DuAn
(
	ID int not null,
	TenDuAn nvarchar(50),
	Phong int,	
	constraint pk_DuAn primary key (ID),
);
go
declare @k int = 1;
while @k<=10
begin 
	declare @Phongda int;
	set @Phongda = cast((rand() * 4 + 1) as int);
	
	insert into DuAn (ID, Phong)
	values (@k, @Phongda);
	set @k = @k +1;
end
go
-- Table PhanCong
if OBJECT_ID('PhanCong') is not null
	drop table PhanCong;
go
create table PhanCong
(
	ID_NV int not null,
	ID_DA int not null,
	BatDau date,
	KetThuc date,
	constraint pk_PhanCong primary key (ID_NV, ID_DA),
);
go
-- Table DangNhap
if OBJECT_ID('DangNhap') is not null
	drop table DangNhap;

create table DangNhap
(
	ID int not null,
	Pass nvarchar(50) not null,
	Permission int not null,
	constraint pk_DangNhap primary key (ID),
);
go
-- Tạo khóa ngoại
-- PhongBan và NhanVien
alter table PhongBan
with nocheck add constraint fk_PhongBan_NhanVien
foreign key (TruongPhong) references NhanVien(ID);
go

-- NhanVien và PhongBan
alter table NhanVien
with nocheck add constraint fk_NhanVien_PhongBan
foreign key (Phong) references PhongBan(ID);
go

-- Luong và NhanVien
alter table Luong
with nocheck add constraint fk_Luong_NhanVien
foreign key (ID) references NhanVien(ID);
go

-- DuAn và PhongBan
alter table DuAn
with nocheck add constraint fk_DuAn_PhongBan
foreign key (Phong) references PhongBan(ID);
go

-- PhanCong và NhanVien
alter table PhanCong
with nocheck add constraint fk_PhanCong_NhanVien
foreign key (ID_NV) references NhanVien(ID);
go

-- PhanCong và DuAn
alter table PhanCong
with nocheck add constraint fk_PhanCong_DuAn
foreign key (ID_DA) references DuAn(ID);
go

-- DangNhap và NhanVien
alter table DangNhap
with nocheck add constraint fk_DangNhap_NhanVien
foreign key (ID) references NhanVien(ID);
go


---------------------------------------------------------------
-- Store Procedure
---------------------------------------------------------------
-- PhongBan
-- Thêm PhongBan
if OBJECT_ID ('addPhongBan') is not null
	drop proc addPhongBan;
go
create procedure addPhongBan
  @ID Int,
  @TenPhong nvarchar(50),
  @TruongPhong int
as 
begin 
set nocount on; 
	begin
		insert into PhongBan(ID, TenPhong , TruongPhong)
		values(@ID, @TenPhong, @TruongPhong)
	end 
end
go

-- Xóa PhongBan
if OBJECT_ID ('deletePhongBan') is not null
	drop proc deletePhongBan;
go
create procedure deletePhongBan
  @ID Int
as 
begin 
set nocount on; 
	begin
		delete from PhongBan where ID = @ID;
	end 
end
go

-- updating data PhongBan
if OBJECT_ID('updatePhongBan') is not null
	drop proc updatePhongBan;
go
create procedure updatePhongBan  
(  
    @ID int,  
    @TenPhong nvarchar(50),  
    @TruongPhong int 
)  
as  
begin  
     update PhongBan 
     set 
		TenPhong = @TenPhong,  
		TruongPhong = @TruongPhong
     where ID = @ID  
end  
go


----------------------------------------------------------------------
-- DuAn
-- Thêm DuAn
if OBJECT_ID ('addPhongBan') is not null
	drop proc addDuAn;
go
create procedure addDuAn
  @ID Int,
  @TenDuAn nvarchar(50),
  @Phong int
as 
begin 
set nocount on; 
	begin
		insert into DuAn(ID, TenDuAn , Phong)
		values(@ID, @TenDuAn, @Phong)
	end 
end
go

-- Xóa DuAn
if OBJECT_ID ('deleteDuAn') is not null
	drop proc deleteDuAn;
go
create procedure deleteDuAn
  @ID Int
as 
begin 
set nocount on; 
	begin
		delete from DuAn where ID = @ID;
	end 
end
go

-- updating data DuAn
if OBJECT_ID('updateDuAn') is not null
	drop proc updateDuAn;
go
create procedure updateDuAn  
(  
    @ID int,  
    @TenDA nvarchar(50),  
    @Phong int 
)  
as  
begin  
     update PhongBan 
     set 
		TenPhong = @TenDA,  
		TruongPhong = @Phong
     where ID = @ID  
end  
go

----------------------------------------------------------------------
-- NhanVien
-- Thêm NhanVien
if OBJECT_ID ('addNhanVien') is not null
	drop proc addNhanVien;
go
create procedure addNhanVien
  @ID Int,
  @Ten nvarchar(50),
  @NgaySinh date,
  @DiaChi nvarchar(50),
  @SDT nvarchar(20),
  @GioiTinh nvarchar(5),
  @TenPhong nvarchar(50)
as 
begin 
declare @Phong nvarchar(50),
		@NgayLamTrongThang int,
	    @NgayLamGanNhat date,
		@NgayGiaNhap date;
set @Phong = (select ID from PhongBan where TenPhong = @TenPhong);
set @NgayLamTrongThang = 0;
set @NgayLamGanNhat = null;
set @NgayGiaNhap = GETDATE();
set nocount on; 
	begin		
		insert into NhanVien(ID, HoVaTen , NgaySinh, DiaChi,SDT, GioiTinh, Phong, NgayLamTrongThang, NgayLamGanNhat, NgayGiaNhap, TrangThai )
		values(@ID, @Ten ,@NgaySinh, @DiaChi, @SDT, @GioiTinh, @Phong, @NgayLamTrongThang, @NgayLamGanNhat, @NgayGiaNhap, 1)
	end 
end
go

-- Xóa NhanVien
if OBJECT_ID ('deleteNhanVien') is not null
	drop proc deleteNhanVien;
go
create procedure deleteNhanVien
  @ID Int
as 
begin 
set nocount on; 
	begin
		delete from NhanVien where ID = @ID;
	end 
end
go

-- updating data NhanVien
if OBJECT_ID('updateNhanVien') is not null
	drop proc updateNhanVien;
go
create procedure updateNhanVien 
(  
  @ID Int,
  @Ten nvarchar(50),
  @DiaChi nvarchar(50),
  @SDT nvarchar(20),
  @TenPhong nvarchar(50)
)  
as  
begin  
declare @Phong nvarchar(50);
set @Phong = (select ID from PhongBan where TenPhong = @TenPhong);
     update NhanVien 
     set 
		HoVaTen = @Ten,  
		DiaChi = @DiaChi,
		SDT = @SDT,
		Phong = @Phong
     where ID = @ID  
end  
go





