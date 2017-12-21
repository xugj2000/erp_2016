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
    public partial class GoodsReturnDo : System.Web.UI.Page
    {
        protected string GoodsId = string.Empty;
        protected string agentid = string.Empty;
        protected int type = 0;
        protected string strTable = string.Empty;
        protected string AgentId = string.Empty;
        protected string ProductName = string.Empty;
        protected string ProductTxm = string.Empty;
        protected string DingDan = string.Empty;
        protected string ProductCount = string.Empty;
        protected string ReturnTime = string.Empty;
        protected string ReturnReson = string.Empty;
        protected string ReceivedOpter = string.Empty;
        protected string Operator = string.Empty;
        protected int Status = 0;
        protected int haveChange = 0;
        protected string fromUrl = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            SiteHelper.CheckLogin();
            SiteHelper.GetPageUrlpower("GoodsReturn/GoodsReturnList.aspx");
            if (Session["PowerRead"].ToString() != "1")
            {
                SiteHelper.NOPowerMessage();
            }
            GoodsId = Request["id"];
            if (!GoodsId.IsNumber())
            {
                JSHelper.WriteScript("alert('数据有误');history.back();");
                Response.End();
            }

            if (!IsPostBack)
            {
                //fromUrl = Request.ServerVariables["Http_Referer"].ToString();

                SqlHelper sp = LocalSqlHelper.WH;
                DataTable dt = sp.ExecDataTable("select * from TB_GoodsReturn with(nolock) where id=" + GoodsId);
                if (dt.Rows.Count > 0)
                {

                    AgentId = Convert.ToString(dt.Rows[0]["AgentId"]);
                    ProductName = Convert.ToString(dt.Rows[0]["ProductName"]);
                    ProductTxm = Convert.ToString(dt.Rows[0]["ProductTxm"]);
                    DingDan = Convert.ToString(dt.Rows[0]["DingDan"]);
                    ProductTxm = Convert.ToString(dt.Rows[0]["ProductTxm"]);
                    ProductCount = Convert.ToString(dt.Rows[0]["ProductCount"]);
                    ReturnTime = Convert.ToString(dt.Rows[0]["ReturnTime"]);
                    ReturnReson = Convert.ToString(dt.Rows[0]["ReturnReson"]);
                    ReceivedOpter = Convert.ToString(dt.Rows[0]["ReceivedOpter"]);
                    Operator = Convert.ToString(dt.Rows[0]["Operator"]);
                    Status = Convert.ToInt32(dt.Rows[0]["Status"]);

                    //根据状态获取处理步骤
                    switch (Status)
                    {
                        case 0://本仓初始
                        case 2://外仓调入确认
                            doStatus.Items.Add(new ListItem(Warehousing.Business.GoodsReturnHelper.getStutusText(4), "4"));//返货待处理
                            break;
                        case 1://外仓调入
                            doStatus.Items.Add(new ListItem(Warehousing.Business.GoodsReturnHelper.getStutusText(2), "2"));//另仓调入已确认
                            doStatus.Items.Add(new ListItem(Warehousing.Business.GoodsReturnHelper.getStutusText(3), "3"));//另仓调入已退回
                            break;
                        case 4://返货待处理
                            doStatus.Items.Add(new ListItem(Warehousing.Business.GoodsReturnHelper.getStutusText(5), "5"));//商品已返厂
                            doStatus.Items.Add(new ListItem(Warehousing.Business.GoodsReturnHelper.getStutusText(7), "7"));//在库维修
                            doStatus.Items.Add(new ListItem(Warehousing.Business.GoodsReturnHelper.getStutusText(12), "12"));//入库返币
                            doStatus.Items.Add(new ListItem(Warehousing.Business.GoodsReturnHelper.getStutusText(13), "13"));//有订单调换
                            doStatus.Items.Add(new ListItem(Warehousing.Business.GoodsReturnHelper.getStutusText(14), "14"));//无订单调换
                            doStatus.Items.Add(new ListItem(Warehousing.Business.GoodsReturnHelper.getStutusText(17), "17"));//原货返回
                            break;
                        case 5://商品已返厂
                            doStatus.Items.Add(new ListItem(Warehousing.Business.GoodsReturnHelper.getStutusText(7), "7"));//在库维修
                            doStatus.Items.Add(new ListItem(Warehousing.Business.GoodsReturnHelper.getStutusText(16), "16"));//厂家直接发货
                            doStatus.Items.Add(new ListItem(Warehousing.Business.GoodsReturnHelper.getStutusText(6), "6"));//等待发货
                            break;
                        case 7://在库维修
                            doStatus.Items.Add(new ListItem(Warehousing.Business.GoodsReturnHelper.getStutusText(5), "5"));//商品已返厂
                            doStatus.Items.Add(new ListItem(Warehousing.Business.GoodsReturnHelper.getStutusText(6), "6"));//等待发货
                            break;
                        case 6://等待发货
                        case 15://确定调换
                            doStatus.Items.Add(new ListItem(Warehousing.Business.GoodsReturnHelper.getStutusText(8), "8"));//订单提交
                            break;
                        case 13://有订单调换
                            doStatus.Items.Add(new ListItem(Warehousing.Business.GoodsReturnHelper.getStutusText(13), "13"));//有订单调换
                            break;
                        case 14://等待发货
                            doStatus.Items.Add(new ListItem(Warehousing.Business.GoodsReturnHelper.getStutusText(15), "15"));//确定调换
                            break;
                        case 16://厂家直接发货
                        case 8://订单提交
                            //doStatus.Items.Add(new ListItem(Warehousing.Business.GoodsReturnHelper.getStutusText(10), "10"));//发货完成
                            //doStatus.Items.Add(new ListItem(Warehousing.Business.GoodsReturnHelper.getStutusText(11), "11"));//取消提交
                            break;
                    }
                }
                bindOrder();//调换货列表
                bindRemarkList(GoodsId);
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string oldStatus = Request["oldStatus"];
            string newStatus = Request["doStatus"];
            string doRemark = Request["doRemark"];
            if (newStatus.IsNullOrEmpty())
            {
                newStatus = oldStatus;
            }

             //根据新旧状态进行处理
            //生成返货订单
            if (Convert.ToInt32(newStatus) == 8 && newStatus != oldStatus)
            {
                ///
                Response.Redirect("GoodsToOrder.aspx?id="+GoodsId);

            }

            //写操作日志
            string dowhat = "";

            dowhat = GoodsId + "商品进行处理,状态由(" + Warehousing.Business.GoodsReturnHelper.getStutusText(Convert.ToInt32(oldStatus)) + oldStatus + ")至(" + Warehousing.Business.GoodsReturnHelper.getStutusText(Convert.ToInt32(newStatus)) + newStatus + ")," + doRemark;
            SiteHelper.writeLog("返货商品处理", dowhat);

             if (newStatus != oldStatus)
            {
                 SqlHelper sp = LocalSqlHelper.WH;
                string sql = "update TB_GoodsReturn set Status=" + newStatus + " where id=" + GoodsId;
                if (newStatus == "14")
                {
                    sql = "update TB_GoodsReturn set Status=" + newStatus + ",ChangeFlag=-1 where id=" + GoodsId;
                }
                sp.Execute(sql);
            }

             fromUrl = Request.QueryString["url"];
            if (fromUrl.IsNullOrEmpty())
            {
                fromUrl = "GoodsReturnList.aspx";
            }

            JSHelper.WriteScript("alert('处理成功');location.href='" + fromUrl + "'");
        }


        protected void bindOrder()
        {
            SqlHelper sp = LocalSqlHelper.WH;
            int count = 0;

            string sql = "select * from TB_GoodsReturn with (nolock) where ChangeFlag=" + GoodsId.ToString();
            DataTable dt = sp.ExecDataTable(sql);
            if (dt.Rows.Count > 0)
            {
                haveChange = 1;
                GoodsList.DataShow(dt);
            }
        }

        protected void bindRemarkList(string goodsId)
        {

            string sql = "select addtime,operator,dowhat from LogVpn where dotype='返货商品处理'  and dowhat like '" + goodsId + "商品进行处理%' order by id";
            SqlHelper sp = LocalSqlHelper.WH;
            DataTable dt = sp.ExecDataTable(sql);
            rpRemarkList.DataShow(dt);

        }

    }
}
