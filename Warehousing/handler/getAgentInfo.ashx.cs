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
    ///根据代理号获得订单中最新的相关收货信息，输出json格式
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    public class getAgentInfo : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string agentId = context.Request["agentid"];
            if (agentId.IsNotNullAndEmpty())
            {
                string shouhuoname = string.Empty;
                string province = string.Empty;
                string city = string.Empty;
                string xian = string.Empty;
                string shopxp_shdz = string.Empty;
                string usertel = string.Empty;

                string sql = "select top 1 shouhuoname,province,city,xian,shopxp_shdz,usertel from Order_Agent_Main where userid=@userid order by shopxpacid desc";
                SqlHelper sp = LocalSqlHelper.WH;
                sp.Params.Add("@userid", agentId);
                DataTable dt = sp.ExecDataTable(sql);
                if (dt.Rows.Count ==0)
                {
                    sp.Params.Clear();
                    sql = "select top 1 shouhuoname,province,city,xian,shopxp_shdz,usertel from Order_Agent_Main where userid=@userid order by shopxpacid desc";
                    sp.Params.Add("@userid", agentId);
                    dt = sp.ExecDataTable(sql);
                }

                if (dt.Rows.Count > 0)
                {
                    shouhuoname = dt.Rows[0]["shouhuoname"].ToString();
                    province = Convert.ToString(dt.Rows[0]["province"]);
                    city = Convert.ToString(dt.Rows[0]["city"]);
                    xian = Convert.ToString(dt.Rows[0]["xian"]);
                    shopxp_shdz = Convert.ToString(dt.Rows[0]["shopxp_shdz"]);
                    usertel = Convert.ToString(dt.Rows[0]["usertel"]);
                }

                    string  JsonStr="({";
                    JsonStr += (char)34 + "shouhuoname" + (char)34 + ":" + (char)34 + shouhuoname +(char)34 +",";
                    JsonStr += (char)34 + "province" + (char)34 + ":" + (char)34 + province + (char)34 + ",";
                    JsonStr += (char)34 + "city" + (char)34 + ":" + (char)34 + city + (char)34 + ",";
                    JsonStr += (char)34 + "xian" + (char)34 + ":" + (char)34 + xian + (char)34 + ",";
                    JsonStr += (char)34 + "usertel" + (char)34 + ":" + (char)34 + usertel + (char)34 + ",";
                    JsonStr += (char)34 + "shopxp_shdz" + (char)34 + ":" + (char)34 + shopxp_shdz + (char)34;
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
