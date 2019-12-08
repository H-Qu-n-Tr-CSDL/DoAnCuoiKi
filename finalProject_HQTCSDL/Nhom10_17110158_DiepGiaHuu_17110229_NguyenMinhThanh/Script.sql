use master;
go

-- Tạo database
if OBJECT_ID('doan_QLNV') is not null
	drop database doan_QLNV;
create database doan_QLNV;
--go
use doan_QLNV;
go
-- Tạo các table
-- Nhân Viên
if OBJECT_ID('NhanVien') is not null
	drop table NhanVien;
go

create table NhanVien
(	
	MaNV int not null identity,
	HoVaTen nvarchar(50),
	CMND nvarchar(10),
	GioiTinh nvarchar(5),
	NgaySinh date,
	DanToc nvarchar(20),
	TonGiao nvarchar(20),
	DiaChi nvarchar(50),
	SDT nvarchar(20),	
	--Phong int not null,
	NgayLamTrongThang int,
	NgayLamGanNhat date,
	NgayGiaNhap date,
	ATM nvarchar(50),
	BHYT nvarchar(50),
	SoHD int,
	--TrangThai int,
	PhongBan int,
	ChucVu int,
	TrinhDo int,
	--HopDong int,
	--TaiKhoan nvarchar(20),
	constraint pk_NhanVien primary key (MaNV),
);
go
-- Phòng Ban
if OBJECT_ID('PhongBan') is not null
	drop table PhongBan;
go
create table PhongBan
(	
	MaPB int not null identity,
	TenPB nvarchar(50),	
	constraint pk_PhongBan primary key (MaPB),
);
go

-- Chức Vụ
if OBJECT_ID('ChucVu') is not null
	drop table ChucVu;
go
create table ChucVu
(	
	MaCV int not null identity,
	TenCV nvarchar(50),	
	PhuCap float,
	constraint pk_ChucVu primary key (MaCV),
);
go

-- Chuyển công tác
if OBJECT_ID('ChuyenCongTac') is not null
	drop table ChuyenCongTac;
go
create table ChuyenCongTac
(	
	MaChuyen int not null identity,
	NgayChuyen date,	
	MaNV int,
	MaCVCu int,
	MaCVMoi int,
	MaPBMoi int,
	constraint pk_ChuyenCongTac primary key (MaChuyen),
);
go

-- Trình Độ
if OBJECT_ID('TrinhDo') is not null
	drop table TrinhDo;
go
create table TrinhDo
(	
	MaTD int not null identity,
	TenTD nvarchar(50),	
	constraint pk_TrinhDo primary key (MaTD),
);
go
-- Chi tiết trình độ
if OBJECT_ID('CTTrinhDo') is not null
	drop table CTTrinhDo;
go
create table CTTrinhDo
(	
	ID int,
	MaNV int,
	ChuyenMon nvarchar(50),
	NgayCap date,
	Truong nvarchar(50),
	constraint pk_CTTrinhDo primary key (MaNV),
);
go

-- Hợp đồng
if OBJECT_ID('HopDong') is not null
	drop table HopDong;
go
create table HopDong
(	
	MaHD int not null identity,
	TenHD nvarchar(50),	
	NgayBD date,
	NgayKT date,
	LuongCB float,
	constraint pk_HopDong primary key (MaHD),
);
go

-- Bảng Lương
if OBJECT_ID('BangLuong') is not null
	drop table BangLuong;
go
create table BangLuong
(	
	MaNV int not null,
	LuongCB float,
	SoNgayTangCa int,
	LuongTangCa float,
	BaoHiem float,
	ThucLanh float,	
	constraint pk_BangLuong primary key (MaNV),
);
go

--	Người Dùng
if OBJECT_ID('NguoiDung') is not null
	drop table NguoiDung;
go
create table NguoiDung
(	
	MaNV int,
	MaPQ int not null,
	TaiKhoan nvarchar(20) not null,
	MatKhau nvarchar(20),
	constraint pk_NguoiDung primary key (MaNV),
);
go

-- Phân Quyền
if OBJECT_ID('PhanQuyen') is not null
	drop table PhanQuyen;
go
create table PhanQuyen
(	
	MaPQ int not null identity,
	TenPQ nvarchar(50) not null,
	constraint pk_PhanQuyen primary key (MaPQ),
);
go

-- Tạo khóa ngoại
-- NhanVien và PhongBan
alter table NhanVien
with nocheck add constraint fk_NhanVien_PhongBan
foreign key (PhongBan) references PhongBan(MaPB);
go

--PhongBan va ChuyenCongTac
alter table ChuyenCongTac
with nocheck add constraint fk_ChuyenCongTac_PhongBan
foreign key (MaPBMoi) references PhongBan(MaPB);
go

