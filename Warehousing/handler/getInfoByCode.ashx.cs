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
    /// getInfoByCode 的摘要说明
    /// </summary>
    public class getInfoByCode : IHttpHandler
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
            SqlHelper conn = LocalSqlHelper.WH;
            string sql = string.Empty;
            kw = kw.Replace("'", "");
            string skuStr = "0";
            if (kw.IsNotNullAndEmpty())
            {
                if (wid.IsNullOrEmpty() || !wid.IsNumber())
                {
                    wid = "0";
                }
                sql = "select pro_id,pro_name,pro_code,pro_spec,pro_model,pro_unit,pro_brand,pro_inprice,pro_outprice,pro_supplierid,pro_marketprice,pro_settleprice from Prolist where pro_txm like '" + kw + "'";
                DataTable dt = helper.ExecDataTable(sql);
                if (dt.Rows.Count > 0)
                {
                    skuStr = dt.Rows[0]["pro_name"].ToString() + ",";
                    skuStr += dt.Rows[0]["pro_code"].ToString() + ",";
                    skuStr += dt.Rows[0]["pro_spec"].ToString() + ",";
                    skuStr += dt.Rows[0]["pro_model"].ToString() + ",";
                    skuStr += dt.Rows[0]["pro_brand"].ToString() + ",";
                    skuStr += dt.Rows[0]["pro_unit"].ToString() + ",";
                    skuStr += dt.Rows[0]["pro_outprice"].ToString() + ",";
                    skuStr += dt.Rows[0]["pro_inprice"].ToString() + ",";
                    conn.Params.Clear();
                    conn.Params.Add("@pro_id", dt.Rows[0]["pro_id"].ToString());
                    conn.Params.Add("@warehouse_id", wid);
                    string shelf_no = Convert.ToString(conn.ExecScalar("select shelf_no from ProductStock where pro_id=@pro_id and warehouse_id=@warehouse_id"));
                    skuStr += shelf_no + ",";
                    skuStr += dt.Rows[0]["pro_marketprice"].ToString() + ",";
                    skuStr += dt.Rows[0]["pro_settleprice"].ToString() + ",";
                    skuStr += Convert.ToString(dt.Rows[0]["pro_supplierid"]);
                    
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