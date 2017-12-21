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

namespace Warehousing.Storage
{
    public partial class addsupplier : mypage
    {
        protected SqlHelper helper = LocalSqlHelper.WH;
        protected int id = 0;
        protected string membersupplier_name = string.Empty;
        protected string membersupplier_address = string.Empty;
        protected string memberserviceTel = string.Empty;
        protected string IsLock = "0", IsFactory="0";

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            SiteHelper.GetPageUrlpower("Storage/SupplierList.aspx");
            id = Convert.ToInt32(Request["id"]);

            if (!Page.IsPostBack)
            {
                string Sql = "select * from supplier where id=@id";
                helper.Params.Add("@id", id);
                DataTable dt = helper.ExecDataTable(Sql);
                if (dt.Rows.Count > 0)
                {
                    if (Session["PowerEdit"].ToString() != "1")
                    {
                        SiteHelper.NOPowerMessage();
                    }
                    membersupplier_name = Convert.ToString(dt.Rows[0]["supplier_name"]);
                    membersupplier_address = Convert.ToString(dt.Rows[0]["supplier_address"]);
                    memberserviceTel = Convert.ToString(dt.Rows[0]["serviceTel"]);
                    IsLock = Convert.ToString(dt.Rows[0]["IsLock"]);
                    IsFactory = Convert.ToString(dt.Rows[0]["IsFactory"]);
                }
                else
                {
                    if (Session["PowerAdd"].ToString() != "1")
                    {
                        SiteHelper.NOPowerMessage();
                    }
                }
                Textsupplier_name.Text = membersupplier_name;
                Textsupplier_address.Text = membersupplier_address;
                TextserviceTel.Text = memberserviceTel;
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            helper.Params.Clear();
            helper.Params.Add("supplier_address", Textsupplier_address.Text);
            helper.Params.Add("supplier_name", Textsupplier_name.Text);
            helper.Params.Add("serviceTel", TextserviceTel.Text);
            helper.Params.Add("IsLock", Request.Form["IsLock"]);
            helper.Params.Add("IsFactory",0);
            
            if (id == 0)
            {

                helper.Insert("supplier");
            }
            else
            {
                helper.Params.Add("id", id);
                helper.Update("supplier", "id");
            }
            JSHelper.WriteScript("alert('编辑成功');location.href='SupplierList.aspx';");
            //Response.Write(RoleList.Text);
            Response.End();
        }
    }
}