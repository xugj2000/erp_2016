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
    public partial class GoodsReturnOrder : System.Web.UI.Page
    {
        protected string queryStr = string.Empty;
        protected int type = 0;
        protected string thisUrl = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            SiteHelper.CheckLogin();
            SiteHelper.GetPageUrlpower("GoodsReturn/GoodsReturnOrder.aspx");
            if (Session["PowerRead"].ToString() != "1")
            {
                SiteHelper.NOPowerMessage();
            }

            if (!Page.IsPostBack)
            {
                thisUrl = Server.UrlEncode("GoodsReturnOrder.aspx?" + Convert.ToString(Request.ServerVariables["Query_String"]));
                //绑定状态下拉
                Warehousing.Business.GoodsReturnHelper.bindDDLByOrderStatus(ddStatus);

                bindOrder(SiteHelper.getPage());
            }

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string AgentId = txtAgentId.Text;
            string OrderId = txtOrderId.Text;
            string Status = ddStatus.SelectedValue;
            queryStr = "agentid=" + AgentId + "&Status=" + Status + "&OrderId=" + OrderId;
            Response.Redirect("GoodsReturnOrder.aspx?" + queryStr);
        }

        //捆绑搜索订单
        protected void bindOrder(int page)
        {
            string where = getWhere();
            SqlHelper sp = LocalSqlHelper.WH;
            int count = 0;
            DataTable dt = sp.TablesPageNew("TB_GoodsReturnOrder", "*", "id desc", true, Pager.PageSize, page, where, out count);
            OrderList.DataShow(dt);
            Pager.RecordCount = count;
            Pager.UrlRewritePattern = "GoodsReturnOrder.aspx?page={0}&" + queryStr;
        }

        //
        protected string getWhere()
        {
            string AgentId = Request["agentid"];
            string OrderId = Request["OrderId"];
            string Status = Request["Status"];
            StringBuilder where = new StringBuilder("1=1");
            queryStr = "agentid=" + AgentId + "&Status=" + Status + "&OrderId=" + OrderId;
            //ddStatus.Text = type.ToString();

            if (AgentId.IsNumber())
            {
                txtAgentId.Text = AgentId;
                where.AppendFormat(" and AgentId='{0}'", AgentId);
            }
            if (OrderId.IsNumber())
            {
                txtOrderId.Text = OrderId;
                where.AppendFormat(" and OrderId='{0}'", OrderId);
            }

            if (Status.IsNumber())
            {
                ddStatus.SelectedValue = Status;
                where.AppendFormat(" and OrderStatus={0}", Status);
            }
            return where.ToString();

        }

        protected void OrderList_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemIndex != -1)
            {
                if (e.Item.ItemType == ListItemType.AlternatingItem || e.Item.ItemType == ListItemType.Item)
                {
                    Repeater OrderDetail = (Repeater)(e.Item.FindControl("OrderDetail"));
                    DataRowView row = (DataRowView)e.Item.DataItem;
                    string dingdan = Convert.ToString(row["OrderId"]);

                    string sql = "select sortid=1,* from TB_GoodsReturn where ReturnOrderId=@dingdan and ChangeFlag>=0 ";
                    SqlHelper sp = LocalSqlHelper.WH;
                    sp.Params.Add("@dingdan", dingdan);
                    DataTable dt = sp.ExecDataTable(sql);
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        dt.Rows[i]["sortid"] = i + 1;
                    }
                    OrderDetail.DataShow(dt);
                }

            }
        }
    }
}
