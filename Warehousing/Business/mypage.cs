using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Warehousing.Model;
using Warehousing.Business;

namespace Warehousing
{
    public class mypage : System.Web.UI.Page
    {
        protected StorageInfo myStorageInfo;
        protected int my_warehouse_id;
        protected int my_admin_id;
        protected string my_admin_name;
        protected int print_page_width=50;
        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            SiteHelper.CheckLogin();
            if (Request.Cookies["userInfo"]["ManageUserId"] != "1" && System.Configuration.ConfigurationManager.AppSettings["stopflag"]=="1")
            {
               Response.Write("ERP系统维护中,请稍后再来使用~~");
               Response.End();
            }
            my_admin_id = Convert.ToInt32(Request.Cookies["userInfo"]["ManageUserId"]);
            my_admin_name = Convert.ToString(Request.Cookies["userInfo"]["LoginName"]);
            my_warehouse_id = Convert.ToInt32(Request.Cookies["userInfo"]["warehouse_id"]);
            myStorageInfo = StorageHelper.getStorageInfo(my_warehouse_id);
            switch (my_warehouse_id)
            {
                case 4:
                    print_page_width = 150;
                    break;
                default:
                    print_page_width = 50;
                    break;
            }
            print_page_width = 100;
            if (myStorageInfo.agent_id==0)
            {
               // print_page_width = 150;
            }
        }



    }
}