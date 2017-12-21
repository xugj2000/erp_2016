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
    public partial class addproductinother : System.Web.UI.Page
    {
        protected SqlHelper helper = LocalSqlHelper.WH;
        protected int id = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            SiteHelper.CheckLogin();
            id = Convert.ToInt32(Request["id"]);
            if (!Page.IsPostBack)
            {
                string Sql = "select * from Tb_storage_main where sm_id=@id";
                helper.Params.Add("@id", id);
                DataTable dt = helper.ExecDataTable(Sql);
                if (dt.Rows.Count > 0)
                {
                    sm_supplier.Text = dt.Rows[0]["sm_supplier"].ToString();
                    sm_sn.Text = dt.Rows[0]["sm_sn"].ToString();
                    sm_date.Text = dt.Rows[0]["sm_date"].ToString();
                    sm_operator.Text = dt.Rows[0]["sm_operator"].ToString();
                    sm_remark.Text = dt.Rows[0]["sm_remark"].ToString();
                    sm_type.Text = dt.Rows[0]["sm_type"].ToString();
                }
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            helper.Params.Clear();
            helper.Params.Add("sm_supplier", sm_supplier.Text);
            helper.Params.Add("sm_type", Request["sm_type"]);
            helper.Params.Add("sm_sn", sm_sn.Text);
            helper.Params.Add("sm_date", Request["sm_date"]);
            helper.Params.Add("sm_operator", sm_operator.Text);
            helper.Params.Add("sm_remark", sm_remark.Text);

            if (id == 0)
            {
                helper.Params.Add("sm_adminid", HttpContext.Current.Session["ManageUserId"].ToString());
                helper.Insert("Tb_storage_main");
                int sm_id = Convert.ToInt32(helper.ExecScalar("select top 1 sm_id from Tb_storage_main order by sm_id desc"));

                string p_name = Request.Form["p_name"];
                if (p_name.IsNotNullAndEmpty())
                {
                    string[] arr_p_name = Request.Form["p_name"].Split(',');
                    string[] arr_p_serial = Request.Form["p_serial"].Split(',');
                    string[] arr_p_brand = Request.Form["p_brand"].Split(',');
                    string[] arr_p_unit = Request.Form["p_unit"].Split(',');
                    string[] arr_p_spec = Request.Form["p_spec"].Split(',');
                    string[] arr_p_model = Request.Form["p_model"].Split(',');
                    string[] arr_p_quantity = Request.Form["p_quantity"].Split(',');
                    string[] arr_p_price = Request.Form["p_price"].Split(',');
                    string[] arr_p_baseprice = Request.Form["p_baseprice"].Split(',');
                    for (int i = 0; i < arr_p_name.Length; i++)
                    {
                        if (arr_p_name[i].IsNotNullAndEmpty())
                        {
                            helper.Params.Clear();
                            helper.Params.Add("sm_id", sm_id);
                            helper.Params.Add("p_name", arr_p_name[i]);
                            helper.Params.Add("p_serial", arr_p_serial[i]);
                            helper.Params.Add("p_brand", arr_p_brand[i]);
                            helper.Params.Add("p_unit", arr_p_unit[i]);
                            helper.Params.Add("p_spec", arr_p_spec[i]);
                            helper.Params.Add("p_model", arr_p_model[i]);
                            helper.Params.Add("p_quantity", arr_p_quantity[i].IsNumber() ? arr_p_quantity[i] : "0");
                            helper.Params.Add("p_price", arr_p_price[i].IsNumber() ? arr_p_price[i] : "0");
                            helper.Params.Add("p_baseprice", arr_p_baseprice[i].IsNumber() ? arr_p_baseprice[i] : "0");
                            helper.Insert("Tb_storage_product");
                        }

                    }
                }
            }
            else
            {
                helper.Params.Add("sm_id", id);
                helper.Update("Tb_storage_main", "sm_id");
            }
            JSHelper.WriteScript("alert('编辑成功');location.href='ProductIn.aspx';");
            //Response.Write(RoleList.Text);
            Response.End();
        }
    }
}