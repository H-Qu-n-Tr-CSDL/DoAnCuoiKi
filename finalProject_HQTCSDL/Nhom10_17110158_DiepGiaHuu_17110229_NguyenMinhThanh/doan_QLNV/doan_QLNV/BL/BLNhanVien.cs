using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace doan_QLNV.BL
{
    public class BLNhanVien
    {
        QLNVDataContext context = new QLNVDataContext();
        public int MaNV, NgayLamTrongThang, HopDong;
        public string TenNV, CMND, GioiTinh, DanToc, TonGiao, DiaChi, SDT, ATM, BHYT, PhongBan, ChucVu;
        public DateTime NgayLamGanNhat, NgayGiaNhap, NgaySinh;
        public DataTable layNhanVien()
        {
            var layNV = context.getNhanVien();
            DataTable dtNV = new DataTable();
            dtNV.Columns.Add("Mã NV");
            dtNV.Columns.Add("Họ Và Tên");
            dtNV.Columns.Add("CMND");
            dtNV.Columns.Add("Giới Tính");
            dtNV.Columns.Add("Ngày Sinh");
            dtNV.Columns.Add("Dân Tộc");
            dtNV.Columns.Add("Tôn Giáo");
            dtNV.Columns.Add("Địa Chỉ");
            dtNV.Columns.Add("SĐT");
            dtNV.Columns.Add("Ngày Làm Trong Tháng");
            dtNV.Columns.Add("Ngày Làm Gần Nhất");
            dtNV.Columns.Add("Ngày Gia Nhập");
            dtNV.Columns.Add("ATM");
            dtNV.Columns.Add("BHYT");
            dtNV.Columns.Add("Phòng Ban");
            dtNV.Columns.Add("Chức Vụ");
            dtNV.Columns.Add("Họp Đồng");
            foreach (var r in layNV)
            {
                dtNV.Rows.Add(r.MaNV, r.HoVaTen, r.CMND, r.GioiTinh, r.NgaySinh, r.DanToc, r.TonGiao, r.DiaChi, r.SDT, r.NgayLamTrongThang, r.NgayLamGanNhat, r.NgayGiaNhap, r.ATM, r.BHYT, r.TenPB, r.TenCV, r.HopDong);
            }
            return dtNV;
        }
        public bool themNV(string hoten, string CMND, string gioi, DateTime ngaysinh, string dantoc, string tongiao, string diachi, string sdt, string atm, string bhyt, string tenpb, string tencv, int hd)
        {
            var themPB = context.addNhanVien(hoten, CMND, gioi, ngaysinh, dantoc, tongiao, diachi, sdt, atm, bhyt, tenpb, tencv, hd);
            return true;
        }
        public bool suaNV(int manv, string hoten, string CMND, string gioi, DateTime ngaysinh, string dantoc, string tongiao, string diachi, string sdt, string atm, string bhyt, string tenpb, string tencv, int hd)
        {
            var suaNV = context.updateNhanVien(manv, hoten, CMND, gioi, ngaysinh, dantoc, tongiao, diachi, sdt, atm, bhyt, tenpb, tencv, hd);
            return true;
        }
        public bool xoaNV(int manv)
        {
            var xoaNV = context.deleteNhanVien(manv);
            return true;
        }
        public DataTable layHoSo(int mnv)
        {
            var layHS = context.lay1NhanVien(mnv);
            DataTable dtHS = new DataTable();
            dtHS.Columns.Add("Mã NV");
            dtHS.Columns.Add("Họ Và Tên");
            dtHS.Columns.Add("CMND");
            dtHS.Columns.Add("Giới Tính");
            dtHS.Columns.Add("Ngày Sinh");
            dtHS.Columns.Add("Dân Tộc");
            dtHS.Columns.Add("Tôn Giáo");
            dtHS.Columns.Add("Địa Chỉ");
            dtHS.Columns.Add("SĐT");
            dtHS.Columns.Add("Ngày Làm Trong Tháng");
            dtHS.Columns.Add("Ngày Làm Gần Nhất");
            dtHS.Columns.Add("Ngày Gia Nhập");
            dtHS.Columns.Add("ATM");
            dtHS.Columns.Add("BHYT");
            dtHS.Columns.Add("Phòng Ban");
            dtHS.Columns.Add("Chức Vụ");
            dtHS.Columns.Add("Họp Đồng");
            foreach (var r in layHS)
            {
                dtHS.Rows.Add(r.MaNV, r.HoVaTen, r.CMND, r.GioiTinh, r.NgaySinh, r.DanToc, r.TonGiao, r.DiaChi, r.SDT, r.NgayLamTrongThang, r.NgayLamGanNhat, r.NgayGiaNhap, r.ATM, r.BHYT, r.TenPB, r.TenCV, r.HopDong);
                MaNV = r.MaNV;
                TenNV = r.HoVaTen;
                CMND = r.CMND;
                GioiTinh = r.GioiTinh;
                NgaySinh = Convert.ToDateTime(r.NgaySinh);
                DanToc = r.DanToc;
                TonGiao = r.TonGiao;
                DiaChi = r.DiaChi;
                SDT = r.SDT;
                NgayLamTrongThang = Convert.ToInt32(r.NgayLamTrongThang);
                NgayLamGanNhat = Convert.ToDateTime(r.NgayLamGanNhat);
                NgayGiaNhap = Convert.ToDateTime(r.NgayGiaNhap);
                ATM = r.ATM;
                BHYT = r.BHYT;
                PhongBan = r.TenPB;
                ChucVu = r.TenCV;
                HopDong = Convert.ToInt32(r.HopDong);
            }
            return dtHS;
        }
        public bool chamcong(int manv)
        {
            var chamcong = context.ChamCong(manv);
            return true;
        }

    }
}
