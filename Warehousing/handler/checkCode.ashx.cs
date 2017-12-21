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
    /// checkCode 的摘要说明
    /// </summary>
    public class checkCode : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string kw = context.Request["q"];
            string wid = context.Request["wid"];
            if (kw.IsNotNullAndEmpty())
            {
                kw = System.Web.HttpUtility.UrlDecode(kw, System.Text.UTF8Encoding.UTF8);
            }

            context.Response.Write(getCodeStr(kw));

        }

        protected string getCodeStr(string kw)
        {
            SqlHelper helper = LocalSqlHelper.WH;
            string sql = string.Empty;
            kw = kw.Replace("'", "");
            string skuStr = "0";
            if (kw.IsNotNullAndEmpty())
            {
                sql = "select pro_name,pro_code,pro_unit,pro_brand from ProductMain where pro_code like '" + kw + "'";
                DataTable dt = helper.ExecDataTable(sql);
                if (dt.Rows.Count > 0)
                {
                    skuStr = dt.Rows[0]["pro_name"].ToString() + "\t";
                    skuStr += dt.Rows[0]["pro_code"].ToString() + "\t";
                    skuStr += dt.Rows[0]["pro_brand"].ToString() + "\t";
                    skuStr += dt.Rows[0]["pro_unit"].ToString() + "\t";
                }
                SinoHelper2.EventLog.WriteLog(sql);
            }
            return skuStr;
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