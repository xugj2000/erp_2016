using System;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SinoHelper2;
using Warehousing.Business;

namespace Warehousing.Storage
{
    public partial class addproduct : System.Web.UI.Page
    {
        protected SqlHelper helper = LocalSqlHelper.WH;
        protected int pm_id = 0;
        protected string sys_del = "0";
        protected string fromUrl = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            SiteHelper.CheckLogin();
            SiteHelper.GetPageUrlpower("Storage/ProductList.aspx");
            pm_id = Convert.ToInt32(Request["id"]);
            if (!Page.IsPostBack)
            {
                string Sql = "select * from ProductMain with(nolock) where pm_id=@id";
                helper.Params.Add("@id", pm_id);
                DataTable dt = helper.ExecDataTable(Sql);
                int supplierid = 0;
                int type_id = 0;
                string pro_brand = string.Empty;
                Textpro_unit.Text = "件";
                TextSpec_name_1.Text ="颜色";
                TextSpec_name_2.Text = "尺码";
                Textpro_unit.Attributes.Add("onclick", "this.select();");
                TextSpec_name_1.Attributes.Add("onclick","this.select();");
                TextSpec_name_2.Attributes.Add("onclick", "this.select();");
                if (dt.Rows.Count > 0)
                {
                    if (Session["PowerEdit"].ToString() != "1")
                    {
                        SiteHelper.NOPowerMessage();
                    }
                    sys_del = Convert.ToString(dt.Rows[0]["sys_del"]);
                    Textpro_name.Text = Convert.ToString(dt.Rows[0]["pro_name"]);
                    Textpro_code.Text = Convert.ToString(dt.Rows[0]["pro_code"]);
                     pro_brand = Convert.ToString(dt.Rows[0]["pro_brand"]);
                    Textpro_unit.Text = Convert.ToString(dt.Rows[0]["pro_unit"]);
                    TextSpec_name_1.Text = Convert.ToString(dt.Rows[0]["spec_name_1"]);
                    TextSpec_name_2.Text = Convert.ToString(dt.Rows[0]["spec_name_2"]);
                    string str_pro_image = Convert.ToString(dt.Rows[0]["pro_image"]);
                    if (str_pro_image.IsNullOrEmpty())
                    {
                        pro_image_view.CssClass = "hide";
                    }else
                    {
                        pro_image_view.ImageUrl = str_pro_image;
                        pro_image.Value = str_pro_image;
                    }
                    
                    supplierid = Convert.ToInt32(dt.Rows[0]["pro_supplierid"]);
                    type_id = Convert.ToInt32(dt.Rows[0]["type_id"]);
                    bindProModel(Convert.ToInt32(dt.Rows[0]["pm_id"]));
                }
                else
                {
                    if (Session["PowerAdd"].ToString() != "1")
                    {
                        SiteHelper.NOPowerMessage();
                    }
                    pro_image_view.CssClass = "hide";
                }
                StorageHelper.BindSupplierList(pro_supplierid, supplierid);
                StorageHelper.BindProTypeList(dd_type_id, type_id);

                StorageHelper.BindBrandList(Textpro_brand, pro_brand);
                fromUrl = Request.UrlReferrer.ToString();
            }
        }

