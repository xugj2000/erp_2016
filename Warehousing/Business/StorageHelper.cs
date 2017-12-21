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
using  Warehousing.Model;
using System.Text.RegularExpressions;

namespace Warehousing.Business
{

    public enum StorageStatus
    {
        待审 = 0,
        通过 = 1,
        作废 = 2,
        入方待审 = 3,
        入方拒绝 = 4
    }

    public enum StorageType
    {
        未知 = 0,
        采购入库 = 1,
        修补返库 = 2,
        调货入库 = 3,
        生产入库 = 9,
        退货入库 = 8,
        其它入库 = 4,

        退货返厂 = 5,
        维修返厂 = 7,
        其它出库 = 6,
        生产出库 = 11,
        调货出库 = 10,
        批发出库 = 12,
        加盟供货 = 13,
        零售出库 = 14,
    }

    public enum PurchasePlanType
    {
        未知 = 0,
        普通采购 = 1,
        补货采购 = 2
    }

    public class StorageHelper
    {
        /// <summary>
        /// 根据出入库类型数值获得类型名称
        /// </summary>
        /// <param name="Status"></param>
        /// <returns></returns>
        public static string getStutusText(int Status)
        {
            StorageStatus col = (StorageStatus)Status;
            return col.ToString();
        }

        public static string getTypeText(int Status)
        {
            StorageType col = (StorageType)Status;
            return col.ToString();
        }

        public static string getPlanTypeText(int Status)
        {
            PurchasePlanType col = (PurchasePlanType)Status;
            return col.ToString();
        }
         

        //订出入库单的中的商品与商品表中的比较，若商品表不存在则加入，若存在则更新库存

        public static void checkStorageOk(int sm_id)
        {
            checkStorageOk(sm_id, true);
        }

        public static void checkStorageOk(int sm_id,bool need_check_stock)
        {
            string checksql = string.Empty;
            SqlHelper conn = LocalSqlHelper.WH;
            DataTable dt_main = conn.ExecDataTable("select * from Tb_storage_main with(nolock) where sm_id=" + sm_id.ToString());
            if (dt_main.Rows.Count == 0)
            {
                return;
            }
            string sql = "update a set a.pro_id=b.pro_id from Tb_storage_product a,Product b where a.p_txm=b.pro_txm and a.pro_id=0";
            conn.Execute(sql);

            int warehouse_id_base = Convert.ToInt32(dt_main.Rows[0]["warehouse_id"]);
            int sm_type = Convert.ToInt32(dt_main.Rows[0]["sm_type"]);
            string sm_direction = Convert.ToString(dt_main.Rows[0]["sm_direction"]);
            //检查入库商品是否有不在商品库中
            string checkTxmsql = "select a.p_txm  from Tb_storage_product a with(nolock) where a.sm_id=" + sm_id.ToString() + " and  not exists(select top 1 1 from Product where pro_txm=a.p_txm)";
            DataTable txtDT = conn.ExecDataTable(checkTxmsql);
            string existTxm = string.Empty;
            if (txtDT.Rows.Count > 0)
            {
                for (int i = 0; i < txtDT.Rows.Count; i++)
                {
                    existTxm += existTxm.IsNullOrEmpty() ? Convert.ToString(txtDT.Rows[i]["p_txm"]) : "," + Convert.ToString(txtDT.Rows[i]["p_txm"]);
                }
                JSHelper.WriteScript("alert('" + existTxm + "条码对应商品不存在商品库');history.back();");
                HttpContext.Current.Response.End();
            }


            //出库时对原库库存进行判断
            if (sm_direction == "出库" && need_check_stock==true)
            {
                string info = string.Empty;
                bool IsEnough = checkStockIsEnough(sm_id, warehouse_id_base, out info);
                if (!IsEnough)
                {
                    JSHelper.WriteScript("alert('" + info + "条码对应商品库存不足！');history.back();");
                    HttpContext.Current.Response.End();
                }
            }

            DataTable dt = conn.ExecDataTable("select * from Tb_storage_product with(nolock) where sm_id=" + sm_id.ToString());
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                conn.Params.Clear();
                double p_quantity = Convert.ToDouble(dt.Rows[i]["p_quantity"]);
                if (p_quantity == 0)
                {
                    continue;
                }
                conn.Params.Add("pro_txm", dt.Rows[i]["p_txm"].ToString());
                DataTable dt2 = conn.ExecDataTable("select pro_id from Product with(nolock) where pro_txm=@pro_txm");
                // HttpContext.Current.Response.Write(dt2.Rows.Count);
                // HttpContext.Current.Response.End();
                if (dt2.Rows.Count > 0)
                {
                    int pro_id = Convert.ToInt32(dt2.Rows[0]["pro_id"]);
                    conn.Params.Clear();
                    if (sm_direction == "入库")
                    {
                        //入库
                        changeStock(warehouse_id_base, pro_id, p_quantity, dt_main.Rows[0]["sm_sn"].ToString(), "商品入库");
                    }
                    else
                    {
                        //出库
                        changeStock(warehouse_id_base, pro_id, 0 - p_quantity,dt_main.Rows[0]["sm_sn"].ToString(), "商品出库");
                    }
                }

            }

        }


