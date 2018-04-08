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

namespace Warehousing.Storage
{
    public partial class ProductOut : mypage
    {
        protected string queryStr = string.Empty;
        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            SiteHelper.GetPageUrlpower("Storage/ProductOut.aspx");
            if (Session["PowerRead"].ToString() != "1")
            {
                SiteHelper.NOPowerMessage();
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            SiteHelper.CheckLogin();
            if (!Page.IsPostBack)
            {

                StorageHelper.BindSupplierList(sm_supplierid, 0);
                string where = "1=1";
                if (my_warehouse_id > 0)
                {
                    if (myStorageInfo.is_manage == 1)
                    {
                        where = " agent_id='" + myStorageInfo.agent_id + "'";
                    }
                    else
                    {
                        where = " (is_manage=1 or warehouse_id=" + myStorageInfo.warehouse_id + ") and agent_id='" + myStorageInfo.agent_id + "'";
                    }
                }
                Warehousing.Business.StorageHelper.BindWarehouseList(warehouse_id, 0, where);

                where = "warehouse_id<>" + myStorageInfo.warehouse_id;
                if (myStorageInfo.agent_id>0)
                {
                    if (myStorageInfo.is_manage == 1)
                    {
                        where += " and (agent_id=0 or agent_id='" + myStorageInfo.agent_id + "')";
                    }
                    else
                    {
                        where += " and is_manage=1 and agent_id='" + myStorageInfo.agent_id + "'";
                    }
                }
                else
                {
                    if (my_warehouse_id > 0)
                    {
                        where += " and (is_manage=1 or agent_id='" + myStorageInfo.agent_id + "')";
                    }
                }

                Warehousing.Business.StorageHelper.BindWarehouseList(to_warehouse_id, 0, where);
                BindMemberList(SiteHelper.getPage());
            }
        }
        protected void BindMemberList(int index)
        {
            string where = getWhere();
            int count = 0;
            SqlHelper conn = LocalSqlHelper.WH;
            SqlHelper helper = LocalSqlHelper.WH;
            AspNetPager1.PageSize = 20;
            DataTable dt = conn.TablesPageNew("Tb_storage_main with(nolock)", "Tb_storage_main.*,pvolume=0.00,procount=isnull((select sum(p_quantity) from Tb_storage_product with(nolock) where sm_id=Tb_storage_main.sm_id),0),sku=isnull((select count(p_quantity) from Tb_storage_product with(nolock) where sm_id=Tb_storage_main.sm_id),0) ", "sm_id desc", true, AspNetPager1.PageSize, index, where, out count);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                helper.Params.Clear();
                dt.Rows[i]["pvolume"] = helper.ExecScalar("select isnull(sum(p_quantity*p_price),0) from Tb_storage_product a with(nolock)  where sm_id=" + dt.Rows[i]["sm_id"].ToString());
            }
            MemberList.DataShow(dt);
            AspNetPager1.RecordCount = count;
            AspNetPager1.UrlRewritePattern = "ProductOut.aspx?page={0}&" + queryStr;

        }

