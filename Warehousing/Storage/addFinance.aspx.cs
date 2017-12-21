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
    public partial class addFinance : System.Web.UI.Page
    {
        protected SqlHelper helper = LocalSqlHelper.WH;
        protected int id = 0, sm_id=0,work_id=0;
        protected string IsCancel = "0";
        protected string object_type = "Storage";
        protected void Page_Load(object sender, EventArgs e)
        {
            SiteHelper.CheckLogin();
            SiteHelper.GetPageUrlpower("Storage/ProductOut.aspx");
            id = Convert.ToInt32(Request["id"]);
            sm_id = Convert.ToInt32(Request["sm_id"]);
            work_id = Convert.ToInt32(Request["work_id"]);
            if (sm_id > 0 && work_id > 0)
            {
                 JSHelper.WriteScript("alert('工单有误');history.back();");
                 Response.End();
            }
            if (sm_id > 0)
            {
                object_type = "Storage";

               // JSHelper.WriteScript("alert('请对应相应工单');history.back();");
               // Response.End();
            }
            if (work_id > 0)
            {
                object_type = "process";
            }
            if (!Page.IsPostBack)
            {
                string Sql = "select * from Tb_FinancialFlow where id=@id";
                helper.Params.Add("@id", id);
                DataTable dt = helper.ExecDataTable(Sql);
                if (dt.Rows.Count > 0)
                {
                    if (Session["PowerEdit"].ToString() != "1")
                    {
                        SiteHelper.NOPowerMessage();
                    }
                    Textpay_money.Text = Convert.ToString(dt.Rows[0]["pay_money"]);
                    Textpay_date.Text = Convert.ToString(dt.Rows[0]["pay_date"]);
                    Textpay_worker.Text = Convert.ToString(dt.Rows[0]["pay_worker"]);
                    Textreceive_worker.Text = Convert.ToString(dt.Rows[0]["receive_worker"]);
                    Textremark.Text = Convert.ToString(dt.Rows[0]["remark"]);
                    IsCancel = Convert.ToString(dt.Rows[0]["is_cancel"]);
                }
                else
                {
                    if (Session["PowerAdd"].ToString() != "1")
                    {
                        SiteHelper.NOPowerMessage();
                    }
                }
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            helper.Params.Clear();
            helper.Params.Add("pay_date", Request["Textpay_date"]);
            helper.Params.Add("pay_money", Textpay_money.Text);
            helper.Params.Add("pay_worker", Textpay_worker.Text);
            helper.Params.Add("receive_worker", Textreceive_worker.Text);
            helper.Params.Add("is_cancel", Request.Form["IsCancel"]);
            helper.Params.Add("remark", Textremark.Text);
           
            string object_url = string.Empty;
            if (object_type == "Storage")
            {
                object_url = "/Storage/ProductFinance.aspx?id=" + sm_id;
            }
            else
            {
                object_url = "/Production/WorkFinance.aspx?id=" + work_id;
            }
            
            if (id == 0)
            {
                helper.Params.Add("object_type", object_type);
                helper.Params.Add("sm_id", sm_id + work_id);
                helper.Params.Add("admin_id", HttpContext.Current.Session["ManageUserId"].ToString());
                helper.Insert("Tb_FinancialFlow");
                //JSHelper.WriteScript("alert('登记成功!');window.parent.frames[0].location.reload();");
                JSHelper.WriteScript("window.parent.frames[0].location.href = \"" + object_url + "\";");
                Response.End();
            }
            else
            {
                helper.Params.Add("id", id);
                helper.Update("Tb_FinancialFlow", "id");
               // ;
                JSHelper.WriteScript("window.parent.frames[0].location.href = \"" + object_url + "\";");
               // JSHelper.WriteScript("alert('修改成功!');window.parent.frames[0].location.reload();");
                Response.End();
            }
        }
    }
}