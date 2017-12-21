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
    public partial class addProductNeed : mypage
    {
        protected SqlHelper helper = LocalSqlHelper.WH;
        protected int id = 0;
        protected string liushuihao = string.Empty;
        protected int int_from_warehouse_id = 0, int_to_warehouse_id = 0;

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            id = Convert.ToInt32(Request["id"]);
            if (!Page.IsPostBack)
            {
                int int_sm_type = 0;
                string Sql = "select * from Tb_need_main where sm_id=@id";
                helper.Params.Add("@id", id);
                DataTable dt = helper.ExecDataTable(Sql);
                if (dt.Rows.Count > 0)
                {
                    liushuihao = dt.Rows[0]["sm_sn"].ToString();
                    sm_date.Text = Convert.ToDateTime(dt.Rows[0]["sm_date"]).ToShortDateString();
                    sm_operator.Text = dt.Rows[0]["sm_operator"].ToString();
                    sm_remark.Text = dt.Rows[0]["sm_remark"].ToString();
                    int_from_warehouse_id = Convert.ToInt32(dt.Rows[0]["warehouse_id_from"]);
                    int_to_warehouse_id = Convert.ToInt32(dt.Rows[0]["warehouse_id"]);
                    int_sm_type = Convert.ToInt32(dt.Rows[0]["sm_type"]);
                }
                int warehouse_id = Convert.ToInt32(Request.Cookies["userInfo"]["warehouse_id"]);
                
                Warehousing.Business.StorageHelper.BindWarehouseList(to_warehouse_id, int_to_warehouse_id,warehouse_id.ToString(),"" );

                string where = string.Empty;
                if (myStorageInfo.warehouse_id > 0)
                {
                    if (myStorageInfo.is_manage == 1)
                    {
                        where = " is_manage=1 and agent_id=0";
                    }
                    else
                    {
                        where += "is_manage=1 and agent_id='" + myStorageInfo.agent_id + "'";
                    }
                }
                //Response.Write(where);
                Warehousing.Business.StorageHelper.BindWarehouseList(from_warehouse_id, int_from_warehouse_id, where);
            }
        }


        protected void Button1_Click(object sender, EventArgs e)
        {
                if (Request["from_warehouse_id"] == Request["to_warehouse_id"])
                {
                    JSHelper.WriteScript("alert('不能在同仓库间申请');history.back();");
                    Response.End();
                }

            helper.Params.Clear();
            helper.Params.Add("warehouse_id", Request["to_warehouse_id"]);
            helper.Params.Add("warehouse_id_from", Request["from_warehouse_id"]);
            helper.Params.Add("sm_date", Request["sm_date"]);
            helper.Params.Add("sm_operator", sm_operator.Text);
            helper.Params.Add("sm_remark", sm_remark.Text);
            if (id == 0)
            {
                helper.Params.Add("sm_sn", StorageHelper.getNewChurukuHao("SQ"));
                helper.Params.Add("sm_adminid", HttpContext.Current.Session["ManageUserId"].ToString());
                try
                {
                    helper.Insert("Tb_need_main");
                }
                catch
                {
                    JSHelper.WriteScript("alert('出库单号已有记录，不能重复！');history.back();");
                    Response.End();
                }
                int sm_id = Convert.ToInt32(helper.ExecScalar("select top 1 sm_id from Tb_need_main order by sm_id desc"));

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
                            helper.Insert("Tb_need_product");
                        }

                    }
                }
            }
            else
            {
                helper.Params.Add("sm_id", id);
                helper.Update("Tb_need_main", "sm_id");
            }
            JSHelper.WriteScript("alert('编辑成功');location.href='ProductNeedList.aspx';");
            //Response.Write(RoleList.Text);
            Response.End();
        }
    }
}