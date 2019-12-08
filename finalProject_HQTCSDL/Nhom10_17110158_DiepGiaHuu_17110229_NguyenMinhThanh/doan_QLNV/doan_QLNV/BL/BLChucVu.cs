using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace doan_QLNV.BL
{
    class BLChucVu
    {
        QLNVDataContext context = new QLNVDataContext();
        public DataTable layChucVu()
        {
            var layPB = context.getChucVu();
            DataTable dtCV = new DataTable();
            dtCV.Columns.Add("Mã Chức vụ");
            dtCV.Columns.Add("Tên Chức vụ");
            dtCV.Columns.Add("Phụ Cấp");
            foreach (var r in layPB)
            {
                dtCV.Rows.Add(r.MaCV, r.TenCV, r.PhuCap);
            }
            return dtCV;
        }
        public bool themChucVu(string tencv, float phucap)
        {
            var themPB = context.addChucVu(tencv, phucap);
            return true;
        }
        public bool suaChucVu(int macv, string tencv, float phucap)
        {
            var suaPB = context.updateChucVu(macv, tencv, phucap);
            return true;
        }
        public bool xoaChucVu(int macv)
        {
            var xoaPB = context.deleteChucVu(macv);
            return true;
        }
    }
}
