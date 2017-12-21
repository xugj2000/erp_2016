﻿using System;
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
    public partial class ProductPlanOne : System.Web.UI.Page
    {
        protected int norecord = 0;
        protected string p_id_old = string.Empty;
        protected int id = 0;
        protected double sm_tax = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            SiteHelper.CheckLogin();
            SiteHelper.GetPageUrlpower("Storage/ProductPlan.aspx");
            if (Session["PowerEdit"].ToString() != "1")
            {
                SiteHelper.NOPowerMessage();
            }
            id = Convert.ToInt32(Request["id"]);
            if (!Page.IsPostBack)
            {
                BindMemberList(1, getWhere());
            }
        }
        protected void BindMemberList(int index, string where)
        {
            int count = 0;
            SqlHelper conn = LocalSqlHelper.WH;
            sm_tax =Convert.ToDouble(conn.ExecScalar("select sm_tax from Tb_plan_main with(nolock) where sm_id="+id.ToString()));
            conn.Params.Clear();
            string sql = "select * from Tb_plan_product with(nolock) where " + where + "  order by p_name,p_spec";
            DataTable dt = conn.ExecDataTable(sql);
            if (dt.Rows.Count == 0)
            {
                norecord = 1;
            }
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                if (p_id_old.IsNullOrEmpty())
                {
                    p_id_old = dt.Rows[i]["p_id"].ToString();
                }
                else
                {
                    p_id_old = p_id_old + "," + dt.Rows[i]["p_id"].ToString();
                }
            }
            MemberList.DataShow(dt);
        }

        protected void AspNetPager1_PageChanging(object src, Wuqi.Webdiyer.PageChangingEventArgs e)
        {
            BindMemberList(e.NewPageIndex, getWhere());
        }

        private string getWhere()
        {
            string where = "sm_id=" + id.ToString();
            return where;
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            SqlHelper helper = LocalSqlHelper.WH;
            string p_name = Request.Form["p_name"];
            string old_p_id = Request.Form["old_p_id"];
            if (p_name.IsNotNullAndEmpty())
            {
                string err = string.Empty;

                string[] arr_p_id, arr_p_name, arr_p_txm, arr_p_serial, arr_p_brand, arr_p_unit, arr_p_spec, arr_p_model, arr_p_quantity, arr_p_price, arr_p_baseprice, arr_p_baseprice_tax;

                arr_p_id = Request.Form["p_id"].Split(',');
                arr_p_txm = Request.Form["p_txm"].Split(',');
                arr_p_name = Request.Form["p_name"].Split(',');
                arr_p_serial = Request.Form["p_serial"].Split(',');
                arr_p_brand = Request.Form["p_brand"].Split(',');
                arr_p_unit = Request.Form["p_unit"].Split(',');
                arr_p_spec = Request.Form["p_spec"].Split(',');
                arr_p_model = Request.Form["p_model"].Split(',');
                arr_p_quantity = Request.Form["p_quantity"].Split(',');
                arr_p_price = Request.Form["p_price"].Split(',');
                arr_p_baseprice = Request.Form["p_baseprice"].Split(',');
                arr_p_baseprice_tax = Request.Form["p_baseprice_tax"].Split(',');
                //比较删除旧有的记录
                string[] arr_old_p_id = Request.Form["old_p_id"].Split(',');
                for (int i = 0; i < arr_old_p_id.Length; i++)
                {
                    int hasflag = 0;
                    for (int j = 0; j < arr_p_id.Length; j++)
                    {
                        if (arr_old_p_id[i] == arr_p_id[j])
                        {
                            hasflag = 1;
                            break;
                        }
                    }
                    if (hasflag == 0)
                    {
                        //将该商品删除
                        helper.Params.Clear();
                        helper.Params.Add("p_id", arr_old_p_id[i]);
                        helper.Delete("Tb_plan_product", "p_id=@p_id");
                    }

                }


                for (int i = 0; i < arr_p_name.Length; i++)
                {
                    if (arr_p_txm[i].IsNotNullAndEmpty() && arr_p_name[i].IsNotNullAndEmpty())
                    {
                        helper.Params.Clear();
                        helper.Params.Add("sm_id", id);
                        helper.Params.Add("p_txm", arr_p_txm[i].Trim());
                        helper.Params.Add("p_name", arr_p_name[i]);
                        helper.Params.Add("p_serial", arr_p_serial[i]);
                        helper.Params.Add("p_brand", arr_p_brand[i]);
                        helper.Params.Add("p_unit", arr_p_unit[i]);
                        helper.Params.Add("p_spec", arr_p_spec[i]);
                        helper.Params.Add("p_model", arr_p_model[i]);
                        helper.Params.Add("p_quantity", arr_p_quantity[i].IsNumber() ? arr_p_quantity[i] : "0");
                        helper.Params.Add("p_price", arr_p_price[i].IsNumber() ? arr_p_price[i] : "0");
                        helper.Params.Add("p_baseprice", arr_p_baseprice[i].IsNumber() ? arr_p_baseprice[i] : "0");
                        helper.Params.Add("p_baseprice_tax", arr_p_baseprice_tax[i].IsNumber() ? arr_p_baseprice_tax[i] : "0");
                        if (arr_p_id[i] == "0")
                        {
                            helper.Insert("Tb_plan_product");
                        }
                        else
                        {
                            helper.Params.Add("p_id", arr_p_id[i]);
                            helper.Update("Tb_plan_product", "p_id");
                        }
                    }
                }

            }
            JSHelper.WriteScript("alert('编辑成功');location.href='ProductPlan.aspx';");
            //Response.Write(RoleList.Text);
            Response.End();
        }
    }
}