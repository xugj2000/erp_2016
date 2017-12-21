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

namespace Warehousing.Production
{
    public partial class addTemplate : mypage
    {
        protected SqlHelper helper = LocalSqlHelper.WH;
        protected int id = 0;
        protected int int_factory_id = 0;
        protected string p_id_old = string.Empty;

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            id = Convert.ToInt32(Request["id"]);
            if (!Page.IsPostBack)
            {
                Session["anti_refresh"] = "1";
                string Sql = "select * from Tb_template where tpl_id=@id";
                helper.Params.Add("@id", id);
                DataTable dt = helper.ExecDataTable(Sql);
                if (dt.Rows.Count > 0)
                {
                    pro_name.Text = dt.Rows[0]["pro_name"].ToString();
                    pro_code.Text = dt.Rows[0]["pro_code"].ToString();
                    do_cost.Text = dt.Rows[0]["do_cost"].ToString();
                    other_cost.Text = dt.Rows[0]["other_cost"].ToString();
                    remark.Text = dt.Rows[0]["remark"].ToString();
                    int_factory_id = Convert.ToInt32(dt.Rows[0]["factory_id"]);
                }
                ProductionHelper.BindFactoryList(factory_id, 0);

                bindTemplatePro(id);
            }
        }


        protected void bindTemplatePro(int tpl_id)
        {
            SqlHelper helper = LocalSqlHelper.WH;
            string sm_sql = "select * from dbo.Tb_template with(nolock) where tpl_id=@tpl_id";
            helper.Params.Add("tpl_id", tpl_id);
            DataTable sm_dt = helper.ExecDataTable(sm_sql);
            if (sm_dt.Rows.Count > 0)
            {
                factory_id.SelectedValue = sm_dt.Rows[0]["factory_id"].ToString();
            }
            helper.Params.Clear();
            string sql = "SELECT a.id,a.pro_nums,b.* FROM dbo.Tb_template_material a left join Prolist b  with(nolock) on a.pro_txm_from=b.pro_txm where a.tpl_id=@tpl_id order by id";
            helper.Params.Add("tpl_id", tpl_id);
            DataTable dt = helper.ExecDataTable(sql);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                if (p_id_old.IsNullOrEmpty())
                {
                    p_id_old = dt.Rows[i]["id"].ToString();
                }
                else
                {
                    p_id_old = p_id_old + "," + dt.Rows[i]["id"].ToString();
                }
            }
            MemberList.DataShow(dt);
        }


        protected void Button1_Click(object sender, EventArgs e)
        {

            if (Session["anti_refresh"] != "1")
            {
                //  JSHelper.WriteScript("alert('请勿重复提交');history.back();");
                //  Response.End();
            }
            Session["anti_refresh"] = "0";

            helper.Params.Clear();
            if (Request["pro_name"].Trim().IsNullOrEmpty() || Request["pro_code"].Trim().IsNullOrEmpty() || Request["factory_id"].IsNullOrEmpty())
            {
                JSHelper.WriteScript("alert('请正确配置商品名称、商品货号以及选择生产工厂');history.back();");
                Response.End();
            }
            helper.Params.Add("pro_name", Request["pro_name"].Trim());
            string str_pro_code = Request["pro_code"].Trim();
            string sql = "select pro_name,pro_code,pro_unit,pro_brand from ProductMain where pro_code like '" + str_pro_code + "'";
            DataTable dt = helper.ExecDataTable(sql);
            if (dt.Rows.Count == 0)
            {
                JSHelper.WriteScript("alert('商品货号不存在，请在采购管理中配置该产品');history.back();");
                Response.End();
            }

            helper.Params.Add("pro_code", Request["pro_code"]);
            helper.Params.Add("factory_id", Request["factory_id"]);
            if (Request["do_cost"].IsNullOrEmpty()||!Request["do_cost"].IsNumber())
            {
                JSHelper.WriteScript("alert('请正确配置加工费用');history.back();");
                Response.End();
            }
            helper.Params.Add("do_cost", Request["do_cost"]);
            if (Request["other_cost"].IsNumber())
            {
                helper.Params.Add("other_cost", Request["other_cost"]);
            }
            helper.Params.Add("remark", remark.Text);

            string p_name = Request.Form["p_name"];
            string[] arr_p_name = Request.Form["p_name"].Split(',');
            string[] arr_p_txm = Request.Form["p_txm"].Split(',');
            string[] arr_p_quantity = Request.Form["p_quantity"].Split(',');

            if (id == 0)
            {


                int p_count = 0;
                if (p_name.IsNotNullAndEmpty())
                {
                    for (int i = 0; i < arr_p_name.Length; i++)
                    {
                        if (arr_p_txm[i].IsNotNullAndEmpty() && arr_p_name[i].IsNotNullAndEmpty())
                        {
                            if (!arr_p_quantity[i].IsNumber())
                            {
                                JSHelper.WriteScript("alert('" + arr_p_txm[i] + "数量要求为数值');history.back();");
                                Response.End();
                            }
                            p_count++;
                        }
                    }
                }
                if (p_count == 0)
                {
                    JSHelper.WriteScript("alert('好歹有些原料吧！');history.back();");
                    Response.End();
                }

                helper.Params.Add("operator", HttpContext.Current.Session["ManageUserId"].ToString());
                helper.Insert("Tb_template");



                int tpl_id = Convert.ToInt32(helper.ExecScalar("select top 1 tpl_id from Tb_template order by tpl_id desc"));
                if (p_name.IsNotNullAndEmpty())
                {
                    for (int i = 0; i < arr_p_name.Length; i++)
                    {
                        if (arr_p_txm[i].IsNotNullAndEmpty() && arr_p_name[i].IsNotNullAndEmpty())
                        {
                            helper.Params.Clear();
                            helper.Params.Add("tpl_id", tpl_id);
                            helper.Params.Add("pro_txm_from", arr_p_txm[i].Trim());
                            helper.Params.Add("pro_nums", arr_p_quantity[i].IsNumber() ? arr_p_quantity[i] : "0");
                            helper.Insert("Tb_template_material");
                        }

                    }
                }
            }
            else
            {
                helper.Params.Add("tpl_id", id);
                helper.Update("Tb_template", "tpl_id");

                string[] arr_p_id = Request.Form["p_id"].Split(',');

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
                        helper.Delete("Tb_template_material", "id=@p_id");
                    }

                }

                for (int i = 0; i < arr_p_name.Length; i++)
                {
                    if (arr_p_txm[i].IsNotNullAndEmpty() && arr_p_name[i].IsNotNullAndEmpty())
                    {
                        helper.Params.Clear();
                        
                        helper.Params.Add("pro_nums", arr_p_quantity[i].IsNumber() ? arr_p_quantity[i] : "0");

                        if (arr_p_id[i] == "0")
                        {
                            helper.Params.Add("tpl_id", id);
                            helper.Params.Add("pro_txm_from", arr_p_txm[i].Trim());
                            helper.Insert("Tb_template_material");
                        }
                        else
                        {
                            helper.Params.Add("id", arr_p_id[i]);
                            helper.Update("Tb_template_material", "id");
                        }
                    }
                }


            }
            JSHelper.WriteScript("alert('编辑成功');location.href='Template.Aspx';");
            //Response.Write(RoleList.Text);
            Response.End();
        }

    }
}