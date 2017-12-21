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

namespace Warehousing.Storage
{
    public partial class ProductInDetail_other : System.Web.UI.Page
    {
        protected SqlHelper helper = LocalSqlHelper.WH;
        protected int id = 0;
        protected int current_sm_status = 0;
        protected string sm_supplier = string.Empty, sm_sn = string.Empty, sm_date = string.Empty, sm_operator = string.Empty;
        protected string sm_remark = string.Empty;
        protected int sm_type = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            id = Convert.ToInt32(Request["id"]);
            if (!Page.IsPostBack)
            {
                string Sql = "select * from Tb_storage_main where sm_id=@id";
                helper.Params.Add("@id", id);
                DataTable dt = helper.ExecDataTable(Sql);
                if (dt.Rows.Count > 0)
                {
                    sm_supplier = dt.Rows[0]["sm_supplier"].ToString();
                    sm_sn = dt.Rows[0]["sm_sn"].ToString();
                    sm_date = dt.Rows[0]["sm_date"].ToString();
                    sm_operator = dt.Rows[0]["sm_operator"].ToString();
                    sm_remark = dt.Rows[0]["sm_remark"].ToString();
                    sm_type = Convert.ToInt32(dt.Rows[0]["sm_type"].ToString());
                    current_sm_status = Convert.ToInt32(dt.Rows[0]["sm_status"].ToString());
                    BindMemberList(1, "sm_id=" + id.ToString());
                }
            }
        }

        protected void BindMemberList(int index, string where)
        {
            int count = 0;
            SqlHelper conn = LocalSqlHelper.WH;
            DataTable dt = conn.ExecDataTable("select * from Tb_storage_product with(nolock) where " + where);
            MemberList.DataShow(dt);
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            helper.Params.Add("sm_status", Request["sm_status"]);
            helper.Params.Add("sm_id", id);
            helper.Update("Tb_storage_main", "sm_id");

            Business.StorageHelper.checkStorageOk(id);

            JSHelper.WriteScript("alert('审核完成');location.href='ProductIn.aspx';");
            //Response.Write(RoleList.Text);
            Response.End();
        }
    }
}