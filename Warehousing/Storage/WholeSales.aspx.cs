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
    public partial class WholeSales : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            SiteHelper.CheckLogin();
            SiteHelper.GetPageUrlpower("Storage/WholeSales.aspx");
            if (Session["PowerRead"].ToString() != "1")
            {
                SiteHelper.NOPowerMessage();
            }
            Response.Redirect("addProductOut.aspx?outType=" + (int)StorageType.批发出库);
        }
    }
}