        /// <summary>
        /// 判断某批次出库商品是否足够库存
        /// </summary>
        /// <param name="sm_id"></param>
        /// <param name="warehouse_id"></param>
        /// <param name="info"></param>
        /// <returns></returns>
        public static bool checkStockIsEnough(int sm_id, int warehouse_id,out string info)
        {
            bool IsEnough = true;
            info = "";
            SqlHelper conn = LocalSqlHelper.WH;

            string checkTxmsql = "select a.p_txm  from Tb_storage_product a with(nolock) left join ProductStock b with(nolock) on a.pro_id=b.pro_id where a.sm_id=" + sm_id.ToString() + " and b.warehouse_id=" + warehouse_id + " and b.kc_nums<a.p_quantity";
            DataTable txtDT = conn.ExecDataTable(checkTxmsql);
            string existTxm = string.Empty;
            if (txtDT.Rows.Count > 0)
            {
                IsEnough = false;
                for (int i = 0; i < txtDT.Rows.Count; i++)
                {
                    existTxm += existTxm.IsNullOrEmpty() ? Convert.ToString(txtDT.Rows[i]["p_txm"]) : "," + Convert.ToString(txtDT.Rows[i]["p_txm"]);
                }
                info=existTxm + "条码对应商品库存不足！";
            }
            return IsEnough;
        }

        /// <summary>
        /// 判断某个商品库存是否充值
        /// </summary>
        /// <param name="pro_id"></param>
        /// <param name="warehouse_id"></param>
        /// <param name="p_quantity"></param>
        /// <returns></returns>
        public static bool checkOneStockIsEnough(int pro_id, int warehouse_id, int p_quantity)
        {
            bool IsEnough = true;
            SqlHelper conn = LocalSqlHelper.WH;
            conn.Params.Add("warehouse_id", warehouse_id);
            conn.Params.Add("pro_id", pro_id);
            string checkTxmsql = "select kc_nums  ProductStock  with(nolock)  where warehouse_id=@warehouse_id and pro_id=@pro_id";
            DataTable txtDT = conn.ExecDataTable(checkTxmsql);
            if (txtDT.Rows.Count > 0)
            {
                double kc_nums = Convert.ToDouble(txtDT.Rows[0]["kc_nums"]);
                if (kc_nums < p_quantity)
                {
                    IsEnough = false;
                }
            }
            else
            {
                IsEnough = false;
            }
            return IsEnough;
        }

        public static bool checkOneStockIsEnough(string p_txm, int warehouse_id, int p_quantity)
        {
            bool IsEnough = true;
            int pro_id = getIdByTxm(p_txm);
            if (pro_id == 0)
            {
                return false;
            }
            SqlHelper conn = LocalSqlHelper.WH;
            string checkTxmsql = "select kc_nums from ProductStock  with(nolock)  where warehouse_id=" + warehouse_id + " and pro_id=" + pro_id;
            //HttpContext.Current.Response.Write(checkTxmsql);
            DataTable txtDT = conn.ExecDataTable(checkTxmsql);
            if (txtDT.Rows.Count > 0)
            {
                double kc_nums = Convert.ToDouble(txtDT.Rows[0]["kc_nums"]);

                if (kc_nums < p_quantity)
                {
                    IsEnough = false;
                }
            }
            else
            {
                IsEnough = false;
            }
            return IsEnough;
        }


