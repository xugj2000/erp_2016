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

namespace Warehousing.Complaint
{
    public partial class addComplaint : System.Web.UI.Page
    {
        protected string Id;
        protected void Page_Load(object sender, EventArgs e)
        {
            SiteHelper.CheckLogin();
            SiteHelper.GetPageUrlpower("Complaint/addComplaint.aspx");
            if (Session["PowerRead"].ToString() != "1")
            {
                SiteHelper.NOPowerMessage();
            }
            Id = Request["id"];
            if (!Id.IsNumber())
            {
                Id = "0";
            }

            if (!IsPostBack)
            {
                SiteHelper.bindReason(ddtypeId);
                ddtypeId.Items.Insert(0, new ListItem("请选择原因", "0"));

                SqlHelper sp = LocalSqlHelper.WH;
                string sql = "select * from Tb_Complaint where id=" + Id;
                DataTable gdDt = sp.ExecDataTable(sql);
                if (gdDt.Rows.Count > 0) //修改时
                {

                    txtUserId.Text = gdDt.Rows[0]["UserId"].ToString();
                    txtuserTel.Text = gdDt.Rows[0]["userTel"].ToString();
                    txtComplaintTime.Text = gdDt.Rows[0]["ComplaintTime"].ToString();
                    txtComplaintDetail.Text = gdDt.Rows[0]["ComplaintDetail"].ToString();
                    txtaddOperator.Text = gdDt.Rows[0]["addOperator"].ToString();
                    ddtypeId.SelectedValue = gdDt.Rows[0]["typeId"].ToString();
                    fromUrl.Value = Request.ServerVariables["HTTP_REFERER"];
                }
                else
                {
                    txtaddOperator.Text = HttpContext.Current.Session["LoginName"].ToString();
                    txtComplaintTime.Text = DateTime.Now.ToString();
                }
                txtaddOperator.Attributes.Add("onchange", "checkLoginId(this.value);");

            }

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string UserId = txtUserId.Text;
                string UserName = txtUserName.Text;
                string userTel = txtuserTel.Text;
                string ComplaintTime = txtComplaintTime.Text;
                string ComplaintDetail = txtComplaintDetail.Text;
                string typeId = ddtypeId.SelectedValue;
                string addOperator = txtaddOperator.Text;

                if (!typeId.IsNumber())
                {
                    JSHelper.WriteScript("alert('请选择投诉类型');history.back();");
                    Response.End();
                }

                if (!UserId.IsNumber())
                {
                    JSHelper.WriteScript("alert('客户ID有误');history.back();");
                    Response.End();
                }
                if (userTel.IsNullOrEmpty())
                {
                    JSHelper.WriteScript("alert('联系方式不能为空');history.back();");
                    Response.End();
                }

                if (ComplaintDetail.IsNullOrEmpty())
                {
                    JSHelper.WriteScript("alert('联系方式不能为空');history.back();");
                    Response.End();
                }

                if (SiteHelper.getTrueNameByLoginId(addOperator).IsNullOrEmpty())
                {
                    JSHelper.WriteScript("alert('请正确录入接诉人工号');history.back();");
                    Response.End();
                }
                string sql = string.Empty;
                Id = Request["id"];
                if (!Id.IsNumber())
                {
                    Id = "0";
                }

                if (Id == "0")
                {
                    if (Session["PowerAdd"].ToString() != "1")
                    {
                        SiteHelper.NOPowerMessage();
                    }
                    sql = "insert into Tb_Complaint(UserId,UserName, ComplaintTime,typeId, ComplaintDetail, userTel, status, addOperator)";
                    sql += " values(@UserId,@UserName, @ComplaintTime,@typeId, @ComplaintDetail, @userTel,0, @addOperator)";
                }
                else
                {
                    if (Session["PowerEdit"].ToString() != "1")
                    {
                        SiteHelper.NOPowerMessage();
                    }
                    sql = "update Tb_Complaint set UserId=@UserId,UserName=@UserName,ComplaintTime=@ComplaintTime,typeId=@typeId, ComplaintDetail=@ComplaintDetail, userTel=@userTel,addOperator=@addOperator where id=" + Id;
                }
                SqlHelper sp = LocalSqlHelper.WH;

                sp.Params.Add("@UserId", UserId);
                sp.Params.Add("@UserName", UserName);
                sp.Params.Add("@userTel", userTel);
                sp.Params.Add("@ComplaintTime", ComplaintTime);
                sp.Params.Add("@ComplaintDetail", ComplaintDetail);
                sp.Params.Add("@typeId", typeId);
                sp.Params.Add("@addOperator", addOperator);
                if (Id == "0")
                {
                    /*
                    sp.Params.Add("@Status", (int)Warehousing.Business.GoodsReturnStatus.返货待处理);
                    sp.Params.Add("@DingDan", orderid);
                    sp.Params.Add("@AgentId", agentid);
                    sp.Params.Add("@Operator", HttpContext.Current.Session["LoginName"].ToString());
                    sp.Params.Add("@OrderType", type.ToString());
                     * */
                }
                sp.Execute(sql);
                JSHelper.WriteScript("alert('客诉提交成功');location.href='ComplaintList.aspx'");
            }
        }

    }
}
