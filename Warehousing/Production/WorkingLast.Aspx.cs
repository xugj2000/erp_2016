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
    public partial class WorkingLast : mypage
    {
        protected SqlHelper helper = LocalSqlHelper.WH;
        protected int int_factory_id = 0, int_from_warehouse_id=0;
        protected int work_id = 0;
        protected double total_out_cost = 0, total_do_cost = 0, total_other_cost = 0, total_goods = 0;

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            work_id = Convert.ToInt32(Request["work_id"]);
            if (!Page.IsPostBack)
            {
                Session["anti_refresh"] = "1";
                string Sql = "select * from Tb_Working where work_id=@work_id";
                helper.Params.Add("@work_id", work_id);
                DataTable dt = helper.ExecDataTable(Sql);
                if (dt.Rows.Count > 0)
                {
                    factory_manager.Text = dt.Rows[0]["factory_manager"].ToString();
                    our_manager.Text = dt.Rows[0]["our_manager"].ToString();
                    start_date.Text = Convert.ToDateTime(dt.Rows[0]["start_date"]).ToShortDateString();
                    end_date.Text = Convert.ToDateTime(dt.Rows[0]["end_date"]).ToShortDateString();
                    work_remark.Text = dt.Rows[0]["work_remark"].ToString();
                    int_factory_id = Convert.ToInt32(dt.Rows[0]["factory_id"]);
                    int_from_warehouse_id = Convert.ToInt32(dt.Rows[0]["warehouse_id"]);
                }

               StorageHelper.BindWarehouseList(from_warehouse_id, int_from_warehouse_id, my_warehouse_id.ToString(), "");
               ProductionHelper.BindFactoryList(factory_id, int_factory_id);

                bindTemplatePro();
            }
        }


        protected void bindTemplatePro()
        {
            string Sql = "select a.wm_id,a.quantity,b.*,all_out_cost=0.00,all_do_cost=b.do_cost*a.quantity,all_other_cost=b.other_cost*a.quantity from Tb_Working_main a left join Tb_template b on a.tpl_id=b.tpl_id where a.work_id=" + work_id + " and a.operator_id=@operator_id";
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
            helper.Params.Add("factory_manager", Request["factory_manager"]);
            helper.Params.Add("our_manager", Request["our_manager"]);
            helper.Params.Add("factory_id", Request["factory_id"]);
            helper.Params.Add("warehouse_id", Request["from_warehouse_id"]);
            helper.Params.Add("start_date", Request["start_date"]);
            helper.Params.Add("end_date", Request["end_date"]);
            helper.Params.Add("work_remark", work_remark.Text);
            if (work_id == 0)
            {
                string ProductionSn = ProductionHelper.genProductionSn();
                helper.Params.Add("work_sn", ProductionSn);
                helper.Params.Add("operator_id", HttpContext.Current.Session["ManageUserId"].ToString());
                helper.Insert("Tb_Working");
                work_id = Convert.ToInt32(helper.ExecScalar("select top 1 work_id from Tb_Working order by work_id desc"));
                helper.Params.Clear();
                helper.Execute("update Tb_Working_material set work_id=" + work_id + " where wm_id in (select wm_id from Tb_Working_main where  work_id=0 and operator_id=" + HttpContext.Current.Session["ManageUserId"].ToString()+")");
                helper.Execute("update Tb_Working_main set work_id=" + work_id + " where work_id=0 and operator_id=" + HttpContext.Current.Session["ManageUserId"].ToString());
                helper.Execute(" update a set a.do_cost=b.do_cost,a.other_cost=b.other_cost,a.pro_code_new=b.pro_code from dbo.Tb_Working_main a,Tb_template b where a.work_id=" + work_id + " and a.tpl_id=b.tpl_id");
            }
            else
            {
                helper.Params.Add("work_id", work_id);
                helper.Update("Tb_Working", "work_id");
            }
            JSHelper.WriteScript("alert('编辑成功');location.href='ProductionList.Aspx';");
            Response.End();
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

    }
}