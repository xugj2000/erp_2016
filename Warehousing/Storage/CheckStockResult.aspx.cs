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

namespace Warehousing.Storage
{
    public partial class CheckStockResult : mypage
    {
        protected int norecord = 0;
        protected int main_id = 0;
        protected string strTable = string.Empty;
        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            SiteHelper.GetPageUrlpower("Storage/CheckStock.aspx");
            if (Session["PowerRead"].ToString() != "1")
            {
                SiteHelper.NOPowerMessage();
            }
            main_id = Request["id"].IsNumber() ? Convert.ToInt32(Request["id"]) : 0;
            if (!Page.IsPostBack)
            {
                
                BindMemberList(SiteHelper.getPage(), getWhere());
            }
        }
        protected void BindMemberList(int index, string where)
        {
            int count = 0;
            SqlHelper conn = LocalSqlHelper.WH;
            AspNetPager1.PageSize = 20;
           
            // Response.Write(strTable);
           // Response.End();
            DataTable dt = conn.TablesPageNew(strTable, "*,plus_num=check_num-kc_num", "pro_id", true, AspNetPager1.PageSize, index, where, out count);
            if (dt.Rows.Count == 0)
            {
                norecord = 1;
            }
            MemberList.DataShow(dt);
            AspNetPager1.RecordCount = count;
            AspNetPager1.UrlRewritePattern = "CheckStockResult.aspx?page={0}&id=" + main_id;
        }

        protected void Button4_Click(object sender, EventArgs e)
        {
            string where = getWhere();
            SqlHelper conn = LocalSqlHelper.WH;
            //Response.Write(strTable);
           // Response.End();
            AspNetPager1.PageSize = 20;
            string strBasePrice = string.Empty;
            //p.pro_inprice as 采购价,p.pro_inprice_tax as '采购价-税',
            if (SiteHelper.getReadRightByText("采购价格"))
            {
                strBasePrice = "p.pro_inprice as 采购价,p.pro_inprice_tax as '采购价-税',";
            }
            string table = "select a.pro_id as 商品ID,' '+a.pro_txm as 条码,a.kc_num as 当前库存,a.check_num as 盘点库存,a.check_num-a.kc_num as 偏差,p.pro_outprice as 销售价," + strBasePrice + "a.exist_info as 备注 from " + strTable + " left join Product p on a.pro_txm=p.pro_txm";
           // Response.Write(table);
            // Response.End();
            DataTable dt = conn.ExecDataTable(table);

            //PublicHelper.ToExcel(dt, "product_" + DateTime.Now.ToString("yyyyMMddHHmmss"));
            SinoHelper2.ExportHelper.ToExcel(dt, "pancun_" + main_id+"_" + DateTime.Now.ToString("yyyyMMddHHmmss"));
            Response.End();
        }

        private string getWhere()
        {
            strTable = "(select pro_id=0,pro_txm,kc_num=0,sum(check_num) as check_num,exist_info='不存在' from Tb_check_input where main_id=" + main_id + " and pro_txm not in (select pro_txm from Tb_check_detail where main_id=" + main_id + ") group by pro_txm";
            strTable += " union all select pro_id,pro_txm,kc_num,check_num=isnull((select sum(check_num) from Tb_check_input where main_id=" + main_id + " and pro_txm=Tb_check_detail.pro_txm),0),exist_info='' from Tb_check_detail where main_id=" + main_id + ") as a ";
            string where = "kc_num<>check_num";
           // where = "main_id=" + main_id;
            return where;
        }
    }
}