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
    public partial class SupplierList : mypage
    {
        protected int norecord = 0;

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            SiteHelper.GetPageUrlpower("Storage/SupplierList.aspx");
            if (Session["PowerRead"].ToString() != "1")
            {
                SiteHelper.NOPowerMessage();
            }
            if (!Page.IsPostBack)
            {
                BindMemberList(1, getWhere());
            }
        }
        protected void BindMemberList(int index, string where)
        {
            int count = 0;
            SqlHelper conn = LocalSqlHelper.WH;
            SqlHelper conn_2 = LocalSqlHelper.WH;
            AspNetPager1.PageSize = 20;
            DataTable dt = conn.TablesPageNew("supplier", "*,PayAlready=0.00,PayWill=0.00,PayAll=0.00", "id desc", true, AspNetPager1.PageSize, index, where, out count);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                conn_2.Params.Clear();
                //应收款
                dt.Rows[i]["PayAll"] = conn_2.ExecScalar("select isnull(sum(a.p_quantity*(case b.sm_type when 5 then 0-a.p_price when 7 then 0-a.p_price else a.p_price end)),0) from Tb_storage_product a left join Tb_storage_main b on a.sm_id=b.sm_id  where b.sm_type in (1,2,5,7) and b.sm_status in (1) and b.sm_supplierid=" + dt.Rows[i]["id"]);
                conn_2.Params.Clear();
                dt.Rows[i]["PayAlready"] = conn_2.ExecScalar("select isnull(sum(case b.sm_type when 5 then 0-a.pay_money when 7 then 0-a.pay_money else a.pay_money end),0) from Tb_FinancialFlow a left join Tb_storage_main b on a.sm_id=b.sm_id  where  a.object_type='Storage' and a.is_cancel=0 and b.sm_type in (1,2,5,7) and b.sm_status in (1) and b.sm_supplierid=" + dt.Rows[i]["id"]);
                dt.Rows[i]["PayWill"] = Convert.ToDouble(dt.Rows[i]["PayAll"]) - Convert.ToDouble(dt.Rows[i]["PayAlready"]);
            }
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
            string where = "IsFactory=0";
            return where;
        }
    }
}