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
    /// getSkuByCode 的摘要说明
    /// </summary>
    public class getSkuByCode : IHttpHandler
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

            context.Response.Write(getSkuStr(kw, wid));

        }

        protected string getSkuStr(string kw, string wid)
        {
            SqlHelper helper = LocalSqlHelper.WH;
            string where = "1=1";
            string sql = string.Empty;
            int falgtype = 0;
             kw = kw.Replace("'", "");
             string skuStr = "0";
            if (kw.IsNotNullAndEmpty())
            {
                if (wid.IsNullOrEmpty()|| !wid.IsNumber())
                {
                    wid = "4";
                }
                sql = "select pro_name,pro_code,pro_spec,pro_model,pro_unit,pro_brand,pro_inprice,pro_outprice,kc_nums=kc_nums-do_nums,shelf_no,pro_marketprice,pro_settleprice from View_Product where warehouse_id=" + wid + " and pro_txm like '" + kw + "'";
                DataTable dt = helper.ExecDataTable(sql);
                if (dt.Rows.Count > 0)
                {
                    skuStr = dt.Rows[0]["pro_name"].ToString() + "\t";
                    skuStr += dt.Rows[0]["pro_code"].ToString() + "\t";
                    skuStr += dt.Rows[0]["pro_spec"].ToString() + "\t";
                    skuStr += dt.Rows[0]["pro_model"].ToString() + "\t";
                    skuStr += dt.Rows[0]["pro_brand"].ToString() + "\t";
                    skuStr += dt.Rows[0]["pro_unit"].ToString() + "\t";
                    skuStr += dt.Rows[0]["pro_outprice"].ToString() + "\t";
                    skuStr += Convert.ToDouble(dt.Rows[0]["kc_nums"]).ToString() + "\t";
                    skuStr += Convert.ToString(dt.Rows[0]["shelf_no"]) + "\t";
                    skuStr += dt.Rows[0]["pro_marketprice"].ToString() + "\t";
                    skuStr += dt.Rows[0]["pro_settleprice"].ToString() + "\t";
                    skuStr += dt.Rows[0]["pro_inprice"].ToString();
                }
                    //SinoHelper2.EventLog.WriteLog(sql);
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