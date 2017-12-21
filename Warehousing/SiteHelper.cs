using System;
using System.Data;
using System.Configuration;
using System.Linq;
using System.Net;
using System.IO;
using System.Text;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Collections;
using System.Collections.Generic;
using SinoHelper2;
using Maiduo.Service.Interface;

namespace Warehousing
{
    public class SiteHelper
    {
        /// <summary>
        /// 初始化相关数据
        /// </summary>

        /// <summary>
        /// 验证是否登录
        /// </summary>
        /// <returns></returns>
        public static void CheckLogin()
        {
            HttpCookie userCookie = HttpContext.Current.Request.Cookies["userInfo"];
            try
            {
                //获取COOKIE值到Session,避免失效
                foreach (var name in userCookie.Values.AllKeys)
                {
                    HttpContext.Current.Session[name] = HttpUtility.UrlDecode(userCookie.Values[name]);
                }
               
            }
            catch
            {
                
            }
            if (HttpContext.Current.Session["LoginName"] == null)
            {
                JSHelper.WriteScript("alert('请先登录！');top.location.href='/';");
                HttpContext.Current.Response.End();
            }
        }

        /// <summary>
        /// 根据页面URL获得对应的访问权限
        /// </summary>
        /// <param name="url">页面地址</param>

        public static void GetPageUrlpower(string url)
        {
            SqlHelper helper = LocalSqlHelper.WH;
            string sql=string.Empty;
            string PowerStr = "000000";
            string RoleID=Convert.ToString(HttpContext.Current.Session["RoleID"]);
            sql = "select a.PowerStr from SinoRoleModule a left join SinoModule b on a.ModuleID=b.ID where b.PageUrl like '%" + url + "' and RoleID=@RoleID";
            helper.Params.Add("@RoleID", RoleID);
            DataTable ds = helper.ExecDataTable(sql);
            if (ds.Rows.Count > 0)
            {
                PowerStr = ds.Rows[0]["PowerStr"].ToString();
            }
            if (PowerStr.Substring(5, 1) == "1")
            {
                HttpContext.Current.Session["PowerRead"] = 1;
                HttpContext.Current.Session["PowerAdd"] = 1;
                HttpContext.Current.Session["PowerEdit"] = 1;
                HttpContext.Current.Session["PowerDel"] = 1;
                HttpContext.Current.Session["PowerAudit"] = 1;
                HttpContext.Current.Session["PowerSuper"] = 1;
            }
            else
            {
                HttpContext.Current.Session["PowerRead"] = PowerStr.Substring(0, 1);
                HttpContext.Current.Session["PowerAdd"] = PowerStr.Substring(1, 1);
                HttpContext.Current.Session["PowerEdit"] = PowerStr.Substring(2, 1);
                HttpContext.Current.Session["PowerDel"] = PowerStr.Substring(3, 1);
                HttpContext.Current.Session["PowerAudit"] = PowerStr.Substring(4, 1);
                HttpContext.Current.Session["PowerSuper"] = 0;
            }
        }

        /// <summary>
        /// 无权限提示
        /// </summary>
        public static void NOPowerMessage()
        {
            HttpContext.Current.Response.Write("<p style='color:red;line-height:200px;text-align:center'>Sorry!!你没有此功能的操作权限!如需完成该操作,请向管理员申请该权限!</p>");
            HttpContext.Current.Response.End();
        }

        /// <summary>
        /// 导出excel表
        /// </summary>
        /// <param name="ctl"></param>
        /// <param name="FileName"></param>
        public static void ToExcel(System.Web.UI.Control ctl, string FileName)
        {
            HttpContext.Current.Response.Charset = "utf-8";
            HttpContext.Current.Response.ContentEncoding = System.Text.Encoding.GetEncoding("utf-8");
            HttpContext.Current.Response.ContentType = "application/ms-excel";
            HttpContext.Current.Response.AppendHeader("Content-Disposition", "attachment;filename=" + "" + FileName + ".xls");
            ctl.Page.EnableViewState = false;
            System.IO.StringWriter tw = new System.IO.StringWriter();
            HtmlTextWriter hw = new HtmlTextWriter(tw);
            ctl.RenderControl(hw);
            HttpContext.Current.Response.Write(tw.ToString());
            HttpContext.Current.Response.End();
        }

        /// <summary>
        /// 根据退换货类型ID获知名称
        /// </summary>
        /// <param name="OpTypeId"></param>
        /// <returns></returns>
        public static string getReturnGoodsText(object OpTypeId)
        {
            string ReturnGoodsText = string.Empty;
            switch (Convert.ToInt16(OpTypeId))
            {
                case 0:
                    ReturnGoodsText = "退货";
                    break;
                case 1:
                    ReturnGoodsText = "换货";
                    break;
            }
            return ReturnGoodsText;
        }

        /// <summary>
        /// 取消订单确定状态
        /// </summary>
        /// <param name="CancelStatus"></param>
        /// <returns></returns>
        public static string getConfirmText(string ConfirmStatus)
        {
            string ConfirmText = string.Empty;
            if (ConfirmStatus == "True")
            {
                ConfirmText = "已确认";
            }
            else
            {
                ConfirmText = "<font color=green>待审</font>";

            }
            return ConfirmText;
        }

