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
    public partial class WorkingDetail : mypage
    {
        protected SqlHelper helper = LocalSqlHelper.WH;
        protected int int_factory_id = 0, int_from_warehouse_id=0;
        protected int work_id = 0, wm_id=0;
        protected DataTable dt;
        protected double total_out_cost = 0, total_do_cost = 0, total_other_cost = 0, total_goods = 0;

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            work_id = Convert.ToInt32(Request["work_id"]);
            //wm_id = helper.ExecScalar("select wm_id from Tb_Working_main where ");
            if (!Page.IsPostBack)
            {
                string Sql = "select * from Tb_Working where work_id=@work_id";
                helper.Params.Add("@work_id", work_id);
                dt = helper.ExecDataTable(Sql);
                if (dt.Rows.Count > 0)
                {
                    factory_manager.Text = dt.Rows[0]["factory_manager"].ToString();
                    our_manager.Text = dt.Rows[0]["our_manager"].ToString();
                    start_date.Text = Convert.ToDateTime(dt.Rows[0]["start_date"]).ToShortDateString();
                    end_date.Text = Convert.ToDateTime(dt.Rows[0]["end_date"]).ToShortDateString();
                    work_remark.Text = dt.Rows[0]["work_remark"].ToString();
                    int_factory_id = Convert.ToInt32(dt.Rows[0]["factory_id"]);
                    int_from_warehouse_id = Convert.ToInt32(dt.Rows[0]["warehouse_id"]);
                    work_status_old.Value = Convert.ToString(dt.Rows[0]["work_status"]);
                    bind_status_list(Convert.ToInt32(dt.Rows[0]["work_status"]));
                }
                else
                {
                    Response.Write("数据传递有误");
                    Response.End();
                }
                ProductionHelper.BindFactoryList(factory_id, int_factory_id);
                StorageHelper.BindWarehouseList(from_warehouse_id, int_from_warehouse_id, my_warehouse_id.ToString(), "");

                bindTemplatePro();
                Session["anti_in_refresh"] = "1";
            }
        }


        protected void bindTemplatePro()
        {
            string Sql = "select a.wm_id,a.quantity,b.*,all_out_cost=0.00,all_do_cost=b.do_cost*a.quantity,all_other_cost=b.other_cost*a.quantity from Tb_Working_main a left join Tb_template b on a.tpl_id=b.tpl_id where a.work_id=" + work_id + " and a.operator_id=@operator_id";
            //Response.Write(Sql);
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
            if (Convert.ToInt32(Request["work_status"]) == 0)
            {
                JSHelper.WriteScript("alert('请选择审核方式');history.back();");
                Response.End();
            }
            if (Session["anti_in_refresh"].ToString() == "0")
            {
                JSHelper.WriteScript("alert('请勿重复提交!');history.back();");
                Response.End();
            }
            Session["anti_in_refresh"] = "0";
            if (Convert.ToInt32(Request["work_status"]) == 1)
            {
                //确认时生成一个加工出库单
                //生成一个调货入库单
                helper.Params.Clear();
                string Sql = "select * from Tb_Working where work_id=@work_id";
                helper.Params.Add("@work_id", work_id);
                dt = helper.ExecDataTable(Sql);
                if (dt.Rows.Count == 0)
                {
                    JSHelper.WriteScript("alert('数据传输有误');history.back();");
                    Response.End();
                }
                helper.Params.Clear();
                helper.Params.Add("sm_type", (int)StorageType.生产出库);

                helper.Params.Add("warehouse_id", dt.Rows[0]["warehouse_id"]);
                helper.Params.Add("warehouse_id_from", dt.Rows[0]["warehouse_id"]);
                helper.Params.Add("sm_supplierid", dt.Rows[0]["factory_id"]);
                helper.Params.Add("sm_sn", Convert.ToString(dt.Rows[0]["work_sn"]) + "_1");
                helper.Params.Add("sm_date", DateTime.Today.ToShortDateString());
                helper.Params.Add("sm_operator", Convert.ToString(dt.Rows[0]["our_manager"]));
                helper.Params.Add("sm_remark", "生产出库");
                helper.Params.Add("sm_direction", "出库");
                helper.Params.Add("sm_status", 1);
                helper.Params.Add("sm_adminid", my_admin_id);
                helper.Insert("Tb_storage_main");
                try
                {
                   
                }
                catch
                {
                    Response.Write("应该已生成过生产出库单，请勿重复操作");
                    Response.End();
                }

                int sm_id_new = Convert.ToInt32(helper.ExecScalar("select top 1 sm_id from Tb_storage_main order by sm_id desc"));

                helper.Params.Clear();
                helper.Params.Add("work_id", work_id);
                //加商品
                string sql = "insert into Tb_storage_product(pro_id,sm_id,sku_id,p_name,p_serial,p_txm,p_spec,p_model,p_price,p_quantity,p_baseprice,p_brand,p_unit) select b.pro_id," + sm_id_new + ",0,b.pro_name,b.pro_code,b.pro_txm,b.pro_spec,b.pro_model,b.pro_outprice,a.pro_real_nums,b.pro_inprice,b.pro_brand,b.pro_unit from Tb_Working_material a left join dbo.Prolist b on a.pro_txm=b.pro_txm where a.work_id=@work_id";
                SinoHelper2.EventLog.WriteLog(sql);
                SiteHelper.writeLog("跟踪", sql);
                helper.Execute(sql);
                //新库加库存
                StorageHelper.checkStorageOk(sm_id_new);
            }

            helper.Params.Clear();
            helper.Params.Add("work_id", work_id);
            helper.Params.Add("work_status", Request["work_status"]);
           // helper.Params.Add("sm_verify_adminid", my_admin_id);
            helper.Update("Tb_Working", "work_id");
            string DoWhat = "原状态:" + Request["work_status_old"] + ",新状态:" + Request["work_status"];
            SiteHelper.writeLog("状态审核", DoWhat);

           


            JSHelper.WriteScript("alert('审核完成');location.href='ProductionList.Aspx';");
            //Response.Write(RoleList.Text);
            Response.End();
        }


        protected void bind_status_list(int sm_type)
        {
            
            switch (sm_type)
            {
                case 0:
                    work_status.Items.Add(new ListItem("等待审核", "0"));
                    work_status.Items.Add(new ListItem("工单确认", "1"));
                    work_status.Items.Add(new ListItem("作废", "2"));
                    break;
                case 1:
                    work_status.Items.Add(new ListItem("送厂加工", "3"));
                    work_status.Items.Add(new ListItem("作废", "2"));
                    break;
                case 3:
                    work_status.Items.Add(new ListItem("成品返库", "4"));
                    break;
                case 4:
                    work_status.Items.Add(new ListItem("工单结束", "8"));
                    break;
            }

        }
    }
}