-- ChuyenCongTac va ChucVu
alter table ChuyenCongTac
with nocheck add constraint fk_ChuyenConggTac_ChucVu
foreign key (MaCVCu) references ChucVu(MaCV);
go

alter table ChuyenCongTac
with nocheck add constraint fk_ChuyenConggTac_ChucVu_Moi
foreign key (MaCVMoi) references ChucVu(MaCV);
go

-- NhanVien va ChucVu
alter table NhanVien
with nocheck add constraint fk_NhanVien_ChucVu
foreign key (ChucVu) references ChucVu(MaCV);
go

-- CTTrinhDo va NhanVien
alter table CTTrinhDo
with nocheck add constraint fk_CTTrinhDo_NhanVien
foreign key (MaNV) references NhanVien(MaNV);
go

-- CTTrinhDo va TrinhDo
alter table CTTrinhDo
with nocheck add constraint fk_CTTrinhDo_TrinhDo
foreign key (ID) references TrinhDo(MaTD);
go

-- NhanVien va HopDong
alter table NhanVien
with nocheck add constraint fk_NhanVien_HopDong
foreign key (HopDong) references HopDong(MaHD);
go

-- BangLuong va NhanVien
alter table BangLuong
with nocheck add constraint fk_BangLuong_NhanVien
foreign key (MaNV) references NhanVien(MaNV);
go

-- NhanVien va NguoiDung
alter table NguoiDung
with nocheck add constraint fk_NguoiDung_NhanVien
foreign key (MaNV) references NhanVien(MaNV);
go

-- NguoiDung va PhanQuyen
alter table NguoiDung
with nocheck add constraint fk_NguoiDung_PhanQuyen
foreign key (MaPQ) references PhanQuyen(MaPQ);
go
---------------------------------------------------------------------------------
-- Index
--------------------------------------------------------------------------------- 
if OBJECT_ID('NhanVien_PB_CV') is not null
drop index NhanVien_PB_CV on dbo.NhanVien
go
create nonclustered index NhanVien_PB_CV
on NhanVien (PhongBan, ChucVu) include (MaNV)
go
--
if OBJECT_ID('PB_TenPB') is not null
drop index PB_TenPB on dbo.PhongBan
go
create nonclustered index PB_TenPB
on PhongBan (TenPB) include (MaPB)
go
if OBJECT_ID('CV_TenCV') is not null
drop index CV_TenCV on dbo.ChucVu
go
create nonclustered index CV_TenCV
on ChucVu (TenCV) include (MaCV)
---------------------------------------------------------------------------------
-- Function
--------------------------------------------------------------------------------- 
-- Function chuyển từ tên phòng bang sang mã phòng
if OBJECT_ID ('TenPb_MaPb') is not null
	drop function TenPb_MaPb;
go

create function TenPb_MaPb(@TenPb nvarchar(50))
	returns int
begin
	return (select MaPB from PhongBan where TenPB = @TenPb)
end
go

-- Function chuyển từ tên chức vụ sang mã chức vụ
if OBJECT_ID ('TenCV_MaCV') is not null
	drop function TenCV_MaCV;
go

create function TenCV_MaCV(@TenCV nvarchar(50))
	returns int
begin
	return (select MaCV from ChucVu where TenCV = @TenCV)
end
go
-- Tính Lương thực lãnh
--if OBJECT_ID ('tinhLuong') is not null
--	drop function tinhLuong;
--go

--create function tinhLuong (@MaNV int)
--	returns float
--begin
--	return (select (LuongCB + SoNgayTangCa * LuongTangCa - BaoHiem) from BangLuong where MaNV = @MaNV )
--end

---- Function xóa NguoiDung
--if OBJECT_ID ('deleteNguoiDung') is not null
--	drop function deleteNguoiDung;
--go

--create function deleteNguoiDung(@MaNV int)
--returns int
--as
--begin
--declare @sql varchar(4000), @cmd varchar(4000)
--select @sql = 'delete from NguoiDung where MaNV = ' + @MaNV;
--EXEC sp_executesql; 
--	return 1;
--end
--go	
--declare @xoa int;
--set @xoa = dbo.deleteNguoiDung('7')
---------------------------------------------------------------------------------
-- Trigger
--------------------------------------------------------------------------------- 
-- Trigger để thêm Tài khoản khi thêm nhân viên
if OBJECT_ID('NhanVien_addTK') IS NOT NULL
	drop trigger NhanVien_addTK;
GO 

create trigger NhanVien_addTK 
on NhanVien
after insert 
as 
declare @MaPQ int,
		@TK nvarchar(20),
		@MK nvarchar(50),
		@MaNV int		
