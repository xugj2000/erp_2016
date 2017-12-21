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
    public partial class addadmin : mypage
    {
        protected SqlHelper helper = LocalSqlHelper.WH;
        protected int RoleId = 0;
        protected int AdminId = 0;
        protected string memberLoginName = string.Empty;
        protected string memberfullname = string.Empty;
        protected string memberLoginPwd = string.Empty;
        protected string IsLock = "0";

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            if (my_warehouse_id > 0 && myStorageInfo.is_manage == 0)
            {
                JSHelper.WriteScript("alert('没有管理员配置权限');history.back();");
                Response.End();
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            AdminId = Convert.ToInt32(Request["id"]);
            if (!Page.IsPostBack)
            {
                string oldRoleID = string.Empty;
                string oldWarehouseId = "0";
                string Sql = "select * from wareHouse_Admin where id=@id";
                helper.Params.Add("@id", AdminId);
                DataTable dt = helper.ExecDataTable(Sql);
                if (dt.Rows.Count > 0)
                {
                    memberLoginName = Convert.ToString(dt.Rows[0]["LoginName"]);
                    memberfullname = Convert.ToString(dt.Rows[0]["fullname"]);
                    IsLock = Convert.ToString(dt.Rows[0]["IsLock"]);
                    oldRoleID = Convert.ToString(dt.Rows[0]["RoleID"]);
                    oldWarehouseId = Convert.ToString(dt.Rows[0]["warehouse_id"]);
                    
                }
                TextLoginName.Text = memberLoginName;
                Textfullname.Text = memberfullname;
                BindRoleList(RoleList);
                RoleList.Text = oldRoleID;
                string where = "1=1";
                if (myStorageInfo.agent_id>0)
                {
                    where = "warehouse_id in (select warehouse_id from WareHouse_List where agent_id='" + myStorageInfo.agent_id + "')";
                }
                Warehousing.Business.StorageHelper.BindWarehouseList(WarehouseList, Convert.ToInt32(oldWarehouseId), where);
                if (my_warehouse_id > 0 && myStorageInfo.agent_id>0)
                {
                    WarehouseList.Items.RemoveAt(0);
                    WarehouseList.Items.Insert(0,new ListItem("选择仓库","0"));
                }
            }
        }
        protected void BindRoleList(DropDownList DropDownList)
        {
            string sql = "SELECT ID,RoleName FROM SinoRole with(nolock) order by ID";
            if (myStorageInfo.agent_id>0)
            {
                sql = "SELECT ID,RoleName FROM SinoRole with(nolock) where isAgent=1 order by ID";
            }

            DataTable dt = helper.ExecDataTable(sql);
            BindingHelper.BindDDL(DropDownList, dt, "RoleName", "ID", false);
        }


        protected void Button1_Click(object sender, EventArgs e)
        {
            if (TextLoginName.Text.IsNullOrEmpty())
            {
                JSHelper.WriteScript("alert('工号不能为空');history.back();");
                return;
            }
            if (my_warehouse_id > 0)
            {
                if (WarehouseList.Text == "0")
                {
                    JSHelper.WriteScript("alert('请选择所属仓库');history.back();");
                    return;
                }
            }


            helper.Params.Clear();
            helper.Params.Add("fullname", Textfullname.Text);
            helper.Params.Add("LoginName", TextLoginName.Text);
            helper.Params.Add("IsLock", Request.Form["IsLock"]);
            helper.Params.Add("RoleID", RoleList.Text);
            helper.Params.Add("warehouse_id", WarehouseList.Text);
            try
            {
                if (AdminId == 0)
                {
                    if (TextLoginPwd.Text.IsNullOrEmpty())
                    {
                        JSHelper.WriteScript("alert('密码不能为空!');history.back();");
                        return;
                    }

                    helper.Params.Add("LoginPwd", SinoHelper2.StringHelper.ASP16MD5(TextLoginPwd.Text));

                    helper.Insert("wareHouse_Admin");
                }
                else
                {
                    if (TextLoginPwd.Text.IsNotNullAndEmpty())
                    {
                        helper.Params.Add("LoginPwd", SinoHelper2.StringHelper.ASP16MD5(TextLoginPwd.Text));
                    }
                    helper.Params.Add("id", AdminId);
                    helper.Update("wareHouse_Admin", "id");
                }
            }
            catch
            {
                JSHelper.WriteScript("alert('工号已被占用，请更换！');history.back();");
                return;
            }
            JSHelper.WriteScript("alert('编辑成功');location.href='memberlist.aspx';");
            //Response.Write(RoleList.Text);
            Response.End();
        }
    }
}