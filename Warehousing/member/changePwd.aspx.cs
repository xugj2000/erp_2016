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

namespace Warehousing.member
{
    public partial class changePwd : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (Page.IsPostBack)
            {
                SqlHelper helper = LocalSqlHelper.WH;
                if (TextOldPwd.Text.IsNullOrEmpty())
                {
                    JSHelper.WriteScript("alert('原密码不能为空');history.back();");
                    Response.End();
                }
                if (TextNewPwd.Text.IsNullOrEmpty())
                {
                    JSHelper.WriteScript("alert('新密码不能为空');history.back();");
                    Response.End();
                }
                if (!TextNewPwd.Text.Equals(TextNewPwd2.Text))
                {
                    JSHelper.WriteScript("alert('两次密码不一致');history.back();");
                    Response.End();
                }

                string sql = "select LoginPwd from wareHouse_Admin where id=@id";
                helper.Params.Add("id", HttpContext.Current.Session["ManageUserId"]);
                string oldPwd = Convert.ToString(helper.ExecScalar(sql));
                if (!oldPwd.Equals(SinoHelper2.StringHelper.ASP16MD5(TextOldPwd.Text)))
                {
                    JSHelper.WriteScript("alert('原密码有误!');history.back();");
                    Response.End();
                }

                helper.Params.Clear();
                helper.Params.Add("LoginPwd", SinoHelper2.StringHelper.ASP16MD5(TextNewPwd.Text));
                helper.Params.Add("id", HttpContext.Current.Session["ManageUserId"]);
                helper.Update("wareHouse_Admin", "id");
                JSHelper.WriteScript("alert('密码修改成功！');location.href='changePwd.aspx';");
                //Response.Write(RoleList.Text);
                Response.End();
            }
        }


    }
}