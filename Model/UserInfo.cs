using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Warehousing.Model
{
    public class UserInfo
    {
        public int User_id { get; set; }
        public string User_name { get; set; }
        public string True_name { get; set; }
        public string User_Mobile { get; set; }
        public string User_Pwd { get; set; }
        public int User_level { get; set; }
        public double Account_money { get; set; }
        public double Account_score { get; set; }
        public int cashier_id_from { get; set; }
        public int store_id_from { get; set; }
        public int is_hide { get; set; }
    }
}
