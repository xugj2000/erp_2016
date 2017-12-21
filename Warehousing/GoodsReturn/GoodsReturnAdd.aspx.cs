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

namespace Warehousing.GoodsReturn
{
    public partial class GoodsReturnAdd : System.Web.UI.Page
    {
        protected int isSearch = 0;
        protected int type = 0;
        protected string queryStr = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            SiteHelper.CheckLogin();
            SiteHelper.GetPageUrlpower("GoodsReturn/GoodsReturnAdd.aspx");
            if (Session["PowerRead"].ToString() != "1")
            {
                SiteHelper.NOPowerMessage();
            }

            if (!Page.IsPostBack)
            {
               //SynHelper.GetProductInfo();
                bindOrder(SiteHelper.getPage());
            }

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string AgentId = txtAgentId.Text;
            string OrderId = txtOrderId.Text;
            queryStr = "agentid=" + AgentId + "&OrderId=" + OrderId;
            if (!AgentId.IsNumber() && !OrderId.IsNumber())
            {
                JSHelper.WriteScript("alert('请正确输入查询条件');history.back();");
                Response.End();
            }
            Response.Redirect("GoodsReturnAdd.aspx?" + queryStr);
        }

        //捆绑搜索订单
        protected void bindOrder(int page)
        {
            string where=getWhere();
            if (isSearch == 0)
            {
                return;
            }
            string strTable = "Direct_OrderMain";
            SqlHelper sp = LocalSqlHelper.WH;
            int count = 0;
            DataTable dt = sp.TablesPageNew(strTable, "*", "fhsj desc", true, Pager.PageSize, page, where, out count);
            OrderList.DataShow(dt);
            Pager.RecordCount = count;
            Pager.UrlRewritePattern = "GoodsReturnAdd.aspx?page={0}&" + queryStr;
        }

        //
        protected string getWhere()
        {
            string AgentId = Request["agentid"];
            string OrderId = Request["OrderId"];
            string where = "1=1";
            queryStr = "agentid=" + AgentId + "&OrderId=" + OrderId;

            if (AgentId.IsNumber())
            {
                isSearch = 1;
                txtAgentId.Text = AgentId;
                where += " and userid='" + AgentId + "'";
            }
            if (OrderId.IsNumber())
            {
                isSearch = 1;
                txtOrderId.Text = OrderId;
                where += " and dingdan='" + OrderId + "'";
            }

            return where;

        }

        protected void OrderList_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemIndex != -1)
            {
                if (e.Item.ItemType == ListItemType.AlternatingItem || e.Item.ItemType == ListItemType.Item)
                {
                    Repeater OrderDetail = (Repeater)(e.Item.FindControl("OrderDetail"));
                    DataRowView row = (DataRowView)e.Item.DataItem;
                    string dingdan = Convert.ToString(row["dingdan"]);
                    string strTable = string.Empty;
                    strTable = "Direct_OrderDetail";
                    string sql = "select sortid=1,* from " + strTable + " where dingdan=@dingdan";
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

        protected void Button2_Click(object sender, EventArgs e)
        {
            Response.Redirect("GoodsReturnAddNext.aspx?isDirect=1");
        }

    }
}
