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

namespace Warehousing.User
{
    public partial class UserList : mypage
    {
        protected string queryStr = string.Empty;

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            SiteHelper.GetPageUrlpower("User/UserList.aspx");
            if (Session["PowerRead"].ToString() != "1")
            {
                SiteHelper.NOPowerMessage();
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["PowerRead"].ToString() != "1")
            {
                SiteHelper.NOPowerMessage();
            }
            if (!Page.IsPostBack)
            {
                BindMemberList(SiteHelper.getPage());
            }
        }
        protected void BindMemberList(int index)
        {
            int count = 0;
            string where = getWhere();
            SqlHelper conn = LocalSqlHelper.WH;
            SqlHelper conn_2 = LocalSqlHelper.WH;
            AspNetPager1.PageSize = 20;
            DataTable dt = conn.TablesPageNew("Tb_User", "*,PayAlready=0.00,PayWill=0.00,PayAll=0.00", "user_id desc", true, AspNetPager1.PageSize, index, where, out count);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                conn_2.Params.Clear();
                //应收款
                dt.Rows[i]["PayAll"] = conn_2.ExecScalar("select isnull(sum(a.p_quantity*(case b.sm_type when 8 then 0-a.p_price else a.p_price end)),0) from Tb_storage_product a left join Tb_storage_main b on a.sm_id=b.sm_id  where b.sm_type in (8,12,13) and b.sm_status in (1) and b.consumer_id=" + dt.Rows[i]["User_id"]);
                conn_2.Params.Clear();
                dt.Rows[i]["PayAlready"] = conn_2.ExecScalar("select isnull(sum(case b.sm_type when 8 then 0-a.pay_money else a.pay_money end),0) from Tb_FinancialFlow a left join Tb_storage_main b on a.sm_id=b.sm_id  where a.is_cancel=0 and b.sm_type in (8,12,13) and b.sm_status in (1) and b.consumer_id=" + dt.Rows[i]["User_id"]);
                dt.Rows[i]["PayWill"] = Convert.ToDouble(dt.Rows[i]["PayAll"]) - Convert.ToDouble(dt.Rows[i]["PayAlready"]);
            }
            MemberList.DataShow(dt);
            AspNetPager1.RecordCount = count;
            AspNetPager1.UrlRewritePattern = "UserList.aspx?page={0}&" + queryStr;

        }


        private string getWhere()
        {
            string str_User_name = Request["User_name"];
            string str_User_Mobile = Request["User_Mobile"];
            string str_StartDate = Request["txtStartDate"];
            string str_EndDate = Request["txtEndDate"];
            string str_User_Level = Request["User_Level"];
            queryStr = "User_name=" + str_User_name + "&User_Mobile=" + str_User_Mobile + "&User_Level=" + str_User_Level + "&txtStartDate=" + str_StartDate + "&txtEndDate=" + str_EndDate; ;
            StringBuilder where = new StringBuilder("1=1");
            if (str_User_name.IsNotNullAndEmpty())
            {
                where.AppendFormat(" and User_name like '%{0}%'", str_User_name);
            }
            if (str_User_Mobile.IsNotNullAndEmpty())
            {
                where.AppendFormat(" and User_Mobile like '%{0}%'", str_User_Mobile);

            }
            if (str_StartDate.IsNotNullAndEmpty())
            {
                where.AppendFormat(" and Add_time >= '{0}'", str_StartDate);

            }

            if (str_EndDate.IsNotNullAndEmpty())
            {
                where.AppendFormat(" and Add_time < DateAdd(d,1,'{0}')", str_EndDate);
            }
            if (str_User_Level.IsNumber())
            {
                where.AppendFormat(" and User_Level='%{0}%'", str_User_Level);
            }

            return where.ToString();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string where = getWhere();
            Response.Redirect("UserList.aspx?" + queryStr);
        }
    }
}