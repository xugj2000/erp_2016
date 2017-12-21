using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Warehousing.Model
{
    public class StorageInfo
    {
        public int warehouse_id { get; set; }
        public string warehouse_name { get; set; }
        public int agent_id { get; set; }
        public string warehouse_tel { get; set; }
        public string warehouse_address { get; set; }
        public int is_manage { get; set; }
        public int is_caigou { get; set; }
    }
}
