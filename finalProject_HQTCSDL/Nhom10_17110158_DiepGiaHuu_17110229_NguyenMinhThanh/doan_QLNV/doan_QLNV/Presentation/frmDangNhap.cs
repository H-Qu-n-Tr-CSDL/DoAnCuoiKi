using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace doan_QLNV.Presentation
{
    public partial class frmDangNhap : Form
    {
        doan_QLNV.BL.BLNguoiDung dn = new BL.BLNguoiDung();
        public int dangnhap = 0;
        public int mnv, mpq;
        public frmDangNhap()
        {
            InitializeComponent();
        }

        private void btnXacNhan_Click(object sender, EventArgs e)
        {
            dangnhap = dn.DangNhap(txtMaNV.Text, txtPass.Text);
            if (dangnhap == 1)
            {
                mnv = dn.MaNV;
                mpq = dn.MaPQ;
                MessageBox.Show("Đăng nhập thành công!", "THÔNG BÁO:");
                this.Close();
            }
            else
            {
                MessageBox.Show("Tài khoản hoặc mật khẩu không chính xác!", "THÔNG BÁO:");
                txtPass.Clear();
                txtPass.Focus();
            }
        }
    }
}
