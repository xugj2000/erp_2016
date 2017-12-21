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
    public partial class Admin : mypage
    {
        protected string TrueName = string.Empty;
        protected string  LoginName=string.Empty;
        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.Cookies["userInfo"]["TrueName"].IsNotNullAndEmpty())
            {
                TrueName =HttpUtility.UrlDecode(Convert.ToString(Request.Cookies["userInfo"]["TrueName"]));
            }
            else
            {
                TrueName = Convert.ToString(Request.Cookies["userInfo"]["LoginName"]);
            }
            LoginName = Convert.ToString(Request.Cookies["userInfo"]["LoginName"]);
        }
    }
}