        protected void bindProModel(int pm_id)
        {
            ProModelList.DataShow(StorageHelper.GetProStyleList(pm_id));
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            helper.Params.Clear();
            helper.Params.Add("pro_code", Textpro_code.Text);
            if (pm_id == 0)
            {
                //新增时比较货号是否重复
                DataTable checkDt = helper.ExecDataTable("select top 1 pm_id from ProductMain with(nolock) where pro_code=@pro_code");
                if (checkDt.Rows.Count > 0)
                {
                    JSHelper.WriteScript("alert('本次录入产品的货号已存在商品库中，请更正或直接修改原产品！');history.back();");
                    Response.End();
                }
            }
            helper.Params.Clear();
            helper.Params.Add("pro_code", Textpro_code.Text);
            helper.Params.Add("pro_name", Textpro_name.Text);
            helper.Params.Add("pro_brand", Textpro_brand.Text);
            helper.Params.Add("pro_unit", Textpro_unit.Text);
            helper.Params.Add("pro_image",Request["pro_image"]);
            
            helper.Params.Add("spec_name_1", TextSpec_name_1.Text);
            helper.Params.Add("spec_name_2", TextSpec_name_2.Text);
            helper.Params.Add("pro_supplierid", Request["pro_supplierid"]);
            helper.Params.Add("type_id", Request["dd_type_id"].IsNumber()?Request["dd_type_id"]:"0");
            helper.Params.Add("sys_del", Request.Form["sys_del"]);
            int is_new = 0;
            string str_txm = string.Empty;
            if (pm_id == 0)
            {
                //检查一下货号是否唯一
                is_new = 1;
                helper.Insert("ProductMain");
                helper.Params.Clear();
                pm_id = Convert.ToInt32(helper.ExecScalar("select top 1 pm_id from ProductMain with(nolock) order by pm_id desc"));
            }
            else
            {
                try
                {
                    helper.Params.Add("pm_id", pm_id);
                    helper.Update("ProductMain", "pm_id");
                    helper.Clear();
                    DataTable dt_txm = helper.ExecDataTable("select pro_txm from Product where pm_id="+pm_id);
                    for (int i = 0; i < dt_txm.Rows.Count; i++)
                    {
                        str_txm = str_txm.IsNullOrEmpty() ? "'"+dt_txm.Rows[i]["pro_txm"].ToString()+"'" : str_txm+",'" + dt_txm.Rows[i]["pro_txm"].ToString()+"'";
                    }

                }
                catch
                {
                    JSHelper.WriteScript("alert('产品货号已存在！');history.back();");
                    Response.End();
                }
            }

            string[] arr_pro_id, arr_pro_txm, arr_pro_spec, arr_pro_model, arr_pro_outprice, arr_pro_outprice_advanced, arr_pro_price, arr_pro_inprice, arr_pro_marketprice, arr_pro_settleprice;

           
            arr_pro_id = Request.Form["pro_id"].Split(',');
           
            
            arr_pro_txm = Request.Form["pro_txm"].Split(',');
            
            arr_pro_spec = Request.Form["pro_spec"].Split(',');
            
            arr_pro_model = Request.Form["pro_model"].Split(',');

            arr_pro_price = Request.Form["pro_price"].Split(',');
            arr_pro_marketprice = Request.Form["pro_marketprice"].Split(',');
            arr_pro_settleprice = Request.Form["pro_settleprice"].Split(',');
            arr_pro_outprice = Request.Form["pro_outprice"].Split(',');
            arr_pro_outprice_advanced = Request.Form["pro_outprice_advanced"].Split(',');
            arr_pro_inprice = Request.Form["pro_inprice"].Split(',');
            string notice_info = string.Empty;
            string txm_info = string.Empty;
            int newTxmCount = 0;
            
            for (int i = 0; i < arr_pro_txm.Length; i++)
            {
                //判断该条码对应商品是否已存在'
                if (arr_pro_txm[i].Trim().IsNotNullAndEmpty())
                {
                    str_txm = str_txm.Replace(arr_pro_txm[i].Trim(), "0");
                    if (arr_pro_txm[i].IndexOf(Textpro_code.Text) ==-1)
                    {
                        notice_info = notice_info.IsNullOrEmpty() ? arr_pro_txm[i] : notice_info + "," + arr_pro_txm[i];
                        continue;
                    }
                    if (StorageHelper.checkTxm(arr_pro_txm[i])==false)
                    {
                        txm_info = txm_info.IsNullOrEmpty() ? arr_pro_txm[i] : txm_info + "," + arr_pro_txm[i];
                        continue;
                    }
                   // Response.Write(arr_pro_txm[i]+"<br>");
                    helper.Params.Clear();
                    string checksql = "select top 1 1 from Product with(nolock) where pro_txm=@pro_txm and pro_id<>@pro_id";
                    helper.Params.Add("pro_id", arr_pro_id[i].Trim());
                    helper.Params.Add("pro_txm", arr_pro_txm[i].Trim());
                    DataTable checkDt = helper.ExecDataTable(checksql);
                    if (checkDt.Rows.Count == 0)
                    {
                        helper.Params.Clear();
                        helper.Params.Add("pm_id", pm_id);
                        helper.Params.Add("pro_txm", arr_pro_txm[i].Trim());
                        helper.Params.Add("pro_spec", arr_pro_spec[i]);
                        helper.Params.Add("pro_model", arr_pro_model[i]);
                        helper.Params.Add("pro_price", arr_pro_price[i].IsNumber() ? arr_pro_price[i] : "0");
                        helper.Params.Add("pro_marketprice", arr_pro_marketprice[i].IsNumber() ? arr_pro_marketprice[i] : "0");
                        helper.Params.Add("pro_outprice", arr_pro_outprice[i].IsNumber() ? arr_pro_outprice[i] : "0");
                        helper.Params.Add("pro_outprice_advanced", arr_pro_outprice_advanced[i].IsNumber() ? arr_pro_outprice_advanced[i] : "0");
                        helper.Params.Add("pro_settleprice", arr_pro_settleprice[i].IsNumber() ? arr_pro_settleprice[i] : "0");
                        helper.Params.Add("pro_inprice", arr_pro_inprice[i].IsNumber() ? arr_pro_inprice[i] : "0");
                        //Response.Write(arr_pro_id[i]);
                        
                        if (arr_pro_id[i] == "0")
                        {
                            newTxmCount++;
                            helper.Insert("product");
                            helper.Params.Clear();

                            /*
                            int pro_id = 0;
                            pro_id = Convert.ToInt32(helper.ExecScalar("select top 1 pro_id from Product with(nolock) order by pro_id desc"));
                            helper.Params.Add("pm_id", pm_id);
                            helper.Params.Add("pro_id", pro_id);
                            helper.Params.Add("warehouse_id", 4);
                            helper.Insert("ProductStock");
                            */
                            //同步到实体店数据
                            //helper.Params.Clear();
                            //helper.Params.Add("pro_id", pro_id);
                            //helper.Execute("insert into ProductStock(pm_id,pro_id,warehouse_id) select pm_id,pro_id,2 from ProductStock where WareHouse_id=4 and pro_id=@pro_id");
                        }
                        else
                        {
                            helper.Params.Add("pro_id", arr_pro_id[i]);
                            helper.Update("product", "pro_id");
                        }
                    }
                }
            }
            if (newTxmCount == 0 && is_new == 1)
            {
                helper.Params.Clear();
                helper.Execute("delete from ProductMain where pm_id="+pm_id);
            }
            helper.Params.Clear();
            //Response.Write(str_txm);
           //Response.End();
            if (str_txm.IsNotNullAndEmpty())
            {
                helper.Execute("delete from Product where pro_txm in (" + str_txm + ")");
            }

            fromUrl = Request["fromUrl"];
            if (fromUrl.IsNullOrEmpty())
            {
                fromUrl = "ProductList.aspx";
            }
            if (notice_info.IsNotNullAndEmpty())
            {
                JSHelper.WriteScript("alert('有" + notice_info + "条码与货号不匹配,请重新录入！ ');");
            }
            if (txm_info.IsNotNullAndEmpty())
            {
                JSHelper.WriteScript("alert('有" + txm_info + "条码有误,请重新录入！ ');");
            }

            JSHelper.WriteScript("alert('编辑成功');location.href='" + fromUrl + "';");
            //Response.Write(RoleList.Text);
            Response.End();
        }
    }
}