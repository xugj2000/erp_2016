using System;
using System.Data;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using SinoHelper2;

namespace Warehousing.Business
{
    /// <summary>
    /// 返货商品的处理状态
    /// </summary>
    public enum GoodsReturnStatus
    {
        本仓初始状态=0,
        另仓调入待审核=1,
        另仓调入已确认=2,
        另仓调入已退回 = 3,
        返货待处理=4,
        商品已返厂 = 5,
        在库维修 = 7,
        取消入库 = 9,
        等待发货=6,
        订单提交=8,
        取消提交=11,
        发货完成 = 10,
        入库返币=12,
        有订单调换=13,
        无订单调换=14,
        确定调换=15,
        厂家直接发货 = 16,
        原货返回=17
    }

    /// <summary>
    /// 返货订单状态
    /// </summary>
    public enum OrderRetusStatus
    {
        订单待打印= 0,
        订单已发货=3,
        订单取消=4
    }

    public class GoodsReturnHelper
    {

        /// <summary>
        /// 根据返货商品状态数值获得状态名称
        /// </summary>
        /// <param name="Status"></param>
        /// <returns></returns>
        public static string getStutusText(int Status)
        {
            GoodsReturnStatus col = (GoodsReturnStatus)Status;
            return col.ToString();
        }

        /// <summary>
        /// 根据返货订单状态数值获得状态名称
        /// </summary>
        /// <param name="Status"></param>
        /// <returns></returns>
        public static string getOrderStutusText(int Status)
        {
            OrderRetusStatus col = (OrderRetusStatus)Status;
            return col.ToString();
        }

        /// <summary>
        /// 获取新的返货订单号
        /// </summary>
        /// <returns></returns>
        public static string genReturnGoodsOrderId()
        {
                SqlHelper sp = LocalSqlHelper.WH;
                string sql, OrderId;
                //订单生成
                sql = "update liushuihao set ReturnOrderId=ReturnOrderId+1";
                sp.Execute(sql);
                OrderId = sp.ExecScalar("select ReturnOrderId from liushuihao").ToString();
                string dateStr = DateTime.Today.ToString("yyMMdd");
            OrderId = "RG" + dateStr + (100000 + Convert.ToInt32(OrderId)).ToString().Substring(1, 5) + "B";
            return OrderId;
        }

        /// <summary>
        /// 用返货商品状态捆绑至dropdownlist
        /// </summary>
        /// <param name="ddl"></param>
        public static void bindDDLByGoodsStatus(DropDownList ddl)
        {
            int[] values = (int[])Enum.GetValues(typeof(GoodsReturnStatus));
            for (int i = 0; i < values.Length; i++)
            {
                ddl.Items.Add(new ListItem(((GoodsReturnStatus)values[i]).ToString(), values[i].ToString()));
            }
        }

        /// <summary>
        /// 用返货订单状态捆绑dropdownlist
        /// </summary>
        /// <param name="ddl"></param>
        public static void bindDDLByOrderStatus(DropDownList ddl)
        {
            int[] values = (int[])Enum.GetValues(typeof(OrderRetusStatus));
            for (int i = 0; i < values.Length; i++)
            {
                ddl.Items.Add(new ListItem(((OrderRetusStatus)values[i]).ToString(), values[i].ToString()));
            }
        }

        //判断是否是调换商品
        public static string checkIsChange(object ChangeFlag)
        {
            string IsChangeText = string.Empty;
            if (Convert.ToInt32(ChangeFlag) > 0)
            {
                IsChangeText = "<font color=green>[调换品]</font>";
            }
            if (Convert.ToInt32(ChangeFlag) == -1)
            {
                IsChangeText = "<font color=red>[被调换]</font>";
            }
            return IsChangeText;
        }

    }
}
