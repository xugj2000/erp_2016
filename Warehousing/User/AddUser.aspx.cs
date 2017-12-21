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
using Warehousing.Model;
using Warehousing.Business;

namespace Warehousing.User
{
    public partial class AddUser : mypage
    {
        protected SqlHelper helper = LocalSqlHelper.WH;
        protected int User_id = 0;
        protected string IsLock = "0";

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            SiteHelper.GetPageUrlpower("User/Userlist.aspx");
            if (Session["PowerSuper"].ToString() != "1")
            {
                SiteHelper.NOPowerMessage();
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            User_id = Convert.ToInt32(Request["id"]);
            if (!Page.IsPostBack)
            {
                string Sql = "select * from Tb_User where User_id=@id";
                helper.Params.Add("@id", User_id);
                DataTable dt = helper.ExecDataTable(Sql);
                if (dt.Rows.Count > 0)
                {
                    TextUser_name.Text = Convert.ToString(dt.Rows[0]["User_name"]);
                    TextTrue_name.Text = Convert.ToString(dt.Rows[0]["True_name"]);
                    TextUser_Mobile.Text = Convert.ToString(dt.Rows[0]["User_Mobile"]);
                    IsLock = Convert.ToString(dt.Rows[0]["is_hide"]);
                    DDUser_Level.SelectedValue = Convert.ToString(dt.Rows[0]["User_Level"]);
                }


            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            helper.Params.Clear();
            helper.Params.Add("User_name", TextUser_name.Text);
            helper.Params.Add("User_Mobile", TextUser_Mobile.Text);
            helper.Params.Add("True_name", TextTrue_name.Text);
            helper.Params.Add("User_Level", Request["DDUser_Level"]);
            helper.Params.Add("is_hide", Request.Form["IsLock"]);
            if (User_id == 0)
            {
                if (TextUser_Pwd.Text.IsNullOrEmpty() || !TextUser_Pwd.Text.IsNumber() && TextUser_Pwd.Text.Length != 6)
                {
                    JSHelper.WriteScript("alert('密码要求为6位数字');history.back();");
                    Response.End();
                }
                helper.Params.Add("User_Pwd", SinoHelper2.StringHelper.ASP16MD5(TextUser_Pwd.Text));
                helper.Insert("Tb_User");
            }
            else
            {
                if (TextUser_Pwd.Text.IsNotNullAndEmpty())
                {
                    if (!TextUser_Pwd.Text.IsNumber() || TextUser_Pwd.Text.Length != 6)
                    {
                        JSHelper.WriteScript("alert('密码要求为6位数字');history.back();");
                        Response.End();
                    }
                    else
                    {
                        helper.Params.Add("User_Pwd", SinoHelper2.StringHelper.ASP16MD5(TextUser_Pwd.Text));
                    }
                }
                helper.Params.Add("User_id", User_id);
                helper.Update("Tb_User", "User_id");
            }
            JSHelper.WriteScript("alert('编辑成功');location.href='UserList.aspx';");
            //Response.Write(RoleList.Text);
            Response.End();
        }
    }
}