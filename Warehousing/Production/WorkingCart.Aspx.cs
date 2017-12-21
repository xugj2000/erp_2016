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

namespace Warehousing.Production
{
    public partial class WorkingCart : mypage
    {
        protected SqlHelper helper = LocalSqlHelper.WH;
        protected int id = 0;
        protected int work_id = 0;
        protected double total_out_cost = 0,total_do_cost = 0, total_other_cost = 0, total_goods = 0;
        protected int factory_num = 0;

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            SiteHelper.GetPageUrlpower("Production/ProductionList.Aspx");
            if (Session["PowerRead"].ToString() != "1")
            {
                SiteHelper.NOPowerMessage();
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            id = Convert.ToInt32(Request["id"]);
            work_id = Convert.ToInt32(Request["work_id"]);
            if (!Page.IsPostBack)
            {
                string act = Request["act"];
                int wm_id = 0;
                switch (act)
                {
                    case "add":
                       
                    case "del":

                        wm_id = Request.QueryString["wm_id"].IsNumber() ? Convert.ToInt32(Request.QueryString["wm_id"]) : 0;
                        string del_sql = "delete from Tb_Working_main  where operator_id=@operator_id and wm_id=@wm_id";
                        helper.Params.Add("@operator_id", my_admin_id);
                        helper.Params.Add("@wm_id", wm_id);
                        helper.Execute(del_sql);
                        JSHelper.WriteScript("alert('移除成功');location.href='WorkingCart.Aspx'");
                        return;
                        break;
                    case "update":
                        int quantity = 0;
                        wm_id = Request.QueryString["wm_id"].IsNumber() ? Convert.ToInt32(Request.QueryString["wm_id"]) : 0;
                        quantity = Request.QueryString["quantity"].IsNumber() ? Convert.ToInt32(Request.QueryString["quantity"]) : 0;
                        if (wm_id == 0 || quantity == 0)
                        {

                            Response.Write(0);
                            Response.End();
                            return;
                        }
                        update_cart(wm_id, quantity);
                        string Sql_new = "select all_do_cost=sum(b.do_cost*a.quantity),all_other_cost=sum(b.other_cost*a.quantity) from Tb_Working_main a left join Tb_template b on a.tpl_id=b.tpl_id where a.operator_id=@operator_id";
                        helper.Params.Add("@operator_id", my_admin_id);
                        DataTable dt_new = helper.ExecDataTable(Sql_new);
                        Response.Write(Convert.ToDouble(dt_new.Rows[0]["all_do_cost"]) + "," + Convert.ToDouble(dt_new.Rows[0]["all_other_cost"]));
                        Response.End();
                        break;

                }
                Session["anti_refresh"] = "1";

                helper.Params.Add("@operator_id", my_admin_id);
                DataTable dt_check =helper.ExecDataTable("select b.factory_id,isnull(count(b.factory_id),0) from Tb_Working_main a left join Tb_template b on a.tpl_id=b.tpl_id where a.work_id=" + work_id + " and a.operator_id=@operator_id group by b.factory_id");
                factory_num = dt_check.Rows.Count;
                helper.Params.Clear();
                string Sql = "select a.wm_id,a.quantity,b.*,all_out_cost=0.00,all_do_cost=b.do_cost*a.quantity,all_other_cost=b.other_cost*a.quantity from Tb_Working_main a left join Tb_template b on a.tpl_id=b.tpl_id where a.work_id=" + work_id + " and a.operator_id=@operator_id";
                helper.Params.Add("@operator_id", my_admin_id);
                DataTable dt = helper.ExecDataTable(Sql);
                if (dt.Rows.Count == 0)
                {
                    JSHelper.WriteScript("alert('请选择待加工产品！');location.href='Template.Aspx';");
                        Response.End();

                }
                
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    dt.Rows[i]["all_out_cost"] = Convert.ToDouble(dt.Rows[i]["all_do_cost"]) + Convert.ToDouble(dt.Rows[i]["all_other_cost"]);
                    total_do_cost += Convert.ToDouble(dt.Rows[i]["all_do_cost"]);
                    total_other_cost += Convert.ToDouble(dt.Rows[i]["all_other_cost"]);
                    total_out_cost += Convert.ToDouble(dt.Rows[i]["all_out_cost"]);
                    total_goods += Convert.ToDouble(dt.Rows[i]["quantity"]);
                }
                GoodsList.DataShow(dt);
                //产品，增加，修改，删除
            }
        }


        protected void update_cart(int wm_id, int quantity)
        {
            helper.Params.Clear();
            helper.Execute("update Tb_Working_main set quantity=" + quantity + " where wm_id=" + wm_id + " and operator_id=" + my_admin_id);
            helper.Params.Clear();
            helper.Execute("update Tb_Working_material set pro_real_nums=pro_nums*" + quantity + " where wm_id=" + wm_id);
        }

        protected void OrderList_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if ((e.Item.ItemType == ListItemType.Item) || (e.Item.ItemType == ListItemType.AlternatingItem))
            {
                Repeater rep = (Repeater)e.Item.FindControl("MaterialList");
                DataRowView row = (DataRowView)e.Item.DataItem;
                string wm_id = Convert.ToString(row["wm_id"]);
                SqlHelper conn = LocalSqlHelper.WH;
                conn.Params.Add("@wm_id", wm_id);
                DataTable dt = conn.ExecDataTable("select a.wp_id,a.pro_nums,a.pro_real_nums,b.* from Tb_Working_material a left join Prolist b on a.pro_txm=b.pro_txm where a.wm_id=@wm_id");
                rep.DataShow(dt);
            }
        }

    }
}