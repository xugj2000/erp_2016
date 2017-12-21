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
    public partial class changerole : System.Web.UI.Page
    {
        protected SqlHelper helper = LocalSqlHelper.WH;
        protected int RoleId = 0;
        protected string memberLoginName = string.Empty;
        protected string memberfullname = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            RoleId = Convert.ToInt32(Request["id"]);
            if (!Page.IsPostBack)
            {
                string oldRoleID=string.Empty;
                string Sql = "select LoginName,fullname,RoleID from wareHouse_Admin where id=@id";
                helper.Params.Add("@id", RoleId);
                DataTable dt = helper.ExecDataTable(Sql);
                if (dt.Rows.Count > 0)
                {
                    memberLoginName = Convert.ToString(dt.Rows[0]["LoginName"]);
                    memberfullname = Convert.ToString(dt.Rows[0]["fullname"]);
                    oldRoleID = Convert.ToString(dt.Rows[0]["RoleID"]);
                }
                BindRoleList(RoleList);
                RoleList.Text = oldRoleID;
            }
        }
        protected void BindRoleList(DropDownList DropDownList)
        {
            string sql = "SELECT ID,RoleName FROM SinoRole order by ID";
            DataTable dt = helper.ExecDataTable(sql);
            BindingHelper.BindDDL(DropDownList, dt, "RoleName", "ID", false);
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string newRoleId = string.Empty;
            newRoleId = RoleList.Text;
            helper.Params.Clear();
            string uSql = "update wareHouse_Admin set RoleID=@RoleID where id=@id";
            helper.Params.Add("@id", RoleId);
            helper.Params.Add("@RoleID", newRoleId);
            helper.Execute(uSql);
            JSHelper.WriteScript("alert('修改成功');location.href='memberlist.aspx';");
            Response.Write(newRoleId);
            Response.End();
        }

    }
}