set @MaNV = (select top 1 MaNV from NhanVien order by MaNV desc)
set @MaPQ = (select MaPQ from PhanQuyen, NhanVien where NhanVien.MaNV= @MaNV and NhanVien.PhongBan = PhanQuyen.PhongBan and NhanVien.ChucVu = PhanQuyen.ChucVu) 
set @TK = 'NV' + convert(nvarchar(20),@MaNV)
set @MK = 1
insert into NguoiDung(MaNV, MaPQ, TaiKhoan, MatKhau) values (@MaNV,  @MaPQ, @TK, @MK)
go
-- Trigger để update phòng khi chuyển công tác nhân viên
if OBJECT_ID('ChuyenCongTac_updateNV') IS NOT NULL
	drop trigger ChuyenCongTac_updateNV;
GO 

create trigger ChuyenCongTac_updateNV
on ChuyenCongTac
after insert 
as 
begin
declare @MaCVmoi int,
		@MaPBmoi int,
		@MaNV int		
set @MaNV = (select top 1 MaNV from ChuyenCongTac order by MaChuyen desc)
set @MaPBmoi = (select MaPBMoi from ChuyenCongTac where MaNV = @MaNV) 
set @MaCVmoi = (select MaCVMoi from ChuyenCongTac where MaNV = @MaNV) 
update NhanVien
set 
	PhongBan = @MaPBmoi,
	ChucVu = @MaCVmoi
where MaNV = @MaNV
end
go

-- Trigger tự cập nhật quyền khi thay đổi chức vụ hay phòng ở bảng NhanVIen ở bảng NhanVien
if OBJECT_ID('NhanVien_updateTK') IS NOT NULL
	drop trigger NhanVien_updateTK;
go

create trigger NhanVien_updateTK 
on NhanVien
after update
as 
	declare @MaPQ int,
			@MaNV int
	select @MaNV = MaNV from inserted
	set @MaPQ = (select MaPQ from PhanQuyen, NhanVien where NhanVien.MaNV= @MaNV and NhanVien.PhongBan = PhanQuyen.PhongBan and NhanVien.ChucVu = PhanQuyen.ChucVu) 
	update NguoiDung 
	set MaPQ = @MaPQ
	where MaNV = @MaNV
go
---------------------------------------------------------------------------------
-- Store Procedure
---------------------------------------------------------------------------------
-- PhongBan
-- View
if OBJECT_ID('DanhSachPhongBan') is not null
	drop View DanhSachPhongBan;
go
create view DanhSachPhongBan
as
	select * from PhongBan;
go
-- Thêm PhongBan
if OBJECT_ID ('addPhongBan') is not null
	drop proc addPhongBan;
go
create procedure addPhongBan
  @TenPB nvarchar(50)
as 
begin 
set nocount on; 
	begin
		insert into PhongBan(TenPB)
		values(@TenPB)
	end 
end
go

-- Xóa PhongBan
if OBJECT_ID ('deletePhongBan') is not null
	drop proc deletePhongBan;
go
create procedure deletePhongBan
  @MaPB Int
as 
begin 
set nocount on; 
	begin
		delete from PhongBan where MaPB = @MaPB;
	end 
end
go

-- updating data PhongBan
if OBJECT_ID('updatePhongBan') is not null
	drop proc updatePhongBan;
go
create procedure updatePhongBan  
(  
    @MaPB int,  
    @TenPB nvarchar(50) 
)  
as  
begin  
     update PhongBan 
     set 
		TenPB = @TenPB
     where MaPB = @MaPB
end  
go
-- Lay du lieu
if OBJECT_ID('getPhongBan') is not null
	drop proc getPhongBan;
go
create procedure getPhongBan
as  
begin  
    select * from PhongBan
end  
go

---------------------------------------------------------------------------------
-- ChucVu
-- View
if OBJECT_ID('DanhSachChucVu') is not null
	drop View DanhSachChucVu;
go
create view DanhSachChucVu
as
	select * from ChucVu;
go
-- Thêm ChucVu
if OBJECT_ID ('addChucVu') is not null
	drop proc addChucVu;
go
create procedure addChucVu
  @TenCV nvarchar(50),
  @PhuCap float
as 
begin 
set nocount on; 
	begin
		insert into ChucVu(TenCV, PhuCap)
		values(@TenCV, @PhuCap)
	end 
end
go

-- Xóa ChucVu
if OBJECT_ID ('deleteChucVu') is not null
	drop proc deleteChucVu;
go
create procedure deleteChucVu
  @MaCV Int
as 
begin 
set nocount on; 
	begin
		delete from ChucVu where MaCV = @MaCV;
	end 
