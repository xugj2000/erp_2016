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

namespace Warehousing.Production
{
    public partial class ProductionList : mypage
    {
        protected string queryStr = string.Empty;

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            SiteHelper.CheckLogin();
            if (!Page.IsPostBack)
            {
                string where = "1=1";
                ProductionHelper.BindFactoryList(factory_id, 0);
                BindMemberList(SiteHelper.getPage());
            }


        }
        protected void BindMemberList(int index)
        {
            string where = getWhere();
            int count = 0;
            SqlHelper conn = LocalSqlHelper.WH;
            SqlHelper helper = LocalSqlHelper.WH;
            AspNetPager1.PageSize = 20;
            DataTable dt = conn.TablesPageNew("Tb_Working with(nolock)", "*,needPayMoney=0.00,willPayMoney=0.00,AlreadyPayMoney=0.00,pvolume=0.00,pquantity=0.00,receivedNum=0.00,doingNum=0.00,pcode=''", "work_id desc", true, AspNetPager1.PageSize, index, where, out count);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                helper.Params.Clear();
                dt.Rows[i]["pquantity"] = helper.ExecScalar("select isnull(sum(quantity),0) from Tb_Working_main where work_id=" + dt.Rows[i]["work_id"]);
                dt.Rows[i]["receivedNum"] = helper.ExecScalar("select isnull(sum(p_quantity),0) from Tb_storage_product a left join dbo.Tb_storage_main b on a.sm_id=b.sm_id where b.sm_type=" + ((int)StorageType.生产入库) + " and b.sm_status in (1,3) and b.relate_sn='" + dt.Rows[i]["work_sn"] + "'");
                dt.Rows[i]["doingNum"] = Convert.ToDouble(dt.Rows[i]["pquantity"]) - Convert.ToDouble(dt.Rows[i]["receivedNum"]);
                dt.Rows[i]["pcode"] = helper.ExecScalar("select top 1 isnull(pro_code,'') from Tb_template a left join Tb_Working_main b on a.tpl_id=b.tpl_id where b.work_id=" + dt.Rows[i]["work_id"]);
                // dt.Rows[i]["needPayMoney"] = helper.ExecScalar("select top 1 isnull((a.do_cost+a.other_cost)*b.quantity,0) from Tb_template a left join Tb_Working_main b on a.tpl_id=b.tpl_id where b.work_id=" + dt.Rows[i]["work_id"]);
                //update a set a.do_cost=b.do_cost,a.other_cost=b.other_cost from dbo.Tb_Working_main a,Tb_template b where a.tpl_id=b.tpl_id
                dt.Rows[i]["needPayMoney"] =  helper.ExecScalar("select top 1 isnull(sum((do_cost+other_cost)*quantity),0) from Tb_Working_main where work_id=" + dt.Rows[i]["work_id"]);
                dt.Rows[i]["AlreadyPayMoney"] = Warehousing.Business.ProductionHelper.getAlreadyPayMoney(Convert.ToInt32(dt.Rows[i]["work_id"]));
                dt.Rows[i]["willPayMoney"] = Convert.ToDouble(dt.Rows[i]["needPayMoney"]) - Convert.ToDouble(dt.Rows[i]["AlreadyPayMoney"]);
            }
            MemberList.DataShow(dt);
            AspNetPager1.RecordCount = count;
            AspNetPager1.UrlRewritePattern = "ProductionList.Aspx?page={0}&" + queryStr;

        }

        private string getWhere()
        {
            string str_work_sn = Request["work_sn"];
            string str_pro_code = Request["pro_code"];

            string int_factory_id = Request["factory_id"];
            string int_work_status = Request["work_status"];

            queryStr = "work_sn=" + str_work_sn + "&factory_id=" + int_factory_id + "&work_status=" + int_work_status + "&pro_code=" + str_pro_code;
            StringBuilder where = new StringBuilder("1=1");


            if (str_work_sn.IsNotNullAndEmpty())
            {
                where.AppendFormat(" and work_sn like '%{0}%'", str_work_sn);
            }
            if (str_pro_code.IsNotNullAndEmpty())
            {
                where.AppendFormat(" and work_id in (select a.work_id from Tb_Working_main a left join dbo.Tb_template b on a.tpl_id=b.tpl_id where b.pro_code like '%{0}%')", str_pro_code);
            }
            if (int_work_status.IsNumber())
            {
                work_status.Text = int_work_status;
                where.AppendFormat(" and work_status={0}", int_work_status);
            }
            if (int_factory_id.IsNumber())
            {
                factory_id.Text = int_factory_id;
                where.AppendFormat(" and factory_id='{0}'", int_factory_id);
            }

            return where.ToString();
        }

        protected string getStyletext(int status)
        {
            return status != 0 && status != 1 && status != 2 ? "style='display:none;'" : "";
        }

        protected string getStyletext2(int status)
        {
            return status != 3 && status != 4  ? "style='display:none;'" : "";
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string where = getWhere();

            Response.Redirect("ProductionList.Aspx?" + queryStr);
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            string work_id_selected = Request["work_id"];
            if (work_id_selected.IsNullOrEmpty())
            {
                JSHelper.WriteScript("alert('请至少选中一个产品模板');history.back()");
                Response.End();
            }
            string[] arr_work_id = work_id_selected.Split(',');
            int select_flag = 0;
            SqlHelper helper = LocalSqlHelper.WH;
            for (int i = 0; i < arr_work_id.Length; i++)
            {
                if (arr_work_id[i].IsNumber())
                {
                    //判断模板是否存在
                    string sql = "select top 1 * from Tb_Working_main with(nolock) where work_id=0 and operator_id=@operator_id and work_id=@work_id";
                    helper.Params.Add("operator_id", HttpContext.Current.Session["ManageUserId"].ToString());
                    helper.Params.Add("work_id", arr_work_id[i]);
                    DataTable dt = helper.ExecDataTable(sql);
                    if (dt.Rows.Count == 0)
                    {
                        //加入WorkingCart
                        helper.Params.Clear();
                        helper.Params.Add("work_id", arr_work_id[i]);
                        helper.Params.Add("operator_id", HttpContext.Current.Session["ManageUserId"].ToString());
                        helper.Params.Add("quantity", 1);
                        helper.Insert("Tb_Working_main");

                        helper.Params.Clear();
                        int new_wmid = Convert.ToInt32(helper.ExecScalar("select top 1 wm_id from Tb_Working_main order by wm_id desc"));

                        helper.Params.Clear();
                        helper.Params.Add("work_id", arr_work_id[i]);
                        string sql_new = "insert into dbo.Tb_Working_material(wm_id,tpt_id,pro_txm,pro_id,pro_nums) select " + new_wmid + ",work_id,pro_txm_from,pro_id_from,pro_nums from dbo.Tb_Working_material where work_id=@work_id ";
                        helper.Execute(sql_new);
                    }
                    select_flag = 1;
                }
            }
            if (select_flag == 0)
            {
                JSHelper.WriteScript("alert('请至少选中一个产品模板');history.back()");
                Response.End();
            }

            Response.Redirect("WorkingCart.Aspx?" + queryStr);
        }
    }
}