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
    public partial class ProductList : mypage
    {
        protected string queryStr = string.Empty;

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            SiteHelper.GetPageUrlpower("Storage/ProductList.aspx");
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
                BindMemberList(SiteHelper.getPage());
            }
        }
        protected void BindMemberList(int index)
        {
            int count = 0;
            string where = getWhere();
            SqlHelper conn = LocalSqlHelper.WH;
            AspNetPager1.PageSize = 20;
            DataTable dt = conn.TablesPageNew("Prolist", "*,'' as supplierName,'' as shortSupplierName", "pro_id desc", true, AspNetPager1.PageSize, index, where, out count);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                dt.Rows[i]["supplierName"] = Warehousing.Business.StorageHelper.getSupplierName(Convert.ToInt32(dt.Rows[i]["pro_supplierid"]));
                dt.Rows[i]["shortSupplierName"] = Convert.ToString(dt.Rows[i]["supplierName"]).Length > 4 ? Convert.ToString(dt.Rows[i]["supplierName"]).Substring(0, 4) + ".." : Convert.ToString(dt.Rows[i]["supplierName"]);
            }
            MemberList.DataShow(dt);
            AspNetPager1.RecordCount = count;
            AspNetPager1.UrlRewritePattern = "ProductList.aspx?page={0}&" + queryStr;

        }


        private string getWhere()
        {
            string str_pro_txm = Request["pro_txm"];
            string str_pro_code = Request["pro_code"];
            string str_pro_name = Request["pro_name"];
            string int_pro_supplierid = Request["pro_supplierid"];
            string dbl_pro_outprice = Request["pro_outprice"];
            queryStr = "pro_txm=" + str_pro_txm + "&pro_code=" + str_pro_code + "&pro_name=" + str_pro_name + "&pro_supplierid=" + int_pro_supplierid + "&pro_outprice="+dbl_pro_outprice; ;
            StringBuilder where = new StringBuilder("1=1");
            if (str_pro_txm.IsNotNullAndEmpty())
            {
                where.AppendFormat(" and pro_txm like '%{0}%'", str_pro_txm);
            }
            if (str_pro_name.IsNotNullAndEmpty())
            {
                where.AppendFormat(" and pro_name like '%{0}%'", str_pro_name);

            }
            if (str_pro_code.IsNotNullAndEmpty())
            {
                where.AppendFormat(" and pro_code like '%{0}%'", str_pro_code);

            }

            if (int_pro_supplierid.IsNumber())
            {
                pro_supplierid.Text = int_pro_supplierid;
                where.AppendFormat(" and pro_supplierid='{0}'", int_pro_supplierid);
            }

            if (dbl_pro_outprice.IsNumber())
            {
                pro_outprice.Text = dbl_pro_outprice;
                where.AppendFormat(" and pro_outprice={0}", dbl_pro_outprice);
            }
            
            return where.ToString();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
           string where = getWhere();
           Response.Redirect("ProductList.aspx?" + queryStr);
        }

        protected double dispInPrice(object InPrice)
        {
            if (SiteHelper.getReadRightByText("采购价格"))
            {
                return Convert.ToDouble(InPrice);
            }
            else
            {
                return 0;
            }

        }

        protected void Button4_Click(object sender, EventArgs e)
        {
            string where = getWhere();
            SqlHelper conn = LocalSqlHelper.WH;
            //string sql = "select pro_id,pro_name,pro_code,pro_txm,warehouse_id,pro_supplierid,pro_spec,pro_model,pro_brand,pro_unit,kc_nums,pro_outprice,pro_inprice from View_Product with(nolock) where " + where + " order by pro_id desc";
            string sql = "select pro_id as 商品id,pro_name as 名称,pro_code as 货号,pro_txm as 条码,pro_supplierid as 供应商ID,'' as 供应商,pro_spec as 规格,pro_model as 型号,pro_brand as 品牌,pro_unit as 单位,pro_outprice as 零售价,pro_inprice as 采购价 from Prolist with(nolock) where " + where + " order by pro_id desc";
            DataTable dt = conn.ExecDataTable(sql);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                dt.Rows[i]["供应商"] = Warehousing.Business.StorageHelper.getSupplierName(Convert.ToInt32(dt.Rows[i]["供应商ID"]));
            }
            //PublicHelper.ToExcel(dt, "product_" + DateTime.Now.ToString("yyyyMMddHHmmss"));
            SinoHelper2.ExportHelper.ToExcel(dt, "product_" + DateTime.Now.ToString("yyyyMMddHHmmss"));
            Response.End();
        }

    }
}