end
go

-- updating data ChucVu
if OBJECT_ID('updateChucVu') is not null
	drop proc updateChucVu;
go
create procedure updateChucVu 
(  
    @MaCV int,  
    @TenCV nvarchar(50),
	@PhuCap float
)  
as  
begin  
     update ChucVu
     set 
		TenCV = @TenCV, 
		PhuCap = @PhuCap
     where MaCV = @MaCV
end  
go
-- Lay du lieu
if OBJECT_ID('getChucVu') is not null
	drop proc getChucVu;
go
create procedure getChucVu
as  
begin  
    select * from ChucVu
end  
go

---------------------------------------------------------------------------------
-- ChuyenCongTac
-- Thêm ChuyenCongTac
if OBJECT_ID ('addChuyenCongTac') is not null
	drop proc addChuyenCongTac;
go
create procedure addChuyenCongTac
  @MaNV int,
  @MaCVMoi int,
  @MaPBMoi int
as 
begin 
set nocount on; 
	begin
		declare @NgayChuyen date = GETDATE(),  
				@MaCVCu int
		set @MaCVCu = (select ChucVu from NhanVien where MaNV = @MaNV) 
		insert into ChuyenCongTac(NgayChuyen, MaNV, MaCVCu, MaCVMoi, MaPBMoi)
		values(@NgayChuyen, @MaNV, @MaCVCu, @MaCVMoi, @MaPBMoi);
	end 
end
go
-- updating data ChuyenCongTac
if OBJECT_ID('updateChuyenCongTac') is not null
	drop proc updateChuyenCongTac;
go
create procedure updateChuyenCongTac
(  
  @MaChuyen int,
  @NgayChuyen date,
  @MaNV int,
  @MaCVCu int,
  @MaCVMoi int,
  @MaPBMoi int
)  
as  
begin  
     update ChuyenCongTac
     set 
		NgayChuyen = @NgayChuyen, 
		MaNV = @MaNV,
		MaCVCu = @MaCVCu,
		MaCVMoi = @MaCVMoi,
		@MaPBMoi = @MaPBMoi
     where MaChuyen = @MaChuyen
end  
go
-- Lay du lieu
if OBJECT_ID('getChuyenCongTac') is not null
	drop proc getChuyenCongTac;
go
create procedure getChuyenCongTac
as  
begin  
    select * from ChuyenCongTac
end  
go


-- NhanVien ----------------------------------------------------------------------------
-- Lấy 1 NhanVien theo MaNV
if OBJECT_ID ('lay1NhanVien') is not null
	drop proc lay1NhanVien;
go
create proc lay1NhanVien @MaNV int
as 
begin
	select MaNV, HoVaTen, CMND, GioiTinh, NgaySinh, DanToc, TonGiao, DiaChi, SDT, NgayLamTrongThang, NgayLamGanNhat, NgayGiaNhap, 
	ATM, BHYT, TenPB, TenCV, HopDong
	from NhanVien, PhongBan, ChucVu
	where MaNV = @MaNV
	and NhanVien.PhongBan = PhongBan.MaPB
	and NhanVien.ChucVu = ChucVu.MaCV
end
go
-- Them NhanVien
if OBJECT_ID ('addNhanVien') is not null
	drop proc addNhanVien;
go

create proc addNhanVien
	@HoVaTen nvarchar(50),
	@CMNV nvarchar(10),
	@GioiTinh nvarchar(5),
	@NgaySinh date,
	@DanToc nvarchar(20),
	@TonGiao nvarchar(20),
	@DiaChi nvarchar(50),
	@SDT nvarchar(20),
	--@NgayLamTrongThang int,
	--@NgayLamGanNhat date,
	--@NgayGiaNhap date,
	@ATM nvarchar(50),
	@BHYT nvarchar(50),
	--@TrangThai int,	
	@TenPhong nvarchar(50),
	@TenCV nvarchar(50),	
	--@TrinhDo int,
	@HopDong int
as 
begin
declare @ChucVu int,
		@PhongBan int,
		@NgayLamTrongThang int,
		@NgayLamGanNhat date,
		@NgayGiaNhap date
set @PhongBan = dbo.TenPb_MaPb(@TenPhong)
set	@ChucVu = dbo.TenCV_MaCV(@TenCV)
set @NgayGiaNhap = GETDATE();
set @NgayLamTrongThang = 0;
set @NgayLamGanNhat = null;
set nocount on; 
	begin
		insert into NhanVien(HoVaTen, CMND, GioiTinh, NgaySinh, DanToc, TonGiao, DiaChi, SDT, NgayLamTrongThang, NgayLamGanNhat, NgayGiaNhap, ATM, BHYT, PhongBan, ChucVu, HopDong)
		values(@HoVaTen, @CMNV, @GioiTinh, @NgaySinh, @DanToc, @TonGiao, @DiaChi, @SDT, @NgayLamTrongThang, @NgayLamGanNhat, @NgayGiaNhap, @ATM, @BHYT, @PhongBan, @ChucVu, @HopDong)
	end 
