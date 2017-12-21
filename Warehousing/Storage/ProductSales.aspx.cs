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
    public partial class ProductSales : mypage
    {
        protected string queryStr = string.Empty;
        protected int totalCount = 0, totalCount_return=0;
        protected double totalSales = 0, totalSales_in=0;
        protected int currentPage = 0;
        protected string groupby = "txm";

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            SiteHelper.GetPageUrlpower("Storage/ProductSales.aspx");
            if (Session["PowerRead"].ToString() != "1")
            {
                SiteHelper.NOPowerMessage();
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                StorageHelper.BindSupplierList(pro_supplierid, 0);
                string where = "1=1";
                if (my_warehouse_id > 0)
                {
                    pro_supplierid.Visible = false;
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
                warehouse_id.Items.Add(new ListItem("所有体验店仓", "-1"));
                StorageHelper.BindClassList(type_id, 0);

                currentPage = SiteHelper.getPage();
                BindMemberList(currentPage);
            }
        }
        protected void BindMemberList(int index)
        {
            int count = 0;
            string where = getWhere();
            SqlHelper conn = LocalSqlHelper.WH;
            SqlHelper helper = LocalSqlHelper.WH;
            AspNetPager1.PageSize = 20;
            string table = "(select a.txm,isnull(sum(productcount),0) as pcount,isnull(sum(case when productcount<0 then productcount else 0 end),0) as return_count,pro_name,pro_code,pro_spec,pro_model,supplierName=cast(pro_supplierid as nvarchar(50)),shortSupplierName='',a.danjia,pro_inprice from Direct_OrderDetail a left join Direct_OrderMain b on a.dingdan=b.dingdan left join Prolist p on a.txm=p.pro_txm where " + where + " group by a.txm,pro_name,pro_code,pro_supplierid,pro_spec,pro_model,a.danjia,pro_inprice) as sales";
            if (groupby == "huohao")
            {
                table = "(select txm='',isnull(sum(productcount),0) as pcount,isnull(sum(case when productcount<0 then productcount else 0 end),0) as return_count,pro_name,pro_code,pro_spec,pro_model='',supplierName=cast(pro_supplierid as nvarchar(50)),shortSupplierName='',a.danjia,pro_inprice from Direct_OrderDetail a left join Direct_OrderMain b on a.dingdan=b.dingdan left join Prolist p on a.txm=p.pro_txm where " + where + " group by pro_code,pro_name,pro_supplierid,pro_spec,a.danjia,pro_inprice) as sales";
                DD_GroupBy.Text = groupby;
            }
           //Response.Write(table);
           //Response.End();
            DataTable dt = conn.TablesPageNew(table, "*", "pcount desc,txm asc", true, AspNetPager1.PageSize, index, "", out count);

           // DataTable dt = PublicHelper.TablesPage(conn, table, "*", "pcount desc", AspNetPager1.PageSize, index, "", "txm", out count);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                    if (my_warehouse_id == 0)
                    {
                        dt.Rows[i]["supplierName"] = StorageHelper.getSupplierName(Convert.ToInt32(dt.Rows[i]["supplierName"]));
                        dt.Rows[i]["shortSupplierName"] = Convert.ToString(dt.Rows[i]["supplierName"]).Length > 4 ? Convert.ToString(dt.Rows[i]["supplierName"]).Substring(0, 4) + ".." : Convert.ToString(dt.Rows[i]["supplierName"]);
                    }
            }
            MemberList.DataShow(dt);
            AspNetPager1.RecordCount = count;
            AspNetPager1.UrlRewritePattern = "ProductSales.aspx?page={0}&" + queryStr;

            string totalSql = "select isnull(sum(productcount),0) as pcount,isnull(sum(case when productcount<0 then productcount else 0 end),0) as rcount,isnull(sum(danjia*productcount),0) as sales,isnull(sum(p.pro_inprice*productcount),0) as sales_in  from Direct_OrderDetail a left join Direct_OrderMain b on a.dingdan=b.dingdan left join Prolist p on a.txm=p.pro_txm where " + where;
            helper.Params.Clear();
            DataTable tdt = helper.ExecDataTable(totalSql);
            totalCount = Convert.ToInt32(tdt.Rows[0]["pcount"]);
            totalSales = Convert.ToDouble(tdt.Rows[0]["sales"]);
            totalSales_in = Convert.ToDouble(tdt.Rows[0]["sales_in"]);
            totalCount_return = Convert.ToInt32(tdt.Rows[0]["rcount"]);
        }


        private string getWhere()
        {
            string str_pro_txm = Request["pro_txm"];
            string str_pro_name = Request["pro_name"];
            string int_pro_supplierid = Request["pro_supplierid"];
            string int_warehouse_id = Request["warehouse_id"];
            string int_type_id = Request["type_id"];
            string StartDate = Request["txtStartDate"];
            string EndDate = Request["txtEndDate"];
            groupby = Request["DD_GroupBy"];
            queryStr = "pro_txm=" + str_pro_txm + "&pro_name=" + str_pro_name + "&pro_supplierid=" + int_pro_supplierid + "&warehouse_id=" + int_warehouse_id + "&txtStartDate=" + StartDate + "&txtEndDate=" + EndDate + "&type_id="+int_type_id+"&DD_GroupBy=" + groupby;
            StringBuilder where = new StringBuilder("1=1");

            if (my_warehouse_id > 0)
            {
                if (myStorageInfo.is_manage == 1)
                {
                    where.AppendFormat(" and b.warehouse_id in (select warehouse_id from WareHouse_List with(nolock) where agent_id='{0}')", myStorageInfo.agent_id);
                }
                else
                {
                    where.AppendFormat(" and  b.warehouse_id ={0}", my_warehouse_id);
                }
            }

            if (str_pro_txm.IsNotNullAndEmpty())
            {
                where.AppendFormat(" and a.txm like '%{0}%'", str_pro_txm);
            }
            if (str_pro_name.IsNotNullAndEmpty())
            {
                where.AppendFormat(" and a.shopxpptname like '%{0}%'", str_pro_name);

            }
            if (int_warehouse_id.IsNumber())
            {
                warehouse_id.SelectedValue = int_warehouse_id;
                if (int_warehouse_id == "-1")
                {
                    where.AppendFormat(" and b.warehouse_id in (select warehouse_id from WareHouse_List where StoreId>2)");
                }
                else
                {
                    where.AppendFormat(" and b.warehouse_id='{0}'", int_warehouse_id);
                }
            }



            if (int_pro_supplierid.IsNumber())
            {
                pro_supplierid.Text = int_pro_supplierid;
                where.AppendFormat(" and a.supplierid='{0}'", int_pro_supplierid);
            }

            if (int_type_id.IsNumber() && int_type_id!="0")
            {
                type_id.SelectedValue = int_type_id;
                where.AppendFormat(" and p.type_id='{0}'", int_type_id);
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
            where.AppendFormat(" and b.fksj>'{0}'", StartDate);
            txtEndDate.Text = EndDate;
            where.AppendFormat(" and b.fksj<DateAdd(d,1,'{0}')", EndDate);
            return where.ToString();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string where = getWhere();
            Response.Redirect("ProductSales.aspx?" + queryStr);
        }

        protected void Button4_Click(object sender, EventArgs e)
        {
            string where = getWhere();
            SqlHelper conn = LocalSqlHelper.WH;
            SqlHelper helper = LocalSqlHelper.WH;
            AspNetPager1.PageSize = 20;
            string table = "select a.txm as 条码,p.pro_name as 商品名,p.pro_code as 货号,p.pro_spec as 型号,p.pro_model as 规格,cast(pro_supplierid as nvarchar(50)) as '供应商',sum(productcount) as 销售数量,danjia as 销售价 from Direct_OrderDetail a left join Direct_OrderMain b on a.dingdan=b.dingdan left join Prolist p on a.txm=p.pro_txm where " + where + " group by a.txm,pro_name,pro_code,pro_supplierid,pro_spec,pro_model,a.danjia,pro_inprice order by sum(productcount) desc,txm asc";
            if (SiteHelper.getReadRightByText("采购价格"))
            {
                table = "select a.txm as 条码,p.pro_name as 商品名,p.pro_code as 货号,p.pro_spec as 型号,p.pro_model as 规格,cast(pro_supplierid as nvarchar(50)) as '供应商',sum(productcount) as 销售数量,danjia as 销售价,pro_inprice as 采购价 from Direct_OrderDetail a left join Direct_OrderMain b on a.dingdan=b.dingdan left join Prolist p on a.txm=p.pro_txm where " + where + " group by a.txm,pro_name,pro_code,pro_supplierid,pro_spec,pro_model,a.danjia,pro_inprice order by sum(productcount) desc,txm asc";
            }
            DataTable dt = conn.ExecDataTable(table);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                dt.Rows[i]["供应商"] = StorageHelper.getSupplierName(Convert.ToInt32(dt.Rows[i]["供应商"]));
            }
            //PublicHelper.ToExcel(dt, "product_" + DateTime.Now.ToString("yyyyMMddHHmmss"));
            SinoHelper2.ExportHelper.ToExcel(dt, "sales_" + DateTime.Now.ToString("yyyyMMddHHmmss"));
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