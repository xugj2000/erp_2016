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
    public partial class ProductEdit : System.Web.UI.Page
    {
        string id = string.Empty;
        string stype = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            SiteHelper.CheckLogin();
            SiteHelper.GetPageUrlpower("Storage/ProductStock.aspx");
            if (Session["PowerRead"].ToString() != "1")
            {
                SiteHelper.NOPowerMessage();
            }

            id = Request["id"];
            if (!(id.IsNumber()))
            {
                Response.Write("数据传输有误");
                Response.End();
            }

            if (!IsPostBack)
            {

                SqlHelper sp = LocalSqlHelper.WH;
                string sql = "select a.p_size,b.shopxpptname,txm=isnull(a.txm,''),shelfNo=isnull(a.shelfNo,'') from shopxp_kucun a left join shopxp_product b on a.shopxpptid=b.shopxpptid where a.id=@shopxpptid ";
                sp.Params.Add("@shopxpptid", id);
                DataTable dt = sp.ExecDataTable(sql);
                if (dt.Rows.Count > 0)
                {
                    lbProductName.Text = Convert.ToString(dt.Rows[0]["shopxpptname"]);
                    lbStyleName.Text = Convert.ToString(dt.Rows[0]["p_size"]);
                    txtShelfNo.Text =Convert.ToString(dt.Rows[0]["shelfNo"]);
                    txtTxm.Text = Convert.ToString(dt.Rows[0]["txm"]);
                }
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            SqlHelper sp = LocalSqlHelper.WH;
            string shelfNo = Convert.ToString(txtShelfNo.Text);
            string txm= Convert.ToString(txtTxm.Text);
            string sql = "update shopxp_kucun set shelfNo=@shelfNo,txm=@txm where id=@shopxpptid";
            sp.Params.Add("@shopxpptid", id);
            sp.Params.Add("@shelfNo", shelfNo);
            sp.Params.Add("@txm", txm);
            sp.Execute(sql);
            sp.Params.Clear();
            sql = "update WareHouse_Detail set sanjian_huojiahao=@shelfNo,txm=@txm where warehouse_id=1 and shopxp_yangshiid=@shopxpptid";
            sp.Params.Add("@shopxpptid", id);
            sp.Params.Add("@shelfNo", shelfNo);
            sp.Params.Add("@txm", txm);
            sp.Execute(sql);
            string doWhat = "样式:" + id + ",供应商ID:" + stype + ",货架号设为:" + shelfNo + ",条码设为:" + txm;
            SiteHelper.writeLog("商品更改",doWhat);
            JSHelper.WriteScript("alert('修改成功');location.href='ProductStock.aspx'");

        }
    }
}
