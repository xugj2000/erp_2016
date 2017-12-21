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

namespace Warehousing.GoodsReturn
{
    public partial class GoodsDetail : System.Web.UI.Page
    {
        protected string orderid = string.Empty;
        protected string agentid = string.Empty;
        protected string GoodsId = "0";
        protected string ChangeFlag="0";
        protected void Page_Load(object sender, EventArgs e)
        {
            SiteHelper.CheckLogin();
            SiteHelper.GetPageUrlpower("GoodsReturn/GoodsReturnAdd.aspx");
            if (Session["PowerRead"].ToString() != "1")
            {
                SiteHelper.NOPowerMessage();
            }
            GoodsId = Request["id"];
            if (!GoodsId.IsNumber())
            {
                JSHelper.WriteScript("alert('数据有误');history.back();");
                Response.End();
            }

            if (!IsPostBack)
            {
                SqlHelper sp = LocalSqlHelper.WH;
                string sql = "select * from TB_GoodsReturn where id=" + GoodsId;
                DataTable gdDt = sp.ExecDataTable(sql);
                if (gdDt.Rows.Count > 0)
                {
                    orderid = gdDt.Rows[0]["DingDan"].ToString();
                    agentid = gdDt.Rows[0]["AgentId"].ToString();
                    txtProductName.Text = gdDt.Rows[0]["ProductName"].ToString();
                    txtProductTxm.Text = gdDt.Rows[0]["ProductTxm"].ToString();
                    txtProductCount.Text = gdDt.Rows[0]["ProductCount"].ToString();
                    txtReturnTime.Text = gdDt.Rows[0]["ReturnTime"].ToString();
                    txtReturnReson.Text = gdDt.Rows[0]["ReturnReson"].ToString();
                    txtReceivedOpter.Text = gdDt.Rows[0]["AgentId"].ToString();
                    txtAddTime.Text = gdDt.Rows[0]["AddTime"].ToString();
                    txtOperator.Text = gdDt.Rows[0]["Operator"].ToString();
                    txtStatus.Text = Warehousing.Business.GoodsReturnHelper.getStutusText(Convert.ToInt32(gdDt.Rows[0]["Status"]));
                    agentid = gdDt.Rows[0]["ReceivedOpter"].ToString();
                    ChangeFlag = gdDt.Rows[0]["ChangeFlag"].ToString();
                }
            }
        }

    }
}
