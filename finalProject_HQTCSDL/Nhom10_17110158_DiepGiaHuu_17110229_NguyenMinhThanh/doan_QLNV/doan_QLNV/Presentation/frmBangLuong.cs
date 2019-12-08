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
    public partial class frmBangLuong : Form
    {
        doan_QLNV.BL.BLBangLuong bl = new BL.BLBangLuong();
        bool Them;
        public frmBangLuong()
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
            this.txtLuongCB.ResetText();
            this.txtSoTC.ResetText();
            this.txtLuongTC.ResetText();
            this.txtBaoHiem.ResetText();
            this.txtThucLanh.ResetText();
            // Không cho thao tác trên các nút Lưu / Hủy
            this.btnLuu.Enabled = false;
            this.btnHuy.Enabled = false;
            this.panel1.Enabled = false;
            // Cho thao tác trên các nút Thêm / Sửa / Xóa /Thoát
            this.btnThem.Enabled = true;
            this.btnSua.Enabled = true;
            this.btnXoa.Enabled = true;
            dgv.DataSource = bl.layBangLuong();
        }

        private void btnThem_Click(object sender, EventArgs e)
        {
            Them = true;
            this.panel1.Enabled = true;
            this.txtMaNV.ResetText();
            this.txtMaNV.Enabled = false;
            this.txtLuongCB.ResetText();
            this.txtSoTC.ResetText();
            this.txtLuongTC.ResetText();
            this.txtBaoHiem.ResetText();
            this.txtThucLanh.ResetText();
            this.btnHuy.Enabled = true;
            this.btnLuu.Enabled = true;
            this.btnThem.Enabled = false;
            this.btnSua.Enabled = false;
            this.btnXoa.Enabled = false;
            this.txtMaNV.Focus();
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
            this.txtLuongCB.Focus();
        }

        private void dgv_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            int r = dgv.CurrentCell.RowIndex;
            this.txtMaNV.Text = dgv.Rows[r].Cells[0].Value.ToString();
            this.txtLuongCB.Text = dgv.Rows[r].Cells[1].Value.ToString();
            this.txtSoTC.Text = dgv.Rows[r].Cells[2].Value.ToString();
            this.txtLuongTC.Text = dgv.Rows[r].Cells[3].Value.ToString();
            this.txtBaoHiem.Text = dgv.Rows[r].Cells[4].Value.ToString();
            this.txtThucLanh.Text = dgv.Rows[r].Cells[5].Value.ToString();
        }

        private void btnLuu_Click(object sender, EventArgs e)
        {
            if (Them == true)
            {
                // Thực hiện lệnh
                bl.themBangLuong(Convert.ToInt32(txtMaNV.Text), Convert.ToInt32(txtLuongCB.Text), Convert.ToInt32(txtSoTC.Text), Convert.ToInt32(txtLuongTC.Text), Convert.ToInt32(txtBaoHiem.Text));
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
                bl.suaBangLuong(Convert.ToInt32(txtMaNV.Text), Convert.ToInt32(txtLuongCB.Text), Convert.ToInt32(txtSoTC.Text), Convert.ToInt32(txtLuongTC.Text), Convert.ToInt32(txtBaoHiem.Text), Convert.ToInt32(txtThucLanh.Text));
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
                bl.xoaBangLuong(Convert.ToInt32(txtMaNV.Text));
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

        private void btnTroVe_Click(object sender, EventArgs e)
        {
            LoadData();
        }
    }   
}
