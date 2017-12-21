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
using Warehousing.Business;

namespace Warehousing.Storage
{
    public partial class addProductPlan : System.Web.UI.Page
    {
        protected SqlHelper helper = LocalSqlHelper.WH;
        protected int id = 0;
        protected string liushuihao = string.Empty;
        protected double sm_tax_old = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            SiteHelper.CheckLogin();
            SiteHelper.GetPageUrlpower("Storage/ProductPlan.aspx");
            id = Convert.ToInt32(Request["id"]);
            if (!Page.IsPostBack)
            {
                string Sql = "select * from Tb_plan_main where sm_id=@id";
                helper.Params.Add("@id", id);
                DataTable dt = helper.ExecDataTable(Sql);
                int supplierid = 0;
                if (dt.Rows.Count > 0)
                {
                    if (Session["PowerEdit"].ToString() != "1")
                    {
                        SiteHelper.NOPowerMessage();
                    }
                    liushuihao = dt.Rows[0]["sm_sn"].ToString();
                    sm_date.Text = Convert.ToDateTime(dt.Rows[0]["sm_date"]).ToShortDateString();
                    sm_tax.Text = dt.Rows[0]["sm_tax"].ToString();
                    sm_tax_old = Convert.ToDouble(dt.Rows[0]["sm_tax"]);
                    sm_operator.Text = dt.Rows[0]["sm_operator"].ToString();
                    sm_remark.Text = dt.Rows[0]["sm_remark"].ToString();
                    sm_type.Text = dt.Rows[0]["sm_type"].ToString();
                    supplierid = Convert.ToInt32(dt.Rows[0]["sm_supplierid"]);
                }
                else
                {
                    if (Session["PowerAdd"].ToString() != "1")
                    {
                        SiteHelper.NOPowerMessage();
                    }
                }
                StorageHelper.BindSupplierList(sm_supplierid, supplierid);
            }
        }


        protected void Button1_Click(object sender, EventArgs e)
        {
            helper.Params.Clear();
            helper.Params.Add("sm_supplierid", Request["sm_supplierid"]);
            helper.Params.Add("sm_type", Request["sm_type"]);
            helper.Params.Add("warehouse_id", 4);
            helper.Params.Add("sm_tax",sm_tax.Text);
            helper.Params.Add("sm_date", Request["sm_date"]);
            helper.Params.Add("sm_operator", sm_operator.Text);
            helper.Params.Add("sm_remark", sm_remark.Text);
            if (id == 0)
            {
                helper.Params.Add("sm_sn", StorageHelper.getNewCaigouHao("CG"));
                helper.Params.Add("sm_adminid", HttpContext.Current.Session["ManageUserId"].ToString());
                try
                {
                    helper.Insert("Tb_plan_main");
                }
                catch
                {
                    JSHelper.WriteScript("alert('采购计划单号已有记录，不能重复！');history.back();");
                    Response.End();
                }
                int sm_id = Convert.ToInt32(helper.ExecScalar("select top 1 sm_id from Tb_plan_main order by sm_id desc"));

                string p_name = Request.Form["p_name"];
                if (p_name.IsNotNullAndEmpty())
                {
                    string[] arr_p_name = Request.Form["p_name"].Split(',');
                    string[] arr_p_serial = Request.Form["p_serial"].Split(',');
                    string[] arr_p_txm = Request.Form["p_txm"].Split(',');
                    string[] arr_p_brand = Request.Form["p_brand"].Split(',');
                    string[] arr_p_unit = Request.Form["p_unit"].Split(',');
                    string[] arr_p_spec = Request.Form["p_spec"].Split(',');
                    string[] arr_p_model = Request.Form["p_model"].Split(',');
                    string[] arr_p_quantity = Request.Form["p_quantity"].Split(',');
                    string[] arr_p_price = Request.Form["p_price"].Split(',');
                    string[] arr_p_baseprice = Request.Form["p_baseprice"].Split(',');
                    string[] arr_p_baseprice_tax = Request.Form["p_baseprice_tax"].Split(',');
                    for (int i = 0; i < arr_p_name.Length; i++)
                    {
                        if (arr_p_txm[i].IsNotNullAndEmpty() && arr_p_name[i].IsNotNullAndEmpty())
                        {
                            helper.Params.Clear();
                            helper.Params.Add("sm_id", sm_id);
                            helper.Params.Add("p_name", arr_p_name[i]);
                            helper.Params.Add("p_serial", arr_p_serial[i]);
                            helper.Params.Add("p_txm", arr_p_txm[i].Trim());
                            helper.Params.Add("p_brand", arr_p_brand[i]);
                            helper.Params.Add("p_unit", arr_p_unit[i]);
                            helper.Params.Add("p_spec", arr_p_spec[i]);
                            helper.Params.Add("p_model", arr_p_model[i]);
                            helper.Params.Add("p_quantity", arr_p_quantity[i].IsNumber() ? arr_p_quantity[i] : "0");
                            helper.Params.Add("p_price", arr_p_price[i].IsNumber() ? arr_p_price[i] : "0");
                            helper.Params.Add("p_baseprice", arr_p_baseprice[i].IsNumber() ? arr_p_baseprice[i] : "0");
                            helper.Params.Add("p_baseprice_tax", arr_p_baseprice_tax[i].IsNumber() ? arr_p_baseprice_tax[i] : "0");
                            helper.Insert("Tb_plan_product");
                        }

                    }
                }
            }
            else
            {
                helper.Params.Add("sm_id", id);
                helper.Update("Tb_plan_main", "sm_id");

                //若税率改变，要对相应商品税前价做出改变
                sm_tax_old = Convert.ToDouble(Request["sm_tax_old"]);
                if (Convert.ToDouble(sm_tax.Text) != sm_tax_old)
                {
                    string ProSql = "update Tb_plan_product set p_baseprice=p_baseprice_tax/(1+" + sm_tax.Text + ") where sm_id=" + id;
                   // Response.Write(ProSql);
                    //Response.End();
                    helper.Params.Clear();
                    helper.Execute(ProSql);
                }
            }
            JSHelper.WriteScript("alert('编辑成功');location.href='ProductPlan.aspx';");
            //Response.Write(RoleList.Text);
            Response.End();
        }
    }
}