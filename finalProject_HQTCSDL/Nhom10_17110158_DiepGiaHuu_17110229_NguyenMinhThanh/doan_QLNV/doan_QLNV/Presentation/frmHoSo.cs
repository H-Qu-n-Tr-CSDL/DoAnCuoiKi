using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using doan_QLNV.BL;
using doan_QLNV.Presentation;

namespace doan_QLNV.Presentation
{
    public partial class frmHoSo : Form
    {
        bool sua;
        DataTable hs = new DataTable();
        doan_QLNV.BL.BLNhanVien nv = new BL.BLNhanVien();
        public frmHoSo()
        {
            InitializeComponent();
        }
        public int mnv;
        void LoadData()
        {
            panel1.Enabled = false;
            hs = nv.layHoSo(mnv);
            txtMaNV.Text = Convert.ToString(nv.MaNV);
            txtTenNV.Text = nv.TenNV;
            txtCMND.Text = nv.CMND;
            txtGioiTinh.Text = nv.GioiTinh;
            txtDiaChi.Text = nv.DiaChi;
            txtDanToc.Text = nv.DanToc;
            txtTonGiao.Text = nv.TonGiao;
            txtSoNgay.Text = Convert.ToString(nv.NgayLamTrongThang);
            txtNgaySinh.Text = Convert.ToString(nv.NgaySinh);
            txtSDT.Text = nv.SDT;
            txtNgayGiaNhap.Text = Convert.ToString(nv.NgayGiaNhap);
            txtNgayGan.Text = Convert.ToString(nv.NgayLamGanNhat);
            txtATM.Text = nv.ATM;
            txtBHYT.Text = nv.BHYT;
            txtChucVu.Text = nv.ChucVu;
            txtTenPhong.Text = nv.PhongBan;
            txtHopDong.Text = Convert.ToString(nv.HopDong);
            
        }

        private void frmHoSo_Load(object sender, EventArgs e)
        {
            LoadData();
        }

        private void btnChamCong_Click(object sender, EventArgs e)
        {
            try
            {
                nv.chamcong(mnv);
            }
            catch
            {
                MessageBox.Show("Hôm nay đã chấm công rồi!", "THÔNG BÁO:");
            }
            LoadData();
        }

        private void btnSua_Click(object sender, EventArgs e)
        {
            sua = true;
            panel1.Enabled = true;
            txtTenPhong.Enabled = false;
            txtMaNV.Enabled = false;
            txtSoNgay.Enabled = false;
            txtNgayGan.Enabled = false;
            btnLuu.Enabled = true;
            btnHuy.Enabled = true;
        }

        private void btnLuu_Click(object sender, EventArgs e)
        {
            //Lưu
            if (sua == true)
            {
                nv.suaNV(Convert.ToInt32(txtMaNV.Text), txtTenNV.Text, txtCMND.Text, txtGioiTinh.Text, Convert.ToDateTime(txtNgaySinh.Text), txtDanToc.Text, txtTonGiao.Text, txtDiaChi.Text, txtSDT.Text, txtATM.Text, txtBHYT.Text, txtTenPhong.Text, txtChucVu.Text, Convert.ToInt32(txtHopDong.Text));
                MessageBox.Show("Cập Nhật thành công!");
                LoadData();
            }
        }

        private void btnHuy_Click(object sender, EventArgs e)
        {
            LoadData();
        }
    }
}
