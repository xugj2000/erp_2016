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

namespace Warehousing.OrderPrint
{
    public partial class WaybillForDirect : System.Web.UI.Page
    {
        private string strwhere = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            SiteHelper.CheckLogin();
            SiteHelper.GetPageUrlpower("OrderPrint/WaybillForDirect.aspx");
            if (Session["PowerRead"].ToString() != "1")
            {
                SiteHelper.NOPowerMessage();
            }
            if (!IsPostBack)
            {
                LoadData(1, getwhere());
            }
        }

        protected void LoadData(int page, string str)
        {
            int count = 0;

            SqlHelper sp = LocalSqlHelper.WH;


            DataTable dt = sp.TablesPageNew("Direct_OrderMain", "*", "shopxpacid desc",true, Pager.PageSize, page, str, out count);

            DirectOrderList.DataShow(dt);
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
            string strwhere = "zhuangtai>6 and zhifufangshi<>99";
            string dingdan = txtDingdan.Text;
            string userid = txtUserid.Text;
            string shouhuoname = txtShouhuoName.Text;
            if (dingdan.IsNotNullAndEmpty())
            {
                strwhere += " and dingdan='" + dingdan + "'";
            }
            if (userid.IsNotNullAndEmpty())
            {
                strwhere += " and user_name='" + userid + "'";
            }
            if (shouhuoname.IsNotNullAndEmpty())
            {
                strwhere += " and shouhuoname like '" + shouhuoname + "'";
            }
            return strwhere;
        }

        public bool isDate(string str)
        {
            DateTime dt;
            DateTime.TryParse(str, out dt);
            return dt == DateTime.MinValue ? false : true;
        }




    }
}
