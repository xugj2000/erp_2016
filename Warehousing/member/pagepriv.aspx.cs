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

namespace Warehousing.member
{
    public partial class pagepriv : System.Web.UI.Page
    {
        protected int norecord = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            SiteHelper.CheckLogin();
            if (!Page.IsPostBack)
            {
                BindMemberList();
            }
        }
        protected void BindMemberList()
        {
            SqlHelper conn = LocalSqlHelper.WH;
            DataTable dt = conn.ExecDataTable("select * from SinoModule order by OrderNum desc,ID desc");
            if (dt.Rows.Count == 0)
            {
                norecord = 1;
            }
            MemberList.DataShow(dt);
        }
    }
}
