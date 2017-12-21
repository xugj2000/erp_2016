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
    public partial class ProductStock : mypage
    {
        protected string queryStr = string.Empty;
        protected double total_amount = 0;
        protected double total_amount_base = 0,total_amount_base_tax = 0, total_kucun=0;


        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            SiteHelper.GetPageUrlpower("Storage/ProductStock.aspx");
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
                    if (myStorageInfo.is_manage == 1)
                    {
                        where = " agent_id='" + myStorageInfo.agent_id + "'";
                    }
                    else
                    {
                        where = " agent_id='" + myStorageInfo.agent_id + "'";
                        //where = " (is_manage=1 or warehouse_id="+myStorageInfo.warehouse_id+") and agent_id='" + myStorageInfo.agent_id + "'";
                    }
                }
                //Response.Write(where);
                Warehousing.Business.StorageHelper.BindWarehouseList(warehouse_id,0, where);

                BindProductStockList(SiteHelper.getPage());
                if (my_warehouse_id > 0)
                {
                    pro_supplierid.Visible = false;
                }
            }
        }
        protected void BindProductStockList(int index)
        {
            int count = 0;
            string where = getWhere();
            SqlHelper conn = LocalSqlHelper.WH;
            AspNetPager1.PageSize = 20;
            DataTable dt = conn.TablesPageNew("View_Product", "*,'' as supplierName,'' as shortSupplierName", "pro_id desc,stock_id desc", false, AspNetPager1.PageSize, index, where, out count);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                if (my_warehouse_id == 0)
                {
                    dt.Rows[i]["supplierName"] = Warehousing.Business.StorageHelper.getSupplierName(Convert.ToInt32(dt.Rows[i]["pro_supplierid"]));
                    dt.Rows[i]["shortSupplierName"] = Convert.ToString(dt.Rows[i]["supplierName"]).Length > 4 ? Convert.ToString(dt.Rows[i]["supplierName"]).Substring(0, 4) + ".." : Convert.ToString(dt.Rows[i]["supplierName"]);
                }
                                }
            MemberList.DataShow(dt);
            AspNetPager1.RecordCount = count;
            AspNetPager1.UrlRewritePattern = "ProductStock.aspx?page={0}&" + queryStr;
            SqlHelper helper = LocalSqlHelper.WH;
            DataTable dt_new = helper.ExecDataTable("select isnull(sum(pro_inprice*kc_nums),0) as total_amount_base,isnull(sum(pro_outprice*kc_nums),0) as total_amount,isnull(sum(kc_nums),0) as total_kucun from View_Product where " + where);
            total_amount = Convert.ToDouble(dt_new.Rows[0]["total_amount"]);
            total_amount_base = Convert.ToDouble(dt_new.Rows[0]["total_amount_base"]);
            total_kucun = Convert.ToDouble(dt_new.Rows[0]["total_kucun"]);
            
        }


        private string getWhere()
        {
            string str_pro_txm = Request["pro_txm"];
            string str_pro_code = Request["pro_code"];
            string str_pro_name = Request["pro_name"];
            string int_pro_supplierid = Request["pro_supplierid"];
            string int_warehouse_id = Request["warehouse_id"];
            string int_kc1 = Request["kc1"];
            string int_kc2 = Request["kc2"];
            string dbl_pro_outprice = Request["pro_outprice"];
            string dbl_pro_outprice2 = Request["pro_outprice2"];
            queryStr = "pro_txm=" + str_pro_txm + "&pro_code=" + str_pro_code + "&pro_name=" + str_pro_name + "&pro_supplierid=" + int_pro_supplierid + "&warehouse_id=" + int_warehouse_id + "&kc1=" + int_kc1 + "&kc2=" + int_kc2 + "&pro_outprice=" + dbl_pro_outprice + "&pro_outprice2=" + dbl_pro_outprice2;
            StringBuilder where = new StringBuilder("1=1");

            if (my_warehouse_id > 0)
            {
                if (myStorageInfo.is_manage == 1)
                {
                    where.AppendFormat(" and warehouse_id in (select warehouse_id from WareHouse_List with(nolock) where agent_id='{0}')", myStorageInfo.agent_id);
                }
                else
                {
                    where.AppendFormat(" and  warehouse_id in (select warehouse_id from WareHouse_List with(nolock) where warehouse_id={0} or (agent_id='{1}' and is_manage=1))", my_warehouse_id, myStorageInfo.agent_id);
                }
            }

            if (str_pro_txm.IsNotNullAndEmpty())
            {
                where.AppendFormat(" and pro_txm like '{0}%'", str_pro_txm);
            }
            if (str_pro_name.IsNotNullAndEmpty())
            {
                where.AppendFormat(" and pro_name like '%{0}%'", str_pro_name);
            }
            if (str_pro_code.IsNotNullAndEmpty())
            {
                where.AppendFormat(" and pro_code like '{0}%'", str_pro_code);

            }

            if (int_pro_supplierid.IsNumber())
            {
                pro_supplierid.Text = int_pro_supplierid;
                where.AppendFormat(" and pro_supplierid='{0}'", int_pro_supplierid);
            }
            if (int_warehouse_id.IsNumber())
            {
                warehouse_id.Text = int_warehouse_id;
                where.AppendFormat(" and warehouse_id='{0}'", int_warehouse_id);
            }
            if (int_kc1.IsNumber())
            {
                kc1.Text = int_kc1;
                where.AppendFormat(" and kc_nums>={0}", int_kc1);
            }
            if (int_kc2.IsNumber())
            {
                kc2.Text = int_kc2;
                where.AppendFormat(" and kc_nums<={0}", int_kc2);
            }
            if (dbl_pro_outprice.IsNumber())
            {
                pro_outprice.Text = dbl_pro_outprice;
                where.AppendFormat(" and pro_outprice>={0}", dbl_pro_outprice);
            }
            if (dbl_pro_outprice2.IsNumber())
            {
                pro_outprice2.Text = dbl_pro_outprice2;
                where.AppendFormat(" and pro_outprice<={0}", dbl_pro_outprice2);
            }
            return where.ToString();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string where = getWhere();
            Response.Redirect("ProductStock.aspx?" + queryStr);
        }

        protected void Button4_Click(object sender, EventArgs e)
        {
            string where = getWhere();
            SqlHelper conn = LocalSqlHelper.WH;
            //string sql = "select pro_id,pro_name,pro_code,pro_txm,warehouse_id,pro_supplierid,pro_spec,pro_model,pro_brand,pro_unit,kc_nums,pro_outprice,pro_inprice from View_Product with(nolock) where " + where + " order by pro_id desc";
            string sql = "select pro_id as 商品id,pro_name as 名称,pro_code as 货号,pro_txm as 条码,warehouse_id as 仓库ID,'' as 仓库,pro_supplierid as 供应商ID,'' as 供应商,pro_spec as 规格,pro_model as 型号,pro_brand as 品牌,pro_unit as 单位,kc_nums as 库存,pro_outprice as 零售价,pro_inprice as 采购价 from View_Product with(nolock) where " + where + " order by pro_id desc";
            DataTable dt = conn.ExecDataTable(sql);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                dt.Rows[i]["仓库"] = Warehousing.Business.StorageHelper.getWarehouseName(Convert.ToInt32(dt.Rows[i]["仓库ID"]));
                dt.Rows[i]["采购价"] = dispInPrice(dt.Rows[i]["采购价"]);
                if (my_warehouse_id == 0)
                {
                    dt.Rows[i]["供应商"] = Warehousing.Business.StorageHelper.getSupplierName(Convert.ToInt32(dt.Rows[i]["供应商ID"]));
                }
                else
                {
                    dt.Rows[i]["采购价"] = "0";
                    dt.Rows[i]["供应商ID"] = "0";
                }
            }
            //PublicHelper.ToExcel(dt, "product_" + DateTime.Now.ToString("yyyyMMddHHmmss"));
            SinoHelper2.ExportHelper.ToExcel(dt, "ProductStock_" + DateTime.Now.ToString("yyyyMMddHHmmss"));
            Response.End();
        }

        protected double dispInPrice(object InPrice)
        {
            return StorageHelper.dispInPrice(InPrice);
        }

    }
}