end
go

-- Sửa nhân viên
if OBJECT_ID ('updateNhanVien') is not null
	drop proc updateNhanVien;
go

create proc updateNhanVien
	@MaNV int,
	@HoVaTen nvarchar(50),
	@CMNV nvarchar(10),
	@GioiTinh nvarchar(5),
	@NgaySinh date,
	@DanToc nvarchar(20),
	@TonGiao nvarchar(20),
	@DiaChi nvarchar(50),
	@SDT nvarchar(20),
	--@NgayLamTrongThang int,
	--@NgayLamGanNhat date,
	--@NgayGiaNhap date,
	@ATM nvarchar(50),
	@BHYT nvarchar(50),
	--@TrangThai int,	
	@TenPhong nvarchar(50),
	@TenCV nvarchar(50),	
	--@TrinhDo int,
	@HopDong int
as 
begin
declare @ChucVu int,
		@PhongBan int
set @PhongBan = dbo.TenPb_MaPb(@TenPhong)
set	@ChucVu = dbo.TenCV_MaCV(@TenCV)
	begin
		update NhanVien
		set 
			HoVaTen = @HoVaTen,
			CMND = @CMNV,
			GioiTinh =  @GioiTinh,
			NgaySinh = @NgaySinh,
			DanToc = @DanToc,
			TonGiao = @TonGiao,
			DiaChi = @DiaChi,
			SDT = @SDT,
			ATM = @ATM,
			BHYT = @BHYT,
			PhongBan = @PhongBan,
			ChucVu = @ChucVu,
			HopDong = @HopDong
		where MaNV = @MaNV
	end
end
go
--Dynamic Search NhanVien
if object_id(N'searchNhanVien', N'P') is not null
	drop proc searchNhanVien
go
create proc searchNhanVien
	@MaNV as int = null,
	@HoVaTen as nvarchar(50) = null,
	@CMND as nvarchar(20)= null,
	@GioiTinh as nvarchar(5) = null,
	@NgaySinh as date = null,
	@DanToc as nvarchar(20) = null,
	@TonGiao as nvarchar(20) = null,
	@DiaChi as nvarchar(50) = null,
	@SDT as nvarchar(20) = null,
	@NgayLamTrongThang as int = null,
	@NgayLamGanNhat as date = null,
	@NgayGiaNhap as date = null,
	@ATM as nvarchar(20) = null,
	@BHYT as nvarchar(50) = null,
	@TenPhong as nvarchar(20) = null,
	@TenCv as nvarchar(20) = null,
	@HopDong as int = null
as
--declare @PhongBan int, @ChucVu int
--set @PhongBan = dbo.TenPb_MaPb(@TenPhong)
--set	@ChucVu = dbo.TenCV_MaCV(@TenCV) 
declare @sql as nvarchar(1000);
SET @sql =
	N'SELECT MaNV, HoVaTen, CMND, GioiTinh, NgaySinh, DanToc, TonGiao, DiaChi, SDT, NgayLamTrongThang, NgayLamGanNhat, NgayGiaNhap, 
	ATM, BHYT, TenPB, TenCV, HopDong'
	+ N' FROM NhanVien, PhongBan, ChucVu'
	+ N' WHERE 1 = 1 and NhanVien.PhongBan = PhongBan.MaPB and NhanVien.ChucVu = ChucVu.MaCV'
+ CASE WHEN @MaNV IS NOT NULL THEN
	N' AND MaNV = @mnv' ELSE N'' END
+ CASE WHEN @HoVaTen IS NOT NULL THEN
	N' AND HoVaTen like ''%''+@hoten+ ''%''' ELSE N'' END
+ CASE WHEN @CMND IS NOT NULL THEN
	N' AND CMND like ''%''+@cmt+ ''%''' ELSE N'' END
+ CASE WHEN @GioiTinh IS NOT NULL THEN
	N' AND GioiTinh like ''%''+@gt+ ''%''' ELSE N'' END
+ CASE WHEN @NgaySinh IS NOT NULL THEN
	N' AND NgaySinh like ''%''+@ns+ ''%''' ELSE N'' END
+ CASE WHEN @DanToc IS NOT NULL THEN
	N' AND DanToc like ''%''+@dt+ ''%''' ELSE N'' END
