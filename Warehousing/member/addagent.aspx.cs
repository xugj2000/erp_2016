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
    public partial class addagent : mypage
    {
        protected SqlHelper helper = LocalSqlHelper.WH;
        protected int Agent_id = 0;
        protected string Agent_name = string.Empty;
        protected string Agent_remark = string.Empty;
        protected string IsLock = "0";

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            SiteHelper.GetPageUrlpower("member/Agentlist.aspx");
            if (Session["PowerSuper"].ToString() != "1")
            {
                SiteHelper.NOPowerMessage();
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            Agent_id = Convert.ToInt32(Request["id"]);
            if (!Page.IsPostBack)
            {
                string Sql = "select * from Tb_Agent where Agent_id=@id";
                helper.Params.Add("@id", Agent_id);
                DataTable dt = helper.ExecDataTable(Sql);
                if (dt.Rows.Count > 0)
                {
                    TextAgent_name.Text = Convert.ToString(dt.Rows[0]["Agent_name"]);
                    TextAgent_remark.Text = Convert.ToString(dt.Rows[0]["Agent_remark"]);
                    IsLock = Convert.ToString(dt.Rows[0]["is_hide"]);
                }


            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            helper.Params.Clear();
            helper.Params.Add("Agent_name", TextAgent_name.Text);
            helper.Params.Add("Agent_remark", TextAgent_remark.Text);
            helper.Params.Add("is_hide", Request.Form["IsLock"]);
            if (Agent_id == 0)
            {
                helper.Insert("Tb_Agent");
            }
            else
            {
                helper.Params.Add("Agent_id", Agent_id);
                helper.Update("Tb_Agent", "Agent_id");
            }
            JSHelper.WriteScript("alert('编辑成功');location.href='AgentList.aspx';");
            //Response.Write(RoleList.Text);
            Response.End();
        }
    }
}