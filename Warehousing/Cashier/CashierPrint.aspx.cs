using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using SinoHelper2;
using Warehousing.Business;

namespace Warehousing.Cashier
{
    public partial class CashierPrint : mypage
    {

        protected string PrintTitle = string.Empty, PrintMessage=string.Empty;
        protected string dingdan=string.Empty;
        protected int count = 0;
        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                PrintTitle = "购物小票";
                PrintMessage = "购物小票";
                SqlHelper helper = LocalSqlHelper.WH;
                if (Request.QueryString["dingdan"].IsNullOrEmpty())
                {
                    JSHelper.WriteScript("alert('订单号不能为空');history.back();");
                    return;
                }
                dingdan = Request.QueryString["dingdan"].Trim();
                if (dingdan.IsNullOrEmpty())
                {
                    JSHelper.WriteScript("alert('订单号不能为空');history.back();");
                    return;
                }
                 PrintMessage = "<table align=center>";
                 PrintMessage += "<tr><td colspan=2>商品清单</td></tr>";
                 PrintMessage += "<tr><td colspan=2 style='text-align:left;'>商品名称	数量		单价		成交价</td></tr>";
                 string sql = "select top 1 *,cashier_name=isnull((select fullname from wareHouse_Admin where id=b.cashier_id),''),guide_name=isnull((select guide_name from Tb_guide_staff where guide_id=b.guide_id),'') from Direct_OrderMain b where dingdan=@dingdan";
                helper.Params.Add("@dingdan", dingdan);
                DataTable dt_main = helper.ExecDataTable(sql);
                if (dt_main.Rows.Count==0)
                {
                    JSHelper.WriteScript("alert('订单号有误');history.back();");
                    return;
                }

                helper.Params.Clear();
                sql = "select * from Direct_OrderDetail where dingdan=@dingdan";
                helper.Params.Add("@dingdan", dingdan);
                DataTable dt = helper.ExecDataTable(sql);
                if (dt.Rows.Count == 0)
                {
                    JSHelper.WriteScript("alert('订单号有误');history.back();");
                    return;
                }
                 count = dt.Rows.Count;
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    PrintMessage += "<tr><td colspan=2 style='text-align:left;'>" + dt.Rows[i]["shopxpptname"] + dt.Rows[i]["p_size"] + "<br>";
                    PrintMessage += "<div style='text-align:right;'>" + dt.Rows[i]["productcount"] + "&nbsp;&nbsp;" + dt.Rows[i]["danjia"] + "&nbsp;&nbsp;" + Convert.ToDouble(dt.Rows[i]["danjia"]) * Convert.ToDouble(dt.Rows[i]["productcount"]) + "</div></td></tr>";

                }
                PrintMessage += "<tr><td>商品总额</td><td>&nbsp;" + (Convert.ToDouble(dt_main.Rows[0]["order_amount"]) + Convert.ToDouble(dt_main.Rows[0]["order_plus"])) + "</td></tr>";
                PrintMessage += "<tr><td>优惠金额</td><td>&nbsp;" + dt_main.Rows[0]["order_plus"] + "</td></tr>";
                PrintMessage += "<tr><td>实收金额</td><td>&nbsp;" + dt_main.Rows[0]["order_amount"] + "</td></tr>";
                PrintMessage += "<tr><td colspan=2>--------------</td></tr>";
                //PrintMessage += "<tr><td colspan=2>结算详情</td></tr>";
                PrintMessage += "<tr><td>会员标识</td><td>&nbsp;" + dt_main.Rows[0]["user_name"] + "</td></tr>";

                PrintMessage += "<tr><td colspan=2>--------------</td></tr>";
                if (Convert.ToString(dt_main.Rows[0]["liuyan"]).IsNotNullAndEmpty()) {
                    PrintMessage += "<tr><td>消费备注</td><td>" + Convert.ToString(dt_main.Rows[0]["liuyan"]) + "</td></tr>";
                }
                PrintMessage += "<tr><td colspan=2>消费单号:" + dt_main.Rows[0]["dingdan"] + "</td></tr>";

                PrintMessage += "<tr><td colspan=2>购物时间:" + dt_main.Rows[0]["fksj"] + "</td></tr>";
                PrintMessage += "<tr><td colspan=2>*7天内商品无损可退换*</td></tr>";
                //PrintMessage += "<tr><td colspan=2>收银:" + dt_main.Rows[0]["cashier_name"] + ",导购:" + dt_main.Rows[0]["guide_name"] + "</td></tr>";
                PrintMessage += "<tr><td colspan=2>收银:" + dt_main.Rows[0]["cashier_name"] + "</td></tr>";
                PrintMessage += "<tr><td colspan=2>" + myStorageInfo.warehouse_name + "谢谢光临" + myStorageInfo.warehouse_tel+ "</td></tr>";
                PrintMessage += "<tr><td colspan=2>打单:" + DateTime.Now + "</td></tr>";
                PrintMessage += "<tr><td colspan=2 style='height:40px'>&nbsp;&nbsp;<img src='/images/rr.jpg' width=100 height=100/></td></tr>";
                PrintMessage += "<tr><td colspan=2>--</td></tr>";
                PrintMessage += "</table>";
            }
        }
    }
}