+ CASE WHEN @TonGiao IS NOT NULL THEN
	N' AND TonGia like ''%''+@tg+ ''%''' ELSE N'' END
+ CASE WHEN @DiaChi IS NOT NULL THEN
	N' AND DiaChi like ''%''+@dc+ ''%''' ELSE N'' END
+ CASE WHEN @SDT IS NOT NULL THEN
	N' AND SDT like ''%''+@pn+ ''%''' ELSE N'' END
+ CASE WHEN @NgayLamTrongThang IS NOT NULL THEN
	N' AND NgayLamTrongThang = @ngtt' ELSE N'' END
+ CASE WHEN @NgayLamGanNhat IS NOT NULL THEN
	N' AND NgayLamGanNhat like ''%''+@nggn+ ''%''' ELSE N'' END
+ CASE WHEN @NgayGiaNhap IS NOT NULL THEN
	N' AND NgayGiaNhap like ''%''+@nggnh+ ''%''' ELSE N'' END
+ CASE WHEN @ATM IS NOT NULL THEN
	N' AND ATM like ''%''+@at+ ''%''' ELSE N'' END
+ CASE WHEN @BHYT IS NOT NULL THEN
	N' AND BHYT like ''%''+@bh+ ''%''' ELSE N'' END
+ CASE WHEN @TenPhong IS NOT NULL THEN
	N' AND TenPB like ''%''+@tenp+ ''%''' ELSE N'' END
+ CASE WHEN @TenCv IS NOT NULL THEN
	N' AND TenCV like ''%''+@tenc+ ''%''' ELSE N'' END
+ CASE WHEN @HopDong IS NOT NULL THEN
	N' AND HopDong = @hd' ELSE N'' END;

EXEC sp_executesql 
	@stmt = @sql,
	@params = N'@mnv as int, @hoten as nvarchar(50), @cmt as nvarchar(20), @gt as nvarchar(5), @ns as date, 
	@dt as nvarchar(20), @tg as nvarchar(20), @dc as nvarchar(50), @pn as nvarchar(20), @ngtt as int, 
	@nggn as date, @nggnh as date, @at as nvarchar(50), @bh as nvarchar(50), @tenp as nvarchar(20), @tenc as nvarchar(20), @hd as int',
	@mnv = @MaNV,
	@hoten = @HoVaTen,
	@cmt = @CMND,
	@gt = @GioiTinh,
	@ns = @NgaySinh,
	@dt = @DanToc,
	@tg = @TonGiao,
	@dc = @DiaChi,
	@pn = @SDT,
	@ngtt = @NgayLamTrongThang,
	@nggn = @NgayLamGanNhat,
	@nggnh = @NgayGiaNhap,
	@at = @ATM,
	@bh = @BHYT,
	@tenp = @TenPhong,
	@tenc = @TenCV,
	@hd = @HopDong;
GO

-- Xóa NhanVien
if OBJECT_ID('deleteNhanVien') is not null
	drop proc deleteNhanVien;
go

create proc deleteNhanVien
	@MaNV int
as
begin try
	begin tran;
		delete from NguoiDung where MaNV = @MaNV;
		delete from BangLuong where MaNV = @MaNV;
		delete from CTTrinhDo where MaNV = @MaNV;
		delete from ChuyenCongTac where MaNV = @MaNV;
		delete from NhanVien where MaNV = @MaNV;
	commit tran; -- commit, thực hiện các lệnh bên trên
	print 'transaction committed';
end try
begin catch
	print 'error when deleting, rolling back transaction';
	rollback tran; -- nếu bị lỗi thì rollback
end catch;
go
-- Lấy NhanVien
if OBJECT_ID('getNhanVien') is not null
	drop proc getNhanVien;
go
create proc getNhanVien
as
begin
	select MaNV, HoVaTen, CMND, GioiTinh, NgaySinh, DanToc, TonGiao, DiaChi, SDT, NgayLamTrongThang, NgayLamGanNhat, NgayGiaNhap, ATM, BHYT, TenPB, TenCV, HopDong
	from NhanVien, PhongBan, ChucVu
	where NhanVien.PhongBan = PhongBan.MaPB
	and NhanVien.ChucVu = ChucVu.MaCV
end
go
-- Chấm công
if OBJECT_ID('ChamCong') is not null
	drop proc ChamCong;
go
create proc ChamCong
	@MaNV int
