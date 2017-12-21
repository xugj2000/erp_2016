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

namespace Warehousing.Production
{
    public partial class FactoryList : mypage
    {
        protected int norecord = 0;

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            SiteHelper.GetPageUrlpower("Production/FactoryList.aspx");
            if (Session["PowerRead"].ToString() != "1")
            {
                SiteHelper.NOPowerMessage();
            }
            if (!Page.IsPostBack)
            {
                BindMemberList(1, getWhere());
            }
        }
        protected void BindMemberList(int index, string where)
        {
            int count = 0;
            SqlHelper conn = LocalSqlHelper.WH;
            SqlHelper conn_2 = LocalSqlHelper.WH;
            SqlHelper conn_3 = LocalSqlHelper.WH;
            double cost = 0;
            AspNetPager1.PageSize = 20;
            DataTable dt = conn.TablesPageNew("supplier", "*,PayAlready=0.00,PayWill=0.00,PayAll=0.00,PayGoods=0.00", "id desc", true, AspNetPager1.PageSize, index, where, out count);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                conn_2.Params.Clear();
                //应收款
                dt.Rows[i]["PayAll"] = conn_2.ExecScalar("select isnull(sum(quantity*(do_cost+other_cost)),0) from Tb_Working_main a left join Tb_Working b on a.work_id=b.work_id  where   b.work_status in (1,3,4,8) and b.factory_id=" + dt.Rows[i]["id"]);
                conn_2.Params.Clear();
                DataTable dt1 = conn_2.ExecDataTable("select c.pro_code,b.relate_sn,quantity=sum(a.p_quantity) from Tb_storage_product a left join Tb_storage_main b on a.sm_id=b.sm_id left join Prolist c on a.p_txm=c.pro_txm where b.sm_type in (5,9) and b.sm_status in (1) and b.sm_supplierid=" + dt.Rows[i]["id"] + " group by c.pro_code,b.relate_sn");
                double PayGoods = 0;
                string sql3 = string.Empty;
                for (int j = 0; j < dt1.Rows.Count; j++)
                {
                    conn_3.Params.Clear();
                    string relate_sn = Convert.ToString(dt1.Rows[j]["relate_sn"]);
                    if (relate_sn.IsNotNullAndEmpty())
                    {
                         //生产入库9
                        sql3 = "select top 1 wm.do_cost+wm.other_cost from Tb_Working_main wm left join Tb_Working w on wm.work_id=w.work_id where w.work_sn='" + dt1.Rows[j]["relate_sn"] + "' and wm.pro_code_new='" + dt1.Rows[j]["pro_code"] + "'";
                    }
                    else
                    {
                        //退货入库
                        sql3 = "select top 1 0-(wm.do_cost+wm.other_cost) from Tb_Working_main wm left join Tb_Working w on wm.work_id=w.work_id where w.factory_id=" + dt.Rows[i]["id"] + "  and wm.pro_code_new='" + dt1.Rows[j]["pro_code"] + "' order by wm.work_id desc";
                    }
                   // Response.Write(sql3+"<br>");

                 try
                        {
                            cost = Convert.ToDouble(conn_3.ExecScalar(sql3));
                            PayGoods += cost * Convert.ToDouble(dt1.Rows[j]["quantity"]);
                }
                    catch
                    {
                        Response.End();
                    }
                }
                dt.Rows[i]["PayGoods"] = PayGoods;
               // conn_2.Params.Clear();
                dt.Rows[i]["PayAlready"] = conn_2.ExecScalar("select isnull(sum(a.pay_money),0) from Tb_FinancialFlow a left join Tb_Working b on a.sm_id=b.work_id  where a.object_type='process' and a.is_cancel=0 and  b.work_status in (1,4,3,8) and b.factory_id=" + dt.Rows[i]["id"]);
                dt.Rows[i]["PayWill"] = Convert.ToDouble(dt.Rows[i]["PayGoods"]) - Convert.ToDouble(dt.Rows[i]["PayAlready"]);
            }
            if (dt.Rows.Count == 0)
            {
                norecord = 1;
            }
            MemberList.DataShow(dt);
            AspNetPager1.RecordCount = count;

        }

        protected void AspNetPager1_PageChanging(object src, Wuqi.Webdiyer.PageChangingEventArgs e)
        {
            BindMemberList(e.NewPageIndex, getWhere());
        }

        private string getWhere()
        {
            string where = "IsFactory=1";
            return where;
        }
    }
}