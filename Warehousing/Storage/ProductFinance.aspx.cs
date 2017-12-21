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
    public partial class ProductFinance : mypage
    {
        protected string queryStr = string.Empty;
        protected int sm_id = 0;
        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            SiteHelper.CheckLogin();
            sm_id = Convert.ToInt32(Request["id"]);
            if (!Page.IsPostBack)
            {
                BindStockList(SiteHelper.getPage());
            }
        }

        protected void BindStockList(int index)
        {
            int count = 0;
            string where = getWhere();
            SqlHelper conn = LocalSqlHelper.WH;
            AspNetPager1.PageSize = 20;
            DataTable dt = conn.TablesPageNew("Tb_FinancialFlow", "*", "id desc", true, AspNetPager1.PageSize, index, where, out count);
            MemberList.DataShow(dt);
            AspNetPager1.RecordCount = count;
            AspNetPager1.UrlRewritePattern = "ProductFinance.aspx?page={0}&" + queryStr;

        }

        private string getWhere()
        {
            string pro_id = Request["pro_id"];
            string where = "object_type='Storage'";
            if (sm_id > 0)
            {
                where = "sm_id=" + sm_id;
            }
            else
            {
                JSHelper.WriteScript("alert('请对应相应工单');history.back();");
                Response.End();
            }
            
            return where;
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("ProductFinance.aspx?id="+sm_id+"&txm=" + pro_txm.Text);
        }


        protected string getWorkStatusText(int WorkStatus)
        {
            string WorkStatusText = string.Empty;
            switch (WorkStatus)
            {
                case 0:
                    WorkStatusText = "正常";
                    break;
                case 1:
                    WorkStatusText = "<font color=red>作废</font>";
                    break;
            }

            return WorkStatusText;
        }

    }
}