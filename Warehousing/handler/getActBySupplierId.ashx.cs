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
    /// 根据供应商ID获得相关的采购及申调单
    /// </summary>
    public class getActBySupplierId : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string type = context.Request["type"];
            int sid = context.Request["sid"].IsNumber()?Convert.ToInt32(context.Request["sid"]):0;
            int wid_current = context.Request["wid"].IsNumber() ? Convert.ToInt32(context.Request["wid"]) : 0;
            int wid_active = context.Request["wid2"].IsNumber() ? Convert.ToInt32(context.Request["wid2"]) : 0;
            context.Response.Write(getActStr(type, wid_current, sid, wid_active));

        }

        protected string getActStr(string type, int wid, int sid, int wid_active)
        {
            SqlHelper helper = LocalSqlHelper.WH;
            string sql = string.Empty;
            string skuStr = "";
            if (type == "caigou")
            {
                //申请调货,根据供应商及当前仓获取相关单据
                sql = "select * from Tb_plan_main  where sm_supplierid=" + sid + " order by sm_id desc";
                //sql = "select * from Tb_plan_main  where warehouse_id=" + wid + " and sm_supplierid=" + sid + " order by sm_id desc";
            }
            else
            {
                //采购计划,根据当前仓及申请仓获取相关单据
                sql = "select * from Tb_need_main where warehouse_id=" + wid_active + " and warehouse_id_from=" + wid + " order by sm_id desc";
            }
                DataTable dt = helper.ExecDataTable(sql);
                if (dt.Rows.Count > 0)
                {
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        skuStr += dt.Rows[i]["sm_sn"].ToString() + ",";
                        skuStr += Convert.ToString(dt.Rows[i]["add_time"]);
                        if (i < dt.Rows.Count-1)
                        {
                            skuStr += ";";
                        }
                    }
                }
                else
                {
                    skuStr = "0";

                }
                //SinoHelper2.EventLog.WriteLog(sql);
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