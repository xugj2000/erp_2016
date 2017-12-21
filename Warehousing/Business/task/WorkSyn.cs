using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using SinoHelper2;
using SinoHelper2.QuartzScheduler;
using System.Web;

namespace Warehousing.Business.task
{
    public class WorkSyn : QuartzJob
    {
        public SqlHelper helper = LocalSqlHelper.WH;
        public WorkSyn()
		{
			//CronExpression = "0 0/1 * * * ?";
			//每天0点到2点59,每隔20分钟执行一次
			//CronExpression = "0 0/20 0-2 * * ?";
            CronExpression = "0 0/1 * * * ?";
			RepeatInterval = new TimeSpan(0, 0, 0);
			RepeatCount = 0;
			DoWork += new EventHandler(this_DoWork);
		}
		public void this_DoWork(object sender, EventArgs e)
		{
			try
			{

                //UpdateLocalPrintEffectNum();
                //SendUserMoneyChange();
                //ConfirmRukuInWeb();
                //SendOrderPrintInfo();
                //SendBeLocalFlag();
                //SendChukuToWeb();
                //UpdateOrderCancel();//确认取消商品
                //SendSupplierTransaction();//供应商交易记录送网上
                //SendWarehousingPrintInfo();//出入库打印信息
                //SendDirectExpressInfo();//直营回传物流信息
                if (System.Configuration.ConfigurationManager.AppSettings["stopflag"] == "1")
                {
                    SinoHelper2.EventLog.WriteLog("维护期间不做同步!");
                    return;
                }
                else
                {

                    StorageHelper.autoUpdateDoNums();
                    SinoHelper2.EventLog.WriteLog("执行正常3   -----更新冻结库存");


                }
                //测试同步
                //string sql = "update test set Today=getdate()";
                //helper.Execute(sql);
			}
			catch(Exception ero)
			{
				SinoHelper2.EventLog.WriteLog(GetType() + "执行出错:" + ero.Message);
			}
		}



    }
}
