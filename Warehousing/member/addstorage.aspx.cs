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
    public partial class addstorage : mypage
    {
        protected SqlHelper helper = LocalSqlHelper.WH;
        protected int warehouse_id = 0;
        protected string memberwarehouse_name = string.Empty;
        protected string memberwarehouse_address = string.Empty, memberagent_id = string.Empty;
        protected string memberwarehouse_tel = string.Empty;
        protected string IsLock = "0";
        protected int IsCaigou = 0, IsManage=0;

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            if (my_warehouse_id > 0 && myStorageInfo.is_manage == 0)
            {
                JSHelper.WriteScript("alert('非主仓管理员不可进行仓库管理操作！');history.back();");
                Response.End();
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            warehouse_id = Convert.ToInt32(Request["id"]);
            if (!Page.IsPostBack)
            {
                string Sql = "select * from WareHouse_List where warehouse_id=@id";
                helper.Params.Add("@id", warehouse_id);
                DataTable dt = helper.ExecDataTable(Sql);
                int agent_id=0;
                if (dt.Rows.Count > 0)
                {
                    memberwarehouse_name = Convert.ToString(dt.Rows[0]["warehouse_name"]);
                    memberwarehouse_address = Convert.ToString(dt.Rows[0]["warehouse_address"]);
                    memberwarehouse_tel = Convert.ToString(dt.Rows[0]["warehouse_tel"]);
                    agent_id = Convert.ToInt32(dt.Rows[0]["agent_id"]);
                    IsLock = Convert.ToString(dt.Rows[0]["IsLock"]);
                    IsCaigou = Convert.ToInt32(dt.Rows[0]["is_caigou"]);
                    IsManage = Convert.ToInt32(dt.Rows[0]["is_manage"]);
                }
                Textwarehouse_name.Text = memberwarehouse_name;
                Textwarehouse_address.Text = memberwarehouse_address;
                Textwarehouse_tel.Text = memberwarehouse_tel;
                
                
                StorageHelper.BindAgentList(DDAgent_id, agent_id);
                if (myStorageInfo.agent_id > 0)
                {
                    DDAgent_id.Visible = false;
                    LabelAgent.Visible = true;
                    LabelAgent.Text = StorageHelper.getAgentName(myStorageInfo.agent_id);
                    // Textagent_id.Attributes.Add("readonly", "true");   
                    // Textagent_id.ReadOnly = true;
                }
                else
                {
                    DDAgent_id.Visible = true;
                    LabelAgent.Visible = false;
                }


            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            helper.Params.Clear();
            helper.Params.Add("warehouse_address", Textwarehouse_address.Text);
            helper.Params.Add("warehouse_name", Textwarehouse_name.Text);
            helper.Params.Add("warehouse_tel", Textwarehouse_tel.Text);
            if (myStorageInfo.agent_id>0)
            {
                helper.Params.Add("agent_id", myStorageInfo.agent_id);
            }
            else
            {
                helper.Params.Add("agent_id", DDAgent_id.Text);
            }

            helper.Params.Add("IsLock", Request.Form["IsLock"]);

            if ((myStorageInfo.is_manage == 1 && myStorageInfo.agent_id==0) || my_warehouse_id == 0)
            {
                helper.Params.Add("is_caigou", Request.Form["IsCaigou"]);
                helper.Params.Add("is_manage", Request.Form["IsManage"]);
            }


            if (warehouse_id == 0)
            {
                helper.Insert("WareHouse_List");
            }
            else
            {
                helper.Params.Add("warehouse_id", warehouse_id);
                helper.Update("WareHouse_List", "warehouse_id");
            }
            JSHelper.WriteScript("alert('编辑成功');location.href='storagelist.aspx';");
            //Response.Write(RoleList.Text);
            Response.End();
        }
    }
}