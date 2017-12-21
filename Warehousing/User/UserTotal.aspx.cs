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
    public partial class UserTotal : mypage
    {
        protected string queryStr = string.Empty;
        protected double total_allCount = 0;

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            SiteHelper.GetPageUrlpower("User/UserTotal.aspx");
            if (Session["PowerRead"].ToString() != "1")
            {
                SiteHelper.NOPowerMessage();
            }
            if (!Page.IsPostBack)
            {
                BindOrderList(SiteHelper.getPage());
            }
        }
        protected void BindOrderList(int index)
        {
            int count = 0;
            string where = getWhere();
            SqlHelper conn = LocalSqlHelper.WH;
            string sql = "select convert(varchar(10),Add_time,120) as thisdate,allCount=count(*) from Tb_User where " + where + " group by convert(varchar(10),Add_time,120) order by convert(varchar(10),Add_time,120)";
           // Response.Write(sql);
            DataTable dt = conn.ExecDataTable(sql);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                total_allCount += Convert.ToDouble(dt.Rows[i]["allCount"]);
            }
            OrderList.DataShow(dt);
        }

        private string getWhere()
        {
            string str_startDate = Request["startDate"];
            string str_endDate = Request["endDate"];
            queryStr = "startDate=" + str_startDate + "&endDate=" + str_endDate;
            StringBuilder where = new StringBuilder("1=1");
            if (my_warehouse_id > 0)
            {
               // where.AppendFormat(" and warehouse_id='{0}'", my_warehouse_id);
            }

            if (str_startDate.IsNullOrEmpty() && str_endDate.IsNullOrEmpty())
            {
                str_startDate = DateTime.Today.AddMonths(-1).ToShortDateString();
                str_endDate = DateTime.Today.ToShortDateString();
            }


            if (str_startDate.IsNullOrEmpty() && str_endDate.IsNotNullAndEmpty())
            {
                str_startDate =Convert.ToDateTime(str_endDate).AddMonths(-1).ToShortDateString();
                
            }
            if (str_endDate.IsNullOrEmpty() && str_startDate.IsNotNullAndEmpty())
            {
                str_endDate = DateTime.Today.ToShortDateString();
                str_endDate = Convert.ToDateTime(str_startDate).AddMonths(1) > DateTime.Today ? DateTime.Today.ToShortDateString() : Convert.ToDateTime(str_startDate).AddMonths(1).ToShortDateString();
            }
            startDate.Text = str_startDate;
            where.AppendFormat(" and Add_time>='{0}'", str_startDate);

            endDate.Text = str_endDate;
            where.AppendFormat(" and Add_time<=DATEADD(d,1,'{0}')", str_endDate);
            return where.ToString();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string where = getWhere();
            Response.Redirect("UserTotal.aspx?" + queryStr);
        }

    }
}