using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Text;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using SinoHelper2;

namespace Warehousing.GoodsReturn
{
    public partial class GoodsReturnToExcel : System.Web.UI.Page
    {
        protected int isSearch = 0;
        protected int type = 0;
        protected string queryStr = string.Empty;
        protected int haveFlag = 0; //有待发货商品标识
        protected int toExcel = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            SiteHelper.CheckLogin();
            SiteHelper.GetPageUrlpower("GoodsReturn/GoodsReturnList.aspx");
            if (Session["PowerRead"].ToString() != "1")
            {
                SiteHelper.NOPowerMessage();
            }

            if (!Page.IsPostBack)
            {
                bindOrder();

            }

        }

        //捆绑搜索订单
        protected void bindOrder()
        {
            string where = getWhere();
            SqlHelper sp = LocalSqlHelper.WH;
            int count = 0;
            DataTable dt;
            dt = sp.ExecDataTable("select * from TB_GoodsReturn where " + getWhere());
            GoodsList.DataShow(dt);
             SiteHelper.ToExcel(GoodsList, "goods");
        }

        //
        protected string getWhere()
        {
            string AgentId = Request["agentid"];
            string ProductName = Request["pname"];
            string Status = Request["status"];
            string UserName = Request["username"];
            string StartDate = Request["startDate"];
            string EndDate = Request["endDate"];
            StringBuilder where = new StringBuilder("ChangeFlag<=0");

            if (AgentId.IsNumber())
            {
                where.AppendFormat(" and AgentId='{0}'", AgentId);
            }
            if (ProductName.IsNotNullAndEmpty())
            {
                where.AppendFormat(" and ProductName like '%{0}%'", ProductName);

            }
            if (UserName.IsNotNullAndEmpty())
            {
                where.AppendFormat(" and UserName like '{0}'", UserName);

            }
            if (Status.IsNumber())
            {
                where.AppendFormat(" and Status={0}", Status);
            }
            if (StartDate.IsNotNullAndEmpty())
            {
                where.AppendFormat(" and AddTime>'{0}'", StartDate);
            }
            if (EndDate.IsNotNullAndEmpty())
            {
                where.AppendFormat(" and AddTime<dateAdd(d,1,'{0}')", EndDate);
            }
            return where.ToString();

        }

    }
}