        public static bool checkTxm(string txm)
        {
            return Regex.IsMatch(txm, @"^[A-Z\d\-\s]*$");
        }

       /// <summary>
       /// 判断出入库批次下是否还有不存在条码
       /// </summary>
       /// <param name="sm_id"></param>
       /// <returns></returns>
        public static bool checkTxmIsBlank(int sm_id)
        {
            SqlHelper conn = LocalSqlHelper.WH;
            string checksql = "select top 1 1 from Tb_storage_product where sm_id=@sm_id and p_txm=''";
            conn.Params.Add("sm_id", sm_id);
            DataTable dt = conn.ExecDataTable(checksql);
            if (dt.Rows.Count > 0)
            {
                return true;
            }
            return false;
        }

        /// <summary>
        /// 获入出入库流水号
        /// </summary>
        /// <param name="NickChar"></param>
        /// <returns></returns>
        public static string getNewChurukuHao(string NickChar)
        {
            string LiuShuiHao = string.Empty;
            SqlHelper conn = LocalSqlHelper.WH;
            string sql = "select top 1 churukuhao from liushuihao with(nolock)";
            int intHao = Convert.ToInt32(conn.ExecScalar(sql))+1;
            conn.Params.Clear();
            conn.Execute("update liushuihao set churukuhao=churukuhao+1 where id=1");
            LiuShuiHao = NickChar + intHao.ToString().PadLeft(8, '0');
            return LiuShuiHao;
        }

        public static string getNewCaigouHao(string NickChar)
        {
            string LiuShuiHao = string.Empty;
            SqlHelper conn = LocalSqlHelper.WH;
            string sql = "select top 1 caigouhao from liushuihao with(nolock)";
            int intHao = Convert.ToInt32(conn.ExecScalar(sql)) + 1;
            conn.Params.Clear();
            conn.Execute("update liushuihao set caigouhao=caigouhao+1 where id=1");
            LiuShuiHao = NickChar + intHao.ToString().PadLeft(8, '0');
            return LiuShuiHao;
        }

        public static string getCheckStockHao(string NickChar)
        {
            string LiuShuiHao = string.Empty;
            SqlHelper conn = LocalSqlHelper.WH;
            string sql = "select top 1 pandianhao from liushuihao with(nolock)";
            int intHao = Convert.ToInt32(conn.ExecScalar(sql)) + 1;
            conn.Params.Clear();
            conn.Execute("update liushuihao set pandianhao=pandianhao+1 where id=1");
            LiuShuiHao = NickChar + intHao.ToString().PadLeft(8, '0');
            return LiuShuiHao;
        }

        //public static void changeStock(int warehouse_id, int pro_id, int p_quantity)
        //{
        //    string dowhy = "";
        //    changeStock(warehouse_id,pro_id,p_quantity,dowhy);
        //}

        /// <summary>
        /// 根据商品ID改变库存
        /// </summary>
        /// <param name="warehouse_id"></param>
        /// <param name="pro_id"></param>
        /// <param name="p_quantity"></param>
        public static void changeStock(int warehouse_id, int pro_id, double p_quantity, string order_sn, string dowhy)
        {
            SqlHelper conn = LocalSqlHelper.WH;
            
            conn.Params.Add("pro_id", pro_id);
            conn.Params.Add("warehouse_id", warehouse_id);
            DataTable dt = conn.ExecDataTable("select stock_id,kc_nums from ProductStock with(nolock) where warehouse_id=@warehouse_id and pro_id=@pro_id");
            conn.Params.Clear();
            int kc_nums = 0;
            string dosql = string.Empty;
            if (dt.Rows.Count>0)
            {
                kc_nums = Convert.ToInt32(dt.Rows[0]["kc_nums"]);
                conn.Params.Add("quantity", p_quantity);
                conn.Params.Add("stock_id", dt.Rows[0]["stock_id"]);
                if (p_quantity > 0)
                {
                    //入库
                    dosql = "update ProductStock set in_nums=in_nums+@quantity,kc_nums=kc_nums+@quantity,kc_flag=1 where stock_id=@stock_id";
                }
                else
                {
                    //出库
                    dosql = "update ProductStock set out_nums=out_nums-@quantity,kc_nums=kc_nums+@quantity,kc_flag=1 where stock_id=@stock_id";
                }
            }
            else
            {
                //新建仓库库存记录
                conn.Params.Add("pro_id", pro_id);
                conn.Params.Add("warehouse_id", warehouse_id);
                conn.Params.Add("quantity", p_quantity);
                dosql = "insert into ProductStock(warehouse_id,pro_id,kc_nums,kc_flag) values(@warehouse_id,@pro_id,@quantity,1)";
            }
            conn.Execute(dosql);

            conn.Params.Clear();
            conn.Params.Add("pro_id", pro_id);
            conn.Params.Add("warehouse_id", warehouse_id);

            try
            {
                conn.Params.Add("do_ip", SinoHelper2.RequestHelper.GetIP());
            }
            catch
            {
                conn.Params.Add("do_ip","syn");
            }
            conn.Params.Add("quantity", p_quantity);
            conn.Params.Add("old_num", kc_nums);
            conn.Params.Add("new_num", kc_nums + p_quantity);
            conn.Params.Add("do_why", dowhy);
            conn.Params.Add("order_sn", order_sn);
            conn.Insert("Tb_ChangeStockRecord");
        }


