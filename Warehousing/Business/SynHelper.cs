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

namespace Warehousing.Business
{
    public class SynHelper
    {
      public static void GetOrderInfo()
        {
            int payment_id = 0;
            int warehouse_id = 0;
            int seller_id = 0;
            SqlHelper helper_mssql = LocalSqlHelper.WH;
            string StoreIdSql = "select StoreId from WareHouse_List with(nolock) where StoreId>0";
            DataTable StoreIdDt = helper_mssql.ExecDataTable(StoreIdSql);
            string StoreIdStr = "-1";
            for (int i = 0; i < StoreIdDt.Rows.Count; i++)
            {
                StoreIdStr += ","+StoreIdDt.Rows[i]["StoreId"].ToString();
            }

            SinoHelper2.MySqlHelper helper_mysql = PublicHelper.connMysql();
            //判断该会员是否已经发放过
            string checksql = "select a.*,ifnull(b.consignee,'') as consignee,ifnull(b.region_id,0) as region_id,ifnull(b.region_name,'') as region_name,ifnull(b.address,'') as address,ifnull(b.zipcode,'') as zipcode,ifnull(b.phone_tel,'') as phone_tel,ifnull(b.phone_mob,'') as phone_mob,ifnull(b.shipping_id,0) as shipping_id,ifnull(b.shipping_name,'') as shipping_name,ifnull(b.shipping_fee,0) as shipping_fee from ecm_order a left join ecm_order_extm b on a.order_id=b.order_id  where a.seller_id in (" + StoreIdStr + ") and a.status in (20,30,40) and a.buyer_id<>4  and  a.sys_flag=0 order by a.order_id";
            DataTable dt = helper_mysql.ExecDataTable(checksql);
            
            
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                helper_mssql.Params.Clear();
                helper_mssql.Params.Add("shopxpacid", Convert.ToInt32(dt.Rows[i]["order_id"]));
                helper_mssql.Params.Add("userid", Convert.ToInt32(dt.Rows[i]["buyer_id"]));
                helper_mssql.Params.Add("user_name", Convert.ToString(dt.Rows[i]["buyer_name"]));
                seller_id = Convert.ToInt32(dt.Rows[i]["seller_id"]);
                helper_mssql.Params.Add("store_id", seller_id);
                warehouse_id = getWarehouseIdByStoreId(seller_id);
               
                //若网上订单，则发货仓待定
                if (warehouse_id == 4)
                {
                    warehouse_id = 0;
                }
                
                helper_mssql.Params.Add("supplierid", warehouse_id);
                helper_mssql.Params.Add("seller_name", dt.Rows[i]["seller_name"]);
                helper_mssql.Params.Add("dingdan", dt.Rows[i]["order_sn"]);
                helper_mssql.Params.Add("dingdan_type", 0);
                helper_mssql.Params.Add("user_type", 0);
                helper_mssql.Params.Add("freight", Convert.ToDouble(dt.Rows[i]["shipping_fee"]));
                //helper_mssql.Params.Add("usertel", dt.Rows[i]["buyer_name"]);
                
                helper_mssql.Params.Add("fapiao_title", dt.Rows[i]["buyer_name"]);
                helper_mssql.Params.Add("shouhuoname", dt.Rows[i]["consignee"]);

                string region_name = Convert.ToString(dt.Rows[i]["region_name"]);
                string[] regions = region_name.Split('	');
                try
                {
                    helper_mssql.Params.Add("province", regions[0]);
                    helper_mssql.Params.Add("city", regions[1]);
                    helper_mssql.Params.Add("xian", regions[2]);
                }
                catch
                {

                }
                string phone_tel = Convert.ToString(dt.Rows[i]["phone_tel"]);
                if (phone_tel.IsNullOrEmpty())
                {
                    phone_tel = dt.Rows[i]["phone_mob"].ToString(); 
                }
                else
                {
                    phone_tel += "/" + dt.Rows[i]["phone_mob"].ToString();
                }
                helper_mssql.Params.Add("usertel", phone_tel);
                helper_mssql.Params.Add("shdz", dt.Rows[i]["address"]);
                helper_mssql.Params.Add("liuyan", dt.Rows[i]["postscript"]);
                helper_mssql.Params.Add("shopxp_shfs", 0);
                int pay_time = Convert.ToInt32(dt.Rows[i]["pay_time"]) + 28800;
                helper_mssql.Params.Add("fksj", PublicHelper.UnixTimeToTime(pay_time.ToString()));
               payment_id=Convert.ToInt32(dt.Rows[i]["payment_id"]);
               helper_mssql.Params.Add("zhifufangshi", payment_id);
               int OrderStatus = 6;
               if (payment_id == 99)
               {
                   OrderStatus = 8;//实体店订单直接打单成功
                   helper_mssql.Params.Add("fhsj", PublicHelper.UnixTimeToTime(pay_time.ToString()));
               }
               helper_mssql.Params.Add("zhuangtai", OrderStatus);
               helper_mssql.Params.Add("ShippingCompany", "noname");

                helper_mssql.Insert("Direct_OrderMain");

                string updatesql = "update ecm_order set sys_flag=1 where order_id=" + dt.Rows[i]["order_id"].ToString();
                helper_mysql.Execute(updatesql);
            }

