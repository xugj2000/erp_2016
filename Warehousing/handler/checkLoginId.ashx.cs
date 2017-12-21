using System;
using System.Collections;
using System.Data;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using SinoHelper2;

namespace Warehousing.handler
{
    /// <summary>
    /// 根据录入操作员ID获知该操作员是否存在
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    public class checkLoginId : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string loginId = context.Request["loginId"];
            if (loginId.IsNotNullAndEmpty())
            {
                string isExist = "0";
                if (SiteHelper.getTrueNameByLoginId(loginId).IsNotNullAndEmpty())
                {
                    isExist = "1"; 
                }

                string JsonStr = "({";
                JsonStr += (char)34 + "isExist" + (char)34 + ":" + (char)34 + isExist + (char)34;
                JsonStr += "})";
                context.Response.Write(JsonStr);
            }
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}
