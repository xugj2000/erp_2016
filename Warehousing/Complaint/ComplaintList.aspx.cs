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
    public partial class ComplaintList : System.Web.UI.Page
    {
        protected int isSearch = 0;
        protected int type = 0;
        protected string queryStr = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            SiteHelper.CheckLogin();
            SiteHelper.GetPageUrlpower("Complaint/ComplaintList.aspx");
            if (Session["PowerRead"].ToString() != "1")
            {
                SiteHelper.NOPowerMessage();
            }

            if (!Page.IsPostBack)
            {
                string act = Convert.ToString(Request["act"]);
                if (act == "del")
                {
                    string delid = Convert.ToString(Request["id"]);
                    string delWhere = "id=" + delid;
                    SqlHelper sp = LocalSqlHelper.WH;
                    sp.Delete("Tb_Complaint", delWhere);
                    string fromurl = Convert.ToString(Request.UrlReferrer);
                    Response.Redirect(fromurl);
                    Response.End();
                }

                //绑定状态下拉
                SiteHelper.bindReason(ddtypeId);
                ddtypeId.Items.Insert(0, new ListItem("所有", ""));
                Business.ComplaintHelper.bindDDLByComplaintStatus(ddStatus);
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
            dt = sp.TablesPageNew("Tb_Complaint", "*", "Status asc,ID desc", true, Pager.PageSize, page, where, out count);
            GoodsList.DataShow(dt);
            Pager.RecordCount = count;
            Pager.UrlRewritePattern = "ComplaintList.aspx?page={0}&" + queryStr;
        }

        //
        protected string getWhere()
        {
            string userId = Request["userId"];
            string username = Request["userName"];
            string op = Request["op"];
            string Status = Request["Status"];
            string typeid = Request["typeid"];
            string userTel = Request["tel"];
            string sDate = Request["sDate"];
            string eDate = Request["eDate"];
            queryStr = "userId=" + userId + "&op=" + op + "&Status=" + Status + "&typeid=" + typeid + "&sDate=" + sDate + "&eDate=" + eDate + "&tel=" + userTel + "&userName=" + username;
            StringBuilder where = new StringBuilder("1=1");

            if (userId.IsNumber())
            {
                where.AppendFormat(" and UserId='{0}'", userId);
            }
            if (username.IsNotNullAndEmpty())
            {
                where.AppendFormat(" and UserName like '%{0}%'", username);
            }
            if (userTel.IsNotNullAndEmpty())
            {
                where.AppendFormat(" and userTel like '%{0}%'", userTel);
            }
            if (op.IsNotNullAndEmpty())
            {
                where.AppendFormat(" and addOperator like '%{0}%'", op);

            }
            if (typeid.IsNumber())
            {
                ddtypeId.SelectedValue = typeid;
                where.AppendFormat(" and typeid= {0}", typeid);

            }
            if (Status.IsNumber())
            {
                ddStatus.SelectedValue = Status;
                where.AppendFormat(" and Status={0}", Status);
            }
            if (sDate.IsNotNullAndEmpty())
            {
                where.AppendFormat(" and addTime>='{0}'", sDate);
            }
            if (eDate.IsNotNullAndEmpty())
            {
                where.AppendFormat(" and addTime<dateadd(d,1,'{0}')", eDate);
            }
            return where.ToString();

        }




        protected void Button1_Click(object sender, EventArgs e)
        {
            buttonClick("0");
        }



        private void buttonClick(string isExcel)
        {
            string userId = txtUserId.Text;
            string userName = txtUserName.Text;
            string op=txtaddOperator.Text;
            string Status = ddStatus.SelectedValue;
            string typeid = ddtypeId.SelectedValue;
            string userTel = txtTel.Text;
            string sDate = txtSdate.Text;
            string eDate = txtEdate.Text;
            queryStr = "userId=" + userId + "&op=" + op + "&Status=" + Status + "&typeid=" + typeid + "&sDate=" + sDate + "&eDate=" + eDate + "&tel=" + userTel + "&userName=" + userName;
            if (isExcel == "1")
            {
                // Response.Redirect("ComplaintListToExcel.aspx?" + queryStr);
            }
            else
            {
                 Response.Redirect("ComplaintList.aspx?" + queryStr);
            }

        }

        protected void Button4_Click(object sender, EventArgs e)
        {
            buttonClick("1");
        }

        protected void GoodsList_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            string act = e.CommandName;
            string id = e.CommandArgument.ToString();
            switch (act)
            {
                case "edit":
                    Response.Redirect("addComplaint.aspx?id="+id);
                    break;
                case "do":
                    Response.Redirect("ComplaintDo.aspx?id=" + id);
                    break;
            }
        }
    }
}
