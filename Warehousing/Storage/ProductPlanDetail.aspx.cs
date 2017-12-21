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
    public partial class ProductPlanDetail : System.Web.UI.Page
    {
        protected SqlHelper helper = LocalSqlHelper.WH;
        protected int id = 0;
        protected int current_sm_status = 0;
        protected string sm_sn = string.Empty, sm_date = string.Empty, sm_operator = string.Empty, sm_tax=string.Empty;
        protected string sm_remark = string.Empty;
        protected int sm_supplierid = 0;
        protected int sm_type = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            SiteHelper.CheckLogin();
            SiteHelper.GetPageUrlpower("Storage/ProductPlan.aspx");
            if (Session["PowerRead"].ToString() != "1")
            {
                SiteHelper.NOPowerMessage();
            }
            id = Convert.ToInt32(Request["id"]);
            if (!Page.IsPostBack)
            {
                string Sql = "select * from Tb_plan_main where sm_id=@id";
                helper.Params.Add("@id", id);
                DataTable dt = helper.ExecDataTable(Sql);
                if (dt.Rows.Count > 0)
                {
                    sm_supplierid = Convert.ToInt32(dt.Rows[0]["sm_supplierid"]);
                    sm_sn = dt.Rows[0]["sm_sn"].ToString();
                    sm_date = dt.Rows[0]["sm_date"].ToString();
                    sm_operator = dt.Rows[0]["sm_operator"].ToString();
                    sm_remark = dt.Rows[0]["sm_remark"].ToString();
                    sm_tax = dt.Rows[0]["sm_tax"].ToString();
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
            DataTable dt = conn.ExecDataTable("select *,p_price*p_quantity as moneyall,p_baseprice*p_quantity as basemoneyall,p_baseprice_tax*p_quantity as basemoneyall_tax from Tb_plan_product with(nolock) where " + where + " order by p_name,p_spec");
            MemberList.DataShow(dt);
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (Session["PowerAudit"].ToString() != "1")
            {
                SiteHelper.NOPowerMessage();
            }

            if (Convert.ToInt32(Request["sm_status"]) == 0)
            {
                JSHelper.WriteScript("alert('请选择审核方式');history.back();");
                Response.End();
            }
            //if (Business.StorageHelper.checkTxmIsBlank(id))
            //{
            //    JSHelper.WriteScript("alert('该批次下产品存在缺少条码,请修改后再审核!');history.back();");
            //    Response.End();
            //}

            if (Convert.ToInt32(Request["sm_status"]) == 1)
            {
               // Business.StorageHelper.checkStorageOk(id);
            }
            helper.Params.Clear();
            helper.Params.Add("sm_id", id);
            helper.Params.Add("sm_status", Request["sm_status"]);
            helper.Update("Tb_plan_main", "sm_id");

            JSHelper.WriteScript("alert('审核完成');location.href='ProductPlan.aspx';");
            //Response.Write(RoleList.Text);
            Response.End();
        }

        protected string getInPrice(object p_baseprice, object p_baseprice_tax)
        {
            if (Session["PowerAudit"].ToString() == "1")
            {
                return "税前:" + p_baseprice.ToString() + "<br>带税:" + p_baseprice_tax.ToString();

            }
            return "";

        }
    }
}