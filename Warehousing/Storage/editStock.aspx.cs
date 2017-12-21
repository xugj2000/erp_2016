using System;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SinoHelper2;
using Warehousing.Business;

namespace Warehousing.Storage
{
    public partial class editStock : System.Web.UI.Page
    {
        protected SqlHelper helper = LocalSqlHelper.WH;
        protected int stock_id = 0;
        protected string sys_del = "0";
        protected string fromUrl = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            stock_id = Convert.ToInt32(Request["id"]);
            if (!Page.IsPostBack)
            {
                string Sql = "select kc_nums,pro_txm,pro_name from View_Product with(nolock) where stock_id=@id";
                helper.Params.Add("@id", stock_id);
                DataTable dt = helper.ExecDataTable(Sql);
                if (dt.Rows.Count > 0)
                {
                    Textkc_nums.Text = Convert.ToDouble(dt.Rows[0]["kc_nums"]).ToString();
                    LBpro_txm.Text = Convert.ToString(dt.Rows[0]["pro_txm"]);
                    LBpro_name.Text = Convert.ToString(dt.Rows[0]["pro_name"]);
                }
                fromUrl = Request.UrlReferrer.ToString();
            }
        }


        protected void Button1_Click(object sender, EventArgs e)
        {
            helper.Params.Clear();
            helper.Params.Add("kc_nums", Textkc_nums.Text);
            helper.Params.Add("stock_id", stock_id);
            helper.Update("ProductStock", "stock_id");
            fromUrl = Request["fromUrl"];
            if (fromUrl.IsNullOrEmpty())
            {
                fromUrl = "ProductStock.aspx";
            }
            JSHelper.WriteScript("alert('编辑成功');location.href='" + fromUrl + "';");
            //Response.Write(RoleList.Text);
            Response.End();
        }
    }
}