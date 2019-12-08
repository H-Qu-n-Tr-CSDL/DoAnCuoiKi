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
    public partial class frmChuyenCongTac : Form
    {
        doan_QLNV.BL.BLChuyenCongTac bl = new BL.BLChuyenCongTac();
        bool Them;
        public frmChuyenCongTac()
        {
            InitializeComponent();
            LoadData();
        }
        void LoadData()
        {
            // Thay đổi độ rộng cột
            dgv.AutoResizeColumns();
            // Xóa trống các đối tượng trong Panel
            this.txtMaC.ResetText();
            this.txtNgayC.ResetText();
            this.txtCVmoi.ResetText();
            this.txtMaNV.ResetText();
            this.txtCVcu.ResetText();
            this.txtPBmoi.ResetText();
            // Không cho thao tác trên các nút Lưu / Hủy
            this.btnLuu.Enabled = false;
            this.panel1.Enabled = false;
            // Cho thao tác trên các nút Thêm / Sửa / Xóa /Thoát
            this.btnThem.Enabled = true;
            this.btnSua.Enabled = true;
            dgv.DataSource = bl.layChuyenCongTac();
        }
        private void dgv_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            int r = dgv.CurrentCell.RowIndex;
            this.txtMaC.Text = dgv.Rows[r].Cells[0].Value.ToString();
            this.txtNgayC.Text = dgv.Rows[r].Cells[1].Value.ToString();
            this.txtCVmoi.Text = dgv.Rows[r].Cells[4].Value.ToString();
            this.txtMaNV.Text = dgv.Rows[r].Cells[2].Value.ToString();
            this.txtCVcu.Text = dgv.Rows[r].Cells[3].Value.ToString();
            this.txtPBmoi.Text = dgv.Rows[r].Cells[5].Value.ToString();
        }

        private void btnThem_Click(object sender, EventArgs e)
        {
            Them = true;
            this.panel1.Enabled = true;
            this.txtMaC.ResetText();
            this.txtMaC.Enabled = false;
            this.txtNgayC.ResetText();
            this.txtCVmoi.ResetText();
            this.txtMaNV.ResetText();
            this.txtCVcu.ResetText();
            this.txtPBmoi.ResetText();
            this.btnLuu.Enabled = true;
            this.btnThem.Enabled = false;
            this.btnSua.Enabled = false;
            this.txtMaC.Focus();
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
            this.panel1.Enabled = true;
            // Không cho thao tác trên các nút Thêm / Xóa / Thoát
            this.btnThem.Enabled = false;
            this.btnSua.Enabled = false;
            //this.btnTroVe.Enabled = false;
            // Đưa con trỏ đến TextField txtMaKH
            this.txtMaC.Enabled = false;
            this.txtNgayC.Focus();
        }

        private void btnLuu_Click(object sender, EventArgs e)
        {
            if (Them == true)
            {
                // Thực hiện lệnh
                bl.themChuyenCongTac(Convert.ToInt32(txtMaNV.Text), Convert.ToInt32(txtCVmoi.Text), Convert.ToInt32(txtPBmoi.Text));
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
                bl.suaChuyenCongTac(Convert.ToInt32(txtMaC.Text), Convert.ToDateTime(txtNgayC.Text), Convert.ToInt32(txtMaNV.Text), Convert.ToInt32(txtCVcu.Text), Convert.ToInt32(txtCVmoi.Text), Convert.ToInt32(txtPBmoi.Text));
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
