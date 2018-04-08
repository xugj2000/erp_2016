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
    public partial class addproductin : mypage
    {
        protected SqlHelper helper = LocalSqlHelper.WH;
        protected int id = 0;
        protected string liushuihao = string.Empty;
        protected int int_warehouse_id = 0;

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            if (my_warehouse_id > 0 && myStorageInfo.is_caigou == 0)
            {
                JSHelper.WriteScript("alert('没有直接采购入库权限');history.back();");
                Response.End();
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {

            id = Convert.ToInt32(Request["id"]);
            if (!Page.IsPostBack)
            {
                Session["anti_refresh"] = "1";
                string Sql = "select * from Tb_storage_main where sm_id=@id";
                helper.Params.Add("@id", id);
                DataTable dt = helper.ExecDataTable(Sql);
                int supplierid = 0;
                if (dt.Rows.Count > 0)
                {
                    liushuihao = dt.Rows[0]["sm_sn"].ToString();
                    sm_date.Text = Convert.ToDateTime(dt.Rows[0]["sm_date"]).ToShortDateString();
                    sm_operator.Text = dt.Rows[0]["sm_operator"].ToString();
                    sm_remark.Text = dt.Rows[0]["sm_remark"].ToString();
                    sm_type.Text = dt.Rows[0]["sm_type"].ToString();
                    supplierid = Convert.ToInt32(dt.Rows[0]["sm_supplierid"]);
                    int_warehouse_id = Convert.ToInt32(dt.Rows[0]["warehouse_id"]);
                    string relate_sn = Convert.ToString(dt.Rows[0]["relate_sn"]);
                    if (relate_sn.IsNotNullAndEmpty())
                    {
                        relateActive.Items.Add(new ListItem(relate_sn, relate_sn));
                        relateActive.Text = relate_sn;
                    }
                }
                
                Warehousing.Business.StorageHelper.BindCaiguoWarehouse(warehouse_id, int_warehouse_id, my_warehouse_id.ToString(), "");
                StorageHelper.BindSupplierList(sm_supplierid, supplierid);
            }
        }


        protected void bindFactoryPro(int work_id)
        {
            SqlHelper helper = LocalSqlHelper.WH;
            string sm_sql = "select *,p_box='' from Tb_Working_main with(nolock) where work_id=@work_id ";
            helper.Params.Add("sm_id", work_id);
            DataTable sm_dt = helper.ExecDataTable(sm_sql);
            if (sm_dt.Rows.Count > 0)
            {
                sm_type.SelectedValue = Convert.ToInt32(StorageType.生产入库).ToString();
            }
            helper.Params.Clear();


            string sql = "SELECT *,shelf_no='',p_box='' FROM Tb_Working_main a left join Prolist with(nolock) where sm_id=@sm_id order by p_id";
            helper.Params.Add("work_id", work_id);
            DataTable dt = helper.ExecDataTable(sql);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                dt.Rows[i]["shelf_no"] = StorageHelper.getShelfNo(Convert.ToInt32(dt.Rows[i]["pro_id"]), Convert.ToInt32(sm_dt.Rows[0]["warehouse_id_from"]));
            }
           // MemberList.DataShow(dt);
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (Session["anti_refresh"]!="1")
            {
              //  JSHelper.WriteScript("alert('请勿重复提交');history.back();");
              //  Response.End();
            }
            Session["anti_refresh"] = "0";
            helper.BeginTran();
            try
            {
                //helper.Params.Clear();
                helper.Params.Add("sm_supplierid", Request["sm_supplierid"]);
                helper.Params.Add("sm_type", Request["sm_type"]);
                helper.Params.Add("warehouse_id", Request["warehouse_id"]);
                helper.Params.Add("sm_date", Request["sm_date"]);
                helper.Params.Add("relate_sn", Request["relateActive"]);
                helper.Params.Add("sm_operator", sm_operator.Text);
                helper.Params.Add("sm_remark", sm_remark.Text);
                helper.Params.Add("sm_direction", "入库");
                if (id == 0)
                {
                    helper.Params.Add("sm_sn", StorageHelper.getNewChurukuHao("RK"));
                    helper.Params.Add("sm_adminid", HttpContext.Current.Session["ManageUserId"].ToString());
                    //try{
                    helper.InsertTrans("Tb_storage_main");
                    //}
                    // catch
                    //{
                    //   JSHelper.WriteScript("alert('入库单号已有记录，不能重复！');history.back();");
                    //    Response.End();
                    //}
                    int sm_id = Convert.ToInt32(helper.ExecScalar("select top 1 sm_id from Tb_storage_main order by sm_id desc"));

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
                                string checksql = "select top 1 1 from product where pro_txm like '" + arr_p_txm[i] + "'";
                                DataTable checkdt = helper.ExecDataTable(checksql);
                                if (checkdt.Rows.Count > 0)
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
                                    helper.InsertTrans("Tb_storage_product");
                                }
                                else
                                {
                                    SiteHelper.writeLog("入库条码检查", arr_p_txm[i] + "不存在");
                                }
                            }

                        }
                    }
                    else
                    {
                        helper.RollbackTran();
                        JSHelper.WriteScript("alert('请添加商品！');");
                        Response.End();
                    }
                }
                else
                {
                    helper.Params.Add("sm_id", id);
                    helper.UpdateTrans("Tb_storage_main", "sm_id");
                }
                helper.CommitTran();
                JSHelper.WriteScript("alert('编辑成功');location.href='ProductIn.aspx';");
            }
            catch (Exception ex)
            {
                helper.RollbackTran();
                JSHelper.WriteScript("alert('有异常:"+ex.Message+"');location.href='ProductIn.aspx';");
            }
            //Response.Write(RoleList.Text);
            Response.End();
        }
    }
}