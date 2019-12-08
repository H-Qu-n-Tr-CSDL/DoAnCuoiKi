using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace doan_QLNV.BL
{    
    public class BLNguoiDung
    {
        QLNVDataContext context = new QLNVDataContext();
        public int MaNV;
        public int MaPQ;
        public int DangNhap(string tk, string mk)
        {
            int hople = 0;
            var dn = context.DangNhap(tk, mk);
            DataTable dtPB = new DataTable();
            dtPB.Columns.Add("MaNV");
            dtPB.Columns.Add("MaPQ");
            foreach (var r in dn)
            {
                dtPB.Rows.Add(r.MaNV, r.MaPQ);
                hople = 1;
                MaNV = r.MaNV;
                MaPQ = r.MaPQ;
            }            
            return hople;
        }
        public bool doiMK(int manv, string mkcu, string mkmoi)
        {
            var suaNV = context.DoiMk(manv, mkcu, mkmoi);
            return true;
        }
    }
}
