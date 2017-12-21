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
using Warehousing.Business;

namespace Warehousing.Production
{
    public partial class TemplateDetail : mypage
    {
        protected SqlHelper helper = LocalSqlHelper.WH;
        protected int id = 0;
        protected int int_factory_id = 0;

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            id = Convert.ToInt32(Request["id"]);
            if (!Page.IsPostBack)
            {
                Session["anti_refresh"] = "1";
                string Sql = "select * from Tb_template where tpl_id=@id";
                helper.Params.Add("@id", id);
                DataTable dt = helper.ExecDataTable(Sql);
                if (dt.Rows.Count > 0)
                {
                    pro_name.Text = dt.Rows[0]["pro_name"].ToString();
                    pro_code.Text = dt.Rows[0]["pro_code"].ToString();
                    do_cost.Text = dt.Rows[0]["do_cost"].ToString();
                    other_cost.Text = dt.Rows[0]["other_cost"].ToString();
                    remark.Text = dt.Rows[0]["remark"].ToString();
                    int_factory_id = Convert.ToInt32(dt.Rows[0]["factory_id"]);
                }
                ProductionHelper.BindFactoryList(factory_id, 0);

                bindTemplatePro(id);
            }
        }


        protected void bindTemplatePro(int tpl_id)
        {
            SqlHelper helper = LocalSqlHelper.WH;
            string sm_sql = "select * from dbo.Tb_template with(nolock) where tpl_id=@tpl_id";
            helper.Params.Add("tpl_id", tpl_id);
            DataTable sm_dt = helper.ExecDataTable(sm_sql);
            if (sm_dt.Rows.Count > 0)
            {
                factory_id.SelectedValue = sm_dt.Rows[0]["factory_id"].ToString();
            }
            helper.Params.Clear();
            string sql = "SELECT a.pro_nums,b.* FROM dbo.Tb_template_material a left join Prolist b  with(nolock) on a.pro_txm_from=b.pro_txm where a.tpl_id=@tpl_id order by id";
            helper.Params.Add("tpl_id", tpl_id);
            DataTable dt = helper.ExecDataTable(sql);
            for (int i = 0; i < dt.Rows.Count; i++)
            {

            }
            MemberList.DataShow(dt);
        }


       
    }
}