        /*
        /// <summary>
        ///WebService SoapHeader验证
        /// </summary>
        /// <returns></returns>
        public static Warehousing.WebReference.LocalToWebsite SendSoapHeader()
        {
            Warehousing.WebReference.MySoapHeader head = new Warehousing.WebReference.MySoapHeader();
            head.User = System.Guid.NewGuid().ToString();
            head.Hash = StringHelper.EncryptMD5(head.User + "{B5880823-ADFF-4982-82BC-1A6A8486E31C}");
            Warehousing.WebReference.LocalToWebsite ss = new Warehousing.WebReference.LocalToWebsite();
            ss.MySoapHeaderValue = head;
            return ss;
        }
         */

		        /// <summary>
        /// 写流水日志,
        /// </summary>
        /// <param name="DoType">操作类型关键词</param>
        /// <param name="DoWhat">操作事宜描述</param>
        public static void writeLog(string DoType,string DoWhat)
        {
            SqlHelper conn = LocalSqlHelper.WH;
            string DoUrl = RequestHelper.GetUrl();
            string Operator = HttpContext.Current.Session["LoginName"].ToString();
            string sql = "insert into LogVpn(Operator, AddTime, DoType, DoUrl, DoWhat,Ip) values(@Operator, @AddTime, @DoType, @DoUrl, @DoWhat,@Ip)";
            conn.Params.Add("@Operator", Operator);
            conn.Params.Add("@DoType", DoType);
            conn.Params.Add("@DoUrl", DoUrl);
            conn.Params.Add("@DoWhat", DoWhat);
            conn.Params.Add("@AddTime", DateTime.Now);
            conn.Params.Add("@Ip",SinoHelper2.RequestHelper.GetIP());
            conn.Execute(sql);
        }


        /// <summary>
        /// 写操作日志,将操作关联ID自成一列
        /// </summary>
        /// <param name="DoType">操作类型关键词</param>
        /// <param name="DoWhat">操作事宜描述</param>
        /// <param name="objectId">关联ID</param>
        public static void writeLog(string DoType, string DoWhat,int objectId)
        {
            SqlHelper conn = LocalSqlHelper.WH;
            string DoUrl = RequestHelper.GetUrl();
            string Operator = HttpContext.Current.Session["LoginName"].ToString();
            string sql = "insert into LogVpn(Operator, AddTime, DoType, DoUrl, DoWhat,Ip,objectId) values(@Operator, @AddTime, @DoType, @DoUrl, @DoWhat,@Ip,@objectId)";
            conn.Params.Add("@Operator", Operator);
            conn.Params.Add("@DoType", DoType);
            conn.Params.Add("@DoUrl", DoUrl);
            conn.Params.Add("@DoWhat", DoWhat);
            conn.Params.Add("@AddTime", DateTime.Now);
            conn.Params.Add("@objectId",objectId);
            conn.Params.Add("@Ip", SinoHelper2.RequestHelper.GetIP());
            conn.Execute(sql);
        }

        /// <summary>
        /// 获得传递过来的页序号
        /// </summary>
        /// <returns></returns>
        public static int getPage()
        {
            string page = HttpContext.Current.Request["page"];
            if (page.IsNumber())
            {
                if (Convert.ToInt32(page) < 1)
                {
                    return 1;
                }
                else
                {
                    return Convert.ToInt32(page);
                }

            }
            else
            {
                return 1;
            }


        }



        /// <summary>
        /// 绑定投诉原因
        /// </summary>

        public static void bindReason(DropDownList dd)
        {
            string sql = "select * from Tb_ComplaintType with(nolock) where isHidden=0 order by typeId";
            SqlHelper sp = LocalSqlHelper.WH;
            DataTable dt = sp.ExecDataTable(sql);
            BindingHelper.BindDDL(dd, dt, "typeName", "typeId");
        }

        /// <summary>
        /// 根据当前操作员ID获知操作员用户名
        /// </summary>
        /// <param name="LoginId"></param>
        /// <returns></returns>
        public static string getTrueNameByLoginId(string LoginId)
        {
            string TrueName = "";
            if (LoginId.IsNotNullAndEmpty())
            {
                string sql = "select top 1 fullname from wareHouse_Admin where LoginName=@LoginName";
                SqlHelper sp = LocalSqlHelper.WH;
                sp.Params.Add("@LoginName", LoginId);
                DataTable dt = sp.ExecDataTable(sql);
                if (dt.Rows.Count > 0)
                {
                    TrueName = dt.Rows[0]["fullname"].ToString();
                }
            }
            return TrueName;
        }


        /// <summary>
        /// 根据文本获知是否可读权限
        /// </summary>
        /// <param name="strText"></param>
        /// <returns></returns>
        public static bool getReadRightByText(string strText)
        {
            bool ReadFlag = false;
            string sql = "select a.PowerStr from SinoRoleModule a left join SinoModule b on a.ModuleID=b.ID where b.ModuleName= '" + strText + "' and RoleID=" + HttpContext.Current.Session["RoleID"].ToString();
            SqlHelper conn = LocalSqlHelper.WH;
            DataTable dt = conn.ExecDataTable(sql);
            if (dt.Rows.Count > 0)
            {
                string PowerStr = dt.Rows[0]["PowerStr"].ToString();
                if ("1".Equals(PowerStr.Substring(0, 1)) || "1".Equals(PowerStr.Substring(5, 1)))
                {
                    ReadFlag = true;
                }
            }
            return ReadFlag;
        }

    }
}
