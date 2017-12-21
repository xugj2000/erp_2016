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

namespace Warehousing.Complaint
{
    public partial class ComplaintType : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SiteHelper.CheckLogin();
            SiteHelper.GetPageUrlpower("Complaint/ComplaintType.aspx");
            if (Session["PowerRead"].ToString() != "1")
            {
                SiteHelper.NOPowerMessage();
            }

            if (!Page.IsPostBack)
            {
                //绑定商品
                hdTypeId.Value = "0";
                rbIsHidden.SelectedValue = "0";
                bindOrder(SiteHelper.getPage());
            }

        }

        //捆绑搜索订单
        protected void bindOrder(int page)
        {
            SqlHelper sp = LocalSqlHelper.WH;
            
            string sql = "select * from Tb_ComplaintType with(nolock) order by typeid ";
            DataTable dt = sp.ExecDataTable(sql);
            GoodsList.DataShow(dt);
        }



        protected void Button1_Click(object sender, EventArgs e)
        {
            string typeName = txtTypeName.Text;
            if (typeName.IsNullOrEmpty())
            {
                JSHelper.WriteScript("alert('类型名称不能为空');history.back();");
                Response.End();
            }
            string typeid = hdTypeId.Value;
            string sql = string.Empty;
            string ishidden = rbIsHidden.SelectedValue;
            if (Convert.ToInt32(typeid) > 0)
            {
                if (Session["PowerEdit"].ToString() != "1")
                {
                    SiteHelper.NOPowerMessage();
                }
                //修改
                sql = "update Tb_ComplaintType set typeName=@typeName,isHidden=@isHidden where typeid="+typeid;
            }
            else
            {
                if (Session["PowerAdd"].ToString() != "1")
                {
                    SiteHelper.NOPowerMessage();
                }
                sql = "insert into Tb_ComplaintType(typeName,isHidden) values(@typeName,@isHidden)";
            }
            SqlHelper sp = LocalSqlHelper.WH;
            sp.Params.Add("@typeName", typeName);
            sp.Params.Add("@isHidden", ishidden);
            sp.Execute(sql);
            JSHelper.WriteScript("alert('操作成功');location.href='ComplaintType.aspx'");
            Response.End();

        }

        protected void GoodsList_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            string act = e.CommandName;
            if (act == "edit")
            {
                if (Session["PowerEdit"].ToString() != "1")
                {
                    SiteHelper.NOPowerMessage();
                }
                 SqlHelper sp = LocalSqlHelper.WH;
                string typeid=e.CommandArgument.ToString();
                if (!typeid.IsNumber())
                {
                    JSHelper.WriteScript("alert('参数有误');history.back();");
                    Response.End();
                }
                string sql="select * from Tb_ComplaintType with(nolock) where typeId=@typeId";
                sp.Params.Add("@typeId", typeid);
                DataTable dt = sp.ExecDataTable(sql);
                if (dt.Rows.Count > 0)
                {
                    txtTypeName.Text = dt.Rows[0]["typeName"].ToString();
                    if (Convert.ToInt32(dt.Rows[0]["isHidden"]) == 1)
                    {
                        rbIsHidden.SelectedValue = "1";

                    }
                    else
                    {
                        rbIsHidden.SelectedValue = "0";
                    }
                    hdTypeId.Value = dt.Rows[0]["typeId"].ToString();
                    Button1.Text = "更改类别";
                }
            }
        }

        protected string getHiddenText(object isHidden)
        {
            if (Convert.ToString(isHidden) == "1")
            {
                return "<font color=gray>停用</font>";
            }
            else
            {
                return "<font color=green>启用</font>";
            }


        }

    }
}
