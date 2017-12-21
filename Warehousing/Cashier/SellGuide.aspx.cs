﻿using System;
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
    public partial class SellGuide : mypage
    {
        protected string queryStr = string.Empty;
        protected double total_allCount = 0, total_all_amount = 0, total_goods_amount = 0, total_goods_nums = 0;

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            SiteHelper.GetPageUrlpower("Cashier/SellGuide.aspx");
            if (Session["PowerRead"].ToString() != "1")
            {
                SiteHelper.NOPowerMessage();
            }
            if (!Page.IsPostBack)
            {
                StorageHelper.BindGuideList(guide_list, 0, my_warehouse_id);
                BindOrderList(SiteHelper.getPage());
            }
        }
        protected void BindOrderList(int index)
        {
            int count = 0;
            string where = getWhere();
            SqlHelper conn = LocalSqlHelper.WH;
            SqlHelper helper = LocalSqlHelper.WH;
            string sql = "select b.guide_id,allCount=count(*),guide_name=isnull((select guide_name from Tb_guide_staff where guide_id=b.guide_id),''),sum(b.order_amount) as all_amount,0.00 as goods_amount,0 as goods_nums from Direct_OrderMain b where " + where + " group by b.guide_id";
            DataTable dt = conn.ExecDataTable(sql);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                helper.Params.Clear();
                DataTable dt_new = helper.ExecDataTable("select isnull(sum(danjia*productcount),0) as goods_amount,isnull(sum(productcount),0) as goods_nums from Direct_OrderDetail where dingdan in (select dingdan from Direct_OrderMain b where " + where + ")");
                dt.Rows[i]["goods_amount"] = dt_new.Rows[0]["goods_amount"];
                dt.Rows[i]["goods_nums"] = dt_new.Rows[0]["goods_nums"];
                total_allCount += Convert.ToDouble(dt.Rows[i]["allCount"]);
                total_all_amount += Convert.ToDouble(dt.Rows[i]["all_amount"]);
                total_goods_amount += Convert.ToDouble(dt.Rows[i]["goods_amount"]);
                total_goods_nums += Convert.ToDouble(dt.Rows[i]["goods_nums"]);
            }
            OrderList.DataShow(dt);
        }

        private string getWhere()
        {
            string int_guide_id = Request["guide_list"];
            string str_startDate = Request["startDate"];
            string str_endDate = Request["endDate"];
            queryStr = "guide_list=" + int_guide_id + "&startDate=" + str_startDate + "&endDate=" + str_endDate;
            StringBuilder where = new StringBuilder("dingdan_type=99 and b.zhuangtai>0");

            if (my_warehouse_id > 0)
            {
                where.AppendFormat(" and warehouse_id='{0}'", my_warehouse_id);
            }
            if (int_guide_id.IsNumber())
            {
                guide_list.Text = int_guide_id;
                where.AppendFormat(" and guide_id='{0}'", int_guide_id);
            }

            if (str_startDate.IsNullOrEmpty())
            {
                str_startDate = DateTime.Today.ToShortDateString();
                startDate.Text = str_startDate;
                where.AppendFormat(" and fksj>='{0}'", str_startDate);
            }
            if (str_endDate.IsNullOrEmpty())
            {
                str_endDate = DateTime.Today.ToShortDateString();
                endDate.Text = str_endDate;
                where.AppendFormat(" and fksj<=DATEADD(d,1,'{0}')", str_endDate);
            }
            //Response.Write(where.ToString());
            //Response.End();
            return where.ToString();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string where = getWhere();
            Response.Redirect("SellGuide.aspx?" + queryStr);
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

    }
}