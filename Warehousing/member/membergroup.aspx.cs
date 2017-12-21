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

namespace Warehousing.member
{
    public partial class membergroup : System.Web.UI.Page
    {
        protected int norecord = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            SiteHelper.CheckLogin();
            if (!Page.IsPostBack)
            {
                BindMemberList(1, getWhere());
            }
        }
        protected void BindMemberList(int index, string where)
        {
            int count = 0;
            SqlHelper conn = LocalSqlHelper.WH;
            AspNetPager1.PageSize = 20;
            DataTable dt = conn.TablesPageNew("SinoRole", "*", "ID desc", true, AspNetPager1.PageSize, index, where, out count);
            if (dt.Rows.Count == 0)
            {
                norecord = 1;
            }
            MemberList.DataShow(dt);
            AspNetPager1.RecordCount = count;

        }

        protected void AspNetPager1_PageChanging(object src, Wuqi.Webdiyer.PageChangingEventArgs e)
        {
            BindMemberList(e.NewPageIndex, getWhere());
        }

        private string getWhere()
        {
            string where = "1=1";
            return where;
        }
    }
}
