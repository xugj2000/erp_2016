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
    public partial class AddCheckStock : mypage
    {
        protected SqlHelper helper = LocalSqlHelper.WH;
        protected int id = 0;
        protected string liushuihao = string.Empty;
        protected int base_warehouse_id = 0;

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            id = Convert.ToInt32(Request["id"]);
            if (!Page.IsPostBack)
            {
                string Sql = "select * from Tb_check_main where main_id=@id";
                helper.Params.Add("@id", id);
                DataTable dt = helper.ExecDataTable(Sql);
                if (dt.Rows.Count > 0)
                {
                    liushuihao = dt.Rows[0]["check_sn"].ToString();
                    manager.Text = dt.Rows[0]["manager"].ToString();
                    remark.Text = dt.Rows[0]["remark"].ToString();
                    base_warehouse_id = Convert.ToInt32(dt.Rows[0]["warehouse_id"]);
                }
                string where = string.Empty;
                if (myStorageInfo.warehouse_id > 0)
                {
                    if (myStorageInfo.is_manage == 1)
                    {
                        where = "agent_id='" + myStorageInfo.agent_id + "'";
                    }
                    else
                    {
                        where += "warehouse_id=" + myStorageInfo.warehouse_id;
                    }
                }
                //Response.Write(where);
                Warehousing.Business.StorageHelper.BindWarehouseList(warehouse_id, base_warehouse_id, where);
            }
        }


        protected void Button1_Click(object sender, EventArgs e)
        {

            helper.Params.Clear();
            int warehouse_id=Convert.ToInt32(Request["warehouse_id"]);
            helper.Params.Add("warehouse_id",warehouse_id);
            helper.Params.Add("manager", manager.Text);
            helper.Params.Add("remark", remark.Text);
            if (id == 0)
            {
                helper.Params.Add("check_sn", StorageHelper.getCheckStockHao("PD"));
                helper.Params.Add("operator_id", HttpContext.Current.Session["ManageUserId"].ToString());
               
                    helper.Insert("Tb_check_main");
                    int main_id = Convert.ToInt32(helper.ExecScalar("select top 1 main_id from Tb_check_main order by main_id desc "));
                    
                    //将当前库存商品保存
                    string sql = "insert into Tb_check_detail(main_id,pro_id,pro_txm,kc_num) select " + main_id + ",pro_id,pro_txm,kc_nums from View_Product where warehouse_id=" + warehouse_id + " and kc_nums<>0";
                    helper.Execute(sql);
                    try
                    {
                }
                catch
                {
                    JSHelper.WriteScript("alert('盘仓单号已有记录，不能重复！');history.back();");
                    Response.End();
                }
            }
            else
            {
                helper.Params.Add("main_id", id);
                helper.Update("Tb_check_main", "main_id");
            }
            JSHelper.WriteScript("alert('编辑成功');location.href='CheckStock.aspx';");
            //Response.Write(RoleList.Text);
            Response.End();
        }
    }
}