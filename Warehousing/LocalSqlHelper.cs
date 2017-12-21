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

namespace Warehousing
{
    public class LocalSqlHelper
    {
        private static SinoHelper2.SqlHelper CreateSqlHelper(string name)
        {
            string dbPath = System.Web.Hosting.HostingEnvironment.MapPath("~/dbConnection/");
            string file = dbPath + name + ".config"; //agent.config Company.config datalog.config liandongxiaofei.config
            SinoHelper2.SqlHelper help = new SinoHelper2.SqlHelper(file, SinoHelper2.ConnectionStringType.EncryptFile);
            return help;
        }

        #region 枚举

        /// <summary>
        /// Warehousing
        /// </summary>
        public static SinoHelper2.SqlHelper WH
        {
            get
            {
                return CreateSqlHelper("WH");
            }
        }
        /// <summary>
        /// 数据库report的连接
        /// </summary>
        public static SinoHelper2.SqlHelper ReportDB
        {
            get
            {
                return CreateSqlHelper("report");
            }
        }
        /// <summary>
        /// 数据库agent_info的连接
        /// </summary>
        public static SinoHelper2.SqlHelper ConnSHDB
        {
            get
            {
                return CreateSqlHelper("ConnSHDB");
            }
        }
        
        /// <summary>
        /// 生产上的agent_info,请确认后使用！
        /// </summary>
        public static SinoHelper2.SqlHelper WebAgentNotUse
        {
            get
            {
                return CreateSqlHelper("WebAgent");
            }
        }

        /// <summary>
        /// 生产上的Report,请确认后使用！
        /// </summary>
        public static SinoHelper2.SqlHelper WebReportNotUse
        {
            get
            {
                return CreateSqlHelper("WebReport");
            }
        }

        #endregion
    }
}
