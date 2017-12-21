//解决当前打印数据后同步远程数据，避免本地已打单发货，而网上继续进行发货前取消操作的情况！
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
    public partial class SendPrintToWeb : System.Web.UI.Page
    {
        protected SqlHelper helper = LocalSqlHelper.WH;
        protected void Page_Load(object sender, EventArgs e)
        {
            SendOrderPrintInfo();
            Response.Write("实时反馈打印数据成功!");
        }

        /// <summary>
        /// 将订单打印相关数据反馈回WEB数据库
        /// </summary>
        void SendOrderPrintInfo()
        {
            #region
            string sql = "select Id,Shopxpacid,BigType,OrderSn,DeliverTime,DeliverOpMan,DeliverMessage,DeliverReplay,LiuShuiHao,UserId from DeliverGoodsOrder where  RemoteFlag=2";
            DataTable ds = helper.ExecDataTable(sql);
            for (int i = 0; i < ds.Rows.Count; i++)
            {
                if (Convert.ToInt32(ds.Rows[i]["BigType"]) == 2)
                {
                    //直营
                    LocalToWebsite.getDirectOrderPost(Convert.ToInt32(ds.Rows[i]["Shopxpacid"]), ds.Rows[i]["UserId"].ToString(), ds.Rows[i]["OrderSn"].ToString(), Convert.ToDateTime(ds.Rows[i]["DeliverTime"]));
                }
                else
                { //自营
                    LocalToWebsite.SendOrderPrintInfo(Convert.ToInt16(ds.Rows[i]["BigType"]), ds.Rows[i]["OrderSn"].ToString(), ds.Rows[i]["LiuShuiHao"].ToString(), ds.Rows[i]["DeliverTime"].ToString(), ds.Rows[i]["DeliverOpMan"].ToString(), ds.Rows[i]["DeliverMessage"].ToString(), ds.Rows[i]["DeliverReplay"].ToString());
                }
                helper.Execute("update DeliverGoodsOrder set RemoteFlag=1 where Id=" + ds.Rows[i]["Id"].ToString());
            }
            #endregion
        }
    }
}
