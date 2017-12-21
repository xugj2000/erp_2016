using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SinoHelper2;
using System.Web;
using System.Net;
using System.Net.Sockets;
using System.Reflection;
using System.IO;
using System.Text.RegularExpressions;
using System.Security.Cryptography;
using System.Data;
using System.Collections;

namespace Warehousing.Business
{
    public class PublicHelper
    {

        /// <summary>
        /// 搜索引擎agentuser头判断串
        /// </summary>
        public static readonly string SESource = "Googlebot,Baiduspider,Sogou web spider,YodaoBot,iaskspider,Aboundex,EtaoSpider";

        /// <summary>
        /// 过滤html,js,css代码
        /// </summary>
        /// <param name="html">参数传入</param>
        /// <returns></returns>
        public static string CheckStr(string html)
        {
            System.Text.RegularExpressions.Regex regex1 = new System.Text.RegularExpressions.Regex(@"<script[\s\S]+</script *>", System.Text.RegularExpressions.RegexOptions.IgnoreCase);
            System.Text.RegularExpressions.Regex regex2 = new System.Text.RegularExpressions.Regex(@" href *= *[\s\S]*script *:", System.Text.RegularExpressions.RegexOptions.IgnoreCase);
            System.Text.RegularExpressions.Regex regex3 = new System.Text.RegularExpressions.Regex(@" no[\s\S]*=", System.Text.RegularExpressions.RegexOptions.IgnoreCase);
            System.Text.RegularExpressions.Regex regex4 = new System.Text.RegularExpressions.Regex(@"<iframe[\s\S]+</iframe *>", System.Text.RegularExpressions.RegexOptions.IgnoreCase);
            System.Text.RegularExpressions.Regex regex5 = new System.Text.RegularExpressions.Regex(@"<frameset[\s\S]+</frameset *>", System.Text.RegularExpressions.RegexOptions.IgnoreCase);
            System.Text.RegularExpressions.Regex regex6 = new System.Text.RegularExpressions.Regex(@"\<img[^\>]+\>", System.Text.RegularExpressions.RegexOptions.IgnoreCase);
            System.Text.RegularExpressions.Regex regex7 = new System.Text.RegularExpressions.Regex(@"</p>", System.Text.RegularExpressions.RegexOptions.IgnoreCase);
            System.Text.RegularExpressions.Regex regex8 = new System.Text.RegularExpressions.Regex(@"<p>", System.Text.RegularExpressions.RegexOptions.IgnoreCase);
            System.Text.RegularExpressions.Regex regex9 = new System.Text.RegularExpressions.Regex(@"<[^>]*>", System.Text.RegularExpressions.RegexOptions.IgnoreCase);
            html = regex1.Replace(html, ""); //过滤<script></script>标记
            html = regex2.Replace(html, ""); //过滤href=javascript: (<A>) 属性
            html = regex3.Replace(html, " _disibledevent="); //过滤其它控件的on...事件
            html = regex4.Replace(html, ""); //过滤iframe
            html = regex5.Replace(html, ""); //过滤frameset
            html = regex6.Replace(html, ""); //过滤frameset
            html = regex7.Replace(html, ""); //过滤frameset
            html = regex8.Replace(html, ""); //过滤frameset
            html = regex9.Replace(html, "");
            html = html.Replace(" ", "");
            html = html.Replace("</strong>", "");
            html = html.Replace("<strong>", "");
            return html;
        }


        ///  <summary> 
        /// 过滤sql中非法字符 
        ///  </summary> 
        ///  <param name="value">要过滤的字符串 </param> 
        ///  <returns>string </returns> 
        public static string CheckSql(string value)
        {
            if (string.IsNullOrEmpty(value)) return string.Empty;
            value = System.Text.RegularExpressions.Regex.Replace(value, @";", string.Empty);
            value = System.Text.RegularExpressions.Regex.Replace(value, @"'", string.Empty);
            value = System.Text.RegularExpressions.Regex.Replace(value, @"&", string.Empty);
            value = System.Text.RegularExpressions.Regex.Replace(value, @"%20", string.Empty);
            value = System.Text.RegularExpressions.Regex.Replace(value, @"--", string.Empty);
            value = System.Text.RegularExpressions.Regex.Replace(value, @"==", string.Empty);
            value = System.Text.RegularExpressions.Regex.Replace(value, @" <", string.Empty);
            value = System.Text.RegularExpressions.Regex.Replace(value, @">", string.Empty);
            value = System.Text.RegularExpressions.Regex.Replace(value, @"%", string.Empty);
            value = System.Text.RegularExpressions.Regex.Replace(value, @"char", string.Empty);
            return value;
        }

