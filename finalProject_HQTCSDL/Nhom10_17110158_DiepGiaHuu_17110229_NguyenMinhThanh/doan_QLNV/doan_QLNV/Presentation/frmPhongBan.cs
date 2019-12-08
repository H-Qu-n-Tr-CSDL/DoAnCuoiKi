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

namespace doan_QLNV
{
    public partial class Form1 : Form
    {
        doan_QLNV.BL.BLPhongBan pb = new BL.BLPhongBan();
        public int mpq;
        bool Them;
        public Form1()
        {
            InitializeComponent();
            LoadData();
        }
        void LoadData()
        {
            // Thay đổi độ rộng cột
            dgv.AutoResizeColumns();
            // Xóa trống các đối tượng trong Panel
            this.txtMaPB.ResetText();
            this.txtTenPB.ResetText();
            // Không cho thao tác trên các nút Lưu / Hủy
            this.btnLuu.Enabled = false;
            this.btnHuy.Enabled = false;
            this.panel1.Enabled = false;
            // Cho thao tác trên các nút Thêm / Sửa / Xóa /Thoát
            this.btnThem.Enabled = true;
            this.btnSua.Enabled = true;
            this.btnXoa.Enabled = true;
            dgv.DataSource = pb.layPhongBan();
        }
        private void btnThem_Click(object sender, EventArgs e)
        {
            Them = true;
            this.panel1.Enabled = true;
            this.txtMaPB.ResetText();
            this.txtMaPB.Enabled = false;
            this.txtTenPB.ResetText();
            this.btnHuy.Enabled = true;
            this.btnLuu.Enabled = true;
            this.btnThem.Enabled = false;
            this.btnSua.Enabled = false;
            this.btnXoa.Enabled = false;
            this.txtTenPB.Focus();
            
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
            this.txtMaPB.Enabled = false;
            this.txtTenPB.Focus();
          
        }

        private void btnHuy_Click(object sender, EventArgs e)
        {
            txtMaPB.Clear();
            txtTenPB.Clear();
            txtTimKiem.Clear();
            LoadData();
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
                pb.xoaPhongBan(Convert.ToInt32(txtMaPB.Text));
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

        private void dgv_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            int r = dgv.CurrentCell.RowIndex;
            this.txtMaPB.Text = dgv.Rows[r].Cells[0].Value.ToString();
            this.txtTenPB.Text = dgv.Rows[r].Cells[1].Value.ToString();
        }

        private void btnLuu_Click(object sender, EventArgs e)
        {
            if (Them == true)
            {
                // Thực hiện lệnh
                pb.themPhongBan(txtTenPB.Text);
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
                pb.suaPhongBan(Convert.ToInt32(txtMaPB.Text), txtTenPB.Text);
                // Load lại dữ liệu trên DataGridView
                LoadData();
                // Thông báo
                MessageBox.Show("Đã sửa xong!");
            }
        }

        private void btnTroVe_Click(object sender, EventArgs e)
        {
            LoadData();
        }
    }
}
