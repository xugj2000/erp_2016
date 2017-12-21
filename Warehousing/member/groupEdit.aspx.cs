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
    public partial class groupEdit : System.Web.UI.Page
    {
        protected SqlHelper helper = LocalSqlHelper.WH;
        protected int GroupId = 0, isAgent=0;
        protected void Page_Load(object sender, EventArgs e)
        {            
            GroupId = Convert.ToInt32(Request["id"]);
            if (!Page.IsPostBack)
            {
                string RoleName = string.Empty;
                string RoleDes = string.Empty;
                string oldRoleID = string.Empty;
                string Sql = "select RoleName,RoleDes,isAgent from SinoRole where ID=@id";
                helper.Params.Add("@id", GroupId);
                DataTable dt = helper.ExecDataTable(Sql);
                if (dt.Rows.Count > 0)
                {
                    RoleName = Convert.ToString(dt.Rows[0]["RoleName"]);
                    RoleDes = Convert.ToString(dt.Rows[0]["RoleDes"]);
                    isAgent = Convert.ToInt32(dt.Rows[0]["isAgent"]);
                }
                TextRoleName.Text = RoleName;
                TextRoleDes.Text = RoleDes;
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string RoleName = string.Empty;
            string RoleDes = string.Empty;
            RoleName = TextRoleName.Text;
            RoleDes = TextRoleDes.Text;
            isAgent = Convert.ToInt32(Request["isAgent"]);
            string doSql = string.Empty;
            
            if (GroupId == 0)
            {
                doSql="select max(ID)+1 from SinoRole";
                object ai=helper.ExecScalar(doSql);
                if (ai==DBNull.Value)
                {
                    ai=1;
                }
                GroupId=Convert.ToInt32(ai);
                doSql = "insert into SinoRole(ID,RoleName,RoleDes,isAgent) values(@ID,@RoleName,@RoleDes,@isAgent)";
            }
            else
            {
                doSql = "update SinoRole set RoleName=@RoleName,RoleDes=@RoleDes,isAgent=@isAgent where ID=@ID";
            }
            helper.Params.Add("@ID", GroupId);
            helper.Params.Add("@RoleName", RoleName);
            helper.Params.Add("@RoleDes", RoleDes);
            helper.Params.Add("@isAgent", isAgent);
            helper.Execute(doSql);
            JSHelper.WriteScript("alert('修改成功');location.href='membergroup.aspx';");
        }
    }
}
