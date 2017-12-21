using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web.Security;
using System.IO;
using SinoHelper2;
using Warehousing.Business;
using System.Web.Services;
using System.Web.SessionState;



namespace Warehousing.Storage
{
    /// <summary>
    /// $codebehindclassname$ 的摘要说明
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    public class Upload1 : IHttpHandler, IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            SinoHelper2.EventLog.WriteLog("test");
            try
            {
                context.Response.Expires = 0;
                context.Response.AddHeader("pragma", "no-cache");
                context.Response.AddHeader("Cache-Control", "no-store, must-revalidate");
                    HttpPostedFile hpf = context.Request.Files["Filedata"];

                    string oldFilename = hpf.FileName;
                    string newFilename = getfileName();

                    //建立今天的文件夹
                    //string d = DateTime.Now.ToString("yyyyMMdd");
                    string path = context.Server.MapPath("pic/");
                    if (!Directory.Exists(path))
                    {
                        Directory.CreateDirectory(path);
                    }
                    hpf.SaveAs(path + newFilename);
                    context.Response.StatusCode = 200;
                    context.Response.Write(newFilename);
            }
            catch (Exception exx)
            {
                // If any kind of error occurs return a 500 Internal Server error
                context.Response.StatusCode = 500;
                SinoHelper2.EventLog.WriteLog(exx.Message);
                context.Response.Write("error");
            }
            finally
            {
                // Clean up 
                context.Response.End();
            }



        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }


        /// <summary>
        /// 生成临时文件名
        /// </summary>
        /// <returns></returns>
        protected string getfileName()
        {
            Random ro = new Random();//得到随机数       
            string OdNo = System.DateTime.Now.Year.ToString()
              + System.DateTime.Now.Month.ToString()
              + System.DateTime.Now.Day.ToString()
              + System.DateTime.Now.Hour.ToString()
              + System.DateTime.Now.Minute.ToString()
              + System.DateTime.Now.Second.ToString()
              + ro.Next(1000).ToString() + ".jpg";
            return OdNo;
        }
    }
}
