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
using Warehousing.Model;
using Warehousing.Business;

namespace Warehousing.member
{
    public partial class addbrand : mypage
    {
        protected SqlHelper helper = LocalSqlHelper.WH;
        protected int brand_id = 0;
        protected string brand_name = string.Empty;
        protected string brand_remark = string.Empty;
        protected string IsLock = "0";

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            SiteHelper.GetPageUrlpower("member/Brandlist.aspx");
            if (Session["PowerSuper"].ToString() != "1")
            {
                SiteHelper.NOPowerMessage();
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            brand_id = Convert.ToInt32(Request["id"]);
            if (!Page.IsPostBack)
            {
                string Sql = "select * from Tb_brand where brand_id=@id";
                helper.Params.Add("@id", brand_id);
                DataTable dt = helper.ExecDataTable(Sql);
                if (dt.Rows.Count > 0)
                {
                    Textbrand_name.Text = Convert.ToString(dt.Rows[0]["brand_name"]);
                    Textbrand_remark.Text = Convert.ToString(dt.Rows[0]["brand_remark"]);
                    IsLock = Convert.ToString(dt.Rows[0]["is_hide"]);
                }


            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            helper.Params.Clear();
            helper.Params.Add("brand_name", Textbrand_name.Text);
            helper.Params.Add("brand_remark", Textbrand_remark.Text);
            helper.Params.Add("is_hide", Request.Form["IsLock"]);
            if (brand_id == 0)
            {
                helper.Insert("Tb_brand");
            }
            else
            {
                helper.Params.Add("brand_id", brand_id);
                helper.Update("Tb_brand", "brand_id");
            }
            JSHelper.WriteScript("alert('编辑成功');location.href='brandList.aspx';");
            //Response.Write(RoleList.Text);
            Response.End();
        }
    }
}