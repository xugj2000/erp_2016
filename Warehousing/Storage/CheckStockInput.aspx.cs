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
    public partial class CheckStockInput : mypage
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
                }
                else
                {

                    JSHelper.WriteScript("alert('不存在');history.back();");
                }
            }
        }


        protected void Button1_Click(object sender, EventArgs e)
        {

            helper.Params.Clear();
            string areaCode = AreaCode.Text;
            string content = remark.Text;
            if (content.IsNullOrEmpty())
            {
                JSHelper.WriteScript("alert('盘点数据不能为空!');history.back();");
            }
            content = content.Replace("，", ",");
            content = content.Replace("\t", ",");
            string[] oneDate = content.Split('\r');

            //数据检查
            for (int i = 0; i < oneDate.Length; i++)
            {
                if (oneDate[i].Trim().IsNotNullAndEmpty())
                {
                    string[] info = oneDate[i].Split(',');
                    if (info.Length < 2)
                    {
                        JSHelper.WriteScript("alert('盘点录入数据格式不对，注意是否最后有空白行');");
                        Response.End();
                    }
                    if (!info[1].IsNumber() || info[0].IsNullOrEmpty())
                    {
                        JSHelper.WriteScript("alert('格式不对：存在条码为空或数量非数值');");
                        Response.End();
                    }
                }
            }

            //数据写入
            string sql = string.Empty;
            for (int i = 0; i < oneDate.Length; i++)
            {
                if (oneDate[i].Trim().IsNotNullAndEmpty())
                {
                    string[] info = oneDate[i].Split(',');
                    sql = "insert into Tb_check_input(main_id,pro_txm,check_num,area_code) values(" + id + ",'" + info[0].Trim() + "'," + info[1].Trim() + ",'" + areaCode + "')";
                    //Response.Write(sql);
                    helper.Execute(sql);
                }
            }

            
            JSHelper.WriteScript("alert('编辑成功');location.href='CheckStock.aspx';");
            //Response.Write(RoleList.Text);
            Response.End();
        }
    }
}