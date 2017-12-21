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
using System.Text;
using Warehousing.Business;

namespace Warehousing.Cashier
{
    public partial class SellReturn : mypage
    {
        protected int shopxpacid = 0;
        
        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            SiteHelper.GetPageUrlpower("Cashier/SellList.aspx");
            if (Session["PowerSuper"].ToString() != "1")
            {
                SiteHelper.NOPowerMessage();
            }
            shopxpacid = Request.QueryString["id"].IsNumber() ? Convert.ToInt32(Request.QueryString["id"]) : 0;

            if (!Page.IsPostBack)
            {


                if (shopxpacid <= 0)
                {
                    JSHelper.WriteScript("alert('数据传递有误');history.back();");
                    return;
                }
                BindOrderList();
            }
        }
        protected void BindOrderList()
        {
            int count = 0;
            string sql = "select * from Direct_OrderMain where shopxpacid=@shopxpacid and warehouse_id=@warehouse_id";
            SqlHelper conn = LocalSqlHelper.WH;
            conn.Params.Add("@shopxpacid",shopxpacid);
            conn.Params.Add("@warehouse_id",my_warehouse_id);
            DataTable dt = conn.ExecDataTable(sql);
            OrderList.DataShow(dt);
        }
      
        protected void OrderList_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if ((e.Item.ItemType == ListItemType.Item) || (e.Item.ItemType == ListItemType.AlternatingItem))
            {
                Repeater rep = (Repeater)e.Item.FindControl("GoodsList");
                DataRowView row = (DataRowView)e.Item.DataItem;
                string dingdan = Convert.ToString(row["dingdan"]);
                SqlHelper conn = LocalSqlHelper.WH;
                conn.Params.Add("@dingdan", dingdan);
                DataTable dt = conn.ExecDataTable("select * from dbo.Direct_OrderDetail where dingdan=@dingdan");
                rep.DataShow(dt);
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string[] arr_detail_id, arr_return_count, arr_can_return;
            arr_detail_id = Request.Form["detail_id"].Split(',');
            arr_can_return = Request.Form["can_return"].Split(',');
            arr_return_count = Request.Form["return_count"].Split(',');
            int checkflag = 0;
            for (int i = 0; i < arr_return_count.Length; i++)
            {
                if (Convert.ToInt32(arr_return_count[i]) > 0)
                {
                    checkflag = 1;
                    break;
                }
            }
            if (checkflag == 0)
            {
                JSHelper.WriteScript("alert('没有设置可退');history.back();");
                return;
            }

            //清空当前退货商品
            string del_sql = "delete from Tb_cashier_cart  where cashier_id=@cashier_id and is_return=1";
            SqlHelper helper = LocalSqlHelper.WH;
            helper.Params.Add("@cashier_id", my_admin_id);
            helper.Execute(del_sql);

            //将退货商品送入购物车！

            for (int i = 0; i < arr_return_count.Length; i++)
            {
                if (Convert.ToInt32(arr_return_count[i]) > Convert.ToInt32(arr_can_return[i]))
                {
                    JSHelper.WriteScript("alert('请求退货数量超出可退数量！');history.back();");
                    Response.End();
                }
                string sql = "select top 1 *,canreturn=productcount-productcount_return from Direct_OrderDetail where id=" + arr_detail_id[i];
                helper.Params.Clear();
                DataTable dt = helper.ExecDataTable(sql);
                if (dt.Rows.Count == 0)
                {
                    JSHelper.WriteScript("alert('商品ID数据传递有误！');history.back();");
                    Response.End();
                }
                if (Convert.ToInt32(dt.Rows[0]["canreturn"]) <= 0)
                {
                    JSHelper.WriteScript("alert('可退数量不量');history.back();");
                    Response.End();
                }

                if (Convert.ToInt32(dt.Rows[0]["canreturn"]) < Convert.ToInt32(arr_return_count[i]))
                {
                    JSHelper.WriteScript("alert('请退数量超额！');history.back();");
                    Response.End();
                }

                helper.Params.Clear();
                helper.Params.Add("cashier_id", my_admin_id);
                helper.Params.Add("trace_id", shopxpacid);
                helper.Params.Add("goods_id", Convert.ToInt32(dt.Rows[0]["shopxpptid"]));
                helper.Params.Add("goods_name", Convert.ToString(dt.Rows[0]["shopxpptname"]));
                helper.Params.Add("txm", Convert.ToString(dt.Rows[0]["txm"]));
                helper.Params.Add("spec_id", dt.Rows[0]["style_id"]);
                helper.Params.Add("specification", dt.Rows[0]["p_size"]);
                helper.Params.Add("price", dt.Rows[0]["danjia"]);
                helper.Params.Add("voucher_price", dt.Rows[0]["voucher"]);
                helper.Params.Add("quantity", 0 - Convert.ToInt32(arr_return_count[i]));
                //helper.Params.Add("goods_image", dt.Rows[0]["goods_image"]);
                helper.Params.Add("is_return", 1);
                helper.Params.Add("order_goods_id", dt.Rows[0]["id"]);
                helper.Insert("Tb_cashier_cart");

               // helper.Params.Clear();
               //helper.Execute("update Direct_OrderDetail set productcount_return=productcount_return+" + arr_return_count[i]+ " where id=" + arr_detail_id[i]);
               // StorageHelper.changeStock(my_warehouse_id, Convert.ToInt32(dt.Rows[i]["style_id"]), Convert.ToInt32(dt.Rows[i]["productcount"]), dingdan_cancel, "订单取消");



            }
            JSHelper.WriteScript("location.href='SellReturnOk.aspx?trace_id=" + shopxpacid + "'");

        }


    }
}