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
    public partial class RukuNewList : System.Web.UI.Page
    {
        private string strwhere = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            SiteHelper.CheckLogin();
            SiteHelper.GetPageUrlpower("Storage/RukuNewList.aspx");
            if (Session["PowerRead"].ToString() != "1")
            {
                SiteHelper.NOPowerMessage();
            }
            if (!IsPostBack)
            {

                if (Session["warehouse_id"] == null)
                {
                    //SiteHelper.NOPowerMessage();
                   // return;
                    JSHelper.WriteScript("alert('请重新登录');top.location.href='/';");
                    Response.End();
                }
                LoadData(1, getwhere());
            }
        }

        protected void LoadData(int page, string str)
        {
            int count = 0;

            SqlHelper sp = LocalSqlHelper.WH;
            DataTable dt = sp.TablesPageNew("warehouse_detail with(nolock) ", "shopxpptname,is_new,shopxp_yangshiid,shopxpptid,p_size,txm,shiji_num,pid=shopxpptid+200000000", "id", true, Pager.PageSize, page, str, out count);
            rptruku_newlist.DataShow(dt);
            Pager.RecordCount = count;
        }

        protected void Pager_PageChanging(object src, Wuqi.Webdiyer.PageChangingEventArgs e)
        {
            LoadData(e.NewPageIndex, getwhere());
        }

        protected void btnOk_Click(object sender, EventArgs e)
        {
            LoadData(1, getwhere());
        }

        protected string getwhere()
        {
            string strwhere = "warehouse_id=" + Convert.ToString(Session["warehouse_id"]) + "and is_new<3";
            if (txtsid.Text.IsNotNullAndEmpty())
            {
                if (CheckCharIsNumber(this.txtsid.Text.ToString()))
                {
                    strwhere += " and shopxpptid=" + txtsid.Text.ToString();
                }
                else
                {
                    JSHelper.Alert("请输入数字类型的商品id");
                }
            }
            if (txttxm.Text.IsNotNullAndEmpty())
            {
                if (CheckCharIsNumber(this.txttxm.Text.ToString()))
                {
                    strwhere += " and txm ='" + txttxm.Text.ToString() + "'";
                }
            }
            if (txtpname.Text.IsNotNullAndEmpty())
            {
                strwhere += " and shopxpptname like '%" + txtpname.Text.ToString() + "%'";
            }

            return strwhere;

        }

        public bool isDate(string str)
        {
            DateTime dt;
            DateTime.TryParse(str, out dt);
            return dt == DateTime.MinValue ? false : true;
        }

        public bool CheckCharIsNumber(string str)
        {
            bool returntempbool = true; // 声明时声明为 “true”

            for (int i = 0; i < str.Length; i++)
            {
                if (!Char.IsNumber(str, i))
                { //不全是数字
                    returntempbool = false;
                }
                else
                {//全是 数字
                    returntempbool = true;
                }
            }
            return returntempbool;
        } 
    }
}
