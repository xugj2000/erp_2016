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

namespace Warehousing.Cashier
{
    public partial class SellTotal : mypage
    {
        protected string queryStr = string.Empty;
        protected int totalCount = 0, totalCount_return = 0;
        protected double totalSales = 0, totalSales_in = 0;
        protected int currentPage = 0;
        protected string groupby = "txm";

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            SiteHelper.GetPageUrlpower("Cashier/SellTotal.aspx");
            if (Session["PowerRead"].ToString() != "1")
            {
                SiteHelper.NOPowerMessage();
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
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
            string table = "(select a.txm,isnull(sum(productcount),0) as pcount,isnull(sum(case when productcount<0 then productcount else 0 end),0) as return_count,pro_name,pro_code,pro_spec,pro_model,a.danjia from Direct_OrderDetail a left join Direct_OrderMain b on a.dingdan=b.dingdan left join Prolist p on a.txm=p.pro_txm where " + where + " group by a.txm,pro_name,pro_code,pro_spec,pro_model,a.danjia) as sales";
            if (groupby == "huohao")
            {
                table = "(select txm='',isnull(sum(productcount),0) as pcount,isnull(sum(case when productcount<0 then productcount else 0 end),0) as return_count,pro_name,pro_code,pro_spec,pro_model='',a.danjia from Direct_OrderDetail a left join Direct_OrderMain b on a.dingdan=b.dingdan left join Prolist p on a.txm=p.pro_txm where " + where + " group by pro_code,pro_name,pro_spec,a.danjia) as sales";
                DD_GroupBy.Text = groupby;
            }
            //Response.Write(table);
            //Response.End();
            DataTable dt = conn.TablesPageNew(table, "*", "pcount desc,txm asc", true, AspNetPager1.PageSize, index, "", out count);

            // DataTable dt = PublicHelper.TablesPage(conn, table, "*", "pcount desc", AspNetPager1.PageSize, index, "", "txm", out count);
            MemberList.DataShow(dt);
            AspNetPager1.RecordCount = count;
            AspNetPager1.UrlRewritePattern = "SellTotal.aspx?page={0}&" + queryStr;

            string totalSql = "select isnull(sum(productcount),0) as pcount,isnull(sum(case when productcount<0 then productcount else 0 end),0) as rcount,isnull(sum(danjia*productcount),0) as sales  from Direct_OrderDetail a left join Direct_OrderMain b on a.dingdan=b.dingdan left join Prolist p on a.txm=p.pro_txm where " + where;
            helper.Params.Clear();
            DataTable tdt = helper.ExecDataTable(totalSql);
            totalCount = Convert.ToInt32(tdt.Rows[0]["pcount"]);
            totalSales = Convert.ToDouble(tdt.Rows[0]["sales"]);
            totalCount_return = Convert.ToInt32(tdt.Rows[0]["rcount"]);
        }


        private string getWhere()
        {
            string str_pro_txm = Request["pro_txm"];
            string str_pro_name = Request["pro_name"];
            string int_type_id = Request["type_id"];
            string StartDate = Request["txtStartDate"];
            string EndDate = Request["txtEndDate"];
            groupby = Request["DD_GroupBy"];
            queryStr = "pro_txm=" + str_pro_txm + "&pro_name=" + str_pro_name + "&txtStartDate=" + StartDate + "&txtEndDate=" + EndDate + "&type_id=" + int_type_id + "&DD_GroupBy=" + groupby;
            StringBuilder where = new StringBuilder("b.dingdan_type=99 and b.zhuangtai>0");

           where.AppendFormat(" and  b.warehouse_id ={0}", my_warehouse_id);

            if (str_pro_txm.IsNotNullAndEmpty())
            {
                where.AppendFormat(" and a.txm like '%{0}%'", str_pro_txm);
            }
            if (str_pro_name.IsNotNullAndEmpty())
            {
                where.AppendFormat(" and a.shopxpptname like '%{0}%'", str_pro_name);

            }


            if (int_type_id.IsNumber() && int_type_id != "0")
            {
                type_id.SelectedValue = int_type_id;
                where.AppendFormat(" and p.type_id='{0}'", int_type_id);
            }
            if (StartDate.IsNullOrEmpty())
            {
                StartDate = DateTime.Now.ToShortDateString();
            }
            if (EndDate.IsNullOrEmpty())
            {
                EndDate = DateTime.Now.ToShortDateString();
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
            Response.Redirect("SellTotal.aspx?" + queryStr);
        }

        protected void Button4_Click(object sender, EventArgs e)
        {
            string where = getWhere();
            SqlHelper conn = LocalSqlHelper.WH;
            SqlHelper helper = LocalSqlHelper.WH;
            AspNetPager1.PageSize = 20;
            string table = "select a.txm as 条码,p.pro_name as 商品名,p.pro_code as 货号,p.pro_spec as 型号,p.pro_model as 规格,sum(productcount) as 销售数量,danjia as 销售价 from Direct_OrderDetail a left join Direct_OrderMain b on a.dingdan=b.dingdan left join Prolist p on a.txm=p.pro_txm where " + where + " group by a.txm,pro_name,pro_code,pro_supplierid,pro_spec,pro_model,a.voucher,pro_inprice order by sum(productcount) desc,txm asc";
            DataTable dt = conn.ExecDataTable(table);
            //PublicHelper.ToExcel(dt, "product_" + DateTime.Now.ToString("yyyyMMddHHmmss"));
            SinoHelper2.ExportHelper.ToExcel(dt, "sales_" + DateTime.Now.ToString("yyyyMMddHHmmss"));
            Response.End();
        }
    }
}