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
    public partial class ProductStockChange : mypage
    {
        protected string queryStr = string.Empty;
        protected int warehouse_id = 0;
        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            SiteHelper.CheckLogin();
            if (!Page.IsPostBack)
            {
                warehouse_id = Request.QueryString["warehouse_id"].IsNumber() ? Convert.ToInt32(Request.QueryString["warehouse_id"]) : 0;
                BindStockList(SiteHelper.getPage());
            }
        }

        protected void BindStockList(int index)
        {
            int count = 0;
            string where = getWhere();
            SqlHelper conn = LocalSqlHelper.WH;
            AspNetPager1.PageSize = 20;
            DataTable dt = conn.TablesPageNew("(select a.*,b.pro_txm from Tb_ChangeStockRecord a left join Product b on a.pro_id=b.pro_id) as xu", "*", "id desc", true, AspNetPager1.PageSize, index, where, out count);
            MemberList.DataShow(dt);
            AspNetPager1.RecordCount = count;
            AspNetPager1.UrlRewritePattern = "ProductStockChange.aspx?page={0}&" + queryStr;

        }

        private string getWhere()
        {
            string pro_id = Request["pro_id"];
            string txm = Request["txm"];
            string where = "1=1";
            if (warehouse_id > 0)
            {
                where = "warehouse_id=" + warehouse_id;
            }
            if (myStorageInfo.warehouse_id == 0)
            {
               // where = "1=1";
                //where = "warehouse_id=" + myStorageInfo.warehouse_id;
            }
            queryStr = "pro_id=" + pro_id + "&txm=" + txm;
            if (pro_id.IsNotNullAndEmpty() && pro_id.IsNumber())
            {
                where += " and pro_id=" + pro_id;
            }
            if (txm.IsNotNullAndEmpty())
            {
                where += " and pro_txm like '" + txm + "'";
            }
            return where;
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("ProductStockChange.aspx?txm=" + pro_txm.Text);
        }

    }
}