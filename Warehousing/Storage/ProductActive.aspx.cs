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
    public partial class ProductActive : mypage
    {
        protected string queryStr = string.Empty;
        protected int totalCount = 0, totalCount_return = 0;
        protected double totalSales = 0, totalSales_in = 0;
        protected int currentPage = 0;
        protected string sm_direction = "入库";
        protected string pro_supplierid_span_css = "inline", to_warehouse_id_span_css = "none";
        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            SiteHelper.GetPageUrlpower("Storage/ProductActive.aspx");
            if (Session["PowerRead"].ToString() != "1")
            {
                SiteHelper.NOPowerMessage();
            }
            if (!Page.IsPostBack)
            {
                StorageHelper.BindSupplierList(pro_supplierid, 0);

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
                StorageHelper.BindWarehouseList(warehouse_id, 0, where);
                direction.Text = "入库";
                if (myStorageInfo.agent_id>0)
                {
                    pro_supplierid.Visible = false;
                }

                if (myStorageInfo.warehouse_id>0&&myStorageInfo.is_manage==0)
                {
                    warehouse_id.Visible = false;
                }

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
                currentPage = SiteHelper.getPage();
                BindMemberList(currentPage);
                if (sm_direction == "入库" || sm_direction == "采购入库")
                {
                    pro_supplierid_span_css = "inline";
                    to_warehouse_id_span_css = "none";
                }
                else if (sm_direction == "出库")
                {
                    pro_supplierid_span_css = "none";
                    to_warehouse_id_span_css = "inline";
                }
                else
                {
                    pro_supplierid_span_css = "none";
                    to_warehouse_id_span_css = "none";
                }
            }
        }
        protected void BindMemberList(int index)
        {
            int count = 0;
            string where = getWhere();
           // Response.Write(where);
            SqlHelper conn = LocalSqlHelper.WH;
            SqlHelper helper = LocalSqlHelper.WH;
            AspNetPager1.PageSize = 20;
            string table = "(select a.p_txm as txm,sum(a.p_quantity) as pcount,pro_name='',pro_code='',pro_spec='',pro_model='',supplierName='',shortSupplierName='',pro_outprice=0.00,pro_inprice=0.00 from Tb_storage_product a left join Tb_storage_main b on a.sm_id=b.sm_id where " + where + " group by a.p_txm) as sales";
            //Response.Write(table);
            DataTable dt = conn.TablesPageNew(table, "*", "txm asc,pcount desc", true, AspNetPager1.PageSize, index, "", out count);

            // DataTable dt = PublicHelper.TablesPage(conn, table, "*", "pcount desc", AspNetPager1.PageSize, index, "", "txm", out count);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                conn.Params.Clear();
                string sql = "select * from Prolist where pro_txm='" + Convert.ToString(dt.Rows[i]["txm"]) + "'";
                // Response.Write(sql);
                DataTable dtPro = helper.ExecDataTable(sql);
                if (dtPro.Rows.Count > 0)
                {
                    dt.Rows[i]["pro_name"] = Convert.ToString(dtPro.Rows[0]["pro_name"]);
                    dt.Rows[i]["pro_code"] = Convert.ToString(dtPro.Rows[0]["pro_code"]);
                    dt.Rows[i]["pro_spec"] = Convert.ToString(dtPro.Rows[0]["pro_spec"]);
                    dt.Rows[i]["pro_model"] = Convert.ToString(dtPro.Rows[0]["pro_model"]);
                    dt.Rows[i]["pro_outprice"] = Convert.ToDouble(dtPro.Rows[0]["pro_outprice"]);
                    dt.Rows[i]["pro_inprice"] = Convert.ToDouble(dtPro.Rows[0]["pro_inprice"]);
                    if (myStorageInfo.agent_id==0)
                    {
                        dt.Rows[i]["supplierName"] = StorageHelper.getSupplierName(Convert.ToInt32(dtPro.Rows[0]["pro_supplierid"]));
                        dt.Rows[i]["shortSupplierName"] = Convert.ToString(dt.Rows[i]["supplierName"]).Length > 4 ? Convert.ToString(dt.Rows[i]["supplierName"]).Substring(0, 4) + ".." : Convert.ToString(dt.Rows[i]["supplierName"]);
                    }
                }
            }
            MemberList.DataShow(dt);
            AspNetPager1.RecordCount = count;
            AspNetPager1.UrlRewritePattern = "ProductActive.aspx?page={0}&" + queryStr;

            string totalSql = "select isnull(sum(p_quantity),0) as pcount,isnull(sum(case when p_quantity<0 then p_quantity else 0 end),0) as rcount,isnull(sum(c.pro_outprice*a.p_quantity),0) as sales,isnull(sum(c.pro_inprice*a.p_quantity),0) as sales_in  from Tb_storage_product a left join Tb_storage_main b on a.sm_id=b.sm_id left join Prolist c on a.p_txm=c.pro_txm where " + where;
            helper.Params.Clear();
            //Response.Write(totalSql);
            DataTable tdt = helper.ExecDataTable(totalSql);
            totalCount = Convert.ToInt32(tdt.Rows[0]["pcount"]);
            totalSales = Convert.ToDouble(tdt.Rows[0]["sales"]);
            totalSales_in = Convert.ToDouble(tdt.Rows[0]["sales_in"]);
            totalCount_return = Convert.ToInt32(tdt.Rows[0]["rcount"]);
        }


        private string getWhere()
        {
            string str_pro_txm = Request["pro_txm"];
            string str_pro_code = Request["pro_code"];
            string int_pro_supplierid = Request["pro_supplierid"];
            string int_warehouse_id = Request["warehouse_id"];
            string int_to_warehouse_id = Request["to_warehouse_id"];
            string int_sm_status = Request["sm_status"];
            string StartDate = Request["txtStartDate"];
            string EndDate = Request["txtEndDate"];
            string str_consumer_name = Request["consumer_name"];
             sm_direction = Request["direction"];
             queryStr = "pro_txm=" + str_pro_txm + "&pro_code=" + str_pro_code + "&direction=" + sm_direction + "&pro_supplierid=" + int_pro_supplierid + "&warehouse_id=" + int_warehouse_id + "&to_warehouse_id=" + int_to_warehouse_id + "&txtStartDate=" + StartDate + "&txtEndDate=" + EndDate + "&sm_status=" + int_sm_status + "&consumer_name=" + str_consumer_name;
            StringBuilder where = new StringBuilder("1=1");
            if (my_warehouse_id > 0)
            {
                where.AppendFormat(" and b.warehouse_id='{0}'", my_warehouse_id);
            }
            else
            {
                if (int_warehouse_id.IsNumber())
                {
                    where.AppendFormat(" and b.warehouse_id='{0}'", int_warehouse_id);
                    warehouse_id.Text = int_warehouse_id;
                }
            }
            if (int_to_warehouse_id.IsNumber())
            {
                where.AppendFormat(" and b.warehouse_id_to='{0}'", int_to_warehouse_id);
                to_warehouse_id.Text = int_to_warehouse_id;
            }

            
            if (str_pro_txm.IsNotNullAndEmpty())
            {
                where.AppendFormat(" and a.p_txm like '%{0}%'", str_pro_txm);
            }
            if (str_pro_code.IsNotNullAndEmpty())
            {
                where.AppendFormat(" and a.p_txm like '{0}%'", str_pro_code);

            }

            if (sm_direction.IsNullOrEmpty())
            {
                sm_direction = "入库";
            }
            direction.Text = sm_direction;

            if (sm_direction == "采购入库")
            {
                where.AppendFormat(" and b.sm_type=1");
            }
            else
            {
                where.AppendFormat(" and b.sm_direction like '{0}'", sm_direction);
               
            }

            if (int_sm_status.IsNullOrEmpty())
            {
                int_sm_status = "1";
            }

            sm_status.Text = int_sm_status;
            where.AppendFormat(" and b.sm_status={0}", int_sm_status);

            if (str_consumer_name.IsNotNullAndEmpty())
            {
                consumer_name.Text = str_consumer_name;
                where.AppendFormat(" and b.consumer_name like '{0}'", str_consumer_name);
            }

            if (int_pro_supplierid.IsNumber())
            {
                pro_supplierid.Text = int_pro_supplierid;
                where.AppendFormat(" and b.sm_supplierid='{0}'", int_pro_supplierid);
            }

            if (StartDate.IsNullOrEmpty())
            {
                StartDate = DateTime.Now.ToString("yyyy-MM-dd");
            }
            if (EndDate.IsNullOrEmpty())
            {
                EndDate = DateTime.Now.ToString("yyyy-MM-dd");
            }

            txtStartDate.Text = StartDate;
            where.AppendFormat(" and b.sm_date>'{0}'", StartDate);
            txtEndDate.Text = EndDate;
            where.AppendFormat(" and b.sm_date<DateAdd(d,1,'{0}')", EndDate);
            //Response.Write(where);
            return where.ToString();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string where = getWhere();
            Response.Redirect("ProductActive.aspx?" + queryStr);
        }

        protected void Button4_Click(object sender, EventArgs e)
        {
            string where = getWhere();
            SqlHelper conn = LocalSqlHelper.WH;
            SqlHelper helper = LocalSqlHelper.WH;
            AspNetPager1.PageSize = 20;
            string table = "select a.p_txm as 条码,'' as 商品名,'' as 货号,'' as 型号,'' as 规格,'' as '供应商',sum(a.p_quantity) as 销售数量,0.00 as 销售价,0.00 as 销售额,0.00 as 采购价 from Tb_storage_product a left join Tb_storage_main b on a.sm_id=b.sm_id  where " + where + " group by a.p_txm order by a.p_txm asc,sum(a.p_quantity) desc";
            DataTable dt = conn.ExecDataTable(table);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                helper.Params.Clear();
                string sql = "select * from Prolist where pro_txm='" + Convert.ToString(dt.Rows[i]["条码"]) + "'";
                // Response.Write(sql);
                DataTable dtPro = helper.ExecDataTable(sql);
                if (dtPro.Rows.Count > 0)
                {
                    dt.Rows[i]["商品名"] = Convert.ToString(dtPro.Rows[0]["pro_name"]);
                    dt.Rows[i]["货号"] = Convert.ToString(dtPro.Rows[0]["pro_code"]);
                    dt.Rows[i]["型号"] = Convert.ToString(dtPro.Rows[0]["pro_spec"]);
                    dt.Rows[i]["规格"] = Convert.ToString(dtPro.Rows[0]["pro_model"]);
                    dt.Rows[i]["销售价"] = Convert.ToDouble(dtPro.Rows[0]["pro_outprice"]);
                    dt.Rows[i]["销售额"] = Convert.ToDouble(dtPro.Rows[0]["pro_outprice"]) * Convert.ToDouble(dt.Rows[i]["销售数量"]);
                    if (my_warehouse_id == 0)
                    {
                        dt.Rows[i]["采购价"] = Convert.ToDouble(StorageHelper.dispInPrice(dtPro.Rows[0]["pro_inprice"]));
                        dt.Rows[i]["供应商"] = StorageHelper.getSupplierName(Convert.ToInt32(dtPro.Rows[0]["pro_supplierid"]));
                    }
                }
            }
            //PublicHelper.ToExcel(dt, "product_" + DateTime.Now.ToString("yyyyMMddHHmmss"));
            SinoHelper2.ExportHelper.ToExcel(dt, "churuku_" + DateTime.Now.ToString("yyyyMMddHHmmss"));
            Response.End();
        }

        protected string getInPrice(object p_baseprice)
        {
            if (SiteHelper.getReadRightByText("采购价格"))
            {
                return p_baseprice.ToString();
            }
            return "";
        }
    }
}