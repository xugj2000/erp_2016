using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using SinoHelper2;
using Warehousing.Business;

namespace Warehousing.Storage
{
    public partial class test : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["anti"] == null)
            {
                Session["anti"] = "1";
            }
            else
            {
                Response.Write("已操作");
                Response.End();
            }
            int sm_id = 0;
            int old_sm_id = 0;
            SqlHelper conn = LocalSqlHelper.WH;
            string sm_sn = string.Empty;
            string sql = "select * from Tb_storage_main where sm_id between 2774 and 3412 and sm_sn like 'CK%_1' and LEN(sm_sn)=12 and sm_status=1";
            DataTable dt = conn.ExecDataTable(sql);
            conn.Params.Clear();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                sm_sn = Convert.ToString(dt.Rows[i]["sm_sn"]);
                sm_id = Convert.ToInt32(dt.Rows[i]["sm_id"]);
                sql = "select sm_id from Tb_storage_main where sm_sn like '" + sm_sn.Replace("_1", "") + "'";
                old_sm_id = Convert.ToInt32(conn.ExecScalar(sql));
                if (old_sm_id > 0)
                {
                    if (old_sm_id < 2085 || old_sm_id > 2507)
                    {
                         Response.Write(sm_id + "<br>");
                        // StorageHelper.checkStorageOk(old_sm_id, false); //不需验库存
                    }
                }
            }

        }
    }
}