        /// <summary>
        /// 根据条码改变库存
        /// </summary>
        /// <param name="warehouse_id"></param>
        /// <param name="txm"></param>
        /// <param name="p_quantity"></param>
        public static void changeStock(int warehouse_id, string txm, double p_quantity, string order_sn, string dowhy)
        {
            int pro_id = getIdByTxm(txm);
            changeStock(warehouse_id, pro_id, p_quantity,order_sn, dowhy);
        }

        public static int getIdByTxm(string txm)
        {
            SqlHelper helper = LocalSqlHelper.WH;
            helper.Params.Add("pro_txm", txm);
            return Convert.ToInt32(helper.ExecScalar("select pro_id from Product with(nolock) where pro_txm=@pro_txm"));
        }

        public static int getSupplierIdByTxm(string txm)
        {
            SqlHelper helper = LocalSqlHelper.WH;
            helper.Params.Add("pro_txm", txm);
            return Convert.ToInt32(helper.ExecScalar("select pro_supplierid from Prolist with(nolock) where pro_txm=@pro_txm"));
        }
        
        public static string getSupplierName(int SupplierId)
        {
            SqlHelper conn = LocalSqlHelper.WH;
            return Convert.ToString(conn.ExecScalar("select supplier_name from supplier with(nolock) where id=" + SupplierId.ToString()));
        }

        public static string getWarehouseName(int WarehouseId)
        {
            SqlHelper conn = LocalSqlHelper.WH;
            string WarehouseName=Convert.ToString(conn.ExecScalar("select warehouse_name from WareHouse_List with(nolock) where warehouse_id=" + WarehouseId.ToString()));
            WarehouseName = WarehouseName.IsNullOrEmpty() ? "全仓" : WarehouseName;
            return WarehouseName;
        }

        public static string getAdminName(int AdminId)
        {
            SqlHelper conn = LocalSqlHelper.WH;
            return Convert.ToString(conn.ExecScalar("select LoginName from wareHouse_Admin with(nolock) where id=" + AdminId));
        }

        /// <summary>
        /// 根据产品ID获知商家名称
        /// </summary>
        /// <param name="ProId"></param>
        /// <returns></returns>
        public static string getSupplierNameByPro(int ProId)
        {
            SqlHelper conn = LocalSqlHelper.WH;
            string SupplierName = string.Empty;
            int supplierid= Convert.ToInt32(conn.ExecScalar("select pro_supplierid from View_Product  where pro_id="+ProId));
            if (supplierid > 0)
            {
                SupplierName = getSupplierName(supplierid);
            }

            return SupplierName;
        }

        public static string getSupplierNameByPro(string TXM)
        {
            SqlHelper conn = LocalSqlHelper.WH;
            string SupplierName = string.Empty;
            int supplierid = Convert.ToInt32(conn.ExecScalar("select pro_supplierid from View_Product  where pro_txm='" + TXM+"'"));
            if (supplierid > 0)
            {
                SupplierName = getSupplierName(supplierid);
            }

            return SupplierName;
        }

