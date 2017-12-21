using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using SinoHelper2;
using Warehousing.Business;
using Warehousing.Model;

namespace Warehousing.Storage
{
    public partial class addProductOut : mypage
    {
        protected SqlHelper helper = LocalSqlHelper.WH;
        protected int id = 0;
        protected string liushuihao = string.Empty;
        protected int int_from_warehouse_id = 0, int_to_warehouse_id = 0;
        protected int int_outType = 0, need_consumer = 0, need_supplier = 0;

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            id = Convert.ToInt32(Request["id"]);
            if (!Page.IsPostBack)
            {
                if (Request.QueryString["outType"].IsNullOrEmpty() || !Request.QueryString["outType"].IsNumber())
                {
                    JSHelper.WriteScript("alert('请选择出库类型');history.back();");
                    Response.End();
                }
                int_outType = Convert.ToInt32(Request.QueryString["outType"]);
                if (int_outType == 12 || int_outType == 13)
                {
                    need_consumer = 1;
                }
                if (int_outType == (int)StorageType.退货返厂 || int_outType == (int)StorageType.维修返厂)
                {
                    need_supplier = 1;
                }
                Session["anti_refresh"] = "1";
                int int_sm_type = 0;
                int supplierid = 0;
                string Sql = "select * from Tb_storage_main where sm_id=@id";
                helper.Params.Add("@id", id);
                DataTable dt = helper.ExecDataTable(Sql);
                if (dt.Rows.Count > 0)
                {
                    liushuihao = dt.Rows[0]["sm_sn"].ToString();
                    sm_date.Text =Convert.ToDateTime( dt.Rows[0]["sm_date"]).ToShortDateString();
                    sm_operator.Text = dt.Rows[0]["sm_operator"].ToString();
                    sm_remark.Text = dt.Rows[0]["sm_remark"].ToString();
                    sm_type.Text = dt.Rows[0]["sm_type"].ToString();
                    TextLoginName.Text = dt.Rows[0]["consumer_name"].ToString();
                    TextLoginName2.Text = dt.Rows[0]["consumer_name"].ToString();
                    supplierid = Convert.ToInt32(dt.Rows[0]["sm_supplierid"]);
                    TextLoginName.Enabled = false;
                    TextLoginName2.Enabled = false;
                   // getbox.Text = dt.Rows[0]["sm_box"].ToString();
                    int_from_warehouse_id = Convert.ToInt32(dt.Rows[0]["warehouse_id"]);
                    int_to_warehouse_id = Convert.ToInt32(dt.Rows[0]["warehouse_id_to"]);
                    int_sm_type = Convert.ToInt32(dt.Rows[0]["sm_type"]);
                    int_outType = int_sm_type;  //既有出库单以出库单出库类型为准
                    string relate_sn=Convert.ToString(dt.Rows[0]["relate_sn"]);
                    if (int_outType == (int)StorageType.调货出库 && relate_sn.IsNotNullAndEmpty())
                    {
                        relateActive.Items.Add(new ListItem(relate_sn, relate_sn));
                        relateActive.Text = relate_sn;
                    }
                    
                }

                if (need_supplier==1)
                {
                    need_supplier = 1;
                    StorageHelper.BindSupplierList(sm_supplierid, supplierid);
                }
               

                Warehousing.Business.StorageHelper.BindWarehouseList(from_warehouse_id, int_from_warehouse_id, my_warehouse_id.ToString(), "");

                sm_type.Items.Add(new ListItem(StorageHelper.getTypeText(int_outType), int_outType.ToString()));

                if (my_warehouse_id!=0&&my_warehouse_id!=4)
                {
                    
                    Label_agent_info.Visible = true;
                }
                string where="warehouse_id<>"+myStorageInfo.warehouse_id;
                if (myStorageInfo.agent_id>0)
                {
                    if (myStorageInfo.is_manage == 1)
                    {
                        where += " and ((agent_id=0 and is_manage = 1) or agent_id='" + myStorageInfo.agent_id + "')";
                    }
                    else
                    {
                        where += " and is_manage=1 and agent_id='" + myStorageInfo.agent_id + "'";
                    }
                }
                else
                {
                    if (my_warehouse_id > 0)
                    {
                        where += " and (is_manage=1 or agent_id='" + myStorageInfo.agent_id + "')";
                    }
                }
                Warehousing.Business.StorageHelper.BindWarehouseList(to_warehouse_id, int_to_warehouse_id, where);
                if (int_outType == (int)StorageType.调货出库)
                {
                    to_warehouse_id.Style.Value = "display:inline";
                    relateActive.Style.Value = "display:inline";
                    relateActiveDiv.Style.Value = "display:inline";
                }
                else
                {
                    to_warehouse_id.Style.Value = "display:none";
                    relateActive.Style.Value = "display:none";
                    relateActiveDiv.Style.Value = "display:none";
                }

                string from_apply_id = Request["apply_id"];
                string from_direct_id = Request["direct_id"];
                if (from_apply_id.IsNotNullAndEmpty() && from_apply_id.IsNumber())
                {
                    bindApplyPro(Convert.ToInt32(from_apply_id));
                }
                if (from_direct_id.IsNotNullAndEmpty() && from_direct_id.IsNumber())
                {
                    bindDirectPro(Convert.ToInt32(from_direct_id));
                }
            }
        }

