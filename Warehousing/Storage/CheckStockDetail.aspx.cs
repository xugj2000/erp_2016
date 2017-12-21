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
    public partial class CheckStockDetail : mypage
    {
        protected int norecord = 0;
        protected int main_id = 0;
        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            SiteHelper.GetPageUrlpower("Storage/CheckStock.aspx");
            if (Session["PowerRead"].ToString() != "1")
            {
                SiteHelper.NOPowerMessage();
            }
            if (!Page.IsPostBack)
            {
                main_id = Request["id"].IsNumber()?Convert.ToInt32( Request["id"]):0;
                BindMemberList(SiteHelper.getPage(), getWhere());
            }
        }
        protected void BindMemberList(int index, string where)
        {
            int count = 0;
            SqlHelper conn = LocalSqlHelper.WH;
            AspNetPager1.PageSize = 20;
            DataTable dt = conn.TablesPageNew("Tb_check_input", "*", "id asc", true, AspNetPager1.PageSize, index, where, out count);
            if (dt.Rows.Count == 0)
            {
                norecord = 1;
            }
            MemberList.DataShow(dt);
            AspNetPager1.RecordCount = count;
            AspNetPager1.UrlRewritePattern = "CheckStockDetail.aspx?page={0}&id=" + main_id;
        }

        private string getWhere()
        {
            string where = "1=1";
            where = "main_id=" + main_id;
            return where;
        }
    }
}