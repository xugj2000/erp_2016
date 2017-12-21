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
using Warehousing.Model;

namespace Warehousing.Cashier
{
    public partial class CashierCollect : mypage
    {
        
        protected double all_sales = 0;
        protected int trace_id = 0;

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            trace_id = Request.QueryString["trace_id"].IsNumber() ? Convert.ToInt32(Request.QueryString["trace_id"]) : 0;
            SqlHelper helper = LocalSqlHelper.WH;
            string Sql = "select isnull(sum(price*quantity),0) as all_sales,isnull(sum(price*quantity),0) as all_quantity from Tb_cashier_cart where cashier_id=@cashier_id and is_return=0 and trace_id=@trace_id";
            helper.Params.Add("@cashier_id", my_admin_id);
            helper.Params.Add("@trace_id", trace_id);
            DataTable dt = helper.ExecDataTable(Sql);
            all_sales = Convert.ToDouble(dt.Rows[0]["all_sales"]);

            if (!Page.IsPostBack)
            {

                TextRealMoney.Text = all_sales.ToString();
                int all_quantity = Convert.ToInt32(dt.Rows[0]["all_quantity"]);
                if (all_quantity == 0)
                {
                    JSHelper.WriteScript("alert('没有待结算商品');history.back();");
                    return;
                }
                StorageHelper.BindGuideList(GuideList, 0, my_warehouse_id);

                helper.Params.Clear();
                Sql = "select *,sales=price*quantity from Tb_cashier_cart where cashier_id=@cashier_id and is_return=0 and trace_id=@trace_id";
                helper.Params.Add("@cashier_id", my_admin_id);
                helper.Params.Add("@trace_id", trace_id);
                dt = helper.ExecDataTable(Sql);
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                   // total_money += Convert.ToDouble(dt.Rows[i]["sales"]);
                   // total_goods += Convert.ToDouble(dt.Rows[i]["quantity"]);
                }
                GoodsList.DataShow(dt);
            }
        }
        protected void BindGuideList(DropDownList DropDownList)
        {
            string sql = "SELECT ID,RoleName FROM SinoRole with(nolock) order by ID";
            if (myStorageInfo.agent_id>0)
            {
                sql = "SELECT ID,RoleName FROM SinoRole with(nolock) where isAgent=1 order by ID";
            }
            SqlHelper helper = LocalSqlHelper.WH;
            DataTable dt = helper.ExecDataTable(sql);
            BindingHelper.BindDDL(DropDownList, dt, "RoleName", "ID", false);
        }


        protected void Button1_Click(object sender, EventArgs e)
        {
            //生成会员，没有就成no_name会员
            //生成主订单
            double order_amount = Convert.ToDouble(TextRealMoney.Text);

            if (order_amount <= 0 || order_amount > all_sales)
            {
                JSHelper.WriteScript("alert('实收金额有误');history.back();");
                return;
            }

            double order_plus = 0;
            order_plus = all_sales - order_amount;

            SqlHelper helper = LocalSqlHelper.WH;
            string Sql = "select * from Tb_cashier_cart where cashier_id=@cashier_id and trace_id=@trace_id";
            helper.Params.Add("@cashier_id", my_admin_id);
            helper.Params.Add("@trace_id", trace_id);
            DataTable dt = helper.ExecDataTable(Sql);
            DateTime pay_time = DateTime.Now;
            string dingdan = "RT" + PublicHelper.ConvertDateTimeInt(pay_time);

             //插入订单商品
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    helper.Params.Clear();
                    int p_quantity = Convert.ToInt32(dt.Rows[i]["quantity"]);
                    string p_txm = Convert.ToString(dt.Rows[i]["txm"]);
                    helper.Params.Add("supplierid", StorageHelper.getSupplierIdByTxm(p_txm));
                    helper.Params.Add("dingdan", dingdan);
                    helper.Params.Add("shopxpptid", Convert.ToInt32(dt.Rows[i]["goods_id"]));
                    helper.Params.Add("style_id", Convert.ToInt32(dt.Rows[i]["spec_id"]));
                    helper.Params.Add("shopxpptname", dt.Rows[i]["goods_name"]);
                    helper.Params.Add("p_size", dt.Rows[i]["specification"]);
                    helper.Params.Add("txm", p_txm);
                    helper.Params.Add("productcount", p_quantity);
                    helper.Params.Add("danjia", Convert.ToDouble(dt.Rows[i]["price"]));
                    helper.Params.Add("voucher", Convert.ToDouble(dt.Rows[i]["voucher_price"]));
                    helper.Insert("Direct_OrderDetail");

                    StorageHelper.changeStock(my_warehouse_id, Convert.ToInt32(dt.Rows[i]["spec_id"]), 0-p_quantity, dingdan, "店面销售");

                }
                
             //生成主订单
                helper.Params.Clear();
                string UserName = TextLoginName.Text;
                int userid = 0;
                if (UserName.IsNotNullAndEmpty())
                {
                    userid = UserHelper.getUserId(UserName);
                    if (TextLoginName.Text!=TextLoginName2.Text)
                    {
                        JSHelper.WriteScript("alert('两次客户标识不一致！');history.back();");
                        return;
                    }
                    if (userid == 0)
                    {
                        if (!UserName.IsCellPhone())
                        {
                            JSHelper.WriteScript("alert('要求为手机号');history.back();");
                            return;
                        }
                        
                        //生成新会员
                        UserInfo newUser=new UserInfo();

                        newUser.User_name = UserName;
                        newUser.User_Mobile = UserName;
                        newUser.is_hide = 0;
                        newUser.User_Pwd = "666666";
                        newUser.User_level = 0;
                        newUser.True_name = "";
                        newUser.cashier_id_from = my_admin_id;
                        newUser.store_id_from = my_warehouse_id;
                        userid=UserHelper.addUser(newUser);
                    }
                    helper.Params.Add("userid", userid);
                    helper.Params.Add("user_name", UserName);
                }

                helper.Params.Add("warehouse_id", my_warehouse_id);

                helper.Params.Add("store_id", my_warehouse_id);
            //myStorageInfo.warehouse_name
                helper.Params.Add("seller_name","" );
                helper.Params.Add("dingdan", dingdan);
                helper.Params.Add("dingdan_type", 99);
                helper.Params.Add("user_type", 0);
                helper.Params.Add("order_amount", order_amount);
                helper.Params.Add("order_plus", order_plus);
                helper.Params.Add("payment_name", DDPaymentName.Text);

                string phone_tel = "";
                helper.Params.Add("usertel", phone_tel);
                helper.Params.Add("liuyan", "");
                helper.Params.Add("shopxp_shfs", 0);

                helper.Params.Add("fksj", pay_time);
                int OrderStatus = 8;//实体店订单直接打单成功
                helper.Params.Add("fhsj", pay_time);
                helper.Params.Add("zhuangtai", OrderStatus);
                helper.Params.Add("ShippingCompany", "noname");
                helper.Params.Add("guide_id", Request["GuideList"]);
                helper.Params.Add("cashier_id", my_admin_id);
                helper.Insert("Direct_OrderMain");

                //清除购物车
                helper.Params.Clear();
                helper.Params.Add("@cashier_id", my_admin_id);
                helper.Params.Add("@trace_id", trace_id);
                helper.Execute("delete  from Tb_cashier_cart where cashier_id=@cashier_id and trace_id=@trace_id");
                
            /*
            helper.BeginTran();
            try
            {
                helper.CommitTran();
            }
            catch (Exception ex)
            {
                helper.RollbackTran();
                JSHelper.WriteScript("alert('"+ex.Message+"');history.back();");
            }
             * */

                JSHelper.WriteScript("alert('结算成功');location.href='CashierPrint.aspx?dingdan=" + dingdan + "';");
            //Response.Write(RoleList.Text);
            Response.End();
        }
    }
}