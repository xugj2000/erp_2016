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
    public partial class addguide : mypage
    {
        protected SqlHelper helper = LocalSqlHelper.WH;
        protected int guide_id = 0;
        protected string guide_name = string.Empty;
        protected string guide_remark = string.Empty;
        protected string IsLock = "0";

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            if (my_warehouse_id > 0 && myStorageInfo.is_manage == 0)
            {
                JSHelper.WriteScript("alert('非导购管理员不可进行导购管理操作！');history.back();");
                Response.End();
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            guide_id = Convert.ToInt32(Request["id"]);
            if (!Page.IsPostBack)
            {
                string Sql = "select * from Tb_guide_staff where guide_id=@id";
                helper.Params.Add("@id", guide_id);
                DataTable dt = helper.ExecDataTable(Sql);
                if (dt.Rows.Count > 0)
                {
                    Textguide_name.Text = Convert.ToString(dt.Rows[0]["guide_name"]);
                    Textguide_remark.Text = Convert.ToString(dt.Rows[0]["guide_remark"]);
                    IsLock = Convert.ToString(dt.Rows[0]["is_hide"]);
                }


            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            helper.Params.Clear();
            helper.Params.Add("guide_name", Textguide_name.Text);
            helper.Params.Add("guide_remark", Textguide_remark.Text);
            helper.Params.Add("is_hide", Request.Form["IsLock"]);
            if (guide_id == 0)
            {
                helper.Params.Add("store_id", my_warehouse_id);
                helper.Insert("Tb_guide_staff");
            }
            else
            {
                helper.Params.Add("guide_id", guide_id);
                helper.Update("Tb_guide_staff", "guide_id");
            }
            JSHelper.WriteScript("alert('编辑成功');location.href='GuideList.aspx';");
            //Response.Write(RoleList.Text);
            Response.End();
        }
    }
}