            checksql = "select a.*,b.order_sn,b.buyer_id,seller_id,b.payment_id from ecm_order_goods a left join ecm_order b on a.order_id=b.order_id where b.seller_id in (" + StoreIdStr + ") and b.status in (20,30,40) and a.sys_flag=0  order by a.rec_id";
            dt = helper_mysql.ExecDataTable(checksql);
          int p_quantity=0;
          string p_txm=string.Empty;
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                warehouse_id = 0;
                int return_order_id = Convert.ToInt32(dt.Rows[i]["return_order_id"]);
                int StoreId = Convert.ToInt32(dt.Rows[i]["seller_id"]);
                int needChangeStock = 1;
                if (return_order_id > 0)
                {
                    helper_mssql.Params.Clear();
                    //判断取消订单本地是否已有原单存在
                    DataTable checkReturnDt = helper_mssql.ExecDataTable("select top 1 shopxpacid,dingdan,supplierid from Direct_OrderMain where shopxpacid=" + return_order_id);
                    if (checkReturnDt.Rows.Count == 0)
                    {
                        needChangeStock = 0; //原单若不存在，不进行取消操作
                    }
                    else
                    {
                        //退单的本单直接对应原单
                        helper_mssql.Params.Clear();
                        warehouse_id = Convert.ToInt32(checkReturnDt.Rows[0]["supplierid"]);
                        helper_mssql.Params.Add("warehouse_id", warehouse_id);
                        helper_mssql.Params.Add("dingdan", Convert.ToString(dt.Rows[i]["order_sn"]));
                        string updateSql = "update Direct_OrderMain set supplierid=@warehouse_id where dingdan=@dingdan and supplierid=0"; ;
                        helper_mssql.Execute(updateSql);
                    }

                }

                if (needChangeStock == 1)
                {
                    helper_mssql.Params.Clear();
                    p_quantity= Convert.ToInt32(dt.Rows[i]["quantity"]);
                    p_txm=Convert.ToString(dt.Rows[i]["goods_txm"]);
                    helper_mssql.Params.Add("id", Convert.ToInt32(dt.Rows[i]["rec_id"]));
                    helper_mssql.Params.Add("userid", Convert.ToInt32(dt.Rows[i]["buyer_id"]));
                    helper_mssql.Params.Add("supplierid", StorageHelper.getSupplierIdByTxm(p_txm));
                    helper_mssql.Params.Add("dingdan", dt.Rows[i]["order_sn"]);
                    helper_mssql.Params.Add("shopxpptid", Convert.ToInt32(dt.Rows[i]["goods_id"]));
                    helper_mssql.Params.Add("style_id", Convert.ToInt32(dt.Rows[i]["spec_id"]));
                    helper_mssql.Params.Add("shopxpptname", dt.Rows[i]["goods_name"]);
                    helper_mssql.Params.Add("p_size", dt.Rows[i]["specification"]);
                    helper_mssql.Params.Add("txm", p_txm);
                    helper_mssql.Params.Add("productcount", p_quantity);
                    helper_mssql.Params.Add("danjia", Convert.ToDouble(dt.Rows[i]["price"]));
                    helper_mssql.Params.Add("voucher", Convert.ToDouble(dt.Rows[i]["voucher_price"]));
                
                    helper_mssql.Params.Add("return_order_id", return_order_id);
                    helper_mssql.Insert("Direct_OrderDetail");

                    payment_id = Convert.ToInt32(dt.Rows[i]["payment_id"]);


                    //不是退换单的话判断所属仓库
                    if (warehouse_id == 0)
                    {
                        warehouse_id = getWarehouseIdByStoreId(StoreId);
                    }

                    //特殊处理,如果是这俩商家的商品,指向银川仓
                    if (warehouse_id == 4 && return_order_id==0)
                    {
                        //int SupplierId = getSupplierId(Convert.ToInt32(dt.Rows[i]["goods_id"]));
                        //if (SupplierId == 11 || SupplierId == 18)
                        //{
                        //    warehouse_id = 1; 
                        //}
                        warehouse_id = 0; 
                    }
                    if (warehouse_id > 0)
                    {
                        StorageHelper.changeStock(warehouse_id, p_txm, 0 - p_quantity, dt.Rows[i]["order_sn"].ToString(), "商品销售,订单号：" + dt.Rows[i]["order_sn"]);
                    }
                }
                string updatesql = "update ecm_order_goods set sys_flag=1 where rec_id =" + dt.Rows[i]["rec_id"].ToString();
                helper_mysql.Execute(updatesql);
            }