        private string getWhere()
        {
            string str_sm_sn = Request["sm_sn"];
            string str_p_serial = Request["p_serial"];
            string str_p_txm = Request["p_txm"];
            string StartDate = Request["startDate"];
            string EndDate = Request["endDate"];
            string int_warehouse_id = Request["warehouse_id"];
            string int_warehouse_id_to = Request["to_warehouse_id"];
            string int_sm_supplierid = Request["sm_supplierid"];
            string int_sm_status = Request["sm_status"];
            string int_sm_type = Request["sm_type"];
            string str_consumer_name = Request["consumer_name"];

            queryStr = "sm_sn=" + str_sm_sn + "&p_serial=" + str_p_serial + "&p_txm=" + str_p_txm + "&startDate=" + StartDate + "&endDate=" + EndDate + "&sm_status=" + int_sm_status + "&sm_type=" + int_sm_type + "&warehouse_id=" + int_warehouse_id + "&to_warehouse_id=" + int_warehouse_id_to + "&consumer_name=" + str_consumer_name + "&sm_supplierid=" + int_sm_supplierid;
            StringBuilder where = new StringBuilder("sm_direction='出库'");

            if (my_warehouse_id > 0)
            {
                where.AppendFormat(" and warehouse_id = {0}", my_warehouse_id);
            }
            if (int_warehouse_id.IsNumber())
            {
                where.AppendFormat(" and warehouse_id = {0}", int_warehouse_id);
                warehouse_id.SelectedValue = int_warehouse_id;
            }

            if (int_warehouse_id_to.IsNumber())
            {
                where.AppendFormat(" and warehouse_id_to = {0}", int_warehouse_id_to);
                to_warehouse_id.SelectedValue = int_warehouse_id_to;
            }


            if (str_sm_sn.IsNotNullAndEmpty())
            {
                where.AppendFormat(" and sm_sn like '%{0}%'", str_sm_sn);

            }
            if (str_p_serial.IsNotNullAndEmpty())
            {
                where.AppendFormat(" and sm_id in (select sm_id from Tb_storage_product where p_serial like '%{0}%')", str_p_serial);
            }

            if (str_p_txm.IsNotNullAndEmpty())
            {
                where.AppendFormat(" and sm_id in (select sm_id from Tb_storage_product where p_txm like '%{0}%')", str_p_txm);
            }
            if (StartDate.IsNotNullAndEmpty())
            {
                startDate.Text = StartDate;
                where.AppendFormat(" and sm_date>='{0}'", StartDate);
            }
            if (EndDate.IsNotNullAndEmpty())
            {
                endDate.Text = EndDate;
                where.AppendFormat(" and sm_date<dateAdd(d,1,'{0}')", EndDate);
            }
            if (int_sm_status.IsNumber())
            {
                sm_status.Text = int_sm_status;
                where.AppendFormat(" and sm_status={0}", int_sm_status);
            }
            if (int_sm_type.IsNumber())
            {
                sm_type.Text = int_sm_type;
                where.AppendFormat(" and sm_type={0}", int_sm_type);
            }
            Button4.Visible = false;
            if (str_consumer_name.IsNotNullAndEmpty())
            {
                consumer_name.Text = str_consumer_name;
                Button4.Visible = true;
                where.AppendFormat(" and consumer_name='{0}'", str_consumer_name);
            }
            if (int_sm_supplierid.IsNumber())
            {
                sm_supplierid.Text = int_sm_supplierid;
                Button4.Visible = true;
                where.AppendFormat(" and sm_supplierid='{0}'", int_sm_supplierid);
            }
            return where.ToString();
        }

        protected string getStyletext(int status)
        {
            return status == 1 || status == 2 || status == 3 ? "style='display:none;'" : "";
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string where = getWhere();

            Response.Redirect("ProductOut.aspx?" + queryStr);
        }
        protected void Button4_Click(object sender, EventArgs e)
        {
            string where = getWhere();
            SqlHelper conn = LocalSqlHelper.WH;
            SqlHelper helper = LocalSqlHelper.WH;
            AspNetPager1.PageSize = 20;
            string table = "select sm_id,sm_sn as 出库单号,cast(sm_date as varchar) as 出库日期,0.00 as 金额,0.00 as 件数,0.00 as 付款额,0.00 as 欠款额 from Tb_storage_main with(nolock)  where sm_status=1 and " + where + " order by sm_id asc";
            DataTable dt = conn.ExecDataTable(table);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                helper.Params.Clear();
                dt.Rows[i]["金额"] = helper.ExecScalar("select isnull(sum(p_quantity*p_price),0) from Tb_storage_product a with(nolock) where sm_id=" + dt.Rows[i]["sm_id"].ToString());
                dt.Rows[i]["件数"] = helper.ExecScalar("select isnull(sum(p_quantity),0) from Tb_storage_product a with(nolock) where sm_id=" + dt.Rows[i]["sm_id"].ToString());
                dt.Rows[i]["付款额"] = StorageHelper.getAlreadyPayMoney(Convert.ToInt32(dt.Rows[i]["sm_id"]));
                dt.Rows[i]["欠款额"] = Convert.ToDouble(dt.Rows[i]["金额"]) - Convert.ToDouble(dt.Rows[i]["付款额"]);
                dt.Rows[i]["出库日期"] = Convert.ToDateTime(dt.Rows[i]["出库日期"]).ToShortDateString();
            }
            //PublicHelper.ToExcel(dt, "product_" + DateTime.Now.ToString("yyyyMMddHHmmss"));
            SinoHelper2.ExportHelper.ToExcel(dt, "consumer_" + DateTime.Now.ToString("yyyyMMddHHmmss"));
            Response.End();
        }
    }
}