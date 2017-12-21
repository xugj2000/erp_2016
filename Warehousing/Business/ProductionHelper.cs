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
using Warehousing.Model;
using System.Text.RegularExpressions;

namespace Warehousing.Business
{
    public class ProductionHelper
    {
        public static string getFactoryName(int FactoryId)
        {
            SqlHelper conn = LocalSqlHelper.WH;
            string FactoryName = Convert.ToString(conn.ExecScalar("select supplier_name from supplier with(nolock) where id=" + FactoryId.ToString()));
            FactoryName = FactoryName.IsNullOrEmpty() ? "所有" : FactoryName;
            return FactoryName;
        }

        public static void BindFactoryList(DropDownList DownList, int ft_id)
        {
            string sql = "SELECT id,supplier_name FROM supplier where IsFactory=1 order by id";
            SqlHelper helper = LocalSqlHelper.WH;
            DataTable dt = helper.ExecDataTable(sql);
            BindingHelper.BindDDL(DownList, dt, "supplier_name", "id", false);
            DownList.SelectedValue = ft_id.ToString();
        }

        public static string getWorkStatusText(int WorkStatus)
        {
            string WorkStatusText = string.Empty;
            switch (WorkStatus)
            {
                case 0:
                    WorkStatusText = "待处理";
                    break;
                case 1:
                    WorkStatusText = "工单确认";
                    break;
                case 4:
                    WorkStatusText = "成品返库";
                    break;
                case 2:
                    WorkStatusText = "作废";
                    break;
                case 3:
                    WorkStatusText = "送厂加工";
                    break;
                case 8:
                    WorkStatusText = "工单结束";
                    break;
            }

            return WorkStatusText;
        }
        /// <summary>
        /// 获取新的返货订单号
        /// </summary>
        /// <returns></returns>
        public static string genProductionSn()
        {
            SqlHelper sp = LocalSqlHelper.WH;
            string sql, OrderId;
            //订单生成
            sql = "update liushuihao set WorkingSn=WorkingSn+1";
            sp.Execute(sql);
            OrderId = sp.ExecScalar("select WorkingSn from liushuihao").ToString();
            string dateStr = DateTime.Today.ToString("yyMMdd");
            OrderId = "WK" + dateStr + (100000 + Convert.ToInt32(OrderId)).ToString().Substring(1, 5);
            return OrderId;
        }

        public static double getAlreadyPayMoney(int sm_id)
        {

            return StorageHelper.getAlreadyPayMoney(sm_id, "process");
        }

    }
}