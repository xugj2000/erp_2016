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
    public partial class ProductTranDetail : mypage
    {
        protected SqlHelper helper = LocalSqlHelper.WH;
        protected int id = 0;
        protected int current_sm_status = 0;
        protected string sm_sn = string.Empty, sm_date = string.Empty, sm_operator = string.Empty;
        protected string sm_remark = string.Empty;
        protected int warehouse_id_from = 0;
        protected int warehouse_id_to = 0;
        protected int sm_type = 0;

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            SiteHelper.GetPageUrlpower("Storage/ProductTran.aspx");
            id = Convert.ToInt32(Request["id"]);
            if (!Page.IsPostBack)
            {
                if (Session["PowerRead"].ToString() != "1")
                {
                    SiteHelper.NOPowerMessage();
                }
                string Sql = "select * from Tb_storage_main where sm_id=@id";
                helper.Params.Add("@id", id);
                DataTable dt = helper.ExecDataTable(Sql);
                if (dt.Rows.Count > 0)
                {
                    warehouse_id_from = Convert.ToInt32(dt.Rows[0]["warehouse_id"]);
                    warehouse_id_to = Convert.ToInt32(dt.Rows[0]["warehouse_id_to"]);
                    sm_sn = dt.Rows[0]["sm_sn"].ToString();
                    sm_date = dt.Rows[0]["sm_date"].ToString();
                    sm_operator = dt.Rows[0]["sm_operator"].ToString();
                    sm_remark = dt.Rows[0]["sm_remark"].ToString();
                    sm_type = Convert.ToInt32(dt.Rows[0]["sm_type"].ToString());
                    current_sm_status = Convert.ToInt32(dt.Rows[0]["sm_status"].ToString());
                    BindMemberList(1, "sm_id=" + id.ToString());
                }
                Session["anti_refresh"] = "1";
            }
        }

        protected void BindMemberList(int index, string where)
        {
            int count = 0;
            SqlHelper conn = LocalSqlHelper.WH;
            DataTable dt = conn.ExecDataTable("select * from Tb_storage_product with(nolock) where " + where + " order by p_name,p_spec");
            MemberList.DataShow(dt);
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (Session["PowerAudit"].ToString() != "1")
            {
                SiteHelper.NOPowerMessage();
            }
            if (Business.StorageHelper.checkTxmIsBlank(id))
            {
                JSHelper.WriteScript("alert('该批次下产品存在缺少条码,请修改后再审核!');history.back();");
                Response.End();
            }
            if (Convert.ToInt32(Request["sm_status"]) == 3)
            {
                JSHelper.WriteScript("alert('请选择审核方式');history.back();");
                Response.End();
            }
            if (Session["anti_refresh"].ToString() == "0")
            {
                JSHelper.WriteScript("alert('请勿重复提交!');history.back();");
                Response.End();
            }

            Session["anti_refresh"] = "0";

            if (Convert.ToInt32(Request["sm_status"]) == 1)
            {
                SqlHelper conn = LocalSqlHelper.WH;
                conn.Params.Add("sm_id", id);
                DataTable dt_old = conn.ExecDataTable("select * from Tb_storage_main with(nolock) where sm_id=@sm_id");
                if (dt_old.Rows.Count > 0)
                {
                    if (Convert.ToInt32(dt_old.Rows[0]["sm_type"]) == (int)Business.StorageType.调货出库)
                    {
                        //老库减库存
                        //
                        StorageHelper.checkStorageOk(id);

                        //生成一个调货入库单
                        conn.Params.Clear();
                        conn.Params.Add("sm_type", (int)StorageType.调货入库);
                        int warehouse_id = Convert.ToInt32(dt_old.Rows[0]["warehouse_id_to"]);
                        int warehouse_id_from = Convert.ToInt32(dt_old.Rows[0]["warehouse_id"]);
                        conn.Params.Add("warehouse_id", warehouse_id);
                        conn.Params.Add("warehouse_id_from", warehouse_id_from);
                        conn.Params.Add("sm_sn", Convert.ToString(dt_old.Rows[0]["sm_sn"]) + "_1");
                        conn.Params.Add("sm_date", Request["Text_sm_date"]);
                        conn.Params.Add("sm_operator", Text_sm_operator.Text);
                        conn.Params.Add("sm_remark", Text_sm_remark.Text);
                        conn.Params.Add("sm_direction", "入库");
                        conn.Params.Add("sm_status", 1);
                        conn.Params.Add("sm_adminid", my_admin_id);
                        conn.Insert("Tb_storage_main");
                        DateTime sm_date = Convert.ToDateTime(dt_old.Rows[0]["sm_date"]);
                        conn.Params.Clear();
                        int sm_id_new = Convert.ToInt32(conn.ExecScalar("select top 1 sm_id from Tb_storage_main order by sm_id desc"));

                        conn.Params.Clear();
                        conn.Params.Add("sm_id", id);
                        //加商品
                        string sql = "insert into Tb_storage_product(pro_id,sm_id,sku_id,p_name,p_serial,p_txm,p_spec,p_model,p_price,p_quantity,p_baseprice,p_brand,p_unit,p_box) select pro_id," + sm_id_new + ",sku_id,p_name,p_serial,p_txm,p_spec,p_model,p_price,p_quantity,p_baseprice,p_brand,p_unit,p_box from Tb_storage_product where sm_id=@sm_id";
                        conn.Execute(sql);
                        //新库加库存
                        StorageHelper.checkStorageOk(sm_id_new);
                    }
                }

            }

            helper.Params.Add("sm_status", Request["sm_status"]);
            helper.Params.Add("sm_verify_adminid", my_admin_id);
            helper.Params.Add("sm_id", id);
            helper.Update("Tb_storage_main", "sm_id");


            JSHelper.WriteScript("alert('审核完成');location.href='ProductTran.aspx';");
            //Response.Write(RoleList.Text);
            Response.End();
        }
    }
}