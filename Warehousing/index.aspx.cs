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

namespace Warehousing
{
    public partial class index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string UserName = Request.Form["UserName"];
            string Password = Request.Form["Password"];
            string s = Request.Form["s"];
            if (UserName.IsNullOrEmpty() || Password.IsNullOrEmpty())
            {
                JSHelper.WriteScript("alert('用户名和密码不能为空!');history.back();");
                Response.End();
            }
            if (s.IsNullOrEmpty()||s.Length!=4)
            {
                JSHelper.WriteScript("alert('请正确填写验证码');history.back();");
                Response.End();
            }
            if (s.ToLower() != Request.Cookies["yzmcode"].Value.ToLower())
            {
                JSHelper.WriteScript("alert('验证码有误');history.back();");
                Response.End();
            }
            SqlHelper helper = LocalSqlHelper.WH;
            string sql = "select id,LoginPwd,fullname,warehouse_id,RoleID from wareHouse_Admin where IsLock=0 and LoginName=@UserName";
            helper.Params.Add("@UserName", UserName);
            DataTable dt = helper.ExecDataTable(sql);
            if (dt.Rows.Count != 1)
            {
                JSHelper.WriteScript("alert('管理员不存在');history.back();");
                Response.End();
            }
            string LoginPwd = Convert.ToString(dt.Rows[0]["LoginPwd"]);
            if (SinoHelper2.StringHelper.ASP16MD5(Password)!=LoginPwd)
            {
                JSHelper.WriteScript("alert('密码有误');history.back();");
                Response.End();
            }
            Session["ManageUserId"] = Convert.ToString(dt.Rows[0]["id"]); ;
            Session["LoginName"] = UserName;
            Session["TrueName"] = UserName; ;
            Session["RoleID"] = Convert.ToString(dt.Rows[0]["RoleID"]);
            Session["warehouse_id"] = Convert.ToString(dt.Rows[0]["warehouse_id"]);

            Response.Cookies["userInfo"]["ManageUserId"] = Convert.ToString(dt.Rows[0]["id"]); ;
            Response.Cookies["userInfo"]["LoginName"] = UserName;
            Response.Cookies["userInfo"]["TrueName"] = HttpUtility.UrlEncode(Convert.ToString(dt.Rows[0]["fullname"])); ;
            Response.Cookies["userInfo"]["RoleID"] = Convert.ToString(dt.Rows[0]["RoleID"]);
            Response.Cookies["userInfo"]["warehouse_id"] = Convert.ToString(dt.Rows[0]["warehouse_id"]);
            JSHelper.WriteScript("location.href='Admin.Aspx'");
            Response.End();
        }
    }
}