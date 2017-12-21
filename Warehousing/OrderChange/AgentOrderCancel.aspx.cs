using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
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

namespace Warehousing.OrderChange
{
    public partial class AgentOrderCancel : System.Web.UI.Page
    {
        private string strwhere = string.Empty;
        protected string querystr = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            SiteHelper.CheckLogin();
            SiteHelper.GetPageUrlpower("Storage/ProductStock.aspx");
            if (Session["PowerRead"].ToString() != "1")
            {
                //SiteHelper.NOPowerMessage();
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
                ConfirmFlag.Text = "0";
                LoadData(1, getwhere());
            }
        }

        protected void LoadData(int page, string str)
        {
            int count = 0;
            SinoHelper2.MySqlHelper helper_mysql = PublicHelper.connMysql();
            DataTable dt = helper_mysql.GetPageData("ecm_order_return", "*,ck_remark as checkidstr", "return_id", Pager.PageSize, page, false, "1=1", out count);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                dt.Rows[i]["checkidstr"] = Convert.ToInt16(dt.Rows[i]["ck_status"]) == 0 ? "<input type='checkbox' name='cancelid' value='" + dt.Rows[i]["return_id"] + "'/>" : "";
            }
            rptruku_newlist.DataShow(dt);
            Pager.RecordCount = count;
            Pager.UrlRewritePattern = "AgentOrderCancel.aspx?page={0}" + querystr;
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
            string strwhere = "shopxp_shfs in (select songid from Config_PostStyle where warehouse_id=" + Convert.ToString(Session["warehouse_id"])+")";
           //去除掉尚未打印发货的订单部份的取消(在打印发货时直接处理冲减)
            //strwhere += " and exists(select shopxpacid from Order_Agent_Main where zhuangtai=3 and dingdan=CancelOrder_Agent.dingdan)";
            //控制取消订单状态:CancelStatus=1客服已审核,warehouse_confirm=0未确认,zhuangtai=3
            string isConfirm = Request["ConfirmFlag"];
            if (!IsPostBack)
            {
                isConfirm = "0";
            }
            querystr = "&ConfirmFlag=" + isConfirm;
            //ConfirmFlag.Text = isConfirm;
            switch (isConfirm)
            {
                case "":
                    strwhere += "";
                    break;
                case "1":
                    strwhere += " and warehouse_confirm=1";
                    break;
                default:
                    strwhere += " and CancelStatus=1 and warehouse_confirm=0";
                    break;
            }

            /*
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
             */
            string OrderSn=Request["txtOrderSn"];
            if (OrderSn.IsNotNullAndEmpty())
            {
                strwhere += " and dingdan ='" + OrderSn + "'";
                querystr+= "&txtOrderSn=" + OrderSn;
            }
            string Operator=Request["txtOperator"];
            if (Operator.IsNotNullAndEmpty())
            {
                strwhere += " and op_user ='" + Operator + "'";
                querystr+= "&txtOperator=" + Server.UrlEncode(Operator);
            }
            string AgentId=Request["txtAgentId"];
            if (AgentId.IsNotNullAndEmpty())
            {
                strwhere += " and userid ='" + AgentId + "'";
                querystr+= "&txtAgentId=" + AgentId;
            }

            string AgentName = Request["txtAgentName"];
            if (AgentName.IsNotNullAndEmpty())
            {
                strwhere += " and username ='" + AgentName + "'";
                querystr+= "&txtAgentName=" + Server.UrlEncode(AgentName);
            }
            string pname = Request["txtpname"];
            if (pname.IsNotNullAndEmpty())
            {
                string[] pNameArr = pname.Split(' ');
                for (int pI=0;pI<pNameArr.Length;pI++)
                {
                    strwhere += " and shopxpptname like '%" + pNameArr[pI] + "%'";
                }
                //querystr+= "&txtpname=" + Server.UrlEncode(pname);
            }
           //Response.Write(strwhere);
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

        protected void Button1_Click(object sender, EventArgs e)
        {
            string cancelid = Convert.ToString(Request["cancelid"]);
            if (cancelid.IsNullOrEmpty())
            {
                JSHelper.WriteScript("alert('请选择要取消的订单商品');history.back();");
                Response.End();
            }
            SqlHelper conn = LocalSqlHelper.WH;
            string[] ids = cancelid.Split(',');
            string msgstr = "";
            string truename = Convert.ToString(Session["LoginName"]);
            for (int i = 0; i < ids.Length; i++)
            {
                conn.Params.Clear();
                conn.OutParams.Clear();
                conn.Params.Add("@id", ids[i]);
                conn.Params.Add("@validate_user", truename);
                SqlParameter msg = new SqlParameter("@msg", SqlDbType.NVarChar, 50);
                msg.Direction = ParameterDirection.Output;
                conn.OutParams.Add(msg);
                conn.Run("Order_Cancel_Agent_Warehouse_confirm");
                msgstr += msg.Value + "\\n";
            }
            JSHelper.WriteScript("alert('" + msgstr + "'),location.href='AgentOrderCancel.aspx'");
        } 



    }
}
