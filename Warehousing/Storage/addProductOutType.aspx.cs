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
using System.Text;
using Warehousing.Business;

namespace Warehousing.Storage
{
    public partial class addProductOutType : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SiteHelper.CheckLogin();
            SiteHelper.GetPageUrlpower("Storage/ProductOut.aspx");
            if (Session["PowerRead"].ToString() != "1")
            {
                SiteHelper.NOPowerMessage();
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string outType = Request["sm_type"];
            if (outType.IsNullOrEmpty() || !outType.IsNumber())
            {
                JSHelper.WriteScript("alert('请选择出库类型');history.back();");
                Response.End();
            }
            Response.Redirect("addProductOut.aspx?outType=" + outType);
        }
    }
}