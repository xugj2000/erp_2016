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

namespace Warehousing.member
{
    public partial class addpage : System.Web.UI.Page
    {
        protected SqlHelper helper = LocalSqlHelper.WH;
        protected int GroupId = 0;
        protected string IsShow = "0";
        protected void Page_Load(object sender, EventArgs e)
        {
            GroupId = Convert.ToInt32(Request["id"]);
            if (!Page.IsPostBack)
            {
                string ModuleName = string.Empty;
                string ModuleDesc = string.Empty;
                string PageUrl = string.Empty;
                string OrderNum = string.Empty;
                string oldRoleID = string.Empty;
                string Sql = "select * from SinoModule where ID=@id";
                helper.Params.Add("@id", GroupId);
                DataTable dt = helper.ExecDataTable(Sql);
                if (dt.Rows.Count > 0)
                {
                    ModuleName = Convert.ToString(dt.Rows[0]["ModuleName"]);
                    ModuleDesc = Convert.ToString(dt.Rows[0]["ModuleDesc"]);
                    OrderNum = Convert.ToString(dt.Rows[0]["OrderNum"]);
                    PageUrl = Convert.ToString(dt.Rows[0]["PageUrl"]);
                    IsShow = Convert.ToString(dt.Rows[0]["IsShow"]);
                }
                else
                {
                    OrderNum = "0";
                }
                TextModuleName.Text = ModuleName;
                TextModuleDesc.Text = ModuleDesc;
                TextOrderNum.Text = OrderNum;
                TextPageUrl.Text = PageUrl;
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string ModuleName = string.Empty;
            string ModuleDesc = string.Empty;
            string PageUrl = string.Empty;
            string OrderNum = string.Empty;
            string IsShow = "0";
            ModuleName = TextModuleName.Text;
            ModuleDesc = TextModuleDesc.Text;
            PageUrl = TextPageUrl.Text;
            OrderNum = TextOrderNum.Text;
            IsShow = Request["IsShow"];
            string doSql = string.Empty;
            if (GroupId == 0)
            {
                doSql = "select max(ID)+1 from SinoModule";
                object ai = helper.ExecScalar(doSql);
                if (ai == DBNull.Value)
                {
                    ai = 1;
                }
                GroupId = Convert.ToInt32(ai);
                doSql = "insert into SinoModule(ID,ModuleName,PageUrl,OrderNum,ModuleDesc,IsShow) values(@ID,@ModuleName,@PageUrl,@OrderNum,@ModuleDesc,@IsShow)";
            }
            else
            {
                doSql = "update SinoModule set ModuleName=@ModuleName,PageUrl=@PageUrl,OrderNum=@OrderNum,ModuleDesc=@ModuleDesc,IsShow=@IsShow where ID=@ID";
            }
            helper.Params.Add("@ID", GroupId);
            helper.Params.Add("@ModuleName", ModuleName);
            helper.Params.Add("@PageUrl", PageUrl);
            helper.Params.Add("@OrderNum", OrderNum);
            helper.Params.Add("@ModuleDesc", ModuleDesc);
            helper.Params.Add("@IsShow", IsShow);
            helper.Execute(doSql);
            JSHelper.WriteScript("alert('提交成功');location.href='pagepriv.aspx';");
        }
    }
}
