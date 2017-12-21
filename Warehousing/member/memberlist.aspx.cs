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
    public partial class memberlist : mypage
    {
        
        protected int norecord = 0;

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            if (my_warehouse_id > 0 && myStorageInfo.is_manage== 0)
            {
                JSHelper.WriteScript("alert('没有管理员配置权限');history.back();");
                Response.End();
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
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
            DataTable dt = conn.TablesPage("wareHouse_Admin a left join SinoRole b on a.RoleID=b.ID", "a.*,b.RoleName", "a.id desc", true, AspNetPager1.PageSize, index, where, out count);
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
            if (myStorageInfo.agent_id>0)
            {
                where = "warehouse_id in (select warehouse_id from WareHouse_List where agent_id='" + myStorageInfo.agent_id + "')";
            }
            return where;
        }
    }
}
