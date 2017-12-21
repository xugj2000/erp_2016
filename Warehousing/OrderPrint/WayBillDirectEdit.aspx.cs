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

namespace Warehousing.OrderPrint
{
    public partial class WayBillDirectEdit : System.Web.UI.Page
    {
        protected string OrderId = "0";
        protected string fromUrl = string.Empty;
        protected string dingdan = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            SiteHelper.CheckLogin();
            SiteHelper.GetPageUrlpower("OrderPrint/WaybillForDirect.aspx");
            if (Session["PowerRead"].ToString() != "1")
            {
                SiteHelper.NOPowerMessage();
            }
            OrderId = Request["id"];
            if (!OrderId.IsNumber())
            {
                OrderId = "0";
            }

            if (!IsPostBack)
            {
                SqlHelper sp = LocalSqlHelper.WH;
                string sql = "select a.dingdan,a.ShippingCompany,a.AWB_No,a.ShippingPhone,a.SupplierRemark from Direct_OrderMain a  where a.shopxpacid in (" + OrderId + ")";
                DataTable gdDt = sp.ExecDataTable(sql);
                if (gdDt.Rows.Count > 0) //修改时
                {
                    lbOrderSn.Text = gdDt.Rows[0]["dingdan"].ToString();
                    txtExpressName.Text = gdDt.Rows[0]["ShippingCompany"].ToString();
                    txtWaybill.Text = gdDt.Rows[0]["AWB_No"].ToString();
                    txtExpressTel.Text = gdDt.Rows[0]["ShippingPhone"].ToString();
                    txtMsg.Text = gdDt.Rows[0]["SupplierRemark"].ToString();
                    fromUrl = Request.ServerVariables["HTTP_REFERER"];
                    dingdan = gdDt.Rows[0]["dingdan"].ToString();
                }
                else
                {
                    JSHelper.WriteScript("alert('数据有误');history.back();");
                    Response.End();   
                }
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string ExpressName = Request["txtExpressName"];
                string Waybill = Request["txtWaybill"];
                string ExpressTel = Request["txtExpressTel"];
                string Msg = Request["txtMsg"];
                if (ExpressName.IsNullOrEmpty())
                {
                    JSHelper.WriteScript("alert('物流公司不能为空');history.back();");
                    Response.End();
                }
                if (Waybill.IsNullOrEmpty())
                {
                    JSHelper.WriteScript("alert('货运单号不能为空');history.back();");
                    Response.End();
                }

                string sql = string.Empty;
                sql = "update Direct_OrderMain set ShippingCompany=@ShippingCompany,AWB_No=@AWB_No,ShippingPhone=@ShippingPhone,SupplierRemark=@SupplierRemark where shopxpacid in (" + OrderId + ")";
                SqlHelper sp = LocalSqlHelper.WH;
                sp.Params.Add("@ShippingCompany", ExpressName);
                sp.Params.Add("@AWB_No", Waybill);
                sp.Params.Add("@ShippingPhone", ExpressTel);
                sp.Params.Add("@SupplierRemark", Msg);

                sp.Execute(sql);
                dingdan=lbOrderSn.Text;
                string dowhat = "直营订单：" + dingdan + ",物流公司:" + ExpressName + ",运单号:" + Waybill + ",物流公司电话:" + ExpressTel + ",备注:" + Msg;
                Warehousing.SiteHelper.writeLog("直营运单录入", dowhat);

                //设定需回传信息票识
                sp.Execute("update DeliverGoodsOrder set RemoteFlag=3 where BigType=2 and Shopxpacid in (" + OrderId + ")");
                string url = Request["fromUrl"];
                JSHelper.WriteScript("alert('货运单录入成功');location.href='" + url + "'");
            }
        }
    }
}
