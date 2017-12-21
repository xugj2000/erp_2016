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
using System.Text;
using Warehousing.Business;

namespace Warehousing.Storage
{
    public partial class ProductTran : System.Web.UI.Page
    {
        protected string queryStr = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            SiteHelper.CheckLogin();
            SiteHelper.GetPageUrlpower("Storage/ProductTran.aspx");
            if (!Page.IsPostBack)
            {
                if (Session["PowerRead"].ToString() != "1")
                {
                    SiteHelper.NOPowerMessage();
                }
                BindMemberList(SiteHelper.getPage());
            }
        }
        protected void BindMemberList(int index)
        {
            string where = getWhere();
            int count = 0;
            SqlHelper conn = LocalSqlHelper.WH;
            AspNetPager1.PageSize = 20;
            DataTable dt = conn.TablesPageNew("Tb_storage_main with(nolock)", "Tb_storage_main.*,procount=(select sum(p_quantity) from Tb_storage_product with(nolock) where sm_id=Tb_storage_main.sm_id),sku=(select count(p_quantity) from Tb_storage_product with(nolock) where sm_id=Tb_storage_main.sm_id)", "sm_id desc", true, AspNetPager1.PageSize, index, where, out count);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                // conn.Params.Clear();
                // dt.Rows[i]["procount"] = conn.ExecScalar("select count(p_quantity) from Tb_storage_product with(nolock) where sm_id=" + dt.Rows[i]["sm_id"].ToString());
            }
            MemberList.DataShow(dt);
            AspNetPager1.RecordCount = count;
            AspNetPager1.UrlRewritePattern = "ProductTran.aspx?page={0}&" + queryStr;

        }

        private string getWhere()
        {
            string str_sm_sn = Request["sm_sn"];
            string int_sm_supplierid = Request["sm_supplierid"];
            string StartDate = Request["startDate"];
            string EndDate = Request["endDate"];
            queryStr = "sm_sn=" + str_sm_sn + "&startDate=" + StartDate + "&endDate=" + EndDate;
            int warehouse_id = Convert.ToInt32(Request.Cookies["userInfo"]["warehouse_id"]);
            StringBuilder where = new StringBuilder("sm_type=10 and sm_status in(3,4)");
            if (warehouse_id > 0)
            {
                where.AppendFormat(" and warehouse_id_to = {0}", warehouse_id);
            }

            if (str_sm_sn.IsNotNullAndEmpty())
            {
                where.AppendFormat(" and sm_sn like '%{0}%'", str_sm_sn);

            }
            if (StartDate.IsNotNullAndEmpty())
            {
                startDate.Text = StartDate;
                where.AppendFormat(" and sm_date>='{0}'", StartDate);
            }
            if (EndDate.IsNotNullAndEmpty())
            {
                endDate.Text = EndDate;
                where.AppendFormat(" and sm_date<dateAdd(d,1,'{0}')", EndDate);
            }
            return where.ToString();
        }

        protected string getStyletext(int status)
        {
            return status == 1 ? "style='display:none;'" : "";
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string where = getWhere();

            Response.Redirect("ProductTran.aspx?" + queryStr);
        }
    }
}