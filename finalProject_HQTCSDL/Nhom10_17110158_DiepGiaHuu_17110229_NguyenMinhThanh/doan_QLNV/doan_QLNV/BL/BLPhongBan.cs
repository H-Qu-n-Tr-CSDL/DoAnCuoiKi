using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace doan_QLNV.BL
{
    public class BLPhongBan
    {
        QLNVDataContext context = new QLNVDataContext();
        public BLPhongBan()
        {

        }
        public DataTable layPhongBan()
        {           
            var layPB = context.getPhongBan();
            DataTable dtPB = new DataTable();
            dtPB.Columns.Add("Mã Phòng Ban");
            dtPB.Columns.Add("Tên Phòng Ban");
            foreach(var r in layPB)
            {
                dtPB.Rows.Add(r.MaPB, r.TenPB);
            }
            return dtPB;
        }
        public bool themPhongBan(string tenpb)
        {
            var themPB = context.addPhongBan(tenpb);
            return true;
        }
        public bool suaPhongBan(int mapb, string tenpb)
        {
            var suaPB = context.updatePhongBan(mapb, tenpb);
            return true;
        }
        public bool xoaPhongBan(int mapb)
        {
            var xoaPB = context.deletePhongBan(mapb);
            return true;
        }
    }
}