        public static void BindSupplierList(DropDownList DownList, int supplierid)
        {
            string sql = "SELECT id,supplier_name FROM supplier order by id";
            SqlHelper helper = LocalSqlHelper.WH;
            DataTable dt = helper.ExecDataTable(sql);
            BindingHelper.BindDDL(DownList, dt, "supplier_name", "ID", false);
            DownList.SelectedValue = supplierid.ToString();
        }

        public static void BindProTypeList(DropDownList DownList, int typeid)
        {
            string sql = "SELECT type_id,type_name FROM ProductType order by sort_order,type_id";
            SqlHelper helper = LocalSqlHelper.WH;
            DataTable dt = helper.ExecDataTable(sql);
            BindingHelper.BindDDL(DownList, dt, "type_name", "type_id", false);
            DownList.SelectedValue = typeid.ToString();
        }

        public static void BindBrandList(DropDownList DownList, string BrandName)
        {
            string sql = "SELECT brand_name FROM Tb_brand order by brand_name desc";
            SqlHelper helper = LocalSqlHelper.WH;
            DataTable dt = helper.ExecDataTable(sql);
            BindingHelper.BindDDL(DownList, dt, "brand_name", "brand_name", false);
            DownList.SelectedValue = BrandName;
        }

        public static void BindAgentList(DropDownList DownList, int Agent_id)
        {
            string sql = "SELECT Agent_id,Agent_name FROM Tb_Agent order by Agent_id desc";
            SqlHelper helper = LocalSqlHelper.WH;
            DataTable dt = helper.ExecDataTable(sql);
            BindingHelper.BindDDL(DownList, dt, "Agent_name", "Agent_id", false);
            DownList.SelectedValue = Agent_id.ToString();
        }

        public static string getAgentName(int Agent_id)
        {
            string AgentName = string.Empty;
            string sql = "SELECT Agent_name FROM Tb_Agent where Agent_id=" + Agent_id;
            SqlHelper helper = LocalSqlHelper.WH;
            DataTable dt = helper.ExecDataTable(sql);
            if (dt.Rows.Count > 0)
            {
                AgentName = Convert.ToString(dt.Rows[0]["Agent_name"]);
            }
            return AgentName;
        }

        public static void BindGuideList(DropDownList DownList, int Guide_id, int store_id)
        {
            string sql = "SELECT Guide_id,Guide_name FROM Tb_guide_staff order by guide_name";
            if (store_id>0)
            {
                sql = "SELECT Guide_id,Guide_name FROM Tb_guide_staff where store_id="+store_id+" order by guide_name";
            }
           // HttpContext.Current.Response.Write(sql);
            SqlHelper helper = LocalSqlHelper.WH;
            DataTable dt = helper.ExecDataTable(sql);
            BindingHelper.BindDDL(DownList, dt, "Guide_name", "Guide_id", false);
            DownList.SelectedValue = Guide_id.ToString();
        }

        public static void BindCashierList(DropDownList DownList, int Cashier_id, int warehouse_id)
        {
            string sql = "SELECT id,fullname FROM wareHouse_Admin where warehouse_id="+warehouse_id+" order by fullname";
            // HttpContext.Current.Response.Write(sql);
            SqlHelper helper = LocalSqlHelper.WH;
            DataTable dt = helper.ExecDataTable(sql);
            BindingHelper.BindDDL(DownList, dt, "fullname", "id", false);
            DownList.SelectedValue = Cashier_id.ToString();
        }

        public static string getTypeName(int type_id)
        {
            string sql = "SELECT type_name FROM ProductType where type_id=@type_id";
            SqlHelper helper = LocalSqlHelper.WH;
            helper.Params.Add("type_id", type_id);
            return Convert.ToString(helper.ExecScalar(sql));
        }

        public static DataTable GetProStyleList(int pm_id)
        {
            string sql = "SELECT * FROM Product with(nolock) where pm_id=@pm_id order by pro_id";
            SqlHelper helper = LocalSqlHelper.WH;
            helper.Params.Add("pm_id", pm_id);
            DataTable dt = helper.ExecDataTable(sql);
            return dt;
        }

