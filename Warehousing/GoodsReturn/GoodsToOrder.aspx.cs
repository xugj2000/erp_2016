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
    public partial class GoodsToOrder : System.Web.UI.Page
    {
        protected string agentid = string.Empty;
        protected string GoodsIdStr = "0";
        protected string strTable = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            SiteHelper.CheckLogin();
            SiteHelper.GetPageUrlpower("GoodsReturn/GoodsReturnAdd.aspx");
            if (Session["PowerRead"].ToString() != "1")
            {
                SiteHelper.NOPowerMessage();
            }
            GoodsIdStr = Request["id"];
            if (GoodsIdStr.IsNullOrEmpty())
            {
                JSHelper.WriteScript("alert('数据有误');history.back();");
                Response.End();
            }
            if (!IsPostBack)
            {
                string[] GoodsIdArr = GoodsIdStr.Split(',');
                bindGoods();
            }
        }

        protected void bindGoods()
        {
            string sql = "select * from TB_GoodsReturn with(nolock) where ReturnOrderId is null and ((Status in (6,15) and id in (" + GoodsIdStr + ")) or ChangeFlag in (" + GoodsIdStr + ")) order by ChangeFlag,id";
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
                if (dt.Rows.Count > 0)
                {
                    txtReceiver.Text = dt.Rows[0]["UserName"].ToString();
                    txtAddress.Text = dt.Rows[0]["UserAddress"].ToString();
                    txtProvince.Text = dt.Rows[0]["UserProvince"].ToString();
                    txtCity.Text = dt.Rows[0]["UserCity"].ToString();
                    txtTown.Text = dt.Rows[0]["UserTown"].ToString();
                    txtTel.Text = dt.Rows[0]["UserTel"].ToString();
                    txtAgentId.Text= dt.Rows[0]["AgentId"].ToString();
                }
                OrderDetail.DataShow(dt);

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                int checkExist =0;
                string AgentId = Request["txtAgentId"];
                string Receiver = Request["txtReceiver"];
                string Address = Request["txtAddress"];
                string Province = Request["txtProvince"];
                string City = Request["txtCity"];
                string Town = Request["txtTown"];
                string Tel = Request["txtTel"];
                string Remark = Request["txtRemark"];
                string sql = string.Empty;
                string OrderId =Warehousing.Business.GoodsReturnHelper.genReturnGoodsOrderId();
                SqlHelper sp = LocalSqlHelper.WH;
                //订单生成



                //检查是否存在同个代理的其它待发订单
                    sql = "select top 1 * from TB_GoodsReturnOrder where OrderStatus in (8,15) and AgentId='" + AgentId+"'";


                    sql = "insert into TB_GoodsReturnOrder(OrderId, AddTime, OrderStatus, province, city, xian, PostAddress, UserTel, AgentId, ReveivedName, Remark)";
                    sql += " values(@OrderId, getdate(),0, @province, @city, @xian, @PostAddress, @UserTel, @AgentId, @ReveivedName,  @Remark)";

                
                sp.Params.Add("@OrderId", OrderId);
                sp.Params.Add("@province", Province);
                sp.Params.Add("@city", City);
                sp.Params.Add("@xian", Town);
                sp.Params.Add("@PostAddress",Address);
                sp.Params.Add("@UserTel", Tel);
                sp.Params.Add("@AgentId", AgentId);
                sp.Params.Add("@ReveivedName", Receiver);
                sp.Params.Add("@Remark", Remark);
                sp.Execute(sql);

                sql = "update TB_GoodsReturn set ReturnOrderId='" + OrderId + "',Status=8 where ReturnOrderId is null and ((Status in (6,15) and id in (" + GoodsIdStr + ")) or ChangeFlag in (" + GoodsIdStr + "))";
                sp.Execute(sql);

                //写操作日志
                string oldStatus = "6";
                string newStatus = "8";
                string dowhat = GoodsIdStr + "商品进行处理,生成订单" + OrderId + ",状态由(" + Warehousing.Business.GoodsReturnHelper.getStutusText(Convert.ToInt32(oldStatus)) + oldStatus + ")至(" + Warehousing.Business.GoodsReturnHelper.getStutusText(Convert.ToInt32(newStatus)) + oldStatus + ")";
                SiteHelper.writeLog("返货商品处理", dowhat);

                JSHelper.WriteScript("alert('返货商品提交成功');location.href='GoodsReturnOrder.aspx'");
            }
        }


    }
}
