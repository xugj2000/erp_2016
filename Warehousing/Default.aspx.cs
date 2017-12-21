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
using System.Security.Cryptography;

namespace Warehousing
{
    public partial class _Default : System.Web.UI.Page
    {
        protected string thistime = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            thistime=DateTime.Now.ToString();
            Response.Write(System.Configuration.ConfigurationManager.AppSettings["stopflag"]);
          //  RSACryptoServiceProvider rsa = new RSACryptoServiceProvider();

            //生成公钥XML字符串  
          //  string publicKeyXmlString = rsa.ToXmlString(false);
            //生成私钥XML字符串  
          //  string privateKeyXmlString = rsa.ToXmlString(true);
          //  Response.Write(publicKeyXmlString + "," + privateKeyXmlString);

        }
    }
}
