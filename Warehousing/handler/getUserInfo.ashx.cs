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
    /// getUserInfo 的摘要说明
    /// </summary>
    public class getUserInfo : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string usercode = context.Request["usercode"];
            if (usercode.IsNotNullAndEmpty())
            {
                usercode = System.Web.HttpUtility.UrlDecode(usercode, System.Text.UTF8Encoding.UTF8);
            }

            context.Response.Write(myUserInfo(usercode));
        }

        protected string myUserInfo(string usercode)
        {
            string skuStr = "0";
            if (usercode.IsNullOrEmpty())
            {
                return skuStr;
            }
            SqlHelper helper = LocalSqlHelper.WH;
            string sql = string.Empty;

            usercode = usercode.Replace("'", "");
            if (usercode.IsNotNullAndEmpty())
            {

                sql = "select * from Tb_User where user_name like '" + usercode + "' or user_mobile like '" + usercode + "'";
                DataTable dt = helper.ExecDataTable(sql);
                if (dt.Rows.Count > 0)
                {
                    skuStr = dt.Rows[0]["user_name"].ToString() + "\t";
                    skuStr += dt.Rows[0]["True_name"].ToString() + "\t";
                    skuStr += dt.Rows[0]["User_Mobile"].ToString() + "\t";
                    skuStr +=Convert.ToDouble(dt.Rows[0]["Account_money"]).ToString() + "\t";
                    skuStr +=Convert.ToDouble(dt.Rows[0]["Account_score"]).ToString();
                }
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