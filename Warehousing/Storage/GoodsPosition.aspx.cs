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
    public partial class GoodsPosition : System.Web.UI.Page
    {
        protected string txm = string.Empty;
        protected string productName = string.Empty;
        protected string styeName = string.Empty;
        protected string styleId = string.Empty;
        protected string productId = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            SiteHelper.CheckLogin();
            SiteHelper.GetPageUrlpower("Storage/GoodsPosition.aspx");
            if (Session["PowerRead"].ToString() != "1")
            {
               // SiteHelper.NOPowerMessage();
            }
            if (!IsPostBack)
            {
                txtTxm.Attributes.Add("onkeydown", "if(event.which || event.keyCode){   if ((event.which == 13) || (event.keyCode == 13)) {   document.getElementById('" + Button1.UniqueID + "').click();return false;}}    else {return true}; ");
                //Button1.Attributes.Add("onclick", "if (document.getElementById('txtTxm').value==''){alert('请输入条码');return false;}");
                txtLocalId.Attributes.Add("onkeydown", "if(event.which || event.keyCode){   if ((event.which == 13) || (event.keyCode == 13)) {   document.getElementById('" + Button2.UniqueID + "').click();return false;}}    else {return true}; ");
                Button2.Attributes.Add("onclick", "if (document.getElementById('txtLocalId').value==''){alert('请输入货位号');return false;}");
                txtTxm.Focus();
                panelStep1.Visible = true;
                panStep2.Visible = false;
                bindLast();
            }
            
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            txm = txtTxm.Text.Trim ();
            string productstr = ProductNameStr.Text.Trim();
            if (txm.IsNullOrEmpty() && productstr.IsNullOrEmpty())
            {
                JSHelper.WriteScript("alert('请输入商品条码或名称！');history.back();");
                return;
            }
            SqlHelper sp = LocalSqlHelper.WH;

            string sql = "select a.id,a.shopxpptid,a.p_size,b.shopxpptname,a.txm,isnull(c.LocalId,'EmptyNull') as LocalId  from shopxp_kucun a left join shopxp_product b on a.shopxpptid=b.shopxpptid left join GoodsPositionSet c on a.id =c.StyleId  where 1=1 ";

            
            if (txm.IsNotNullAndEmpty())
            {
                sql += " and a.txm = @txm";
                sp.Params.Add("@txm",txm);
            }
            
            if (productstr.IsNotNullAndEmpty())
            {
                sql += " and b.shopxpptname like @prostr";
                sp.Params.Add("@prostr","%"+productstr+"%");
            }            
            DataTable dt = sp.ExecDataTable(sql);
            if (dt.Rows.Count==1)
            {
                //将当前获取到的商品的信息付给控件进行显示
                //此处修改为列表显示
                productName = dt.Rows[0]["shopxpptname"].ToString();
                styeName = dt.Rows[0]["p_size"].ToString();

                styleId = dt.Rows[0]["id"].ToString();
                productId = dt.Rows[0]["shopxpptid"].ToString();

                lbProductName.Text = productId + "," + productName;
                lbStyleName.Text = styleId + "," + styeName;

                panelStep1.Visible = false;
                FindList.Visible = false;
                panStep2.Visible = true;

                //获取当前商品对应的的货位号（如果已存在）
                string checksql = "select LocalId from GoodsPositionSet where StyleId=" + styleId;
                DataTable dt0 = sp.ExecDataTable(checksql);
                if (dt0.Rows.Count > 0)
                {
                    string LocalId = dt0.Rows[0]["LocalId"].ToString();
                    txtLocalId.Text = LocalId;
                }
                txtLocalId.Focus();
                txtLocalId.Attributes.Add("onfocus", "this.select();");
                //JSHelper.WriteScript("document.getElementById('savestyleid').value=" + styleId + ";");
            }
            else if (dt.Rows.Count > 1)//添加此处
            {
                //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "js", "document.getElementById('nearInput').display=none;", true);
                //此处为列表显示,并进行选择
                FindShowList.DataSource = dt;
                FindShowList.DataBind();
                
                //显示
                panelStep1.Visible = false;
                FindList.Visible = true;
            }
            else
            {
                JSHelper.WriteScript("alert('商品不存在');history.back();");
                return;
            }
        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            if (savestyleid.Value.Trim().IsNullOrEmpty())
            {
                JSHelper.WriteScript("alert('请选择要执行操作的商品！');history.back();");
                return;
            }
            FindList.Visible = false;
            string sql = "select a.id,a.shopxpptid,a.p_size,b.shopxpptname,a.txm from shopxp_kucun a left join shopxp_product b on a.shopxpptid=b.shopxpptid where id in (" + savestyleid.Value .Trim () + ")";
            SqlHelper sp = LocalSqlHelper.WH;
            DataTable dt = sp.ExecDataTable(sql);
            CheckRp.DataSource = dt;
            CheckRp.DataBind();
            CheckList.Visible = true;
            //panStep2.Visible = true;
            forList.Visible = true;
            HuoWeiHao.Focus();
        }


        protected void Button2_Click(object sender, EventArgs e)
        {
            SqlHelper sp = LocalSqlHelper.WH;
            sp.Params.Clear();
            string localId = txtLocalId.Text;
            string myLocalId = HuoWeiHao.Text.Trim();
            
            string sql = string.Empty;
            if (savestyleid.Value.Trim().IsNullOrEmpty())
            {
                if (localId.IsNullOrEmpty())
                {
                    JSHelper.WriteScript("alert('货位号输入有误');history.back();");
                    return;
                }

                string styleid = Request["styleid"];
                if (!styleid.IsNumber())
                {
                    JSHelper.WriteScript("alert('操作有误');history.back();");
                    return;
                }

                
                //查找是否已存在货位号
                object id = sp.ExecScalar("select id from GoodsPositionSet where StyleId=" + styleid);
                string checkid = "";
                if (id != DBNull.Value)
                {
                    checkid = Convert.ToString(id);
                }
                //如果存在货位号
                if (checkid.IsNumber())
                {
                    sql = "update GoodsPositionSet set UpdateTime=getdate(),LocalId=@LocalId where StyleId=@StyleId";
                }
                //如果不存在
                else
                {
                    sql = "insert into GoodsPositionSet(StyleId,LocalId,AddTime) values(@StyleId,@LocalId,getdate())";
                }
                sp.Params.Clear();
                sp.Params.Add("@StyleId", styleid);
                sp.Params.Add("@LocalId", localId);
                sp.Execute(sql);
                sp.Params.Clear();
            }
            else
            {
                string[] sArray = savestyleid.Value.Trim().Split(new char[] { ',' });
                foreach (string instr in sArray)
                {
                    //EventLog.Log("---------------------------------------------------------------------"+instr);
                    object id = sp.ExecScalar("select id from GoodsPositionSet where StyleId='" + instr +"'");
                    string checkid = "";
                    if (id != DBNull.Value)
                    {
                        checkid = Convert.ToString(id);
                    }
                    //如果存在货位号
                    if (checkid.IsNumber())
                    {
                        //EventLog.Log("---update--------------------------------" + instr);
                        sql = "update GoodsPositionSet set UpdateTime=getdate(),LocalId=@LocalId where StyleId=@StyleId";
                    }
                    //如果不存在
                    else
                    {
                        //EventLog.Log("----insert----------------------------------------------" + instr);
                        sql = "insert into GoodsPositionSet(StyleId,LocalId,AddTime) values(@StyleId,@LocalId,getdate())";
                    }
                    sp.Params.Clear();
                    sp.Params.Add("@StyleId", instr);
                    sp.Params.Add("@LocalId", myLocalId);
                    sp.Execute(sql);
                    sp.Params.Clear();
                }
            }
            Response.Redirect("GoodsPosition.aspx");  
        }
        protected void bindLast()
        {
            SqlHelper sp = LocalSqlHelper.WH;
            string sql = "select top 20 a.StyleId,a.LocalId,a.AddTime,b.shopxpptid,b.shopxpptname,b.p_size,b.txm from GoodsPositionSet a left join warehouse_detail b on a.StyleId=b.shopxp_yangshiid order by a.AddTime desc";
            DataTable dt = sp.ExecDataTable(sql);
            lastList.DataShow(dt);

        }
    }
}