        protected void bindApplyPro(int ap_id)
        {
            SqlHelper helper = LocalSqlHelper.WH;
            string sm_sql = "select *,p_box='' from Tb_need_main with(nolock) where sm_id=@sm_id ";
            helper.Params.Add("sm_id", ap_id);
            DataTable sm_dt = helper.ExecDataTable(sm_sql);
            if (sm_dt.Rows.Count > 0)
            {
                sm_type.SelectedValue = Convert.ToInt32(StorageType.调货出库).ToString();
                from_warehouse_id.SelectedValue = sm_dt.Rows[0]["warehouse_id_from"].ToString();
                to_warehouse_id.Style.Value = "display:inline";
                to_warehouse_id.SelectedValue = sm_dt.Rows[0]["warehouse_id"].ToString();
            }
            helper.Params.Clear();
            string sql = "SELECT *,shelf_no='',p_box='' FROM Tb_need_product with(nolock) where sm_id=@sm_id order by p_id";
            helper.Params.Add("sm_id", ap_id);
            DataTable dt = helper.ExecDataTable(sql);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                dt.Rows[i]["shelf_no"] = StorageHelper.getShelfNo(Convert.ToInt32(dt.Rows[i]["pro_id"]), Convert.ToInt32(sm_dt.Rows[0]["warehouse_id_from"]));
            }
            MemberList.DataShow(dt);
        }

        protected void bindDirectPro(int direct_id)
        {
            SqlHelper helper = LocalSqlHelper.WH;
            string sm_sql = "select * from Tb_storage_main with(nolock) where sm_id=@sm_id and is_direct=0";
            helper.Params.Add("sm_id", direct_id);
            DataTable sm_dt = helper.ExecDataTable(sm_sql);
            if (sm_dt.Rows.Count > 0)
            {
                sm_type.SelectedValue =Convert.ToInt32(StorageType.调货出库).ToString();
                from_warehouse_id.SelectedValue = sm_dt.Rows[0]["warehouse_id"].ToString();
                to_warehouse_id.Style.Value = "display:inline";
               // to_warehouse_id.SelectedValue = sm_dt.Rows[0]["warehouse_id_from"].ToString();
            }
            helper.Params.Clear();
            string sql = "SELECT *,shelf_no='' FROM Tb_storage_product with(nolock) where sm_id=@sm_id order by p_id";
            helper.Params.Add("sm_id", direct_id);
            DataTable dt = helper.ExecDataTable(sql);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                dt.Rows[i]["shelf_no"] = StorageHelper.getShelfNo(Convert.ToInt32(dt.Rows[i]["pro_id"]), Convert.ToInt32(sm_dt.Rows[0]["warehouse_id"]));
            }
            MemberList.DataShow(dt);
        }


        protected void Button1_Click(object sender, EventArgs e)
        {
            int_to_warehouse_id = 0;
            if (Request["sm_type"].IsNullOrEmpty() || !Request["sm_type"].IsNumber())
            {
                JSHelper.WriteScript("alert('出库类型有误');history.back();");
                Response.End();
            }
            if ((int)StorageType.调货出库==Convert.ToInt32(Request["sm_type"]))
            {
                if (Request["from_warehouse_id"] == Request["to_warehouse_id"])
                {
                    JSHelper.WriteScript("alert('不能在同仓库间调货');history.back();");
                    Response.End();
                }
                if (Request["to_warehouse_id"].IsNullOrEmpty() || !Request["to_warehouse_id"].IsNumber())
                {
                    JSHelper.WriteScript("alert('调货目录仓有误');history.back();");
                    Response.End();
                }
                int_to_warehouse_id = Convert.ToInt32(Request["to_warehouse_id"]);
            }
            if (Session["anti_refresh"] != "1")
            {
                //  JSHelper.WriteScript("alert('请勿重复提交');history.back();");
                //  Response.End();
            }
            Session["anti_refresh"] = "0";

            helper.Params.Clear();
            helper.Params.Add("sm_supplierid", Request["sm_supplierid"]);
            helper.Params.Add("sm_type", Request["sm_type"]);
            helper.Params.Add("warehouse_id", Request["from_warehouse_id"]);
            helper.Params.Add("warehouse_id_to", int_to_warehouse_id);
            helper.Params.Add("sm_date", Request["sm_date"]);
            helper.Params.Add("relate_sn", Request["relateActive"]);
            helper.Params.Add("sm_operator", sm_operator.Text);
            helper.Params.Add("sm_remark", sm_remark.Text);
            if (need_supplier == 1)
            {
                helper.Params.Add("sm_supplierid", Request["sm_supplierid"]);
            }
            //helper.Params.Add("sm_box", getbox.Text);
            helper.Params.Add("sm_direction", "出库");

            if (id == 0)
            {
                string p_name = Request.Form["p_name"];
                string[] arr_p_name = Request.Form["p_name"].Split(',');
                string[] arr_p_serial = Request.Form["p_serial"].Split(',');
                string[] arr_p_txm = Request.Form["p_txm"].Split(',');
                string[] arr_p_brand = Request.Form["p_brand"].Split(',');
                string[] arr_p_unit = Request.Form["p_unit"].Split(',');
                string[] arr_p_spec = Request.Form["p_spec"].Split(',');
                string[] arr_p_model = Request.Form["p_model"].Split(',');
                string[] arr_p_quantity = Request.Form["p_quantity"].Split(',');
                string[] arr_p_price = Request.Form["p_price"].Split(',');
                //string[] arr_p_box = Request.Form["p_box"].Split(',');
                if (p_name.IsNotNullAndEmpty())
                {
                    for (int i = 0; i < arr_p_name.Length; i++)
                    {
                        if (arr_p_txm[i].IsNotNullAndEmpty() && arr_p_name[i].IsNotNullAndEmpty() &&arr_p_quantity[i].IsNotNullAndEmpty()&& arr_p_quantity[i].IsNumber())
                        {
                            bool isEnough = StorageHelper.checkOneStockIsEnough(arr_p_txm[i], Convert.ToInt32(Request["from_warehouse_id"]), Convert.ToInt32(arr_p_quantity[i]));
                            //Response.Write(arr_p_quantity[i]);
                            if (!isEnough)
                            {
                                JSHelper.WriteScript("alert('" + arr_p_txm[i] + "对应商品库存不足！');history.back();");
                                Response.End();
                            }
                        }
                    }
                }

                helper.Params.Add("sm_sn", StorageHelper.getNewChurukuHao("CK"));
                helper.Params.Add("sm_adminid", HttpContext.Current.Session["ManageUserId"].ToString());
                try
                {
                    string UserName = TextLoginName.Text;
                    int userid = 0;
                    if (UserName.IsNotNullAndEmpty())
                    {
                        userid = UserHelper.getUserId(UserName);

                        if (userid == 0)
                        {
                            if (TextLoginName.Text != TextLoginName2.Text)
                            {
                                JSHelper.WriteScript("alert('两次客户标识不一致！');history.back();");
                                return;
                            }
                            if (UserName.IsNullOrEmpty())
                            {
                                  JSHelper.WriteScript("alert('用户名不能为空');history.back();");
                                  return;
                            }
                            if (!UserName.IsCellPhone())
                            {
                              //  JSHelper.WriteScript("alert('要求为手机号');history.back();");
                              //  return;
                            }

                            //生成新会员
                            UserInfo newUser = new UserInfo();

                            newUser.User_name = UserName;
                            if (UserName.IsCellPhone())
                            {
                                newUser.User_Mobile = UserName;
                            }
                            newUser.User_level = 2;//一级批发商
                            newUser.is_hide = 0;
                            newUser.User_Pwd = "666666";
                            newUser.True_name = "";
                            newUser.cashier_id_from = my_admin_id;
                            newUser.store_id_from = my_warehouse_id;
                            userid = UserHelper.addUser(newUser);
                        }
                        helper.Params.Add("consumer_id", userid);
                        helper.Params.Add("consumer_name", UserName);
                    }

                    helper.Insert("Tb_storage_main");

                }
                catch
                {
                    JSHelper.WriteScript("alert('出库单号已有记录，不能重复！');history.back();");
                    Response.End();
                }
                int sm_id = Convert.ToInt32(helper.ExecScalar("select top 1 sm_id from Tb_storage_main order by sm_id desc"));
                string from_direct_id = Request["direct_id"];
                if (from_direct_id.IsNotNullAndEmpty()&&from_direct_id.IsNumber())
                {
                    helper.Params.Clear();
                    helper.Execute("update Tb_storage_main set is_direct=" + sm_id + " where sm_id=" + from_direct_id);
                }
                if (p_name.IsNotNullAndEmpty())
                {
                    for (int i = 0; i < arr_p_name.Length; i++)
                    {
                        if (arr_p_txm[i].IsNotNullAndEmpty() && arr_p_name[i].IsNotNullAndEmpty())
                        {
                            helper.Params.Clear();
                            helper.Params.Add("sm_id", sm_id);
                            helper.Params.Add("p_name", arr_p_name[i]);
                            helper.Params.Add("p_serial", arr_p_serial[i]);
                            helper.Params.Add("p_txm", arr_p_txm[i].Trim());
                            helper.Params.Add("p_brand", arr_p_brand[i]);
                            helper.Params.Add("p_unit", arr_p_unit[i]);
                            helper.Params.Add("p_spec", arr_p_spec[i]);
                            helper.Params.Add("p_model", arr_p_model[i]);
                            helper.Params.Add("p_quantity", arr_p_quantity[i].IsNumber() ? arr_p_quantity[i] : "0");
                            helper.Params.Add("p_price", arr_p_price[i].IsNumber() ? arr_p_price[i] : "0");
                            //helper.Params.Add("p_box", arr_p_box[i]);
                            helper.Insert("Tb_storage_product");
                        }

                    }
                }
            }
            else
            {
                helper.Params.Add("sm_id", id);
                helper.Update("Tb_storage_main", "sm_id");
            }
            JSHelper.WriteScript("alert('编辑成功');location.href='ProductOut.aspx';");
            //Response.Write(RoleList.Text);
            Response.End();
        }

        protected void sm_type_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (this.sm_type.SelectedValue.IsNullOrEmpty())
            {
                return;
            }
            int int_sm_type = Convert.ToInt32(this.sm_type.Text);
            if (int_sm_type == (int)StorageType.调货出库)
            {
                to_warehouse_id.Style.Value = "display:inline";
                if (myStorageInfo.warehouse_id == 0)
                {
                    to_warehouse_id.SelectedIndex = 0;
                }
            }
            else
            {
                to_warehouse_id.Style.Value = "display:none";
            }
            
        }
    }
}