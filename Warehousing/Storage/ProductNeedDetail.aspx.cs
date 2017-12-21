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
    public partial class ProductNeedDetail : mypage
    {
        protected SqlHelper helper = LocalSqlHelper.WH;
        protected int id = 0;
        protected int current_sm_status = 0;
        protected string sm_sn = string.Empty, sm_date = string.Empty, sm_operator = string.Empty, sm_time = string.Empty;
        protected string sm_remark = string.Empty;
        protected int warehouse_id_from = 0;
        protected int warehouse_id_to = 0;
        protected int sm_type = 0;
        protected int total_quantity = 0;
        protected double total_price = 0;
        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            id = Convert.ToInt32(Request["id"]);
            if (!Page.IsPostBack)
            {
                string Sql = "select * from Tb_need_main where sm_id=@id";
                helper.Params.Add("@id", id);
                DataTable dt = helper.ExecDataTable(Sql);
                if (dt.Rows.Count > 0)
                {
                    warehouse_id_from = Convert.ToInt32(dt.Rows[0]["warehouse_id_from"]);
                    warehouse_id_to = Convert.ToInt32(dt.Rows[0]["warehouse_id"]);
                    sm_sn = dt.Rows[0]["sm_sn"].ToString();
                    sm_date = Convert.ToDateTime(dt.Rows[0]["sm_date"]).ToShortDateString();
                    sm_time = dt.Rows[0]["add_time"].ToString();
                    sm_operator = dt.Rows[0]["sm_operator"].ToString();
                    sm_remark = dt.Rows[0]["sm_remark"].ToString();
                    current_sm_status = Convert.ToInt32(dt.Rows[0]["sm_status"].ToString());
                    BindMemberList(1, "sm_id=" + id.ToString());
                    bind_status_list(sm_type);
                }
            }
        }

        protected void BindMemberList(int index, string where)
        {
            int count = 0;
            SqlHelper conn = LocalSqlHelper.WH;
            DataTable dt = conn.ExecDataTable("select * from Tb_need_product with(nolock) where " + where + " order by p_name,p_spec");
            MemberList.DataShow(dt);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                total_quantity += Convert.ToInt32(dt.Rows[i]["p_quantity"]);
                total_price += Convert.ToInt32(dt.Rows[i]["p_quantity"]) * Convert.ToDouble(dt.Rows[i]["p_price"]);
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (Business.StorageHelper.checkTxmIsBlank(id))
            {
                JSHelper.WriteScript("alert('该批次下产品存在缺少条码,请修改后再审核!');history.back();");
                Response.End();
            }
            if (Convert.ToInt32(Request["sm_status"]) == 0)
            {
                JSHelper.WriteScript("alert('请选择审核方式');history.back();");
                Response.End();
            }
            helper.Params.Add("sm_status", Request["sm_status"]);
            helper.Params.Add("sm_verify_adminid", my_admin_id);
            helper.Params.Add("sm_id", id);
            helper.Update("Tb_need_main", "sm_id");

            JSHelper.WriteScript("alert('审核完成');location.href='ProductNeedList.aspx';");
            //Response.Write(RoleList.Text);
            Response.End();
        }

        protected void bind_status_list(int sm_type)
        {
            sm_status.Items.Add(new ListItem("等待审核", "0"));
            sm_status.Items.Add(new ListItem("通过", "1"));
            sm_status.Items.Add(new ListItem("作废", "2"));
        }
    }
}