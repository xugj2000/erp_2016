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
using Warehousing.Model;

namespace Warehousing.Storage
{
    public partial class ProductReturn : mypage
    {
        protected SqlHelper helper = LocalSqlHelper.WH;
        protected int return_id = 0;
        protected string liushuihao = string.Empty;
        protected int int_from_warehouse_id = 0;
        protected int int_inType = 0;
        protected DataTable dt;

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            SiteHelper.GetPageUrlpower("Storage/ProductOut.aspx");
            if (Session["PowerAdd"].ToString() != "1")
            {
                SiteHelper.NOPowerMessage();
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            return_id = Convert.ToInt32(Request["return_id"]);
            string Sql = "select * from Tb_storage_main where sm_id=@id";
            helper.Params.Add("@id", return_id);
            dt = helper.ExecDataTable(Sql);

            if (!Page.IsPostBack)
            {
                Session["anti_refresh"] = "1";
                int int_sm_type = 0;
                int_inType = 8;
                string where = "warehouse_id=" + int_from_warehouse_id;
                if (dt.Rows.Count > 0)
                {
                    liushuihao = dt.Rows[0]["sm_sn"].ToString();
                    sm_date.Text = Convert.ToDateTime(dt.Rows[0]["sm_date"]).ToShortDateString();
                    sm_operator.Text = dt.Rows[0]["sm_operator"].ToString();
                    sm_remark.Text = dt.Rows[0]["sm_remark"].ToString();
                    sm_type.Text = dt.Rows[0]["sm_type"].ToString();
                    TextLoginName.Text = dt.Rows[0]["consumer_name"].ToString();
                    TextLoginName.Enabled = false;
                    // getbox.Text = dt.Rows[0]["sm_box"].ToString();
                    int_from_warehouse_id = Convert.ToInt32(dt.Rows[0]["warehouse_id"]);
                    int_sm_type = Convert.ToInt32(dt.Rows[0]["sm_type"]);
                     //既有出库单以出库单出库类型为准
                    relateActiveDiv.InnerText = liushuihao;
                    bindReturnPro(return_id);
                    where = "warehouse_id=" + int_from_warehouse_id;
                }
                else
                {
                    where = "1=1";
                    //Response.End();
                }

                sm_type.Items.Add(new ListItem(StorageHelper.getTypeText(int_inType), int_inType.ToString()));

                

                Warehousing.Business.StorageHelper.BindWarehouseList(to_warehouse_id, int_from_warehouse_id, where);

                
            }
        }


        protected void bindReturnPro(int direct_id)
        {
            SqlHelper helper = LocalSqlHelper.WH;
            string sql = "SELECT *,shelf_no='' FROM Tb_storage_product with(nolock) where sm_id=@sm_id order by p_id";
            helper.Params.Add("sm_id", direct_id);
            DataTable dt = helper.ExecDataTable(sql);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                dt.Rows[i]["shelf_no"] = StorageHelper.getShelfNo(Convert.ToInt32(dt.Rows[i]["pro_id"]), int_from_warehouse_id);
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
            helper.Params.Add("sm_type", 8);
            helper.Params.Add("sm_date", Request["sm_date"]);
            
            helper.Params.Add("sm_remark", sm_remark.Text);
            //helper.Params.Add("sm_box", getbox.Text);
            helper.Params.Add("sm_direction", "入库");

                string p_name = Request.Form["p_name"];
                string[] arr_p_name = Request.Form["p_name"].Split(',');
                string[] arr_p_serial = Request.Form["p_serial"].Split(',');
                string[] arr_p_txm = Request.Form["p_txm"].Split(',');
                string[] arr_p_brand = Request.Form["p_brand"].Split(',');
                string[] arr_p_unit = Request.Form["p_unit"].Split(',');
                string[] arr_p_spec = Request.Form["p_spec"].Split(',');
                string[] arr_p_model = Request.Form["p_model"].Split(',');
                string[] arr_p_quantity = Request.Form["p_quantity"].Split(',');
                string[] arr_p_price = Request.Form["p_price"].Split(',');
                //string[] arr_p_box = Request.Form["p_box"].Split(',');

                helper.Params.Add("sm_sn", StorageHelper.getNewChurukuHao("RT"));
                helper.Params.Add("sm_adminid", HttpContext.Current.Session["ManageUserId"].ToString());

                if (return_id > 0)
                {
                    helper.Params.Add("warehouse_id", Convert.ToInt32(dt.Rows[0]["warehouse_id"]));
                    helper.Params.Add("warehouse_id_to", Convert.ToInt32(dt.Rows[0]["warehouse_id"]));
                    helper.Params.Add("relate_sn", dt.Rows[0]["sm_sn"].ToString());
                    helper.Params.Add("consumer_id", Convert.ToInt32(dt.Rows[0]["consumer_id"]));
                    helper.Params.Add("consumer_name", dt.Rows[0]["consumer_name"]);
                }
                else
                {
                    helper.Params.Add("warehouse_id", Request.Form["to_warehouse_id"]);
                    helper.Params.Add("warehouse_id_to", Request.Form["to_warehouse_id"]);
                    string UserName = TextLoginName.Text;
                    int userid = 0;
                    if (UserName.IsNotNullAndEmpty())
                    {
                        userid = UserHelper.getUserId(UserName);

                        if (userid == 0)
                        {
                            JSHelper.WriteScript("alert('用户名不存在，不可退货!');history.back();");
                            return;
                        }
                        helper.Params.Add("consumer_id", userid);
                        helper.Params.Add("consumer_name", UserName);
                    }
                }

                helper.Insert("Tb_storage_main");

                int sm_id = Convert.ToInt32(helper.ExecScalar("select top 1 sm_id from Tb_storage_main order by sm_id desc"));
                if (p_name.IsNotNullAndEmpty())
                {
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
                            //helper.Params.Add("p_box", arr_p_box[i]);
                            helper.Insert("Tb_storage_product");
                        }

                    }
                }
            JSHelper.WriteScript("alert('编辑成功');location.href='ProductIn.aspx';");
            //Response.Write(RoleList.Text);
            Response.End();
        }
    }
}