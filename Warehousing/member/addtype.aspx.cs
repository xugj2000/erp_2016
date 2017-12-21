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
    public partial class addtype : mypage
    {
        protected SqlHelper helper = LocalSqlHelper.WH;
        protected int type_id = 0;
        protected string type_name = string.Empty;
        protected string type_remark = string.Empty;
        protected string IsLock = "0";

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            SiteHelper.GetPageUrlpower("member/ProductTypeList.aspx");
            if (Session["PowerSuper"].ToString() != "1")
            {
                SiteHelper.NOPowerMessage();
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            type_id = Convert.ToInt32(Request["id"]);
            if (!Page.IsPostBack)
            {
                string Sql = "select * from ProductType where type_id=@id";
                helper.Params.Add("@id", type_id);
                DataTable dt = helper.ExecDataTable(Sql);
                if (dt.Rows.Count > 0)
                {
                    Texttype_name.Text = Convert.ToString(dt.Rows[0]["type_name"]);
                    Texttype_remark.Text = Convert.ToString(dt.Rows[0]["type_remark"]);
                    IsLock = Convert.ToString(dt.Rows[0]["is_hide"]);
                }


            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            helper.Params.Clear();
            helper.Params.Add("type_name", Texttype_name.Text);
            helper.Params.Add("type_remark", Texttype_remark.Text);
            helper.Params.Add("is_hide", Request.Form["IsLock"]);
            if (type_id == 0)
            {
                helper.Insert("ProductType");
            }
            else
            {
                helper.Params.Add("type_id", type_id);
                helper.Update("ProductType", "type_id");
            }
            JSHelper.WriteScript("alert('编辑成功');location.href='ProductTypeList.aspx';");
            //Response.Write(RoleList.Text);
            Response.End();
        }
    }
}