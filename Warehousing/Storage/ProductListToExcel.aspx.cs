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
    public partial class ProductListToExcel : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SiteHelper.CheckLogin();
            if (!Page.IsPostBack)
            {
                BindMemberList();
            }
        }
        protected void BindMemberList()
        {
            string where = getWhere();
            SqlHelper conn = LocalSqlHelper.WH;
            //string sql = "select pro_id,pro_name,pro_code,pro_txm,warehouse_id,pro_supplierid,pro_spec,pro_model,pro_brand,pro_unit,kc_nums,pro_outprice,pro_inprice from View_Product with(nolock) where " + where + " order by pro_id desc";
            string sql = "select pro_id as ID,pro_name as 名称,pro_code as 货号,pro_txm as 条码,warehouse_id as 仓库ID,'' as 仓库,pro_supplierid as 供应商ID,'' as 供应商,pro_spec as 规格,pro_model as 型号,pro_brand as 品牌,pro_unit as 单位,kc_nums as 库存,pro_outprice as 零售价,pro_inprice as 采购价 from View_Product with(nolock) where " + where + " order by pro_id desc";
            DataTable dt = conn.ExecDataTable(sql);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                dt.Rows[i]["仓库"] = Warehousing.Business.StorageHelper.getWarehouseName(Convert.ToInt32(dt.Rows[i]["仓库ID"]));
                dt.Rows[i]["供应商"] = Warehousing.Business.StorageHelper.getSupplierName(Convert.ToInt32(dt.Rows[i]["供应商ID"]));
            }
           // MemberList.DataShow(dt);

            SinoHelper2.ExportHelper.ToExcel(dt, "product_" + DateTime.Now.ToString("yyyyMMddhhmmss"));
            //SiteHelper.ToExcel(MemberList, "product_"+DateTime.Now.ToString("yyyyMMddhhmmss"));
        }


        private string getWhere()
        {
            string str_pro_txm = Request["pro_txm"];
            string str_pro_code = Request["pro_code"];
            string str_pro_name = Request["pro_name"];
            string int_pro_supplierid = Request["pro_supplierid"];
            string int_warehouse_id = Request["warehouse_id"];

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
                where.AppendFormat(" and pro_supplierid='{0}'", int_pro_supplierid);
            }
            if (int_warehouse_id.IsNumber())
            {
                where.AppendFormat(" and warehouse_id='{0}'", int_warehouse_id);
            }
            return where.ToString();
        }
    }
}