using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace doan_QLNV.BL
{
    class BLChuyenCongTac
    {
        QLNVDataContext context = new QLNVDataContext();
        public DataTable layChuyenCongTac()
        {
            var layPB = context.getChuyenCongTac();
            DataTable dtct = new DataTable();
            dtct.Columns.Add("Mã Chuyển công tác");
            dtct.Columns.Add("Ngày chuyển");
            dtct.Columns.Add("MaNV");
            dtct.Columns.Add("Mã Chức vụ cũ");
            dtct.Columns.Add("Mã Chức vụ mới");
            dtct.Columns.Add("Mã Phòng bang mới");
            foreach (var r in layPB)
            {
                dtct.Rows.Add(r.MaChuyen, r.NgayChuyen, r.MaNV, r.MaCVCu, r.MaCVMoi, r.MaPBMoi);
            }
            return dtct;
        }
        public bool themChuyenCongTac(int mnv, int macvmoi, int mapbmoi)
        {
            var themCT = context.addChuyenCongTac(mnv, macvmoi, mapbmoi);
            return true;
        }
        public bool suaChuyenCongTac(int mc, DateTime nc, int mnv, int macvcu, int macvmoi, int mapbmoi)
        {
            var suaCT = context.updateChuyenCongTac(mc, nc, mnv, macvcu, macvmoi, mapbmoi);
            return true;
        }
    }
}