        /// <summary>
        /// 判断是否来自搜索引擎
        /// </summary>
        /// <returns></returns>
        public static bool CheckFromSE()
        {
            //判断是否来自搜索引擎爬虫
            string userAgent = System.Web.HttpContext.Current.Request.UserAgent;
            if (!string.IsNullOrEmpty(userAgent))
            {
                userAgent = userAgent.ToLower();
                string[] SESourceArray = SESource.Split(',');
                for (int i = 0; i < SESourceArray.Length; i++)
                {
                    if (userAgent.IndexOf(SESourceArray[i].ToLower()) > -1)
                    {
                        return true;
                    }
                }
            }
            return false;
        }



        /// <summary>
        /// 获得当前页次
        /// </summary>
        /// <param name="pageName"></param>
        /// <returns></returns>
        public static int getPage(string pageName)
        {
            int page = 1;
            try
            {
                page = Convert.ToInt32(HttpContext.Current.Request[pageName]);
            }
            catch
            {
                page = 1;
            }
            if (page == 0)
            {
                page = 1;
            }
            return page;
        }

        /// <summary>
        /// 不使用分页存储的分页,目前仅适用单表,不用加with (nolock)
        /// </summary>
        /// <param name="helper"></param>
        /// <param name="tableName"></param>
        /// <param name="fields"></param>
        /// <param name="sortfield"></param>
        /// <param name="pageSize"></param>
        /// <param name="pageIndex"></param>
        /// <param name="condition"></param>
        /// <param name="pKeyName"></param>
        /// <param name="count"></param>
        /// <returns></returns>
        public static System.Data.DataTable TablesPage(SqlHelper helper, string tableName, string fields, string sortfield, int pageSize, int pageIndex, string condition, string pKeyName, out int count)
        {
            if (condition.IsNullOrEmpty())
            {
                condition = "1=1";
            }
            count = Convert.ToInt32(helper.ExecScalar("select count(*) from " + tableName + " with (nolock) where " + condition));
            string sql = "select top " + pageSize + " " + fields + " from " + tableName + " tableAliasA with (nolock) where " + condition + " and not exists(select top 1 1 from (select top " + (pageIndex - 1) * pageSize + " " + pKeyName + " from " + tableName + " where " + condition + " order by " + sortfield + ") as tableAliasB where " + pKeyName + "=tableAliasA." + pKeyName + ") order by " + sortfield;
            //HttpContext.Current.Response.Write(sql);
         //  HttpContext.Current.Response.End();

            System.Data.DataTable dt = helper.ExecDataTable(sql);
            return dt;
        }

        /// <summary>
        /// 生成N位随机码的函数
        /// </summary>
        /// <param name="codeCount"></param>
        /// <returns></returns>
        public static string CreateRandomCode(int codeCount)
        {
            string allChar = "0,1,2,3,4,5,6,7,8,9,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,e,s,t,u,v,w,x,y,z";
            string[] allCharArray = allChar.Split(',');
            string randomCode = "";
            int temp = -1;

            Random rand = new Random();
            for (int i = 0; i < codeCount; i++)
            {
                if (temp != -1)
                {
                    rand = new Random(i * temp * ((int)DateTime.Now.Ticks));
                }
                int t = rand.Next(36);
                if (temp != -1 && temp == t)
                {
                    return CreateRandomCode(codeCount);
                }
                temp = t;
                randomCode += allCharArray[t];
            }
            return randomCode;
        }




        /// <summary>
        /// 清除COOKIES
        /// </summary>
        /// <param name="CookieName"></param>
        public static void RemoveCookies(string CookieName)
        {
            if (HttpContext.Current.Request.Cookies[CookieName] != null)
            {
                HttpCookie myCookie = new HttpCookie(CookieName);
                myCookie.Expires = DateTime.Now.AddDays(-1d);
                HttpContext.Current.Response.Cookies.Add(myCookie);
            }

        }



        /// <summary>
        /// 生成短地址
        /// </summary>
        /// <param name="url"></param>
        /// <returns></returns>
        public static string[] ShortUrl(string url)
        {
            //可以自定义生成MD5加密字符传前的混合KEY   
            string key = "36936";
            //要使用生成URL的字符   
            string[] chars = new string[]{  
            "a" , "b" , "c" , "d" , "e" , "f" , "g" , "h" ,  
            "i" , "j" , "k" , "l" , "m" , "n" , "o" , "p" ,  
            "q" , "r" , "s" , "t" , "u" , "v" , "w" , "x" ,  
            "y" , "z" , "0" , "1" , "2" , "3" , "4" , "5" ,  
            "6" , "7" , "8" , "9" , "A" , "B" , "C" , "D" ,  
            "E" , "F" , "G" , "H" , "I" , "J" , "K" , "L" ,  
            "M" , "N" , "O" , "P" , "Q" , "R" , "S" , "T" ,  
            "U" , "V" , "W" , "X" , "Y" , "Z"   
        };

            //对传入网址进行MD5加密   
            string hex = System.Web.Security.FormsAuthentication.HashPasswordForStoringInConfigFile(key + url, "md5");

            string[] resUrl = new string[4];

            for (int i = 0; i < 4; i++)
            {
                //把加密字符按照8位一组16进制与0x3FFFFFFF进行位与运算   
                int hexint = 0x3FFFFFFF & Convert.ToInt32("0x" + hex.Substring(i * 8, 8), 16);
                string outChars = string.Empty;
                for (int j = 0; j < 6; j++)
                {
                    //把得到的值与0x0000003D进行位与运算，取得字符数组chars索引   
                    int index = 0x0000003D & hexint;
                    //把取得的字符相加   
                    outChars += chars[index];
                    //每次循环按位右移5位   
                    hexint = hexint >> 5;
                }
                //把字符串存入对应索引的输出数组   
                resUrl[i] = outChars;
            }
            return resUrl;
        }




