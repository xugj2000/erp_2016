//跟踪网上在本次打印之前是否有新的取消数据产生,若有，导致本地。
using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using SinoHelper2;
using Maiduo.Service.Interface;

namespace Warehousing.OrderPrint
{
    public partial class getNewCancel : System.Web.UI.Page
    {
        protected SqlHelper sp = LocalSqlHelper.WH;
        protected void Page_Load(object sender, EventArgs e)
        {
            string bigtype = string.Empty;
            string orderstr = string.Empty;
            bigtype =Convert.ToString(Request["bigtype"]);
            if (bigtype.IsNullOrEmpty())
            {
                Response.Write("操作类别有误");
                Response.End();
            }
            orderstr = Convert.ToString(Request["orderstr"]);
            if (orderstr.IsNullOrEmpty())
            {
                Response.Write("订单有误");
                Response.End();
            }
            string[] order = orderstr.Split(',');
            string ordernewstr = string.Empty;
            for (int i = 0; i < order.Length; i++)
            {
                order[i]="'"+order[i]+"'";
                ordernewstr = ordernewstr.IsNullOrEmpty() ? order[i] : ordernewstr + "," + order[i];
            }
            string cancelTable = string.Empty;
            switch (bigtype)
            {
                case "0"://代理
                    cancelTable = "CancelOrder_Agent";
                    break;
                case "1"://分销中心
                    cancelTable = "CancelOrder_Distribution";
                    break;
            }
            //获取所选订单中已取消商品记录

            string sql = "select id from " + cancelTable + " where dingdan in (" + ordernewstr + ")";
            //Response.Write(sql);
            DataTable ds = sp.ExecDataTable(sql);
            string cancelIdStr = string.Empty;
            for (int j = 0; j < ds.Rows.Count; j++)
            {
                cancelIdStr = cancelIdStr.IsNullOrEmpty() ? ds.Rows[j]["id"].ToString() : cancelIdStr + "," + ds.Rows[j]["id"].ToString();
            }

            ///调用远程服务获取时间差内取消订单到本地
            //Response.Write(cancelIdStr);
            getRemoteCancel(ordernewstr, cancelIdStr, Convert.ToInt32(bigtype));


        }

        protected void getRemoteCancel(string orderstr,string cancelidstr,int bigtype)
        {
            string sql=string.Empty;
            int EffectNum = LocalToWebsite.getNoLocalCancelOrder(orderstr, cancelidstr, bigtype);
            if (EffectNum > 0) //若有记录，写入本地表
            {
                //通过存储过程将此中的取消订单获取到本地
                sp.Execute("exec Cancel_From_Server");
                //Response.Write("写入中...");
                JSHelper.WriteAlert("过程中有取消订单,已同步。。");
            }
            else
            {
                Response.Write("无数据...");
            }

        }

    }
}
