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

namespace Warehousing.Complaint
{
    public partial class ComplaintTotal : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SiteHelper.CheckLogin();
            SiteHelper.GetPageUrlpower("Complaint/ComplaintTotal.aspx");
            if (Session["PowerRead"].ToString() != "1")
            {
                SiteHelper.NOPowerMessage();
            }

            if (!Page.IsPostBack)
            {
                //绑定商品
                bindOrder();

            }

        }

        //捆绑搜索订单
        protected void bindOrder()
        {
            string where = getWhere();
            SqlHelper sp = LocalSqlHelper.WH;

            string sql = "select typeid,typeName,count1=0,count2=0,count3=0 from Tb_ComplaintType order by typeId";
            DataTable dt = sp.ExecDataTable(sql);
           
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                dt.Rows[i]["count1"] = sp.ExecScalar("select isnull(count(*),0) from Tb_Complaint where " + where + " and typeId=" + dt.Rows[i]["typeid"].ToString() + " and status=0");//待处理
                dt.Rows[i]["count2"] = sp.ExecScalar("select isnull(count(*),0) from Tb_Complaint where " + where + " and typeId=" + dt.Rows[i]["typeid"].ToString() + " and status=1");//处理中
                dt.Rows[i]["count3"] = sp.ExecScalar("select isnull(count(*),0) from Tb_Complaint where " + where + " and typeId=" + dt.Rows[i]["typeid"].ToString() + " and status=2");//已处理
            }
            GoodsList.DataShow(dt);
        }

        //
        protected string getWhere()
        {
            string dooperator = Request["txtOperator"];
            string addtime = Request["txtAddTime"];
            string endtime= Request["txtEndTime"];

            StringBuilder where = new StringBuilder("1=1");

            if (dooperator.IsNotNullAndEmpty())
            {
                where.AppendFormat(" and doOperator='{0}'", dooperator);
            }
            if (addtime.IsNotNullAndEmpty())
            {
                where.AppendFormat(" and addTime >='{0}'", addtime);

            }
            if (endtime.IsNotNullAndEmpty())
            {
                where.AppendFormat(" and addTime <=dateadd(d,1,'{0}')", endtime);
            }
            return where.ToString();

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            bindOrder();
        }

    }
}