        public static string RemoveXSS(string html)
        {
            if (html.IsNotNullAndEmpty())
            {
                html = html.Replace("\"", "");
                html = html.Replace("\'", "");
            }
            return html;
        }




        public static void AlertBackEnd(string info)
        {
            JSHelper.WriteScript("alert('" + info + "');history.back();");
            HttpContext.Current.Response.End();
        }


        /// <summary>
        /// 根据URL获得页面内容,返回页面内容
        /// </summary>
        /// <param name="url">远程URL</param>
        /// <param name="pagecode">编码</param>
        public static string getUrlContent(string url, string pagecode)
        {
            //编码
            Encoding encode = Encoding.GetEncoding(pagecode);
            //请求URL
            HttpWebRequest req = (HttpWebRequest)WebRequest.Create(url);
            //设置超时(10秒)
            req.Timeout = 10000;
            //获取Response
            HttpWebResponse rep = (HttpWebResponse)req.GetResponse();
            //创建StreamReader与StreamWriter文件流对象
            StreamReader sr = new StreamReader(rep.GetResponseStream(), encode);
            string webcontent = sr.ReadToEnd();
            sr.Close();
            sr.Dispose();
            //Response.Write(url);
            return webcontent;
        }


        /// <summary>
        /// MD5加密
        /// </summary>
        /// <param name="str"></param>
        /// <param name="length"></param>
        /// <returns></returns>
        public static string EncryptMD5(string str, int length)
        {
            if (length == 16)
                return EncryptMD5(str);

            return System.Web.Security.FormsAuthentication.HashPasswordForStoringInConfigFile(str, "MD5");
        }
        public static string EncryptMD5(string str)
        {
            return System.Web.Security.FormsAuthentication.HashPasswordForStoringInConfigFile(str, "MD5").Substring(8, 16);
        }



        public static bool IsMobileDevice()
        {

            string u = HttpContext.Current.Request.ServerVariables["HTTP_USER_AGENT"];
            Regex b = new Regex(@"android.+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|symbian|treo|up\.(browser|link)|vodafone|wap|windows (ce|phone)|xda|xiino|ucweb|mqqbrowser", RegexOptions.IgnoreCase | RegexOptions.Multiline);
            Regex v = new Regex(@"1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(di|rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-", RegexOptions.IgnoreCase | RegexOptions.Multiline);

            //if (HttpContext.Current.Request.ServerVariables["HTTP_VIA"] != null || HttpContext.Current.Request.ServerVariables["HTTP_VIA"] != "")
            //{
            //    return true;
            //}

            if (b.IsMatch(u))
            {
                return true;
            }
            return v.IsMatch(u.Substring(0, 4));
        }

        /// <summary>
        /// 连接MYsql数据库
        /// </summary>
        /// <returns></returns>
        public static MySqlHelper connMysql()
        {
            string ConnenctionString = System.Configuration.ConfigurationManager.ConnectionStrings["mysqlConn"].ToString();
            SinoHelper2.MySqlHelper help = new SinoHelper2.MySqlHelper(ConnenctionString, SinoHelper2.ConnectionStringType.ConnString);
            return help;
        }

        /// <summary>
        /// 设置不同类型SoapHead的值
        /// </summary>
        /// <param name="_head"></param>
        public static void SetHead(object _head)
        {
            string User = System.Guid.NewGuid().ToString();
            long Time = DateTime.Now.ToBinary();
            string EntryKey = "123456";
            string Hash = StringHelper.EncryptMD5(User + EntryKey + Time);

            Type type = _head.GetType();

            PropertyInfo property = type.GetProperty("User");
            property.SetValue(_head, User, null);

            property = type.GetProperty("Hash");
            property.SetValue(_head, Hash, null);

            property = type.GetProperty("Time");

            property.SetValue(_head, Time, null);
        }