             (new SynHelper()).SetOrderWarehouseByStock();

        }

      public static void GetSupplierInfo()
        {
            SinoHelper2.MySqlHelper helper_mysql = PublicHelper.connMysql();
            string checksql = "select * from ecm_store where sgrade in (2,4) and sys_flag=0";
            DataTable dt = helper_mysql.ExecDataTable(checksql);

            SqlHelper helper_mssql = LocalSqlHelper.WH;
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                helper_mssql.Clear();
                helper_mssql.Params.Add("id", Convert.ToInt32(dt.Rows[i]["store_id"]));
                helper_mssql.Params.Add("supplier_name", dt.Rows[i]["store_name"]);
                helper_mssql.Params.Add("serviceTel", dt.Rows[i]["tel"]);
                helper_mssql.Params.Add("store_logo", dt.Rows[i]["store_logo"]);
                helper_mssql.Insert("supplier");
                string updatesql = "update ecm_store set sys_flag=1 where store_id=" + dt.Rows[i]["store_id"].ToString();
                helper_mysql.Execute(updatesql);
            }
        }

        /// <summary>
        /// 根据商家获得仓库名
        /// </summary>
        /// <param name="StoreId"></param>
        /// <returns></returns>
      public static int getWarehouseIdByStoreId(int StoreId)
      {
          int WarehouseId = 0;
          SqlHelper helper_mssql = LocalSqlHelper.WH;
          helper_mssql.Params.Add("StoreId", StoreId);
          DataTable dt = helper_mssql.ExecDataTable("select warehouse_id from WareHouse_List with(nolock) where StoreId=@StoreId");
          if (dt.Rows.Count > 0)
          {
              WarehouseId = Convert.ToInt32(dt.Rows[0]["warehouse_id"]);
          }
          return WarehouseId;
      }


        /// <summary>
        /// 
        /// </summary>
        /// <param name="goods_id"></param>
        /// <returns></returns>
      public static int getSupplierId(int goods_id)
      {
          int supplier_id = 0;
          SinoHelper2.MySqlHelper helper_mysql = PublicHelper.connMysql();
          helper_mysql.Params.Add("?goods_id", goods_id);
          //判断该会员是否已经发放过
          string checksql = "select supplier_id from ecm_goods where goods_id=?goods_id";
          DataTable dt = helper_mysql.ExecDataTable(checksql);
          if (dt.Rows.Count > 0)
          {
              supplier_id = Convert.ToInt32(dt.Rows[0]["supplier_id"]);
          }
          return supplier_id;
      }

      public static void GetProductInfo()
        {
            SinoHelper2.MySqlHelper helper_mysql = PublicHelper.connMysql();
            //判断该会员是否已经发放过
            string checksql = "select * from ecm_goods";
            DataTable dt = helper_mysql.ExecDataTable(checksql);

            SqlHelper helper_mssql = LocalSqlHelper.WH;
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                helper_mssql.Params.Clear();
                helper_mssql.Params.Add("shopxpptid", Convert.ToInt32(dt.Rows[i]["goods_id"]));
                helper_mssql.Params.Add("supplier_id", Convert.ToInt32(dt.Rows[i]["store_id"]));
                helper_mssql.Params.Add("shopxpptname", Convert.ToString(dt.Rows[i]["goods_name"]));
                helper_mssql.Params.Add("hezuojia", 0);
                helper_mssql.Insert("shopxp_product");

                //string updatesql = "update ecm_goods set sys_flag=1 where goods_id=" + dt.Rows[i]["goods_id"].ToString();
                //helper_mysql.Execute(updatesql);
            }
            checksql = "select a.* from ecm_goods_spec a left join ecm_goods b on a.goods_id=b.goods_id";
            dt = helper_mysql.ExecDataTable(checksql);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                helper_mssql.Clear();
                helper_mssql.Params.Add("id", Convert.ToInt32(dt.Rows[i]["spec_id"]));
                helper_mssql.Params.Add("shopxpptid", Convert.ToInt32(dt.Rows[i]["goods_id"]));
                helper_mssql.Params.Add("txm", Convert.ToString(dt.Rows[i]["sku"]));
                helper_mssql.Params.Add("p_size", Convert.ToString(dt.Rows[i]["spec_1"]) +"/"+ Convert.ToString(dt.Rows[i]["spec_2"]));
                helper_mssql.Insert("shopxp_kucun");
                //string updatesql = "update ecm_goods_spec set sys_flag=1 where spec_id =" + dt.Rows[i]["spec_id"].ToString();
                //helper_mysql.Execute(updatesql);
            }
        }

      
      //比较当前库存,确定发货仓
      protected void SetOrderWarehouseByStock()
      {
        string sql = "select dingdan,province from Direct_OrderMain where supplierid=0 order by fksj";
        SqlHelper helper_mssql = LocalSqlHelper.WH;
        DataTable dt = helper_mssql.ExecDataTable(sql);
        string checksql = string.Empty;
        string province = string.Empty;
        string dingdan = string.Empty;
        int warehouse_id = 0;
        int pro_id = 0;
        int stock = 0;
        int return_order_id = 0;
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            province = Convert.ToString(dt.Rows[i]["province"]);
            if (province.IsNotNullAndEmpty())
            {
                province = province.Replace("\t", " ");
                string[] provinceArr = province.Split(' ');
                province = provinceArr[0];
            }
            dingdan = Convert.ToString(dt.Rows[i]["dingdan"]);
            warehouse_id = 4;//广州仓
            if (province == "宁夏" || province == "内蒙古" || province == "甘肃" || province == "陕西" || province == "青海")
            {
                warehouse_id = 1;//银川仓
                //判断宁夏仓库存是否充足,若足从宁夏发
                helper_mssql.Params.Clear();
                helper_mssql.Params.Add("dingdan", dingdan);
                checksql = "select txm,productcount,return_order_id  from Direct_OrderDetail where dingdan=@dingdan";
                DataTable dtDetail = helper_mssql.ExecDataTable(checksql);
                for (int j = 0; j < dtDetail.Rows.Count; j++)
                {
                    pro_id = StorageHelper.getIdByTxm(Convert.ToString(dtDetail.Rows[j]["txm"]));
                    
                    //涉退订单跟从原来订单仓库走
                    return_order_id = Convert.ToInt32(dtDetail.Rows[j]["return_order_id"]);
                    if (return_order_id > 0)
                    {
                        warehouse_id = getWarehouseIdByReturnId(return_order_id);
                        break;
                    }

                    //如果有一商品不足,则改由总仓发
                    stock = StorageHelper.getStockNum(pro_id, warehouse_id);
                    if (stock <Convert.ToInt32(dtDetail.Rows[j]["productcount"]))
                    {
                        warehouse_id = 4;//广州仓
                        break;
                    }
                }
            }

            //更新当前关联仓库
            helper_mssql.Params.Clear();
            helper_mssql.Params.Add("warehouse_id", warehouse_id);
            helper_mssql.Params.Add("dingdan", dingdan);
            string updateSql = "update Direct_OrderMain set supplierid=@warehouse_id where dingdan=@dingdan"; ;
            helper_mssql.Execute(updateSql);

            //将当前订单的库存对应变动
            helper_mssql.Params.Clear();
            helper_mssql.Params.Add("dingdan", dingdan);
            checksql = "select txm,productcount from Direct_OrderDetail where dingdan=@dingdan";
            DataTable dtDetail2 = helper_mssql.ExecDataTable(checksql);
            for (int j = 0; j < dtDetail2.Rows.Count; j++)
            {
               StorageHelper.changeStock(warehouse_id, Convert.ToString(dtDetail2.Rows[j]["txm"]), 0 - Convert.ToInt32(dtDetail2.Rows[j]["productcount"]), dingdan, "商品销售,订单号：" + dingdan);
            }

        }
      }

    



      protected int getWarehouseIdByReturnId(int return_id)
      {
          SqlHelper helper_mssql = LocalSqlHelper.WH;
          return Convert.ToInt32(helper_mssql.ExecScalar("select supplierid from Direct_OrderMain where shopxpacid="+return_id));
      }
    }
}