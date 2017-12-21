using System;
using System.Data;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using SinoHelper2;


namespace Warehousing.Business
{
    /// <summary>
    /// 客诉处理状态
    /// </summary>
    public enum ComplaintStatus
    {
        待处理 = 0,
        处理中 = 1,
        已处理=2
    }

    public class ComplaintHelper
    {
        /// <summary>
        /// 根据客诉处理状态数值获得状态名称
        /// </summary>
        /// <param name="Status">状态数字</param>
        /// <returns></returns>
        public static string getStutusText(int Status)
        {
            string StatusText = "";
            ComplaintStatus col = (ComplaintStatus)Status;
            switch (Status){
                case 0:
                StatusText="<font color=red>"+col.ToString()+"</font>";
                break;
                case 1:
                StatusText = "<font color=green>" + col.ToString() + "</font>";
                break;
                case 2:
                StatusText = "<font color=black>" + col.ToString() + "</font>";
                break;
            }

            return StatusText;
        }

        /// <summary>
        /// 用客诉处理状态捆绑至dropdownlist
        /// </summary>
        /// <param name="ddl">相应下拉控件</param>
        public static void bindDDLByComplaintStatus(DropDownList ddl)
        {
            int[] values = (int[])Enum.GetValues(typeof(ComplaintStatus));
            for (int i = 0; i < values.Length; i++)
            {
                ddl.Items.Add(new ListItem(((ComplaintStatus)values[i]).ToString(), values[i].ToString()));
            }
        }


        /// <summary>
        /// 获得投诉类型的文字名称
        /// </summary>
        /// <param name="typeid">类型数字ID</param>
        /// <returns></returns>
        public static string getTypeName(object typeid)
        {
            string sql = "select top 1 typeName from Tb_ComplaintType where typeid=@typeid";
            SqlHelper sp = LocalSqlHelper.WH;
            sp.Params.Add("@typeid", typeid);
            DataTable dt = sp.ExecDataTable(sql);
            if (dt.Rows.Count > 0)
            {
                return dt.Rows[0]["typeName"].ToString();

            }
            else
            {
                return "未知";
            }
        }
    }
}
