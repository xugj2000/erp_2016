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
    public partial class grouproles : System.Web.UI.Page
    {
        protected int norecord = 0;
        protected int RoleID = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            SiteHelper.CheckLogin();
            RoleID = Convert.ToInt32(Request["id"]);
            if (RoleID == 0)
            {
               // JSHelper.WriteScript("alert('参数有误');history.back();");
            }

            if (!Page.IsPostBack)
            {
                BindMemberList();
            }
        }
        protected void BindMemberList()
        {
            int ModuleId = 0;
            int i=0;
            string PowerStr = string.Empty;
            string Psql = string.Empty;
            SqlHelper conn = LocalSqlHelper.WH;
            SqlHelper helper = LocalSqlHelper.WH;
            string sql = "select *,p1='',p2='',p3='',p4='',p5='',p6='' from SinoModule  order by OrderNum,ID desc";
            DataTable dt = conn.ExecDataTable(sql);
            conn.Params.Clear();
            if (dt.Rows.Count == 0)
            {
                norecord = 1;
            }
            else
            {
                for (i = 0; i < dt.Rows.Count; i++)
                {
                    ModuleId = Convert.ToInt32(dt.Rows[i]["ID"]);
                    helper.Params.Clear();
                    Psql = "select PowerStr from SinoRoleModule where RoleID=@RoleID and ModuleID=@ModuleId";
                    helper.Params.Add("@RoleID", RoleID);
                    helper.Params.Add("@ModuleId", ModuleId);
                    PowerStr = Convert.ToString(helper.ExecScalar(Psql));
                    if (PowerStr.IsNullOrEmpty())
                    {
                        PowerStr = "000000";
                    }
                    dt.Rows[i]["p1"] = PowerStr.Substring(0, 1)=="1"?" checked":"";
                    dt.Rows[i]["p2"] = PowerStr.Substring(1, 1)=="1"?" checked":"";
                    dt.Rows[i]["p3"] = PowerStr.Substring(2, 1)=="1"?" checked":"";
                    dt.Rows[i]["p4"] = PowerStr.Substring(3, 1)=="1"?" checked":"";
                    dt.Rows[i]["p5"] = PowerStr.Substring(4, 1)=="1"?" checked":"";
                    dt.Rows[i]["p6"] = PowerStr.Substring(5, 1) == "1" ? " checked" : "";
                }
            }
            MemberList.DataShow(dt);

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            SqlHelper conn = LocalSqlHelper.WH;
            string sql = "select ID from SinoModule";

            //将所有相关权限复位
            string resetSql = "update SinoRoleModule set PowerStr='000000' where RoleID=@RoleID";
            conn.Params.Add("@RoleID", RoleID);
            conn.Execute(resetSql);

            DataTable ds = conn.ExecDataTable(sql);
            string p1, p2, p3, p4, p5, p6;
            string PowerStr = string.Empty;
            string checksql = string.Empty;
            string checkID = string.Empty;
            string dosql = string.Empty;

                for (int i=0;i<ds.Rows.Count;i++)
                {
                    p1 = Request["o_" + ds.Rows[i]["ID"] + "_1"];
                    p2 = Request["o_" + ds.Rows[i]["ID"] + "_2"];
                    p3 = Request["o_" + ds.Rows[i]["ID"] + "_3"];
                    p4 = Request["o_" + ds.Rows[i]["ID"] + "_4"];
                    p5 = Request["o_" + ds.Rows[i]["ID"] + "_5"];
                    p6 = Request["o_" + ds.Rows[i]["ID"] + "_6"];
                    if (p1.IsNullOrEmpty()) p1 = "0";
                    if (p2.IsNullOrEmpty()) p2 = "0";
                    if (p3.IsNullOrEmpty()) p3 = "0";
                    if (p4.IsNullOrEmpty()) p4 = "0";
                    if (p5.IsNullOrEmpty()) p5 = "0";
                    if (p6.IsNullOrEmpty()) p6 = "0";
                    PowerStr = p1 + p2 + p3 + p4 + p5 + p6;
                    checksql = "select ID from SinoRoleModule where RoleID=@RoleID and ModuleID=@ModuleID";
                    conn.Params.Clear();
                    conn.Params.Add("@RoleID", RoleID);
                    conn.Params.Add("@ModuleID", ds.Rows[i]["ID"]);
                    checkID =Convert.ToString(conn.ExecScalar(checksql));
                    if (checkID.IsNullOrEmpty())
                    {
                        dosql="insert into SinoRoleModule(RoleID,ModuleID,PowerStr) values(@RoleID,@ModuleID,@PowerStr)";
                    }
                    else
                    {
                        dosql="update SinoRoleModule set RoleID=@RoleID,ModuleID=@ModuleID,PowerStr=@PowerStr where ID="+checkID;
                    }
                    conn.Params.Clear();
                    conn.Params.Add("@RoleID", RoleID);
                    conn.Params.Add("@ModuleID", ds.Rows[i]["ID"]);
                    conn.Params.Add("@PowerStr", PowerStr);
                    conn.Execute(dosql);
                }

             JSHelper.WriteScript("alert('提交成功');location.href='membergroup.aspx';");



        }
    }
}
