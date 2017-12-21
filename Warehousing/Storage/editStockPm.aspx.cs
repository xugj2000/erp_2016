using System;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SinoHelper2;
using Warehousing.Business;

namespace Warehousing.Storage
{
    public partial class editStockPm : System.Web.UI.Page
    {
        protected SqlHelper helper = LocalSqlHelper.WH;
        protected int stock_id = 0;
        protected string sys_del = "0";
        protected string fromUrl = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            SiteHelper.CheckLogin();
            SiteHelper.GetPageUrlpower("Storage/ProductStock.aspx");
            if (Session["PowerSuper"].ToString() != "1")
            {
                SiteHelper.NOPowerMessage();
            }
            stock_id = Convert.ToInt32(Request["id"]);
            if (!Page.IsPostBack)
            {
                string Sql = "select kc_nums,pm_id,pro_code,pro_name,WareHouse_id from View_Product with(nolock) where stock_id=@id";
                helper.Params.Add("@id", stock_id);
                DataTable dt = helper.ExecDataTable(Sql);
                if (dt.Rows.Count > 0)
                {
                    LBpro_code.Text = Convert.ToString(dt.Rows[0]["pro_code"]);
                    LBpro_name.Text = Convert.ToString(dt.Rows[0]["pro_name"]);
                    LBwarehouse_name.Text=StorageHelper.getWarehouseName(Convert.ToInt32(dt.Rows[0]["WareHouse_id"]));
                    BindStockList(Convert.ToInt32(dt.Rows[0]["pm_id"]), Convert.ToInt32(dt.Rows[0]["WareHouse_id"]));
                }
                fromUrl = Request.UrlReferrer.ToString();
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (TextRemark.Text.IsNullOrEmpty())
            {
                JSHelper.WriteScript("alert('请填写修改备注');history.back();");
                return;
            }
            string[] arr_stock_id = Request.Form["stock_id"].Split(',');
            string[] arr_kc_nums = Request.Form["kc_nums"].Split(',');
            string DoWhat = string.Empty;
            int old_nums = 0;
            for (int i = 0; i < arr_stock_id.Length; i++)
            {
                if (arr_kc_nums[i].IsNumber())
                {
                    helper.Params.Clear();
                    helper.Params.Add("stock_id", arr_stock_id[i]);
                    DataTable dt = helper.ExecDataTable("select * from ProductStock with(nolock) where stock_id=@stock_id");
                    old_nums = Convert.ToInt32(dt.Rows[0]["kc_nums"]);
                    int change_quantity = Convert.ToInt32(arr_kc_nums[i]) - old_nums;
                    if (change_quantity!=0)
                    {
                        //helper.Params.Clear();
                        //helper.Params.Add("stock_id", arr_stock_id[i]);
                        //helper.Params.Add("kc_nums", arr_kc_nums[i]);
                        //helper.Update("ProductStock", "stock_id");
                        StorageHelper.changeStock(Convert.ToInt32(dt.Rows[0]["warehouse_id"]), Convert.ToInt32(dt.Rows[0]["pro_id"]), change_quantity, "", "手工库存调整(" + TextRemark.Text + "),by:" + Session["LoginName"].ToString());
                        DoWhat = "StockId:"+arr_stock_id[i]+",原库存:" + old_nums + ",新库存:" + arr_kc_nums[i];
                        SiteHelper.writeLog("库存调整", DoWhat);
                    }
                }
            }

            fromUrl = Request["fromUrl"];
            if (fromUrl.IsNullOrEmpty())
            {
                fromUrl = "ProductStock.aspx";
            }
            JSHelper.WriteScript("alert('编辑成功');location.href='" + fromUrl + "';");
            //Response.Write(RoleList.Text);
            Response.End();
        }

        protected void BindStockList(int Pm_id, int WareHouseId)
        {
            int count = 0;
            SqlHelper conn = LocalSqlHelper.WH;
            string sql = "select stock_id,pro_txm,pro_name,pro_spec,pro_model, kc_nums from View_Product with(nolock) where warehouse_id=" + WareHouseId + " and pm_id=" + Pm_id+" order by pro_model";
            //Response.Write(sql);
            DataTable dt = conn.ExecDataTable(sql);
            StockList.DataShow(dt);
        }
    }
}