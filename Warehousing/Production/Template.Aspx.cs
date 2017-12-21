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
    public partial class Template : mypage
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
                BindMemberList(SiteHelper.getPage());
                ProductionHelper.BindFactoryList(factory_id, 0);
            }


        }
        protected void BindMemberList(int index)
        {
            string where = getWhere();
            int count = 0;
            SqlHelper conn = LocalSqlHelper.WH;
            SqlHelper helper = LocalSqlHelper.WH;
            AspNetPager1.PageSize = 20;
            DataTable dt = conn.TablesPageNew("Tb_template with(nolock)", "*,pro_txm_from='',pvolume=0.00,pro_nums=0.00", "tpl_id desc", true, AspNetPager1.PageSize, index, where, out count);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                helper.Params.Clear();
                dt.Rows[i]["pvolume"] = helper.ExecScalar("select isnull(sum(a.pro_nums*b.pro_inprice),0) from Tb_template_material a with(nolock) left join Prolist b with(nolock) on a.pro_txm_from=b.pro_txm  where a.tpl_id=" + dt.Rows[i]["tpl_id"].ToString());
                dt.Rows[i]["pro_txm_from"] = helper.ExecScalar("select isnull(pro_txm_from,'') from Tb_template_material where tpl_id=" + dt.Rows[i]["tpl_id"] + " order by id");
                dt.Rows[i]["pro_nums"] = helper.ExecScalar("select isnull(pro_nums,0) from Tb_template_material where tpl_id=" + dt.Rows[i]["tpl_id"] + " order by id");
                //dt.Rows[i]["pro_color"] = helper.ExecScalar("select isnull(b.pro_txm_from,'') from Tb_template_material a left join Product b on a.pro_txm_from=b.pro_txm where a.tpl_id=" + dt.Rows[i]["tpl_id"]);
            }
            MemberList.DataShow(dt);
            AspNetPager1.RecordCount = count;
            AspNetPager1.UrlRewritePattern = "Template.Aspx?page={0}&" + queryStr;

        }

        private string getWhere()
        {
            string str_pro_name = Request["pro_name"];
            string str_pro_code = Request["pro_code"];

            string int_factory_id = Request["factory_id"];
            string int_tpl_status = Request["tpl_status"];

            queryStr = "pro_name=" + str_pro_name + "&pro_code=" + str_pro_code + "&factory_id=" + int_factory_id + "&tpl_status=" + int_tpl_status;
            StringBuilder where = new StringBuilder("1=1");


            if (str_pro_name.IsNotNullAndEmpty())
            {
                where.AppendFormat(" and pro_name like '%{0}%'", str_pro_name);
            }
            if (str_pro_code.IsNotNullAndEmpty())
            {
                where.AppendFormat(" and pro_code like '%{0}%'", str_pro_code);
            }
            if (int_tpl_status.IsNumber())
            {
                tpl_status.Text = int_tpl_status;
                where.AppendFormat(" and tpl_status={0}", int_tpl_status);
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
            return status == 1 || status == 2 ? "style='display:none;'" : "";
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string where = getWhere();

            Response.Redirect("Template.Aspx?" + queryStr);
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            string tpl_id_selected = Request["tpl_id"];
            if (tpl_id_selected.IsNullOrEmpty())
            {
                JSHelper.WriteScript("alert('请至少选中一个产品模板');history.back()");
                Response.End();
            }
            string[] arr_tpl_id = tpl_id_selected.Split(',');
            int select_flag = 0;
            SqlHelper helper = LocalSqlHelper.WH;
            for (int i = 0; i < arr_tpl_id.Length; i++)
            {
                if (arr_tpl_id[i].IsNumber())
                {
                    //判断模板是否存在
                    string sql = "select top 1 * from Tb_Working_main with(nolock) where work_id=0 and operator_id=@operator_id and tpl_id=@tpl_id";
                    helper.Params.Clear();
                    helper.Params.Add("operator_id", HttpContext.Current.Session["ManageUserId"].ToString());
                    helper.Params.Add("tpl_id", arr_tpl_id[i]);
                    DataTable dt = helper.ExecDataTable(sql);
                    if (dt.Rows.Count == 0)
                    {
                        //加入WorkingCart
                        helper.Params.Clear();
                        helper.Params.Add("tpl_id", arr_tpl_id[i]);
                        helper.Params.Add("operator_id", HttpContext.Current.Session["ManageUserId"].ToString());
                        helper.Params.Add("quantity", 1);
                        helper.Insert("Tb_Working_main");

                        helper.Params.Clear();
                        int new_wmid=Convert.ToInt32(helper.ExecScalar("select top 1 wm_id from Tb_Working_main order by wm_id desc"));
                        
                        helper.Params.Clear();
                        helper.Params.Add("tpl_id", arr_tpl_id[i]);
                        string sql_new = "insert into dbo.Tb_Working_material(wm_id,tpt_id,pro_txm,pro_id,pro_nums,pro_real_nums) select " + new_wmid + ",tpl_id,pro_txm_from,pro_id_from,pro_nums,pro_nums from dbo.Tb_template_material where tpl_id=@tpl_id ";
                        helper.Execute(sql_new);
                    }
                    select_flag = 1;
                }
            }
            if (select_flag==0)
            {
                JSHelper.WriteScript("alert('请至少选中一个产品模板');history.back()");
                Response.End();
            }

            Response.Redirect("WorkingCart.Aspx?" + queryStr);
        }
    }
}