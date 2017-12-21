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
    public partial class CheckStock : mypage
    {
        protected int norecord = 0;

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
                string act = Request["act"];
                SqlHelper conn = LocalSqlHelper.WH;
                switch (act)
                {
                    case "truncate"://清空
                        string sql = "delete from Tb_check_input where main_id="+Request["id"];
                        conn.Execute(sql);
                        JSHelper.WriteScript("alert('已清空');location.href='CheckStock.aspx';");
                        break;
                    case "drop"://删除
                        Response.Write("开发进行中...");
                        break;
                    default:
                        BindMemberList(SiteHelper.getPage(), getWhere());
                        break;
                }
            }
        }
        protected void BindMemberList(int index, string where)
        {
            int count = 0;
            SqlHelper conn = LocalSqlHelper.WH;
            AspNetPager1.PageSize = 20;
            DataTable dt = conn.TablesPageNew("Tb_check_main", "*", "main_id desc", true, AspNetPager1.PageSize, index, where, out count);
            if (dt.Rows.Count == 0)
            {
                norecord = 1;
            }
            MemberList.DataShow(dt);
            AspNetPager1.RecordCount = count;
            AspNetPager1.UrlRewritePattern = "CheckStock.aspx?page={0}";
        }

        private string getWhere()
        {
            string where = "1=1";
            if (myStorageInfo.warehouse_id > 0)
            {
                where = "warehouse_id=" + myStorageInfo.warehouse_id;
            }
            return where;
        }
    }
}