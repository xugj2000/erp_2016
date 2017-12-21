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
    public partial class ProductNeedList : mypage
    {
        protected string queryStr = string.Empty;

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
               
                string where = "1=1";
                if (my_warehouse_id > 0)
                {
                    if (myStorageInfo.is_manage == 1)
                    {
                        where = " agent_id=" + myStorageInfo.agent_id + " or (warehouse_id=4 and is_manage=1)";
                    }
                    else
                    {
                        where = " is_manage=1 and agent_id=" + myStorageInfo.agent_id;
                    }
                }
                Warehousing.Business.StorageHelper.BindWarehouseList(warehouse_id_from, 0, where);

                Warehousing.Business.StorageHelper.BindWarehouseList(warehouse_id_base, 0, where);


                BindMemberList(SiteHelper.getPage());
            }
        }
        protected void BindMemberList(int index)
        {
            string where = getWhere();
            int count = 0;
            SqlHelper conn = LocalSqlHelper.WH;
            AspNetPager1.PageSize = 20;
            DataTable dt = conn.TablesPageNew("Tb_need_main with(nolock)", "Tb_need_main.*,procount=(select sum(p_quantity) from Tb_need_product with(nolock) where sm_id=Tb_need_main.sm_id),sku=(select count(p_quantity) from Tb_need_product with(nolock) where sm_id=Tb_need_main.sm_id)", "sm_id desc", true, AspNetPager1.PageSize, index, where, out count);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                // conn.Params.Clear();
                // dt.Rows[i]["procount"] = conn.ExecScalar("select count(p_quantity) from Tb_need_product with(nolock) where sm_id=" + dt.Rows[i]["sm_id"].ToString());
            }
            MemberList.DataShow(dt);
            AspNetPager1.RecordCount = count;
            AspNetPager1.UrlRewritePattern = "ProductNeedList.aspx?page={0}&" + queryStr;
        }

        private string getWhere()
        {
            string str_sm_sn = Request["sm_sn"];
            string str_p_serial = Request["p_serial"];
            string str_p_txm = Request["p_txm"];
            string StartDate = Request["startDate"];
            string EndDate = Request["endDate"];
            string from_warehouse_id= Request["warehouse_id_from"];

            queryStr = "sm_sn=" + str_sm_sn + "&p_serial=" + str_p_serial + "&p_txm=" + str_p_txm + "&startDate=" + StartDate + "&endDate=" + EndDate + "&warehouse_id_from="+from_warehouse_id+"&warehouse_id_base="+Request["warehouse_id_base"];
            StringBuilder where = new StringBuilder("1=1");
            if (my_warehouse_id > 0)
            {
                where.AppendFormat(" and (warehouse_id = {0} or warehouse_id_from = {0})", my_warehouse_id);
            }

            if (from_warehouse_id.IsNumber()){
                where.AppendFormat(" and warehouse_id_from = {0}", from_warehouse_id);
                warehouse_id_from.Text = from_warehouse_id;
            }
            if (Request["warehouse_id_base"].IsNumber())
            {
                where.AppendFormat(" and warehouse_id = {0}", Request["warehouse_id_base"]);
                warehouse_id_base.Text = Request["warehouse_id_base"];
            }

            if (str_sm_sn.IsNotNullAndEmpty())
            {
                where.AppendFormat(" and sm_sn like '%{0}%'", str_sm_sn);

            }
            if (str_p_serial.IsNotNullAndEmpty())
            {
                where.AppendFormat(" and sm_id in (select sm_id from Tb_need_product where p_serial like '%{0}%')", str_p_serial);
            }

            if (str_p_txm.IsNotNullAndEmpty())
            {
                where.AppendFormat(" and sm_id in (select sm_id from Tb_need_product where p_txm like '%{0}%')", str_p_txm);
            }
            if (StartDate.IsNotNullAndEmpty())
            {
                startDate.Text = StartDate;
                where.AppendFormat(" and sm_date>='{0}'", StartDate);
            }
            if (EndDate.IsNotNullAndEmpty())
            {
                endDate.Text = EndDate;
                where.AppendFormat(" and sm_date<dateAdd(d,1,'{0}')", EndDate);
            }
            return where.ToString();
        }

        protected string getStyletext(int status)
        {
            return status == 1 || status == 3 ? "style='display:none;'" : "";
        }


        protected string getPeihuotext(object status, object warehouse_id_from)
        {
            string PeihuoText = string.Empty;
            int warehouse_id=Convert.ToInt32(Request.Cookies["userInfo"]["warehouse_id"]);
            if (warehouse_id == 0 || Convert.ToInt32(warehouse_id_from) == warehouse_id)
            {

            }
            else
            {
                PeihuoText = "style='display:none;'";
            }
            return PeihuoText;
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string where = getWhere();

            Response.Redirect("ProductNeedList.aspx?" + queryStr);
        }
    }
}