        /// <summary>
        /// 获取md5码
        /// </summary>
        /// <param name="source">待转换字符串</param>
        /// <returns>md5加密后的字符串</returns>
        public static string getMD5(string source)
        {
            string result = "";
            try
            {
                MD5 getmd5 = new MD5CryptoServiceProvider();
                byte[] targetStr = getmd5.ComputeHash(UnicodeEncoding.UTF8.GetBytes(source));
                result = BitConverter.ToString(targetStr).Replace("-", "");
                return result;
            }
            catch (Exception)
            {
                return "0";
            }

        }

        /// <summary>
        /// 获取时间戳
        /// </summary>
        /// <returns></returns>
        public static double GetTimeStamp()
        {
            DateTime dtStart = TimeZone.CurrentTimeZone.ToLocalTime(new DateTime(1970, 1, 1));
            DateTime dtNow = DateTime.Parse(DateTime.Now.ToString());
            TimeSpan toNow = dtNow.Subtract(dtStart);
            string timeStamp = toNow.Ticks.ToString();
            timeStamp = timeStamp.Substring(0, timeStamp.Length - 7);
            return Convert.ToInt32(timeStamp) - 60 * 60 * 8;
        }

        public static void ToExcel(DataTable dt,string fileName)
        {

            HttpContext.Current.Response.Clear();
            HttpContext.Current.Response.AddHeader("content-disposition", "attachment;filename=" + fileName + ".xls");
            HttpContext.Current.Response.ContentEncoding = Encoding.GetEncoding("gb2312");
            HttpContext.Current.Response.ContentType = "application/ms-excel";
            StringWriter sw = new StringWriter();
            ArrayList list = new ArrayList();
            string connstr = "";
            for (int i = 0; i < dt.Columns.Count; i++)
            {
                connstr = connstr + dt.Columns[i].ColumnName + "\t";
                list.Add(dt.Columns[i].ColumnName);
            }
            connstr = connstr.Substring(0, connstr.Length - 1);
            sw.WriteLine(connstr);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                connstr = "";
                for (int j = 0; j < dt.Columns.Count; j++)
                {
                    connstr = connstr + dt.Rows[i][list[j].ToString()].ToString() + "\t";
                }
                connstr = connstr.Substring(0, connstr.Length - 1);
                sw.WriteLine(connstr);
            }
            HttpContext.Current.Response.Write(sw.ToString());
            HttpContext.Current.Response.Flush();
            HttpContext.Current.Response.Close();
        }


        /// <summary>
        /// unix时间转换为datetime
        /// </summary>
        /// <param name="timeStamp"></param>
        /// <returns></returns>
        public static DateTime UnixTimeToTime(string timeStamp)
        {
            DateTime dtStart = TimeZone.CurrentTimeZone.ToLocalTime(new DateTime(1970, 1, 1));
            long lTime = long.Parse(timeStamp + "0000000");
            TimeSpan toNow = new TimeSpan(lTime);
            return dtStart.Add(toNow);
        }

        /// <summary>
        /// datetime转换为unixtime
        /// </summary>
        /// <param name="time"></param>
        /// <returns></returns>
        public static int ConvertDateTimeInt(System.DateTime time)
        {
            System.DateTime startTime = TimeZone.CurrentTimeZone.ToLocalTime(new System.DateTime(1970, 1, 1));
            return (int)(time - startTime).TotalSeconds;
        }

        public static string subStr(string content, int len)
        {
            if (content.Length <= len)
            {
                return content;
            }
            else
            {

                return content.Substring(0, len) + "..";
            }
        }

        public static string getStatusText(object Status)
        {
            int intStatus = 0;
            if (Convert.ToString(Status).IsNumber())
            {
                intStatus = Convert.ToInt32(Status);
            }
            else
            {
                return "未知";
            }
            return intStatus == 1 ? "是" : "否";
        }


        public static int getReadRightByText(string strText)
        {
            SqlHelper conn = LocalSqlHelper.WH;
            int ReadFlag = 0;
            string sql = "select a.PowerStr from SinoRoleModule a left join SinoModule b on a.ModuleID=b.ID where b.ModuleName= '" + strText + "' and RoleID=" + HttpContext.Current.Request.Cookies["userInfo"]["RoleID"];
            DataTable dt = conn.ExecDataTable(sql);

            if (dt.Rows.Count > 0)
            {
                string PowerStr = Convert.ToString(dt.Rows[0]["PowerStr"]);
                string lastChar = string.Empty;
                lastChar = PowerStr.Substring(5, 1);
                if (lastChar == "1")
                {
                    ReadFlag = 1;
                }
                else
                {
                    ReadFlag = Convert.ToInt32(PowerStr.Substring(0, 1));
                }
                
            }
            return ReadFlag; 
        }
    }
}
