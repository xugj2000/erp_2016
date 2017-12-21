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
    public partial class GoodsReturnList : System.Web.UI.Page
    {
        protected int isSearch = 0;
        protected int type = 0;
        protected string queryStr = string.Empty;
        protected int haveFlag = 0; //有待发货商品标识
        protected string thisUrl = "";
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
                string act = Convert.ToString(Request["act"]);
                thisUrl =Server.UrlEncode("GoodsReturnList.aspx?" +Convert.ToString(Request.ServerVariables["Query_String"]));
                if (act == "del")
                {
                    string delid = Convert.ToString(Request["id"]);
                    string delWhere = "id="+delid+" and Status="+((int)Business.GoodsReturnStatus.返货待处理).ToString();
                    SqlHelper sp = LocalSqlHelper.WH;
                    sp.Delete("TB_GoodsReturn", delWhere);
                    string fromurl =Convert.ToString(Request.UrlReferrer);
                    Response.Redirect(fromurl);
                    Response.End();
                }

                //绑定状态下拉
                Warehousing.Business.GoodsReturnHelper.bindDDLByGoodsStatus(ddStatus);
                //绑定商品
                bindOrder(SiteHelper.getPage());
                
            }

        }

        //捆绑搜索订单
        protected void bindOrder(int page)
        {
            string where = getWhere();
            SqlHelper sp = LocalSqlHelper.WH;
            int count = 0;
            DataTable dt;
            dt = sp.TablesPageNew("TB_GoodsReturn", "*", "ID desc", true, Pager.PageSize, page, where, out count);
            GoodsList.DataShow(dt);
            Pager.RecordCount = count;
            Pager.UrlRewritePattern = "GoodsReturnList.aspx?page={0}&" + queryStr;
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


            queryStr = "agentid=" + AgentId + "&Status=" + Status + "&startDate=" + StartDate + "&endDate=" + EndDate + "&username=" + UserName + "&pname=" + ProductName;
            StringBuilder where = new StringBuilder("1=1 and ChangeFlag<=0");

            if (AgentId.IsNumber())
            {
                where.AppendFormat(" and AgentId='{0}'",AgentId);
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
                ddStatus.SelectedValue = Status;
                where.AppendFormat(" and Status={0}", Status);
            }
            if (StartDate.IsNotNullAndEmpty())
            {
                txtStartDate.Text = StartDate;
                where.AppendFormat(" and AddTime>'{0}'", StartDate);
            }
            if (EndDate.IsNotNullAndEmpty())
            {
                txtEndDate.Text = EndDate;
                where.AppendFormat(" and AddTime<dateAdd(d,1,'{0}')", EndDate);
            }
            return where.ToString();

        }


        protected string getCheckBoxStr(string id,string Status)
        {
            if (Status == "6" || Status == "15")
            {
                haveFlag = 1;
                return "<input type=\"checkbox\" name=\"id\" value=\""+id+"\" />";
            }
            return "";
        }


        protected void Button3_Click(object sender, EventArgs e)
        {
            string id = Request.Form["id"];
            if (id.IsNullOrEmpty())
            {
                JSHelper.WriteScript("alert('数据有误');history.back();");
                Response.End();
            }
            Response.Redirect("GoodsToOrder.aspx?id=" + id);
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            buttonClick("0");
        }

        protected string getDelString(object id, object status)
        {

            string delString = string.Empty;
            if (Convert.ToInt32(Eval("Status")) == (int)Warehousing.Business.GoodsReturnStatus.返货待处理)
            {
                delString = "<input name=botton2 type='button' value='删除' onclick=\"if (confirm('确定删除吗')){location.href='GoodsReturnList.aspx?act=del&id=" + id.ToString() + "';}\">";

            }
            return delString;

        }

        protected string getChangeString(object id, object status)
        {

            string delString = string.Empty;
            if (Convert.ToInt32(Eval("Status")) == (int)Warehousing.Business.GoodsReturnStatus.无订单调换)
            {
                delString = "<input name=botton3 type='button' value='调换' onclick=\"location.href='GoodsChange.aspx?id=" + id.ToString() + "';\">";

            }
            return delString;

        }

        protected void Button4_Click(object sender, EventArgs e)
        {
            buttonClick("1");
        }

        private void buttonClick(string isExcel)
        {
            string AgentId = txtAgentId.Text;
            string ProductName = txtProductName.Text;
            string Status = ddStatus.SelectedValue;
            string UserName = txtUserName.Text;
            string startDate = Request["txtStartDate"];
            string endDate = Request["txtEndDate"];
            queryStr = "agentid=" + AgentId + "&Status=" + Status + "&startDate="+startDate+"&endDate="+endDate+"&username=" + UserName + "&pname=" + ProductName;
            if (isExcel == "1")
            {
                Response.Redirect("GoodsReturnToExcel.aspx?" + queryStr);
            }
            else
            {
                Response.Redirect("GoodsReturnList.aspx?" + queryStr);
            }

        }
        
    }
}
