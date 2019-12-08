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
    public partial class frmMain : Form
    {
        int tinhtrangDN = 0;
        public int MaNV;
        public int MaPQ;
        public frmMain()
        {
            InitializeComponent();
        }

        private void lDN_Click(object sender, EventArgs e)
        {
            if (tinhtrangDN == 0)
            {
                frmDangNhap fdn = new frmDangNhap();
                fdn.ShowDialog();
                MaNV = fdn.mnv;
                MaPQ = fdn.mpq;
                tinhtrangDN = fdn.dangnhap;
                MessageBox.Show("Chào mừng nhân viên " + MaNV + ", Mã quyền: " + MaPQ, "THÔNG BÁO:");
                lDN.ForeColor = Color.Red;
                lDN.Text = "Đăng Xuất";
            }
            else
            {
                // Khai báo biến traloi
                DialogResult traloi;
                // Hiện hộp thoại hỏi đáp
                traloi = MessageBox.Show("Bạn muốn đăng xuất?", "Trả lời",
                MessageBoxButtons.OKCancel, MessageBoxIcon.Question);
                // Kiểm tra có nhắp chọn nút Ok không?
                if (traloi == DialogResult.OK)
                {
                    tinhtrangDN = 0;
                    MaPQ = 0;
                    lDN.ForeColor = Color.Blue;
                    lDN.Text = "Đăng Nhập";
                }
            }
        }

        private void btnPhongBan_Click(object sender, EventArgs e)
        {
            if (tinhtrangDN == 1 && MaPQ == 1 || MaPQ == 10 || MaPQ == 11 || MaPQ == 12)
            {
                Form1 fpb = new Form1();
                fpb.mpq = MaPQ;
                fpb.ShowDialog();
            }
            else MessageBox.Show("Bạn chưa đăng nhập hoặc không đủ quyền để truy cập mục này!", "THÔNG BÁO:");
        }

        private void btnNhanVien_Click(object sender, EventArgs e)
        {
            if (tinhtrangDN == 1 && MaPQ == 1 || MaPQ == 2 || MaPQ == 3 || MaPQ == 4 || MaPQ == 5)
            {
                frmNhanVien fnv = new frmNhanVien();
                //fnv. = MaPQ;
                fnv.ShowDialog();
            }
            else MessageBox.Show("Bạn chưa đăng nhập hoặc không đủ quyền để truy cập mục này!", "THÔNG BÁO:");
        }

        private void btnHoSo_Click(object sender, EventArgs e)
        {
            if (tinhtrangDN == 1 )
            {
                frmHoSo fhs = new frmHoSo();
                fhs.mnv = this.MaNV;
                fhs.ShowDialog();
            }
            else MessageBox.Show("Bạn chưa đăng nhập!", "THÔNG BÁO:");
        }

        private void btnDoiMK_Click(object sender, EventArgs e)
        {
            if (tinhtrangDN == 1)
            {
                frmDoiMK fdmk = new frmDoiMK();
                fdmk.mnv = this.MaNV;
                fdmk.ShowDialog();
            }
            else MessageBox.Show("Bạn chưa đăng nhập!", "THÔNG BÁO:");
        }

        private void btnChucVu_Click(object sender, EventArgs e)
        {
            if (tinhtrangDN == 1 && MaPQ == 1 || MaPQ == 10 || MaPQ == 11 || MaPQ == 12)
            {
                frmChucVu fcv = new frmChucVu();
                fcv.mpq = MaPQ;
                fcv.ShowDialog();
            }
            else MessageBox.Show("Bạn chưa đăng nhập hoặc không đủ quyền để truy cập mục này!", "THÔNG BÁO:");
        }

        private void btnLuong_Click(object sender, EventArgs e)
        {
            if (tinhtrangDN == 1 && MaPQ == 1 || MaPQ == 6 || MaPQ == 7 || MaPQ == 8 || MaPQ == 9)
            {
                frmBangLuong fbl = new frmBangLuong();
                fbl.ShowDialog();
            }
            else MessageBox.Show("Bạn chưa đăng nhập hoặc không đủ quyền để truy cập mục này!", "THÔNG BÁO:");
        }

        private void btnChuyenCongTac_Click(object sender, EventArgs e)
        {
            if (tinhtrangDN == 1 && MaPQ == 1 || MaPQ == 10 || MaPQ == 11 || MaPQ == 12)
            {
                frmChuyenCongTac fctt = new frmChuyenCongTac();
                fctt.ShowDialog();
            }
            else MessageBox.Show("Bạn chưa đăng nhập hoặc không đủ quyền để truy cập mục này!", "THÔNG BÁO:");
        }

        private void btnCTTrinhDo_Click(object sender, EventArgs e)
        {
            if (tinhtrangDN == 1 && MaPQ == 1 || MaPQ == 2 || MaPQ == 3 || MaPQ == 4 || MaPQ == 5)
            {
                frmTrinhDo ftd = new frmTrinhDo();
                //fnv. = MaPQ;
                ftd.ShowDialog();
            }
            else MessageBox.Show("Bạn chưa đăng nhập hoặc không đủ quyền để truy cập mục này!", "THÔNG BÁO:");
        }
    }
}
