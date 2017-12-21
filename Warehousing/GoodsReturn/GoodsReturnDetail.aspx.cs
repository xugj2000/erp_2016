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

namespace Warehousing.GoodsReturn
{
    public partial class GoodsReturnDetail : System.Web.UI.Page
    {
        protected string OrderId = string.Empty;
        protected int Status = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            SiteHelper.CheckLogin();
            SiteHelper.GetPageUrlpower("GoodsReturn/GoodsReturnOrder.aspx");
            if (Session["PowerRead"].ToString() != "1")
            {
                SiteHelper.NOPowerMessage();
            }
            OrderId = Request["orderid"];
            if (OrderId.IsNullOrEmpty())
            {
                JSHelper.WriteScript("alert('数据有误');history.back();");
                Response.End();
            }
            if (!IsPostBack)
            {
                getOrderDetail(OrderId);
                bindGoods();
                bindRemarkList(OrderId);
            }
        }

        /// <summary>
        /// 返货订单相关信息
        /// </summary>
        /// <param name="orderid"></param>
        protected void getOrderDetail(String orderid)
        {
            SqlHelper sp = LocalSqlHelper.WH;
            string sql = "select * from TB_GoodsReturnOrder where OrderId=@OrderId";
            sp.Params.Add("@OrderId", orderid);
            DataTable dt = sp.ExecDataTable(sql);
            if (dt.Rows.Count > 0)
            {
                txtAgentId.Text = dt.Rows[0]["AgentId"].ToString();
                txtReceiver.Text = dt.Rows[0]["ReveivedName"].ToString();
                txtProvince.Text = dt.Rows[0]["province"].ToString();
                txtCity.Text = dt.Rows[0]["city"].ToString();
                txtTown.Text = dt.Rows[0]["xian"].ToString();
                txtAddress.Text = dt.Rows[0]["PostAddress"].ToString();
                txtTel.Text = dt.Rows[0]["UserTel"].ToString();
                txtRemark.Text = dt.Rows[0]["Remark"].ToString();
                Status = Convert.ToInt32(dt.Rows[0]["OrderStatus"]);
            }
            else
            {
                JSHelper.WriteScript("alert('订单数据有误');history.back();");
                Response.End();
            }
            //根据状态获取处理步骤
            switch (Status)
            {
                case 0://订单待打印
                    doStatus.Items.Add(new ListItem(Warehousing.Business.GoodsReturnHelper.getOrderStutusText(3), "3"));//订单已发货
                    doStatus.Items.Add(new ListItem(Warehousing.Business.GoodsReturnHelper.getOrderStutusText(4), "4"));//订单取消
                    break;
            }

        }

        /// <summary>
        /// 订单商品
        /// </summary>
        protected void bindGoods()
        {
            string sql = "select * from TB_GoodsReturn with(nolock) where ReturnOrderId='" + OrderId + "'";
            SqlHelper sp = LocalSqlHelper.WH;
            DataTable dt = null;
            string dingdan = string.Empty;
            int OrderType = 0;
            try
            {
                dt = sp.ExecDataTable(sql);
            }
            catch
            {
                JSHelper.WriteScript("alert('数据有误');history.back();");
                Response.End();
            }
            OrderDetail.DataShow(dt);

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string AgentId = Request["txtAgentId"];
                string Receiver = Request["txtReceiver"];
                string Address = Request["txtAddress"];
                string Province = Request["txtProvince"];
                string City = Request["txtCity"];
                string Town = Request["txtTown"];
                string Tel = Request["txtTel"];
                string Remark = Request["txtRemark"];
                string toUrl = Request["url"];
                string sql = string.Empty;
                SqlHelper sp = LocalSqlHelper.WH;
                //订单生成

                string oldStatus = Request["oldStatus"];
                string newStatus = Request["doStatus"];
                string doRemark = Request["doRemark"];

                if (newStatus.IsNullOrEmpty())
                {
                    JSHelper.WriteScript("alert('请选择处理方式');history.back();");
                    Response.End();
                }

                //写操作日志
                string dowhat = OrderId + "订单进行处理,状态由(" + Warehousing.Business.GoodsReturnHelper.getOrderStutusText(Convert.ToInt32(oldStatus)) + oldStatus + ")至(" + Warehousing.Business.GoodsReturnHelper.getOrderStutusText(Convert.ToInt32(newStatus)) + newStatus + ")" + doRemark;
                SiteHelper.writeLog("返货订单处理", dowhat);

                if (oldStatus != newStatus)
                {
                    sql = "update TB_GoodsReturnOrder set OrderStatus=@OrderStatus where OrderId=@OrderId";
                    sp.Params.Clear();
                    sp.Params.Add("@OrderId", OrderId);
                    sp.Params.Add("@OrderStatus", newStatus);
                    sp.Execute(sql);
                }

                //“取消提交”，此时，该订单从返货订单栏目中删除，返货商品在返货管理中的状态由“订单提交”更改为“等待发货”状态。
                if (Convert.ToInt32(newStatus) == (int)Warehousing.Business.OrderRetusStatus.订单取消)
                {
                    string delsql = "delete from TB_GoodsReturnOrder where OrderId=@OrderId";
                    sp.Params.Clear();
                    sp.Params.Add("@OrderId", OrderId);
                    sp.Execute(delsql);

                    //取消后关联订单返回上一级
                    sp.Params.Clear();
                    string updateSql = "update TB_GoodsReturn set Status=6,ReturnOrderId=null where ReturnOrderId='" + OrderId + "' and ChangeFlag<>-1";
                    sp.Execute(updateSql);
                    updateSql = "update TB_GoodsReturn set Status=15,ReturnOrderId=null where ReturnOrderId='" + OrderId + "' and ChangeFlag=-1";
                    sp.Execute(updateSql);

                }


                /*
                //对订单进行修改,仅有相应权限才可以
                sql = "update TB_GoodsReturnOrder set province=@province,city=@city,xian=@xian,PostAddress=@PostAddress,UserTel=@UserTel,ReveivedName=@ReveivedName,Remark=@Remark where OrderId=@OrderId";
                sp.Params.Add("@OrderId", OrderId);
                sp.Params.Add("@province", Province);
                sp.Params.Add("@city", City);
                sp.Params.Add("@xian", Town);
                sp.Params.Add("@PostAddress", Address);
                sp.Params.Add("@UserTel", Tel);
                sp.Params.Add("@ReveivedName", Receiver);
                sp.Params.Add("@Remark", Remark);
                sp.Execute(sql);
                 */

                JSHelper.WriteScript("alert('返货订单处理成功');location.href='" + toUrl + "'");
            }
        }

        protected void bindRemarkList(string orderId)
        {

            string sql = "select addtime,operator,dowhat from LogVpn where dotype='返货订单处理'  and dowhat like '" + orderId + "订单进行处理%' order by id";
            SqlHelper sp = LocalSqlHelper.WH;
            DataTable dt = sp.ExecDataTable(sql);
            rpRemarkList.DataShow(dt);

        }
    }
}
