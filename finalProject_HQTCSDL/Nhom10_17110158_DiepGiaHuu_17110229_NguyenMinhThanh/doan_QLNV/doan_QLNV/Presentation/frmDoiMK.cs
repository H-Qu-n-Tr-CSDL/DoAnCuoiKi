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
    public partial class frmDoiMK : Form
    {
        doan_QLNV.BL.BLNguoiDung dn = new BL.BLNguoiDung();
        public frmDoiMK()
        {
            InitializeComponent();
        }
        public int mnv;
        private void btnXacNhan_Click(object sender, EventArgs e)
        {
            try
            {
                if (txtmkmoi.Text == txtmkxn.Text)
                {
                    dn.doiMK(mnv, txtmkcu.Text, txtmkmoi.Text);
                    MessageBox.Show("Đổi mật khẩu thành công!", "THỐNG BÁO:");
                }
                else
                {
                    MessageBox.Show("Mật khẩu xác nhận lại không trùng khớp!", "THÔNG BÁO:");
                    txtmkmoi.Clear();
                    txtmkxn.Clear();
                    txtmkmoi.Focus();
                }
            }
            catch
            {
                MessageBox.Show("Đổi mật khẩu không thành công!", "THÔNG BÁO");
            }
        }
    }
}