        public static void BindWarehouseList(DropDownList DropDownList, int warehouse_id)
        {
            BindWarehouseList(DropDownList, warehouse_id, "", "");
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="DropDownList">下拉表单</param>
        /// <param name="warehouse_id">当前仓库</param>
        /// <param name="includeId">包含的仓库</param>
        /// <param name="ExcludeId">排除的仓库</param>
        public static void BindWarehouseList(DropDownList DropDownList, int warehouse_id,string includeId,string ExcludeId)
        {
            string where = "1=1";
            if (includeId.IsNotNullAndEmpty() && includeId!="0")
            {
                where += " and warehouse_id in ('" + includeId + "')";
            }
            if (ExcludeId.IsNotNullAndEmpty() && ExcludeId != "0")
            {
                where += " and warehouse_id not in ('" + ExcludeId + "')";
            }
            DataTable dt = GetWarehouseList(where);
            BindingHelper.BindDDL(DropDownList, dt, "warehouse_name", "warehouse_id", false);
            DropDownList.SelectedValue = warehouse_id.ToString();
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="DropDownList"></param>
        /// <param name="warehouse_id"></param>
        /// <param name="where"></param>
        public static void BindWarehouseList(DropDownList DropDownList, int warehouse_id, string where)
        {
            DataTable dt = GetWarehouseList(where);
            BindingHelper.BindDDL(DropDownList, dt, "warehouse_name", "warehouse_id", false);
            DropDownList.SelectedValue = warehouse_id.ToString();
        }

        public static DataTable GetWarehouseList(string where)
        {
            string sql = "SELECT warehouse_id,warehouse_name FROM WareHouse_List with(nolock) where IsLock=0";
            sql += where.IsNullOrEmpty() ? "" : " and " + where;
            sql += " order by warehouse_id";
            SqlHelper helper = LocalSqlHelper.WH;
            DataTable dt = helper.ExecDataTable(sql);
            return dt;
        }

        public static void BindClassList(DropDownList DropDownList, int type_id)
        {
            string sql = "SELECT type_id,type_name FROM ProductType with(nolock) order by sort_order";
            SqlHelper helper = LocalSqlHelper.WH;
            DataTable dt = helper.ExecDataTable(sql);
            BindingHelper.BindDDL(DropDownList, dt, "type_name", "type_id", false);
            DropDownList.SelectedValue = type_id.ToString();
        }

        /// <summary>
        /// 采购仓列表
        /// </summary>
        /// <param name="DropDownList">下拉表单</param>
        /// <param name="warehouse_id">当前仓库</param>
        /// <param name="includeId">包含的仓库</param>
        /// <param name="ExcludeId">排除的仓库</param>
        public static void BindCaiguoWarehouse(DropDownList DropDownList, int warehouse_id, string includeId, string ExcludeId)
        {
            string sql = "SELECT warehouse_id,warehouse_name FROM WareHouse_List with(nolock) where IsLock=0 and is_caigou=1";
            if (includeId.IsNotNullAndEmpty() && includeId != "0")
            {
                sql += " and warehouse_id in ('" + includeId + "')";
            }
            if (ExcludeId.IsNotNullAndEmpty() && ExcludeId != "0")
            {
                sql += " and warehouse_id not in ('" + ExcludeId + "')";
            }
            sql += "order by warehouse_id";
            // HttpContext.Current.Response.Write(sql);
            SqlHelper helper = LocalSqlHelper.WH;
            DataTable dt = helper.ExecDataTable(sql);
            BindingHelper.BindDDL(DropDownList, dt, "warehouse_name", "warehouse_id", false);
            DropDownList.SelectedValue = warehouse_id.ToString();
        }

        public static int getStoreIdByWarehouseId(int warehouse_id)
        {
            SqlHelper helper = LocalSqlHelper.WH;
            helper.Params.Add("warehouse_id", warehouse_id);
            return Convert.ToInt32(helper.ExecScalar("select StoreId from WareHouse_List with(nolock) where warehouse_id=@warehouse_id"));
        }

        /// <summary>
        /// 根据ID获知仓库信息
        /// </summary>
        /// <param name="warehouse_id"></param>
        /// <returns></returns>
        public static StorageInfo getStorageInfo(int warehouse_id)
        {
            StorageInfo myStorageInfo = new StorageInfo();
            SqlHelper helper = LocalSqlHelper.WH;
            helper.Params.Add("warehouse_id", warehouse_id);
            //HttpContext.Current.Response.Write("select * from WareHouse_List with(nolock) where warehouse_id=" + warehouse_id);
            DataTable dt = helper.ExecDataTable("select * from WareHouse_List with(nolock) where warehouse_id=@warehouse_id");
            if (dt.Rows.Count > 0)
            {
               // warehouse_name,agent_id,is_caigou,is_manage
                myStorageInfo.warehouse_id = warehouse_id;
                myStorageInfo.warehouse_name = Convert.ToString(dt.Rows[0]["warehouse_name"]);
                myStorageInfo.warehouse_tel = Convert.ToString(dt.Rows[0]["warehouse_tel"]);
                myStorageInfo.warehouse_address = Convert.ToString(dt.Rows[0]["warehouse_address"]);
                myStorageInfo.agent_id = Convert.ToInt32(dt.Rows[0]["agent_id"]);
                myStorageInfo.is_caigou = Convert.ToInt32(dt.Rows[0]["is_caigou"]);
                myStorageInfo.is_manage = Convert.ToInt32(dt.Rows[0]["is_manage"]);
            }
            return myStorageInfo;
        }

        public static string getOrderStatusText(int Status)
        {
            string StatusText = "未知";
            switch (Status)
            {
                case -1:
                    StatusText = "订单已取消";
                    break;
                case 8:
                    StatusText = "订单完成";
                    break;
                case 9:
                    StatusText = "生成取消";
                    break;
                case 10:
                    StatusText = "取消新生成";
                    break;
                case 11:
                    StatusText = "退货新生成";
                    break;

            }
            return StatusText;
        }

        public static int getWarehouseIdByStoreId(int store_id)
        {
            SqlHelper helper = LocalSqlHelper.WH;
            helper.Params.Add("store_id", store_id);
            return Convert.ToInt32(helper.ExecScalar("select warehouse_id from WareHouse_List with(nolock) where StoreId=@store_id"));
        }

        public static string getShelfNo(int pro_id, int warehouse_id)
        {

            SqlHelper helper = LocalSqlHelper.WH;
            helper.Params.Add("pro_id", pro_id);
            helper.Params.Add("warehouse_id", warehouse_id);
            return Convert.ToString(helper.ExecScalar("select shelf_no from ProductStock with(nolock) where warehouse_id=@warehouse_id and pro_id=@pro_id"));
        }

        public static int getStockId(int pro_id, int warehouse_id)
        {
            SqlHelper helper = LocalSqlHelper.WH;
            helper.Params.Add("pro_id", pro_id);
            helper.Params.Add("warehouse_id", warehouse_id);
            return Convert.ToInt32(helper.ExecScalar("select stock_id from ProductStock with(nolock) where warehouse_id=@warehouse_id and pro_id=@pro_id"));
        }

        public static int getStockNum(int pro_id, int warehouse_id)
        {
            string sql = "select kc_nums  from ProductStock with(nolock) where warehouse_id=@warehouse_id and pro_id=@pro_id";
            SqlHelper helper_mssql = LocalSqlHelper.WH;
            helper_mssql.Params.Add("warehouse_id", warehouse_id);
            helper_mssql.Params.Add("pro_id", pro_id);
            return Convert.ToInt32(helper_mssql.ExecScalar(sql));
        }

        public static double dispInPrice(object InPrice)
        {
            if (SiteHelper.getReadRightByText("采购价格"))
            {
                return Convert.ToDouble(InPrice);
            }
            else
            {
                return 0;
            }
        }

        /// <summary>
        /// 自动更新冻结库存
        /// </summary>
        public static void autoUpdateDoNums()
        {
            SqlHelper helper = LocalSqlHelper.WH;
            helper.Execute("exec Sp_getDoNums");
        }

        public static double getAlreadyPayMoney(int sm_id)
        {

            return getAlreadyPayMoney(sm_id, "Storage");
        }
        public static double getAlreadyPayMoney(int sm_id, string object_type)
        {
            string sql = "select isnull(sum(pay_money),0)  from Tb_FinancialFlow with(nolock) where object_type=@object_type and sm_id=@sm_id and is_cancel=0";
            SqlHelper helper_mssql = LocalSqlHelper.WH;
            helper_mssql.Params.Add("object_type", object_type);
            helper_mssql.Params.Add("sm_id", sm_id);
            return Convert.ToDouble(helper_mssql.ExecScalar(sql));

        }

    }
}