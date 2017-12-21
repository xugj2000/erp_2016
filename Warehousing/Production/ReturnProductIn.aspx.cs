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
    public partial class ReturnProductIn : mypage
    {
        protected SqlHelper helper = LocalSqlHelper.WH;
        protected int work_id = 0;
        protected string work_sn = string.Empty;
        protected int int_warehouse_id = 0;

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
        }

        protected void Page_Load(object sender, EventArgs e)
        {

            work_id = Convert.ToInt32(Request["work_id"]);
            if (!Page.IsPostBack)
            {
                Session["anti_refresh"] = "1";
                string Sql = "select * from Tb_Working where work_id=@work_id";
                helper.Params.Add("@work_id", work_id);
                DataTable dt = helper.ExecDataTable(Sql);
                int supplierid = 0;
                if (dt.Rows.Count > 0)
                {
                    supplierid = Convert.ToInt32(dt.Rows[0]["factory_id"]);
                    work_sn = Convert.ToString(dt.Rows[0]["work_sn"]);
                }

                Warehousing.Business.StorageHelper.BindCaiguoWarehouse(warehouse_id, int_warehouse_id, my_warehouse_id.ToString(), "");
                helper.Params.Clear();
                string supplierid_name = StorageHelper.getSupplierName(supplierid);
                sm_supplierid.Items.Add(new ListItem(supplierid_name, supplierid.ToString()));
               //StorageHelper.BindSupplierList(sm_supplierid, supplierid);
                bindFactoryPro(work_id);
            }
        }


        protected void bindFactoryPro(int work_id)
        {
            SqlHelper helper = LocalSqlHelper.WH;
            string sql = "SELECT distinct c.* FROM Tb_Working_main a with(nolock) left join Tb_template b on a.tpl_id=b.tpl_id left join Prolist c on b.pro_code=c.pro_code where a.work_id=@work_id order by c.pro_code,c.pro_spec";
           // string sql = "SELECT a.*,b.quantity FROM Prolist a left join  Tb_Working_main b with(nolock) on a.pro_code=b.pro_code_new where b.work_id=@work_id order by b.wm_id";
            helper.Params.Add("work_id", work_id);
            DataTable dt = helper.ExecDataTable(sql);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
               
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
            helper.Params.Add("sm_supplierid", Request["sm_supplierid"]);
            helper.Params.Add("sm_type", Request["sm_type"]);
            helper.Params.Add("warehouse_id", Request["warehouse_id"]);
            helper.Params.Add("sm_date", Request["sm_date"]);
            helper.Params.Add("relate_sn", Request["work_sn"]);
            helper.Params.Add("sm_operator", sm_operator.Text);
            helper.Params.Add("sm_remark", sm_remark.Text);
            helper.Params.Add("sm_direction", "入库");
            helper.Params.Add("sm_sn", StorageHelper.getNewChurukuHao("RK"));
            helper.Params.Add("sm_adminid", HttpContext.Current.Session["ManageUserId"].ToString());
            helper.Insert("Tb_storage_main");
                try
                {
                   
                }
                catch(Exception ex)
                {
                    SiteHelper.writeLog("错误", ex.Message);
                    SinoHelper2.EventLog.WriteLog(ex.Message);
                    JSHelper.WriteScript("alert('入库单号已有记录，不能重复！');history.back();");
                    Response.End();
                }
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
                        if (arr_p_txm[i].IsNotNullAndEmpty() && arr_p_name[i].IsNotNullAndEmpty() && arr_p_quantity[i].IsNumber() && Convert.ToDouble(arr_p_quantity[i]) > 0)
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
                                helper.Insert("Tb_storage_product");
                            }
                            else
                            {
                                SiteHelper.writeLog("入库条码检查", arr_p_txm[i] + "不存在");
                            }
                        }

                    }
                }
                JSHelper.WriteScript("alert('提交入库成功');location.href='../Storage/ProductIn.aspx';");
            //Response.Write(RoleList.Text);
            Response.End();
        }
    }
}