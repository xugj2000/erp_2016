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
    public partial class GoodsReturnAddNext : System.Web.UI.Page
    {
        protected string orderid = string.Empty;
        protected string agentid = string.Empty;
        protected int type = 0;
        protected string GoodsId = "0";
        protected string isDirect = string.Empty;
        protected string strTable = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            SiteHelper.CheckLogin();
            SiteHelper.GetPageUrlpower("GoodsReturn/GoodsReturnAdd.aspx");
            if (Session["PowerRead"].ToString() != "1")
            {
                SiteHelper.NOPowerMessage();
            }
            isDirect = Request["isDirect"];
            orderid = Request["orderid"];
            GoodsId = Request["id"];
            if (!GoodsId.IsNumber())
            {
                GoodsId = "0";
            }
            if (isDirect != "1" && GoodsId!="0") //非直接录入根据订单号获取相应代理信息
            {
                if (!orderid.IsNumber())
                {
                    JSHelper.WriteScript("alert('数据有误');history.back();");
                    Response.End();
                }
                if (!Request["type"].IsNumber())
                {
                    type = 0;
                }
                else
                {
                    type = Convert.ToInt32(Request["type"]);
                }
            }
            
            if (!IsPostBack)
            {
                strTable = type == 1 ? "Order_Distribution_Main" : "Order_Agent_Main";
                SqlHelper sp = LocalSqlHelper.WH;
                string sql = "select * from TB_GoodsReturn where id=" + GoodsId;
                DataTable gdDt = sp.ExecDataTable(sql);
                if (gdDt.Rows.Count > 0) //修改时
                {
                    txtProductName.Text = gdDt.Rows[0]["ProductName"].ToString();
                    txtProductTxm.Text = gdDt.Rows[0]["ProductTxm"].ToString();
                    txtProductCount.Text = gdDt.Rows[0]["ProductCount"].ToString();
                    txtReturnTime.Text = gdDt.Rows[0]["ReturnTime"].ToString();
                    txtReturnReson.Text = gdDt.Rows[0]["ReturnReson"].ToString();
                    txtReceivedOpter.Text = gdDt.Rows[0]["ReceivedOpter"].ToString();
                    txtAgentid.Text = gdDt.Rows[0]["AgentId"].ToString();
                    txtUserName.Text = gdDt.Rows[0]["UserName"].ToString();
                    txtUserTel.Text = gdDt.Rows[0]["UserTel"].ToString();
                    txtPostFee.Text = gdDt.Rows[0]["PostFee"].ToString();
                    txtProvince.Text = gdDt.Rows[0]["UserProvince"].ToString();
                    txtCity.Text = gdDt.Rows[0]["UserCity"].ToString();
                    txtTown.Text = gdDt.Rows[0]["UserTown"].ToString();
                    txtAddress.Text = gdDt.Rows[0]["UserAddress"].ToString();
                    txtRemark.Text = gdDt.Rows[0]["ReturnRemark"].ToString();
                    //fromUrl.Value = Request.UrlReferrer.ToString();
                    fromUrl.Value = Request["url"]; ;
                }
                else
                {
                    if (isDirect != "1")
                    {
                        agentid = Convert.ToString(sp.ExecScalar("select userid from " + strTable + " where dingdan='" + orderid + "'"));
                        if (agentid.IsNullOrEmpty())
                        {
                            JSHelper.WriteScript("alert('订单数据有误');history.back();");
                            Response.End();
                        }
                        txtAgentid.Text = gdDt.Rows[0]["agentid"].ToString();
                        txtOrderId.Text = orderid;
                    }
                    txtReceivedOpter.Text = HttpContext.Current.Session["LoginName"].ToString();
                    txtReturnTime.Text = DateTime.Today.ToShortDateString();
                }
                txtAgentid.Attributes.Add("onchange", "getAgentinfo(this.value);");
            }

            bindReson();//显示原因
            ddreson.Items.Insert(0,new ListItem("请选择原因",""));
            ddreson.Attributes.Add("onchange", "myform.txtReturnReson.value=this.value;");
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string ProductName =Request["txtProductName"];
                string ProductTxm = Request["txtProductTxm"];
                string ProductCount = Request["txtProductCount"];
                string ReturnTime = Request["txtReturnTime"];
                string ReturnReson = Request["txtReturnReson"];
                string ReceivedOpter = Request["txtReceivedOpter"];
                agentid = Request["txtAgentid"];
                orderid = Request["txtOrderId"];
                if (!agentid.IsNumber())
                {
                    JSHelper.WriteScript("alert('代理商ID有误');history.back();");
                    Response.End();
                }
                if (ProductName.IsNullOrEmpty())
                {
                    JSHelper.WriteScript("alert('商品名称不能为空');history.back();");
                    Response.End();
                }
                if (!ProductCount.IsNumber())
                {
                    JSHelper.WriteScript("alert('商品数量有误');history.back();");
                    Response.End();
                }

                string sql = string.Empty;
                GoodsId = Request["id"];
                if (!GoodsId.IsNumber())
                {
                    GoodsId = "0";
                }
                if (GoodsId == "0")
                {
                    sql = "insert into TB_GoodsReturn(ProductName, ProductCount, DingDan, AgentId, ReturnTime, ProductTxm, ReturnReson, ReceivedOpter, AddTime,Status,Operator,OrderType,UserName,UserTel,PostFee,UserProvince,ReturnRemark,UserCity,UserTown,UserAddress)";
                    sql += " values(@ProductName, @ProductCount, @DingDan, @AgentId, @ReturnTime, @ProductTxm, @ReturnReson, @ReceivedOpter, getdate(),@Status,@Operator,@OrderType,@UserName,@UserTel,@PostFee,@UserProvince,@ReturnRemark,@UserCity,@UserTown,@UserAddress)";
                }
                else
                {
                    sql = "update TB_GoodsReturn set AgentId=@AgentId,ProductName=@ProductName,ProductCount=@ProductCount,ReturnTime=@ReturnTime,ProductTxm=@ProductTxm,ReturnReson=@ReturnReson,ReceivedOpter=@ReceivedOpter,UserName=@UserName,UserTel=@UserTel,PostFee=@PostFee,UserProvince=@UserProvince,UserCity=@UserCity,UserTown=@UserTown,UserAddress=@UserAddress,ReturnRemark=@ReturnRemark where id=" + GoodsId;
                }
                SqlHelper sp = LocalSqlHelper.WH;
                string UserName = txtUserName.Text;
                string UserTel = txtUserTel.Text;
                string PostFee = txtPostFee.Text;
                string UserProvince = txtProvince.Text;
                string ReturnRemark = txtRemark.Text;
                sp.Params.Add("@ProductName", ProductName);
                sp.Params.Add("@ProductCount", ProductCount);
                sp.Params.Add("@ReturnTime", ReturnTime);
                sp.Params.Add("@ProductTxm", ProductTxm);
                sp.Params.Add("@ReturnReson", ReturnReson);
                sp.Params.Add("@ReceivedOpter", ReceivedOpter);
                sp.Params.Add("@UserName", UserName);
                sp.Params.Add("@UserTel", UserTel);
                sp.Params.Add("@PostFee", PostFee);
                sp.Params.Add("@UserProvince", UserProvince);
                sp.Params.Add("@UserCity", txtCity.Text);
                sp.Params.Add("@UserTown",txtTown.Text);
                sp.Params.Add("@UserAddress", txtAddress.Text);
                sp.Params.Add("@ReturnRemark", ReturnRemark);
                sp.Params.Add("@AgentId", agentid);
                string fromUrl = Request.Form["fromUrl"];
                if (GoodsId == "0")
                {
                    sp.Params.Add("@Status", (int)Warehousing.Business.GoodsReturnStatus.返货待处理);
                    sp.Params.Add("@DingDan", orderid);
                    sp.Params.Add("@Operator", HttpContext.Current.Session["LoginName"].ToString());
                    sp.Params.Add("@OrderType", type.ToString());
                    fromUrl = "GoodsReturnList.aspx";
                }
                if (fromUrl.IsNullOrEmpty())
                {
                    fromUrl = "GoodsReturnList.aspx";
                }
                sp.Execute(sql);
                JSHelper.WriteScript("alert('返货商品提交成功');location.href='" + fromUrl + "'");
            }
        }

        protected void bindReson()
        {
            string sql = "select * from Tb_GoodsReturnReson with(nolock) where isHidden=0 order by typeId";
            SqlHelper sp = LocalSqlHelper.WH;
            DataTable dt = sp.ExecDataTable(sql);
            BindingHelper.BindDDL(ddreson, dt, "typeName", "typeName");
        }
    }
}
