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
    public partial class frmNhanVien : Form
    {
        doan_QLNV.BL.BLNhanVien nv = new BL.BLNhanVien();
        bool Them;
        public frmNhanVien()
        {
            InitializeComponent();
            LoadData();
        }
        void LoadData()
        {
            // Thay đổi độ rộng cột
            dgv.AutoResizeColumns();
            // Xóa trống các đối tượng trong Panel
            this.txtMaNV.ResetText();
            this.txtTenNV.ResetText();
            this.txtCMND.ResetText();
            this.txtGioiTinh.ResetText();
            this.txtNgaySinh.ResetText();
            this.txtDanToc.ResetText();
            this.txtTonGiao.ResetText();
            this.txtDiaChi.ResetText();
            this.txtSDT.ResetText();
            this.txtATM.ResetText();
            this.txtBHYT.ResetText();
            this.txtPhong.ResetText();
            this.txtChucVu.ResetText();
            this.txtHopDong.ResetText();
            // Không cho thao tác trên các nút Lưu / Hủy
            this.btnLuu.Enabled = false;
            this.btnHuy.Enabled = false;
            this.panel1.Enabled = false;
            // Cho thao tác trên các nút Thêm / Sửa / Xóa /Thoát
            this.btnThem.Enabled = true;
            this.btnSua.Enabled = true;
            this.btnXoa.Enabled = true;
            dgv.DataSource = nv.layNhanVien();

        }

        private void dgv_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            int r = dgv.CurrentCell.RowIndex;
            this.txtMaNV.Text = dgv.Rows[r].Cells[0].Value.ToString();
            this.txtTenNV.Text = dgv.Rows[r].Cells[1].Value.ToString();
            this.txtCMND.Text = dgv.Rows[r].Cells[2].Value.ToString();
            this.txtGioiTinh.Text = dgv.Rows[r].Cells[3].Value.ToString();
            this.txtNgaySinh.Text = dgv.Rows[r].Cells[4].Value.ToString();
            this.txtDanToc.Text = dgv.Rows[r].Cells[5].Value.ToString();
            this.txtTonGiao.Text = dgv.Rows[r].Cells[6].Value.ToString();
            this.txtDiaChi.Text = dgv.Rows[r].Cells[7].Value.ToString();
            this.txtSDT.Text = dgv.Rows[r].Cells[8].Value.ToString();
            this.txtATM.Text = dgv.Rows[r].Cells[12].Value.ToString();
            this.txtBHYT.Text = dgv.Rows[r].Cells[13].Value.ToString();
            this.txtPhong.Text = dgv.Rows[r].Cells[14].Value.ToString();
            this.txtChucVu.Text = dgv.Rows[r].Cells[15].Value.ToString();
            this.txtHopDong.Text = dgv.Rows[r].Cells[16].Value.ToString();
        }

        private void btnThem_Click(object sender, EventArgs e)
        {
            Them = true;
            this.panel1.Enabled = true;
            this.txtMaNV.ResetText();
            this.txtMaNV.Enabled = false;
            this.txtTenNV.ResetText();
            this.txtCMND.ResetText();
            this.txtGioiTinh.ResetText();
            this.txtNgaySinh.ResetText();
            this.txtDanToc.ResetText();
            this.txtTonGiao.ResetText();
            this.txtDiaChi.ResetText();
            this.txtSDT.ResetText();
            this.txtATM.ResetText();
            this.txtBHYT.ResetText();
            this.txtPhong.ResetText();
            this.txtChucVu.ResetText();
            this.txtHopDong.ResetText();
            this.btnHuy.Enabled = true;
            this.btnLuu.Enabled = true;
            this.btnThem.Enabled = false;
            this.btnSua.Enabled = false;
            this.btnXoa.Enabled = false;
            this.txtTenNV.Focus();
        }

        private void btnHuy_Click(object sender, EventArgs e)
        {
            LoadData();
        }

        private void btnSua_Click(object sender, EventArgs e)
        {
            // Kích hoạt biến Sửa
            Them = false;
            // Cho phép thao tác trên Panel
            this.panel1.Enabled = true;
            dgv_CellClick(null, null);
            // Cho thao tác trên các nút Lưu / Hủy / Panel
            this.btnLuu.Enabled = true;
            this.btnHuy.Enabled = true;
            this.panel1.Enabled = true;
            // Không cho thao tác trên các nút Thêm / Xóa / Thoát
            this.btnThem.Enabled = false;
            this.btnSua.Enabled = false;
            this.btnXoa.Enabled = false;
            //this.btnTroVe.Enabled = false;
            // Đưa con trỏ đến TextField txtMaKH
            this.txtMaNV.Enabled = false;
            this.txtTenNV.Focus();
        }

        private void btnLuu_Click(object sender, EventArgs e)
        {
            if (Them == true)
            {
                // Thực hiện lệnh
                nv.themNV(txtTenNV.Text,txtCMND.Text,txtGioiTinh.Text, Convert.ToDateTime(txtNgaySinh.Text),txtDanToc.Text, txtTonGiao.Text, txtDiaChi.Text, txtSDT.Text, txtATM.Text, txtBHYT.Text, txtPhong.Text, txtChucVu.Text, Convert.ToInt32(txtHopDong.Text));
                // Load lại dữ liệu trên DataGridView
                LoadData();
                // Thông báo
                MessageBox.Show("Đã thêm xong!");
                //}
                //catch (SqlException)
                //{
                //    MessageBox.Show("Không thêm được. Lỗi rồi!");
                //}
            }
            else
            {
                // Thực hiện lệnh
                nv.suaNV(Convert.ToInt32(txtMaNV.Text), txtTenNV.Text, txtCMND.Text, txtGioiTinh.Text, Convert.ToDateTime(txtNgaySinh.Text), txtDanToc.Text, txtTonGiao.Text, txtDiaChi.Text, txtSDT.Text, txtATM.Text, txtBHYT.Text, txtPhong.Text, txtChucVu.Text, Convert.ToInt32(txtHopDong.Text));
                // Load lại dữ liệu trên DataGridView
                LoadData();
                // Thông báo
                MessageBox.Show("Đã sửa xong!");
            }
        }

        private void btnXoa_Click(object sender, EventArgs e)
        {
            // Thực hiện lệnh
            // Lấy thứ tự record hiện hành
            int r = dgv.CurrentCell.RowIndex;
            // Lấy MaKH của record hiện hành
            string strNV = dgv.Rows[r].Cells[0].Value.ToString();
            // Viết câu lệnh SQL
            // Hiện thông báo xác nhận việc xóa mẫu tin
            // Khai báo biến traloi
            DialogResult traloi;
            // Hiện hộp thoại hỏi đáp
            traloi = MessageBox.Show("Chắc xóa mẫu tin này không?", "Trả lời",
            MessageBoxButtons.YesNo, MessageBoxIcon.Question);
            // Kiểm tra có nhắp chọn nút Ok không?
            if (traloi == DialogResult.Yes)
            {
                nv.xoaNV(Convert.ToInt32(strNV));
                // Cập nhật lại DataGridView
                LoadData();
                // Thông báo
                MessageBox.Show("Đã xóa xong!");
            }
            else
            {
                // Thông báo
                MessageBox.Show("Không thực hiện việc xóa mẫu tin!");
            }
        }
    }
}
