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
    public partial class SellList : mypage
    {
        protected string queryStr = string.Empty;
        protected double order_amount_all = 0, order_real_all=0;

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            SiteHelper.GetPageUrlpower("Cashier/SellList.aspx");
            if (Session["PowerRead"].ToString() != "1")
            {
                SiteHelper.NOPowerMessage();
            }
            if (!Page.IsPostBack)
            {
                string act = Request["act"];
                switch (act)
                {
                    case "drop":
                        if (Session["PowerSuper"].ToString() != "1")
                        {
                            SiteHelper.NOPowerMessage();
                        }
                        int shopxpacid = Request.QueryString["id"].IsNumber() ? Convert.ToInt32(Request.QueryString["id"]) : 0;
                        if (shopxpacid <= 0)
                        {
                            JSHelper.WriteScript("alert('数据传递有误');history.back();");
                            return;
                        }
                        SqlHelper helper = LocalSqlHelper.WH;
                        string sql = "select top 1 * from Direct_OrderMain b where warehouse_id=@warehouse_id and shopxpacid=@shopxpacid";
                        helper.Params.Add("@warehouse_id", my_warehouse_id);
                        helper.Params.Add("@shopxpacid", shopxpacid);
                        DataTable dt = helper.ExecDataTable(sql);
                        if (dt.Rows.Count == 0)
                        {
                            JSHelper.WriteScript("alert('订单不存在');history.back();");
                            return;
                        }
                        string dingdan = Convert.ToString(dt.Rows[0]["dingdan"]);

                        if (Convert.ToInt32(dt.Rows[0]["zhuangtai"])!=8)
                        {
                            JSHelper.WriteScript("alert('此订单当前状态不可取消');history.back();");
                            return;
                        }

                        helper.Params.Clear();
                        sql = "select isnull(sum(productcount_return),0) from Direct_OrderDetail where dingdan=@dingdan";
                        helper.Params.Add("@dingdan", dingdan);
                        int check_return_count= Convert.ToInt32(helper.ExecScalar(sql));
                        if (check_return_count>0)
                        {
                            JSHelper.WriteScript("alert('此订单已存在退货商品，不可整单取消');history.back();");
                            return;
                        }

                        //做个日志
                        string DoWhat = "订单号:" + dingdan + ",订单价格:" + dt.Rows[0]["order_amount"]+",操作员："+my_admin_id+"_"+my_admin_name;
                        SiteHelper.writeLog("订单取消", DoWhat);

                        DateTime fksj = Convert.ToDateTime(dt.Rows[0]["fksj"]);
                        int is_today = 0;
                        DateTime qxsj = DateTime.Now;
                        string dingdan_cancel = string.Empty;
                        int zhuangtai = 0;
                        if (fksj.ToShortDateString() == DateTime.Today.ToShortDateString())
                        {
                            dingdan_cancel = dingdan;
                            //同一天的，直接取消
                            zhuangtai = -1; //取消状态
                            is_today = 1;
                        }
                        else
                        {
                            zhuangtai = 9; //取消另生成原单状态
                            //不同天的，生成新的取消订单
                            //生成主订单
                            dingdan_cancel = dt.Rows[0]["dingdan"] + "_cancel";
                            helper.Params.Clear();
                            helper.Params.Add("userid", dt.Rows[0]["userid"]);
                            helper.Params.Add("user_name", dt.Rows[0]["user_name"]);
                            helper.Params.Add("warehouse_id", dt.Rows[0]["warehouse_id"]);
                            helper.Params.Add("store_id", dt.Rows[0]["store_id"]);
                            helper.Params.Add("seller_name", dt.Rows[0]["seller_name"]);
                            helper.Params.Add("dingdan", dingdan_cancel);
                            helper.Params.Add("dingdan_type", dt.Rows[0]["dingdan_type"]);
                            helper.Params.Add("user_type", dt.Rows[0]["user_type"]);
                            helper.Params.Add("order_amount", 0-Convert.ToDouble(dt.Rows[0]["order_amount"]));
                            helper.Params.Add("order_plus", 0 - Convert.ToDouble(dt.Rows[0]["order_plus"]));
                            helper.Params.Add("payment_name", dt.Rows[0]["order_plus"]);
                            helper.Params.Add("usertel", dt.Rows[0]["usertel"]);
                            helper.Params.Add("liuyan", "订单取消");

                            helper.Params.Add("fksj", qxsj);
                            int OrderStatus = 10;//原单取消后生成的新订单
                            helper.Params.Add("fhsj", qxsj);
                            helper.Params.Add("zhuangtai", OrderStatus);
                            helper.Params.Add("guide_id", dt.Rows[0]["guide_id"]);
                            helper.Params.Add("cashier_id", my_admin_id);
                            helper.Insert("Direct_OrderMain");
                        }
                        helper.Params.Clear();
                        helper.Params.Add("@dingdan", dingdan);
                        sql="select * from Direct_OrderDetail where dingdan=@dingdan";
                        dt = helper.ExecDataTable(sql);
                        for (int i = 0; i < dt.Rows.Count; i++)
                        {
                            if (is_today == 0)
                            {
                                helper.Params.Clear();
                                helper.Params.Add("supplierid", dt.Rows[i]["supplierid"]);
                                helper.Params.Add("dingdan", dingdan_cancel);
                                helper.Params.Add("shopxpptid", dt.Rows[i]["shopxpptid"]);
                                helper.Params.Add("style_id", dt.Rows[i]["style_id"]);
                                helper.Params.Add("shopxpptname", dt.Rows[i]["shopxpptname"]);
                                helper.Params.Add("p_size", dt.Rows[i]["p_size"]);
                                helper.Params.Add("txm", dt.Rows[i]["txm"]);
                                helper.Params.Add("productcount",0-Convert.ToInt32(dt.Rows[i]["productcount"]));
                                helper.Params.Add("danjia", dt.Rows[i]["danjia"]);
                                helper.Params.Add("voucher", dt.Rows[i]["voucher"]);
                                helper.Insert("Direct_OrderDetail");
                            }
                            //加回库存
                            StorageHelper.changeStock(my_warehouse_id, Convert.ToInt32(dt.Rows[i]["style_id"]), Convert.ToInt32(dt.Rows[i]["productcount"]), dingdan_cancel, "订单取消");
                        }

                        helper.Params.Clear();
                        helper.Params.Add("zhuangtai", zhuangtai);
                        helper.Params.Add("qxsj", qxsj);
                        helper.Params.Add("shopxpacid", shopxpacid);
                        helper.Update("Direct_OrderMain", "shopxpacid");

                        JSHelper.WriteScript("alert('取消成功');location.href='SellList.aspx';");
                        Response.End();
                        break;


                }
                StorageHelper.BindGuideList(guide_list, 0,my_warehouse_id);
                StorageHelper.BindCashierList(cashier_list, 0, my_warehouse_id);
                BindOrderList(SiteHelper.getPage());
            }
        }
        protected void BindOrderList(int index)
        {
            int count = 0;
            string where = getWhere();
            SqlHelper conn = LocalSqlHelper.WH;
            AspNetPager1.PageSize = 20;
            DataTable dt = conn.TablesPageNew("Direct_OrderMain", "*,cashier_name=isnull((select fullname from wareHouse_Admin where id=Direct_OrderMain.cashier_id),''),guide_name=isnull((select guide_name from Tb_guide_staff where guide_id=Direct_OrderMain.guide_id),'')", "fksj desc", true, AspNetPager1.PageSize, index, where, out count);
            for (int i = 0; i < dt.Rows.Count; i++)
            {

            }
            OrderList.DataShow(dt);
            AspNetPager1.RecordCount = count;
            AspNetPager1.UrlRewritePattern = "SellList.aspx?page={0}&" + queryStr;

            SqlHelper helper = LocalSqlHelper.WH;
            dt = helper.ExecDataTable("select isnull(sum(order_amount),0) as order_real_all,isnull(sum(order_amount+order_plus),0) as order_amount_all from Direct_OrderMain where " + where);
            order_real_all = Convert.ToDouble(dt.Rows[0]["order_real_all"]);
            order_amount_all = Convert.ToDouble(dt.Rows[0]["order_amount_all"]);
        }


        private string getWhere()
        {
            string str_pro_txm = Request["pro_txm"];
            string str_dingdan = Request["dingdan"];
            string int_guide_id = Request["guide_list"];
            string int_cashier_id = Request["cashier_list"];
            string dbl_order_amount0 = Request["order_amount0"];
            string dbl_order_amount1 = Request["order_amount1"];
            queryStr = "pro_txm=" + str_pro_txm + "&dingdan=" + str_dingdan + "&cashier_list=" + int_cashier_id + "&guide_list=" + int_guide_id + "&order_amount0=" + dbl_order_amount0 + "&order_amount1=" + dbl_order_amount1; ;
            StringBuilder where = new StringBuilder("dingdan_type=99");

            //"supplierid=" + my_warehouse_id

            if (str_dingdan.IsNotNullAndEmpty())
            {
                where.AppendFormat(" and dingdan like '%{0}%'", str_dingdan);

            }

            if (str_pro_txm.IsNotNullAndEmpty())
            {
                where.AppendFormat(" and  exists(select txm from Direct_OrderDetail where dingdan=Direct_OrderMain.dingdan and txm like '{0}%' )", str_pro_txm);
            }

            if (int_guide_id.IsNumber())
            {
                guide_list.Text = int_guide_id;
                where.AppendFormat(" and guide_id='{0}'", int_guide_id);
            }
            if (int_cashier_id.IsNumber())
            {
                cashier_list.Text = int_cashier_id;
                where.AppendFormat(" and cashier_id='{0}'", int_cashier_id);
            }


            if (dbl_order_amount0.IsNumber())
            {
                order_amount0.Text = dbl_order_amount0;
                where.AppendFormat(" and order_amount>={0}", dbl_order_amount0);
            }
            if (dbl_order_amount1.IsNumber())
            {
                order_amount1.Text = dbl_order_amount1;
                where.AppendFormat(" and order_amount<={0}", dbl_order_amount1);
            }
            return where.ToString();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string where = getWhere();
            Response.Redirect("SellList.aspx?" + queryStr);
        }

        protected double dispInPrice(object InPrice)
        {
            if (SiteHelper.getReadRightByText("采购价格"))
            {
                return Convert.ToDouble(InPrice);
            }
            else
            {
                return 0;
            }

        }

        protected void Button4_Click(object sender, EventArgs e)
        {
            return;
            string where = getWhere();
            SqlHelper conn = LocalSqlHelper.WH;
            //string sql = "select pro_id,pro_name,pro_code,pro_txm,warehouse_id,pro_supplierid,pro_spec,pro_model,pro_brand,pro_unit,kc_nums,pro_outprice,pro_inprice from View_Product with(nolock) where " + where + " order by pro_id desc";
            string sql = "select pro_id as 商品id,pro_name as 名称,pro_code as 货号,pro_txm as 条码,pro_supplierid as 供应商ID,'' as 供应商,pro_spec as 规格,pro_model as 型号,pro_brand as 品牌,pro_unit as 单位,pro_outprice as 零售价,pro_inprice as 采购价 from Prolist with(nolock) where " + where + " order by pro_id desc";
            DataTable dt = conn.ExecDataTable(sql);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                dt.Rows[i]["供应商"] = Warehousing.Business.StorageHelper.getSupplierName(Convert.ToInt32(dt.Rows[i]["供应商ID"]));
            }
            //PublicHelper.ToExcel(dt, "product_" + DateTime.Now.ToString("yyyyMMddHHmmss"));
            SinoHelper2.ExportHelper.ToExcel(dt, "product_" + DateTime.Now.ToString("yyyyMMddHHmmss"));
            Response.End();
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


    }
}