using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
namespace doan_QLNV.BL
{
    
    class BLBangLuong
    {
        QLNVDataContext context = new QLNVDataContext();
        public DataTable layBangLuong()
        {
            var layPB = context.getBangLuong();
            DataTable dtBL = new DataTable();
            dtBL.Columns.Add("Mã NV");
            dtBL.Columns.Add("Lương cơ bản");
            dtBL.Columns.Add("Số ngày tăng ca");
            dtBL.Columns.Add("Lương tăng ca");
            dtBL.Columns.Add("Bảo hiểm");
            dtBL.Columns.Add("Thực lãnh");
            foreach (var r in layPB)
            {
                dtBL.Rows.Add(r.MaNV, r.LuongCB, r.SoNgayTangCa, r.LuongTangCa, r.BaoHiem, r.ThucLanh);
            }
            return dtBL;
        }
        public bool themBangLuong(int mnv, float luongcb, int songay, float luongtang, float baohiem)
        {
            var themBL = context.addBangLuong(mnv, luongcb, songay, luongtang, baohiem);
            return true;
        }
        public bool suaBangLuong(int mnv, float luongcb, int songay, float luongtang, float baohiem, float thuclanh)
        {
            var suaBL = context.updateBangLuong(mnv, luongcb, songay, luongtang, baohiem, thuclanh);
            return true;
        }
        public bool xoaBangLuong(int MaNV)
        {
            var xoaPB = context.deleteBangLuong(MaNV);
            return true;
        }
    }
}
