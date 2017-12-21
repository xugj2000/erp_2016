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

namespace Warehousing
{
    public partial class ASPTOASPX : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string goUrl = Request["goUrl"].ToString();
            if (goUrl.IsNullOrEmpty())
            {
                goUrl = "admin.asp";
            }
            for (int i = 0; i < (int)Request.Form.Count; i++)
            {
                
                Session[Request.Form.Keys[i].ToString()] = Request.Form[i].ToString();
                Response.Cookies["userInfo"][Request.Form.Keys[i].ToString()] = HttpUtility.UrlEncode(Request.Form[i].ToString());
            }
            Session["userpass"] = "";
            //Response.Write(Request.Cookies["userInfo"]["RoleID"]);
            JSHelper.WriteScript("top.location.href='" + goUrl + "';");
            //Response.Redirect(goUrl);
        }
    }
}
