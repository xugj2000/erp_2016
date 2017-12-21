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
    public partial class ComplaintDo : System.Web.UI.Page
    {
        protected string Id;
        protected void Page_Load(object sender, EventArgs e)
        {
            SiteHelper.CheckLogin();
            SiteHelper.GetPageUrlpower("Complaint/ComplaintList.aspx");
            if (Session["PowerRead"].ToString() != "1")
            {
                SiteHelper.NOPowerMessage();
            }

            Id = Request["id"];
            if (!Id.IsNumber())
            {
                JSHelper.WriteScript("alert('数据传递有误');history.back();");
                Response.End();
            }

            if (!IsPostBack)
            {

                SqlHelper sp = LocalSqlHelper.WH;
                string sql = "select * from Tb_Complaint where id=" + Id;
                DataTable gdDt = sp.ExecDataTable(sql);
                if (gdDt.Rows.Count > 0) //修改时
                {
                    txtUserId.Text = gdDt.Rows[0]["UserId"].ToString();
                    txtUserName.Text = gdDt.Rows[0]["UserName"].ToString();
                    txtuserTel.Text = gdDt.Rows[0]["userTel"].ToString();
                    txtComplaintTime.Text = gdDt.Rows[0]["ComplaintTime"].ToString();
                    txtComplaintDetail.Text = gdDt.Rows[0]["ComplaintDetail"].ToString();
                    txtaddOperator.Text = gdDt.Rows[0]["addOperator"].ToString();
                    txtdoContent.Text = gdDt.Rows[0]["doContent"].ToString();
                    txtdoOperator.Text = gdDt.Rows[0]["doOperator"].ToString();
                    ddtypeId.Text =Business.ComplaintHelper.getTypeName(gdDt.Rows[0]["typeId"]);
                    string dostatus = gdDt.Rows[0]["status"].ToString();
                    switch (dostatus)
                    {
                        case "0":
                            ddStatus.Items.Add(new ListItem(Warehousing.Business.ComplaintHelper.getStutusText(1), "1"));
                            ddStatus.Items.Add(new ListItem(Warehousing.Business.ComplaintHelper.getStutusText(2), "2"));
                            break;
                        case "1":
                            ddStatus.Items.Add(new ListItem(Warehousing.Business.ComplaintHelper.getStutusText(1),"1"));
                            ddStatus.Items.Add(new ListItem(Warehousing.Business.ComplaintHelper.getStutusText(2),"2"));
                            break;
                        case "2":
                            ddStatus.Items.Add(new ListItem(Warehousing.Business.ComplaintHelper.getStutusText(2), "2"));
                            break;
                    }
                    txtdoOperator.Attributes.Add("onchange", "checkLoginId(this.value);");
                    fromUrl.Value = Request.ServerVariables["HTTP_REFERER"];
                }
                else
                {
                    JSHelper.WriteScript("alert('数据传递有误');history.back();");
                    Response.End();
                }

            }

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (Session["PowerAudit"].ToString() != "1")
            {
                SiteHelper.NOPowerMessage();
            }

            if (Page.IsValid)
            {

                string sql = string.Empty;


                string doContent = txtdoContent.Text;
                string doOperator = txtdoOperator.Text;
                string dostatus = ddStatus.SelectedValue;

                if (SiteHelper.getTrueNameByLoginId(doOperator).IsNullOrEmpty())
                {
                    JSHelper.WriteScript("alert('请正确输入处理人工号');history.back();");
                    Response.End();
                }

                if (!dostatus.IsNumber())
                {
                    JSHelper.WriteScript("alert('请选择处理状态');history.back();");
                    Response.End();
                }

                sql = "update Tb_Complaint set doOperator=@doOperator,doContent=@doContent,status=@dostatus,updateTime=getdate()";
                if (dostatus=="2")
                {

                    if (doContent.IsNullOrEmpty())
                    {
                        JSHelper.WriteScript("alert('处理结果不能为空');history.back();");
                        Response.End();
                    }
                    sql+=",endTime=getdate()";
                }
                sql += " where id=" + Id;
                SqlHelper sp = LocalSqlHelper.WH;

                sp.Params.Add("@doContent", doContent);
                sp.Params.Add("@doOperator", doOperator);
                sp.Params.Add("@dostatus", dostatus);
                sp.Execute(sql);

                //写处理日志
                string doWhat = "客诉处理：状态至" + dostatus + "(" + Warehousing.Business.ComplaintHelper.getStutusText(Convert.ToInt32(dostatus)) + "),处理人为:" + doOperator + ",处理意见：" + doContent;
                SiteHelper.writeLog("客诉处理", doWhat, Convert.ToInt32(Id));

                JSHelper.WriteScript("alert('客诉处理成功');location.href='ComplaintList.aspx'");
            }
        }
    }
}