as
begin
	declare @NgayHienTai date = GETDATE(),
			@NgayLamTruocDo date,
			@NgayLamTrongThang int
	set @NgayLamTruocDo = (select NgayLamGanNhat from NhanVien where MaNV = @MaNV)
	set @NgayLamTrongThang = (select NgayLamTrongThang from NhanVien where MaNV = @MaNV)
	if @NgayHienTai > @NgayLamTruocDo or @NgayLamTruocDo is null 
		update NhanVien 
		set
			NgayLamTrongThang = @NgayLamTrongThang + 1,
			NgayLamGanNhat = @NgayHienTai
		where MaNV = @MaNV
	else throw 50001, 'Hôm nay đã chấm công rồi.', 1;
end
go
-- Đăng nhập
if OBJECT_ID ('DangNhap') is not null
	drop proc DangNhap;
go

create proc DangNhap 	
	@tk nvarchar(20),
	@mk nvarchar(20)
as 
begin
	select MaNV, MaPQ from NguoiDung where TaiKhoan = @tk and MatKhau = @mk
end
go
-- Đổi mật khẩu
if OBJECT_ID ('DoiMk') is not null
	drop proc DoiMk;
go

create proc DoiMk
	@MaNV int,
	@mkcu nvarchar(20),
	@mkmoi nvarchar(20)
as 
begin
	if @mkcu like (select MatKhau from NguoiDung where MaNV = @MaNV)		
	update NguoiDung
	set MatKhau = @mkmoi
	where MaNV = @MaNV	
	else throw 50001, 'Mat khau cu khong chinh xac.', 1;
end
go

-- BangLuong
-- View
if OBJECT_ID('DanhSachLuong') is not null
	drop View DanhSachLuong;
go
create view DanhSachLuong
as
	select * from BangLuong;
go
-- Thêm Bảng Lương
if OBJECT_ID ('addBangLuong') is not null
	drop proc addBangLuong;
go
create procedure addBangLuong
  @MaNV int,
  @LuongCB float,
  @SoNgayTangCa int,
  @LuongTangCa float,
  @BaoHiem float
as 
begin 
set nocount on; 	
	begin
		declare @ThucLanh float;
		set @ThucLanh = (@LuongCB + @LuongTangCa * @SoNgayTangCa - @BaoHiem)
		insert into BangLuong(MaNV, LuongCB,SoNgayTangCa,LuongTangCa,BaoHiem,ThucLanh)
		values(@MaNV, @LuongCB,@SoNgayTangCa,@LuongTangCa,@BaoHiem,@ThucLanh)
	end 
end
go
exec addBangLuong  26, 50000, 2, 5000, 10000
select * from BangLuong
-- Xóa BangLuong
if OBJECT_ID ('deleteBangLuong') is not null
	drop proc deleteBangLuong;
go
create procedure deleteBangLuong
  @MaNV Int
as 
begin 
set nocount on; 
	begin
		delete from BangLuong where MaNV = @MaNV;
	end 
end
go

-- updating data BangLuong
if OBJECT_ID('updateBangLuong') is not null
	drop proc updateBangLuong;
go
create procedure updateBangLuong  
(  
    @MaNV int,  
    @LuongCB float,
	@SoNgayTangCa int ,
	@LuongTangCa float,
	@BaoHiem float,
	@ThucLanh float
)  
as  
begin  
     update BangLuong
     set 
		LuongCB=@LuongCB,
		SoNgayTangCa=@SoNgayTangCa,
		LuongTangCa=@LuongTangCa,
		BaoHiem=@BaoHiem,
		ThucLanh=@ThucLanh
     where MaNV = @MaNV
end  
go

-- Lay du lieu BangLuong
if OBJECT_ID('getBangLuong') is not null
	drop proc getBangLuong;
go
create procedure getBangLuong
as  
begin  
    select * from BangLuong
end  
go
-- HopDong
-- View
if OBJECT_ID('DanhSachHopDong') is not null
	drop View DanhSachHopDong;
go
create view DanhSachHopDong
as
	select * from HopDong;
go
-- Them Hop Dong

if OBJECT_ID ('addHopDong') is not null
drop proc addHopDong;
go 
create procedure addHopDong
@TenHD nvarchar(50),
@NgayBD date ,
@NgayKT date,
@LuongCB float
as
set nocount on
begin
	begin
	 insert into HopDong(TenHD,NgayBD,NgayKT,LuongCB)
	 values (@TenHD,@NgayBD,@NgayKT,@LuongCB)
	end
end

go
--Xóa HopDong
 if OBJECT_ID('deleteHopDong') is not null
 drop proc deleteHopDong;
 go

 create procedure deleteHopDong
 @MaHD int
 as
 begin
	delete from HopDong where MaHD=@MaHD
 end
 go
 -- Update HopDong
 if OBJECT_ID('updateHopDong') is not null
 drop proc updateHopDong

 go

 create procedure updateHopDong
 @MaHD int,
 @TenHD nvarchar(50),
 @NgayBD date,
 @NgayKT date,
 @LuongCB float

 as
 begin
	 update HopDong
	 set
	 TenHD=@TenHD,
	 NgayBD=@NgayBD,
	 NgayKT=@NgayKT,
	 LuongCB=@LuongCB
	 where MaHD=@MaHD
 end

 go
 -- Lay Hop dong
 if OBJECT_ID('getHopDong') is not null
  drop proc getHopDong
  go

  create procedure getHopDong

  as
  begin
  select * from HopDong
  end
