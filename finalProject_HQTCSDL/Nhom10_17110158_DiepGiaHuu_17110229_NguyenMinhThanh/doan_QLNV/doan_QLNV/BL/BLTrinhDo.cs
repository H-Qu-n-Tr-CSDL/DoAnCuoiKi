using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace doan_QLNV.BL
{
    class BLTrinhDo
    {
        QLNVDataContext context = new QLNVDataContext();
        public DataTable layTD()
        {
            var layPB = context.getCTTrinhDo();
            DataTable dtBL = new DataTable();
            dtBL.Columns.Add("ID");
            dtBL.Columns.Add("Mã NV");
            dtBL.Columns.Add("Chuyên môn");
            dtBL.Columns.Add("Ngày cấp");
            dtBL.Columns.Add("Trường");
            foreach (var r in layPB)
            {
                dtBL.Rows.Add(r.ID, r.MaNV, r.ChuyenMon, r.NgayCap, r.Truong);
            }
            return dtBL;
        }
        public bool themCTTrinhDo(int mnv, string chuyenmon, DateTime ngaycap, string truong)
        {
            var themBL = context.addCTTrinhDo(mnv, chuyenmon, ngaycap, truong);
            return true;
        }
        public bool suaCTTrinhDo(int id, int mnv, string chuyenmon, DateTime ngaycap, string truong)
        {
            var suaBL = context.updateCTTrinhDo(id, mnv, chuyenmon, ngaycap, truong);
            return true;
        }
        public bool xoaCTTrinhDo(int id)
        {
            var xoaPB = context.deleteCTTrinhDo(id);
            return true;
        }
    }
}
