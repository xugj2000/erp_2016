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
using Warehousing.Model;
using System.Text.RegularExpressions;

namespace Warehousing.Business
{
    public class UserHelper
    {

        public static DataRow getUserInfo(string UserCode)
        {
            SqlHelper helper = LocalSqlHelper.WH;
            string sql = "select top 1 * from Tb_User where user_name like '" + UserCode + "' or user_mobile like '" + UserCode + "'";
            DataTable dt = helper.ExecDataTable(sql);
            if (dt.Rows.Count == 0)
            {
                return null;
            }
            return dt.Rows[0];
        }

        public static int getUserId(string UserCode)
        {
            DataRow dr= getUserInfo(UserCode);
            if (dr != null)
            {
                return Convert.ToInt32(dr["User_id"]);
            }
            return 0;
        }

        /// <summary>
        /// 生成新会员
        /// </summary>
        /// <param name="newUser"></param>
        /// <returns>新会员ID</returns>
        public static int addUser(UserInfo newUser)
        {
            SqlHelper helper = LocalSqlHelper.WH;
            helper.Params.Add("User_name", newUser.User_name);
            if (newUser.User_Mobile != null)
            {
                helper.Params.Add("User_Mobile", newUser.User_Mobile);
            }
            helper.Params.Add("True_name", newUser.True_name);
            helper.Params.Add("User_level", newUser.User_level);
            helper.Params.Add("is_hide", newUser.is_hide);
            helper.Params.Add("cashier_id_from", newUser.cashier_id_from);
            helper.Params.Add("store_id_from", newUser.store_id_from);
            helper.Params.Add("User_Pwd", SinoHelper2.StringHelper.ASP16MD5(newUser.User_Pwd));
            try
            {
                helper.Insert("Tb_User");
                return getUserId(newUser.User_name);
            }
            catch
            {
                return 0;
            }
        }

        public static string getUserLevelText(int User_Level)
        {
            string UserLevelText=string.Empty;
            switch (User_Level)
            {
                case 1:
                    UserLevelText = "一级批发商";
                    break;
                case 2:
                    UserLevelText = "二级批发商";
                    break;
                case 9:
                    UserLevelText = "加盟商";
                    break;
                default:
                    UserLevelText = "普通会员";
                    break;
            }
            return UserLevelText;
        }
    }
}