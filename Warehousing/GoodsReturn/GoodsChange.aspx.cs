using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Text;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using SinoHelper2;


namespace Warehousing.GoodsReturn
{
    public partial class GoodsChange : System.Web.UI.Page
    {
        protected int pid=0;
        protected string changeId = string.Empty;
        protected string changePname = string.Empty;
        protected string changePtxt = string.Empty;
        protected string changePnum = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            SiteHelper.CheckLogin();
            SiteHelper.GetPageUrlpower("GoodsReturn/GoodsReturnList.aspx");
            if (Session["PowerRead"].ToString() != "1")
            {
                SiteHelper.NOPowerMessage();
            }
            if (Request["id"].IsNumber())
            {
                pid = Convert.ToInt32(Request["id"]);
            }
            else
            {
                Response.End();
            }

            if (!Page.IsPostBack)
            {
               // txtChangePid.Value = pid.ToString();
                bindOrder();
            }

        }

        //捆绑搜索订单
        protected void bindOrder()
        {
            SqlHelper sp = LocalSqlHelper.WH;
            int count = 0;
            
            string sql = "select * from TB_GoodsReturn with (nolock) where ChangeFlag=" + pid.ToString();
            DataTable dt = sp.ExecDataTable(sql);
            GoodsList.DataShow(dt);
        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            SqlHelper sp = LocalSqlHelper.WH;
            changeId = txtChangePid.Value;
            changePname = txtChangePname.Text;
            changePnum = txtChangeNum.Text;
            changePtxt = txtChangeTxt.Text;
            if (changePname.IsNullOrEmpty() || !changePnum.IsNumber())
            {
                JSHelper.WriteScript("alert('输入有误');history.back()");
                Response.End();
            }
            string sql = string.Empty;
            if (changeId.IsNumber())
            {
                //更改
                sql = "update TB_GoodsReturn set ProductName=@ProductName,ProductCount=@ProductCount,ProductTxm=@ProductTxm where ID=@ID and ChangeFlag=@ChangeFlag";
                sp.Params.Add("@ID", changeId);
            }
            else
            {
                //插入
                sql = "insert into TB_GoodsReturn(ProductName,ProductCount,ProductTxm,DingDan,AgentId,ReturnReson,ReceivedOpter,ChangeFlag) select @ProductName,@ProductCount,@ProductTxm,DingDan,AgentId,ReturnReson,ReceivedOpter,@ChangeFlag from TB_GoodsReturn where ID=@ChangeFlag";
            }
            sp.Params.Add("@ProductName", changePname);
            sp.Params.Add("@ProductCount", changePnum);
            sp.Params.Add("@ProductTxm", changePtxt);
            sp.Params.Add("@ChangeFlag", pid);
            //Response.Write(sql);
            //Response.End();
            sp.Execute(sql);
            JSHelper.WriteScript("alert('编辑成功');location.href='GoodsChange.aspx?id=" + pid .ToString()+ "'");
        }

        protected void GoodsList_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            string changeid = e.CommandArgument.ToString();
            SqlHelper sp = LocalSqlHelper.WH;
            if (!changeid.IsNumber())
            {
                JSHelper.WriteScript("alert('输入有误');history.back()");
                Response.End();
            }
            string sql = string.Empty;
            if (e.CommandName == "change")
            {
                sql="select * from TB_GoodsReturn where id="+changeid;
                DataTable dt=sp.ExecDataTable(sql);
                if (dt.Rows.Count>0)
                {
                    txtChangePname.Text=dt.Rows[0]["ProductName"].ToString();
                    txtChangeNum.Text = dt.Rows[0]["ProductCount"].ToString();
                    txtChangeTxt.Text = dt.Rows[0]["ProductTxm"].ToString();
                    txtChangePid.Value=changeid;
                }

            }
            if (e.CommandName == "del")
            {
                sql = "delete from TB_GoodsReturn where id=" + changeid;
                sp.Execute(sql);
                Response.Redirect("GoodsChange.aspx?id=" + pid.ToString());
            }
        }


    }
}
