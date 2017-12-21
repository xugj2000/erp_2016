using System;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SinoHelper2;
using Warehousing.Business;

namespace Warehousing.Storage
{
    public partial class AddShelfNo : System.Web.UI.Page
    {
        protected SqlHelper helper = LocalSqlHelper.WH;
        protected int stock_id = 0;
        protected int sm_id=0;
        protected string sys_del = "0";
        protected string fromUrl = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            SiteHelper.CheckLogin();
            SiteHelper.GetPageUrlpower("Storage/ProductIn.aspx");
            if (Session["PowerRead"].ToString() != "1")
            {
                SiteHelper.NOPowerMessage();
            }
            sm_id = Convert.ToInt32(Request["id"]);
            if (!Page.IsPostBack)
            {
                string Sql = "select * from Tb_storage_main where sm_id=@id";
                helper.Params.Add("@id", sm_id);
                DataTable dt = helper.ExecDataTable(Sql);
                if (dt.Rows.Count > 0)
                {
                    LBpro_name.Text = Convert.ToString(dt.Rows[0]["sm_sn"]);
                    LBwarehouse_name.Text = StorageHelper.getWarehouseName(Convert.ToInt32(dt.Rows[0]["WareHouse_id"]));
                    BindStockList(sm_id, Convert.ToInt32(dt.Rows[0]["WareHouse_id"]));
                }
                
                fromUrl = Request.UrlReferrer.ToString();
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string[] arr_stock_id = Request.Form["stock_id"].Split(',');
            string[] arr_shelf_no = Request.Form["shelf_no"].Split(',');
            string DoWhat = string.Empty;
            string old_shelf_no = string.Empty;
            for (int i = 0; i < arr_stock_id.Length; i++)
            {
                helper.Params.Clear();
                helper.Params.Add("stock_id", arr_stock_id[i]);
                DataTable dt = helper.ExecDataTable("select * from ProductStock with(nolock) where stock_id=@stock_id");
                old_shelf_no = Convert.ToString(dt.Rows[0]["shelf_no"]);
                if (!old_shelf_no.Equals(arr_shelf_no[i]))
                {
                    helper.Params.Clear();
                    helper.Params.Add("stock_id", arr_stock_id[i]);
                    helper.Params.Add("shelf_no", arr_shelf_no[i]);
                    helper.Update("ProductStock", "stock_id");
                    // StorageHelper.changeStock(Convert.ToInt32(dt.Rows[0]["warehouse_id"]), Convert.ToInt32(dt.Rows[0]["pro_id"]), change_quantity, "", "手工库存调整,by:" + Session["LoginName"].ToString());
                    DoWhat = "StockId:" + arr_stock_id[i] + ",原仓位:" + old_shelf_no + ",新仓位:" + arr_shelf_no[i];
                    SiteHelper.writeLog("仓位调整", DoWhat);
                }
            }

            fromUrl = Request["fromUrl"];
            if (fromUrl.IsNullOrEmpty())
            {
                fromUrl = "ProductIn.aspx";
            }
            JSHelper.WriteScript("alert('编辑成功');location.href='" + fromUrl + "';");
            //Response.Write(RoleList.Text);
            Response.End();
        }

        protected void BindStockList(int sm_id, int WareHouse_id)
        {
            int count = 0;
            SqlHelper conn = LocalSqlHelper.WH;
            string sql = "select *,shelf_no='',stock_id=0 from Tb_storage_product with(nolock) where  sm_id=" + sm_id + " order by p_name,p_spec";
            //Response.Write(sql);
            DataTable dt = conn.ExecDataTable(sql);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                dt.Rows[i]["shelf_no"]= StorageHelper.getShelfNo(Convert.ToInt32(dt.Rows[i]["pro_id"]),WareHouse_id);
                dt.Rows[i]["stock_id"] = StorageHelper.getStockId(Convert.ToInt32(dt.Rows[i]["pro_id"]), WareHouse_id);
            }
            StockList.DataShow(dt);
        }
    }
}