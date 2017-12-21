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
    public partial class SellGoods : mypage
    {
        protected SqlHelper helper = LocalSqlHelper.WH;
        protected int id = 0;
        protected int trace_id = 0;
        protected double total_money = 0, total_goods = 0;

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            SiteHelper.GetPageUrlpower("Cashier/SellGoods.aspx");
            if (Session["PowerRead"].ToString() != "1")
            {
                SiteHelper.NOPowerMessage();
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            id = Convert.ToInt32(Request["id"]);
            if (!Page.IsPostBack)
            {
                
                trace_id=Request.QueryString["trace_id"].IsNumber()?Convert.ToInt32(Request.QueryString["trace_id"]):0;
                string act = Request["act"];
                int rec_id = 0;
                switch (act)
                {
                    case "add":
                        string txm = Request.QueryString["product_sn"];
                        int flag=-1;
                        if (txm.IsNullOrEmpty())
                        {
                            JSHelper.WriteScript("alert('条码不能为空');history.back();");
                            return;
                        }
                        flag = add_into_cart(txm, trace_id);
                        switch (flag)
                        {
                           case  1:
                            JSHelper.WriteScript("alert('提交成功');location.href='SellGoods.aspx'");
                            return;
                            break;
                           case 0:
                            JSHelper.WriteScript("alert('条码不存在');history.back();");
                            return;
                            break;
                        }
                        break;
                    case "del":
                       
                        rec_id = Request.QueryString["rec_id"].IsNumber() ? Convert.ToInt32(Request.QueryString["rec_id"]) : 0;
                        string del_sql = "delete from Tb_cashier_cart  where cashier_id=@cashier_id and rec_id=@rec_id";
                        helper.Params.Add("@cashier_id", my_admin_id);
                        helper.Params.Add("@rec_id", rec_id);
                        helper.Execute(del_sql);
                        JSHelper.WriteScript("alert('移除成功');location.href='SellGoods.aspx'");
                        return;
                        break;
                    case "update":
                        int quantity = 0;
                        rec_id = Request.QueryString["rec_id"].IsNumber() ? Convert.ToInt32(Request.QueryString["rec_id"]) : 0;
                        quantity = Request.QueryString["quantity"].IsNumber() ? Convert.ToInt32(Request.QueryString["quantity"]) : 0;
                        if (rec_id == 0 || quantity == 0)
                        {
                           
                            Response.Write(0);
                            Response.End();
                            return;
                        }
                        update_cart(rec_id, quantity);
                        string Sql_new = "select sum(price*quantity) from Tb_cashier_cart where cashier_id=@cashier_id and trace_id=@trace_id";
                        helper.Params.Add("@cashier_id", my_admin_id);
                        helper.Params.Add("@trace_id", trace_id);
                        Response.Write(Convert.ToDouble(helper.ExecScalar(Sql_new)));
                        Response.End();
                        break;
                    case "hang":
                        int new_trace_id = 0;
                        Random r = new Random();
                        int new_flag = 0;
                        while (new_flag == 0)
                        {
                            new_trace_id = Convert.ToInt32(my_admin_id.ToString() + r.Next(1000, 9999).ToString());
                            string check_sql = "select top 1 trace_id from Tb_cashier_cart where trace_id=@trace_id";
                            helper.Params.Add("@trace_id", new_trace_id);
                            DataTable check_dt = helper.ExecDataTable(check_sql);
                            if (check_dt.Rows.Count == 0)
                            {
                                new_flag = 1;
                            }
                        }

                        string hang_sql = "update Tb_cashier_cart set trace_id=" + new_trace_id + "  where cashier_id=@cashier_id and is_return=0 and trace_id=0";
                        helper.Params.Add("@cashier_id", my_admin_id);
                        helper.Execute(hang_sql);
                         JSHelper.WriteScript("alert('挂起成功');location.href='SellGoods.aspx'");
                        return;
                        break;

                }
                Session["anti_refresh"] = "1";

                string Sql = "select *,sales=price*quantity from Tb_cashier_cart where cashier_id=@cashier_id and is_return=0 and trace_id=@trace_id";
                helper.Params.Add("@cashier_id", my_admin_id);
                helper.Params.Add("@trace_id", trace_id);
                DataTable dt = helper.ExecDataTable(Sql);
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    total_money += Convert.ToDouble(dt.Rows[i]["sales"]);
                    total_goods += Convert.ToDouble(dt.Rows[i]["quantity"]);
                }
                GoodsList.DataShow(dt);
                Sql = "select trace_id from Tb_cashier_cart where cashier_id=@cashier_id and is_return=0 and trace_id>0 group by trace_id";
                dt = helper.ExecDataTable(Sql);
                if (dt.Rows.Count == 0)
                {
                    HangList.Visible = false;
                }
                else
                {
                    HangList.DataShow(dt);
                }
                //产品，增加，修改，删除
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (Session["anti_refresh"] != "1")
            {
                //  JSHelper.WriteScript("alert('请勿重复提交');history.back();");
                //  Response.End();
            }
            Session["anti_refresh"] = "0";

            helper.Params.Clear();
            helper.Params.Add("sm_type", Request["sm_type"]);
            helper.Params.Add("warehouse_id", Request["from_warehouse_id"]);
            helper.Params.Add("sm_date", Request["sm_date"]);
            helper.Params.Add("relate_sn", Request["relateActive"]);
            helper.Params.Add("sm_direction", "出库");

            if (id == 0)
            {
                string p_name = Request.Form["p_name"];
                string[] arr_p_name = Request.Form["p_name"].Split(',');
                string[] arr_p_serial = Request.Form["p_serial"].Split(',');
                string[] arr_p_txm = Request.Form["p_txm"].Split(',');
                string[] arr_p_brand = Request.Form["p_brand"].Split(',');
                string[] arr_p_unit = Request.Form["p_unit"].Split(',');
                string[] arr_p_spec = Request.Form["p_spec"].Split(',');
                string[] arr_p_model = Request.Form["p_model"].Split(',');
                string[] arr_p_quantity = Request.Form["p_quantity"].Split(',');
                string[] arr_p_price = Request.Form["p_price"].Split(',');
                string[] arr_p_box = Request.Form["p_box"].Split(',');
                if (p_name.IsNotNullAndEmpty())
                {
                    for (int i = 0; i < arr_p_name.Length; i++)
                    {
                        if (arr_p_txm[i].IsNotNullAndEmpty() && arr_p_name[i].IsNotNullAndEmpty())
                        {
                            bool isEnough = StorageHelper.checkOneStockIsEnough(arr_p_txm[i], Convert.ToInt32(Request["from_warehouse_id"]), Convert.ToInt32(arr_p_quantity[i]));
                            //Response.Write(arr_p_quantity[i]);
                            if (!isEnough)
                            {
                                JSHelper.WriteScript("alert('" + arr_p_txm[i] + "对应商品库存不足！');history.back();");
                                Response.End();
                            }
                        }
                    }
                }

                helper.Params.Add("sm_sn", StorageHelper.getNewChurukuHao("CK"));
                helper.Params.Add("sm_adminid", HttpContext.Current.Session["ManageUserId"].ToString());
                try
                {
                    helper.Insert("Tb_storage_main");

                }
                catch
                {
                    JSHelper.WriteScript("alert('出库单号已有记录，不能重复！');history.back();");
                    Response.End();
                }
                int sm_id = Convert.ToInt32(helper.ExecScalar("select top 1 sm_id from Tb_storage_main order by sm_id desc"));
                string from_direct_id = Request["direct_id"];
                if (from_direct_id.IsNotNullAndEmpty() && from_direct_id.IsNumber())
                {
                    helper.Params.Clear();
                    helper.Execute("update Tb_storage_main set is_direct=" + sm_id + " where sm_id=" + from_direct_id);
                }
                if (p_name.IsNotNullAndEmpty())
                {
                    for (int i = 0; i < arr_p_name.Length; i++)
                    {
                        if (arr_p_txm[i].IsNotNullAndEmpty() && arr_p_name[i].IsNotNullAndEmpty())
                        {
                            helper.Params.Clear();
                            helper.Params.Add("sm_id", sm_id);
                            helper.Params.Add("p_name", arr_p_name[i]);
                            helper.Params.Add("p_serial", arr_p_serial[i]);
                            helper.Params.Add("p_txm", arr_p_txm[i].Trim());
                            helper.Params.Add("p_brand", arr_p_brand[i]);
                            helper.Params.Add("p_unit", arr_p_unit[i]);
                            helper.Params.Add("p_spec", arr_p_spec[i]);
                            helper.Params.Add("p_model", arr_p_model[i]);
                            helper.Params.Add("p_quantity", arr_p_quantity[i].IsNumber() ? arr_p_quantity[i] : "0");
                            helper.Params.Add("p_price", arr_p_price[i].IsNumber() ? arr_p_price[i] : "0");
                            helper.Params.Add("p_box", arr_p_box[i]);
                            helper.Insert("Tb_storage_product");
                        }

                    }
                }
            }
            else
            {
                helper.Params.Add("sm_id", id);
                helper.Update("Tb_storage_main", "sm_id");
            }
            JSHelper.WriteScript("alert('编辑成功');location.href='ProductOut.aspx';");
            //Response.Write(RoleList.Text);
            Response.End();
        }


        protected int add_into_cart(string txm, int trace_id)
        {
            SqlHelper helper_price = LocalSqlHelper.WH;

            string sql = "select top 1 * from Prolist with(nolock) where pro_txm=@pro_txm";
            helper.Params.Add("pro_txm",txm);
            DataTable dt = helper.ExecDataTable(sql);
            int pro_id = 0;
            if (dt.Rows.Count == 0)
            {
                return 0;
            }
            pro_id = Convert.ToInt32(dt.Rows[0]["pro_id"]);
            helper.Params.Clear();
            helper.Params.Add("@cashier_id", my_admin_id);
            helper.Params.Add("@trace_id", trace_id);
            helper.Params.Add("@pro_id", pro_id);
            sql = "select rec_id from Tb_cashier_cart with(nolock) where cashier_id=@cashier_id and trace_id=@trace_id and spec_id=@pro_id";
            DataTable dt_cart = helper.ExecDataTable(sql);
            helper.Params.Clear();
            if (dt_cart.Rows.Count > 0)
            {
                //更新

                helper.Execute("update Tb_cashier_cart set quantity=quantity+1 where rec_id=" + dt_cart.Rows[0]["rec_id"]);
            }
            else
            {
                helper.Params.Add("cashier_id",my_admin_id);
                helper.Params.Add("trace_id", trace_id);
                helper.Params.Add("goods_id",Convert.ToInt32(dt.Rows[0]["pm_id"]));
                helper.Params.Add("goods_name",Convert.ToString(dt.Rows[0]["pro_name"]));
                helper.Params.Add("txm", txm);
                helper.Params.Add("spec_id",Convert.ToInt32(dt.Rows[0]["pro_id"]));
                helper.Params.Add("specification",Convert.ToString(dt.Rows[0]["pro_spec"])+Convert.ToString(dt.Rows[0]["pro_model"]));
                double pro_outprice = Convert.ToDouble(dt.Rows[0]["pro_marketprice"]);
                
                //查一下当前仓库的本商品价格
                string sql_price="select top 1 stock_price from ProductStock where pro_id=@pro_id and warehouse_id=@warehouse_id";
                helper_price.Params.Add("@pro_id", Convert.ToInt32(dt.Rows[0]["pro_id"]));
                helper_price.Params.Add("@warehouse_id",my_warehouse_id);
                DataTable dt_price = helper_price.ExecDataTable(sql_price);
                if (dt_price.Rows.Count > 0)
                {
                    if (Convert.ToDouble(dt_price.Rows[0]["stock_price"]) > 0)
                    {
                        pro_outprice = Convert.ToDouble(dt_price.Rows[0]["stock_price"]);
                    }
                }

                helper.Params.Add("price", pro_outprice);
                helper.Params.Add("voucher_price",Convert.ToDouble(dt.Rows[0]["pro_outprice"]));
                helper.Params.Add("quantity",1);
                helper.Params.Add("goods_image",Convert.ToString(dt.Rows[0]["pro_image"]));
                helper.Insert("Tb_cashier_cart");
                //新增
            }
            return 1;
        }

        protected void update_cart(int rec_id, int quantity)
        {
            helper.Params.Clear();
            helper.Execute("update Tb_cashier_cart set quantity=" + quantity + " where rec_id=" + rec_id+" and cashier_id="+my_admin_id);
        }

    }
}