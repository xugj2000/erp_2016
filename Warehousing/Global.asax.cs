using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;
using System.Xml.Linq;
using SinoHelper2;

namespace Warehousing
{
    public class Global : System.Web.HttpApplication
    {
        static SinoHelper2.QuartzScheduler.QuartzWorker worker;
        protected void Application_Start(object sender, EventArgs e)
        {
            //ThreadStart();
            //表示不是本地
                try
                {
                   // worker = new SinoHelper2.QuartzScheduler.QuartzWorker();
                    //同步测试

                   // Business.task.WorkSyn job = new Business.task.WorkSyn();
                   // worker.AddWork(job);
                    /**/
                   // worker.Start();
                    //SinoHelper2.EventLog.WriteLog("by:duanjuehng   外网IP为：" + hostIP + "        进程执行成功!");
                }
                catch
                {
                    //do nothing 
                    SinoHelper2.EventLog.WriteLog("进程出错");
                }
        }

        protected void Session_Start(object sender, EventArgs e)
        {

        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {

        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {

        }

        protected void Application_Error(object sender, EventArgs e)
        {

        }

        protected void Session_End(object sender, EventArgs e)
        {

        }

        protected void Application_End(object sender, EventArgs e)
        {

        }
    }
}