go

-- TrinhDo
-- View
if OBJECT_ID('DanhSachTrinhDo') is not null
	drop View DanhSachTrinhDo;
go
create view DanhSachTrinhDo
as
	select * from TrinhDo;
go
-- Them Trinh Do
if OBJECT_ID('addTrinhDo') is not null
drop proc addTrinhDo
go

create procedure addTrinhDo
@TenTD nvarchar (50)

as 
begin
set nocount on
	begin
		insert into TrinhDo(TenTD)
		values(@TenTD)
	end
end

go
-- Delete TrinhDo
if OBJECT_ID('deleteTrinhDo') is not null
drop proc deleteTrinhDo
go

create procedure deleteTrinhDo
@MaTD int
as
begin
	delete from TrinhDo where MaTD=@MaTD
end
go

--Update trinh do

if OBJECT_ID('updateTrinhDo') is not null
drop proc updateTrinhDo
go
create procedure updateTrinhDo
@MaTD int,
@TenTD nvarchar (50)
as
begin
	update TrinhDo
	set
	TenTD=@TenTD
	where MaTD=@MaTD
end

-- Lay Trinh Do
if OBJECT_ID('getTrinhDo') is not null
drop proc getTrinhDo

go

create procedure getTrinhDo
as
begin
select * from TrinhDo
end
go

-- Chi Tiet Trinh Do
-- View
if OBJECT_ID('DanhSachCTTinhDo') is not null
	drop View DanhSachPhongBan;
go
create view DanhSachCTTrinhDo
as
	select * from CTTrinhDo;
go

--Them CTTrinhDo

if OBJECT_ID('addCTTrinhDo') is not null
drop proc addCTTrinhDo

go
create procedure addCTTrinhDo

@MaNV int,
@ChuyenMon nvarchar(50),
@NgayCap date,
@Truong nvarchar(50)

as
begin
set nocount on 
	begin
	insert into CTTrinhDo (MaNV,ChuyenMon,NgayCap,Truong)
	values (@MaNV,@ChuyenMon,@NgayCap,@Truong)
	end
end

--Delete Chi tiet Trinh Do

if OBJECT_ID('deleteCTTrinhDo') is not null
drop proc deleteCTTrinhDo

go
create procedure deleteCTTrinhDo
@ID int
as
begin 
delete from CTTrinhDo where ID=@ID
end

go

--Update Trinh Do

if OBJECT_ID('updateCTTinhDo') is not null
drop proc updateCTTrinhDo

go

create procedure updateCTTrinhDo
@ID int,
@MaNV  int,
@ChuyenMon nvarchar(50),
@NgayCap date,
@Truong nvarchar (50)

as
 begin
	 update CTTrinhDo
	 set 
	 MaNV=@MaNV,
	 ChuyenMon=@ChuyenMon,
	 NgayCap=@NgayCap,
	 Truong=@Truong
 end
 go

 -- Lay CTTrinhDo

 if OBJECT_ID('getCTTrinhDo') is not null
 drop proc getCTTinhDo

 go
 create procedure getCTTrinhDo
 as
 begin
 select * from CTTrinhDo
 end
 go 



-- Test
exec DoiMk 7, '2', '3'
select * from NguoiDung
declare @status1 int =0;
--set @status1 = (select count(*) from NguoiDung where TaiKhoan = 'NV7' and MatKhau = '1')
exec DangNhap 'NV7', '1'
print @status1
go 
exec deleteNhanVien 23
select * from NguoiDung
go
select * from NhanVien
exec addPhongBan 'Kĩ Thuật';
exec addChucVu 'Admin', 132446;
exec addNhanVien 'B', '221472782', 'nam', '1-1-1999', 'Kinh', 'Khong', 'c5', '012345679', '01243941164654', '225+44164', 'Nhan Su', 'Truong', 1
exec updateNhanVien 24, 'A', '221472782', 'nam', '1-1-1999', 'Kinh', 'Khong', 'c5', '012345679', '01243941164654', '225+44164', 'Ke Hoach', 'Truong', 1
select * from NhanVien
go
select * from PhongBan
go
select * from NguoiDung
delete from PhongBan where MaPB = 1
exec searchNhanVien 'Kinh'