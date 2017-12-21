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
    public partial class WorkingConfirm : mypage
    {
        protected SqlHelper helper = LocalSqlHelper.WH;
        protected int id = 0;
        protected int work_id = 0;
        protected double total_out_cost = 0, total_do_cost = 0, total_other_cost = 0, total_goods = 0;

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
                Session["anti_refresh"] = "1";

                int wm_id = 0;


                string Sql = "select a.wm_id,a.quantity,b.*,all_out_cost=0.00,all_do_cost=b.do_cost*a.quantity,all_other_cost=b.other_cost*a.quantity from dbo.Tb_Working_main a left join Tb_template b on a.tpl_id=b.tpl_id where a.work_id=" + work_id + " and a.operator_id=@operator_id";
                helper.Params.Add("@operator_id", my_admin_id);
                DataTable dt = helper.ExecDataTable(Sql);
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


        protected void OrderList_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if ((e.Item.ItemType == ListItemType.Item) || (e.Item.ItemType == ListItemType.AlternatingItem))
            {
                Repeater rep = (Repeater)e.Item.FindControl("MaterialList");
                DataRowView row = (DataRowView)e.Item.DataItem;
                string wm_id = Convert.ToString(row["wm_id"]);
                double quantity = Convert.ToDouble(row["quantity"]);
                SqlHelper conn = LocalSqlHelper.WH;
                conn.Params.Add("@wm_id", wm_id);
                DataTable dt = conn.ExecDataTable("select a.wp_id,a.pro_nums,a.pro_real_nums,need_num=a.pro_nums*" + quantity + ",b.* from dbo.Tb_Working_material a left join Prolist b on a.pro_txm=b.pro_txm where a.wm_id=@wm_id");
                rep.DataShow(dt);
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string wp_id_str = Request["wp_id"];
            string quantity_str = Request["quantity"];
            string[] arr_wp_id = wp_id_str.Split(',');
            string[] arr_quantity = quantity_str.Split(',');
            for (int j = 0; j < arr_wp_id.Length; j++)
            {
                if (arr_wp_id[j].IsNumber() && arr_quantity[j].IsNumber())
                {
                    helper.Params.Clear();
                    helper.Params.Add("wp_id", arr_wp_id[j]);
                    helper.Params.Add("pro_real_nums", arr_quantity[j]);
                    helper.Update("Tb_Working_material", "wp_id");
                }
            }

            Response.Redirect("WorkingLast.Aspx?work_id=" + work_id);
        }

    }
}