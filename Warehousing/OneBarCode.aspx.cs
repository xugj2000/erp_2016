using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Warehousing.Business;
using System.Drawing;
using System.Drawing.Imaging;
using SinoHelper2;

namespace Warehousing
{
    public partial class OneBarCode : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            BarCode.Code128 _Code = new BarCode.Code128();
            _Code.ValueFont = new Font("宋体", 20);
            string ProductSn = Request.QueryString["Code"];
            if (ProductSn.IsNullOrEmpty())
            {
                ProductSn = "123456789";
            }
            ProductSn = ProductSn.ToUpper();
            System.Drawing.Bitmap imgTemp = _Code.GetCodeImage(ProductSn, Warehousing.Business.BarCode.Code128.Encode.Code128A);
             //imgTemp.Save(System.AppDomain.CurrentDomain.BaseDirectory + "\\" + "BarCode.gif", System.Drawing.Imaging.ImageFormat.Gif);
            // ImgGeometricThumbnail(System.AppDomain.CurrentDomain.BaseDirectory + "\\" + "BarCode.gif");
             imgTemp.Save(Response.OutputStream, ImageFormat.Gif);
            //Response.Write("<img src='/BarCode.gif'/>");
        }


        /// <summary>
        /// 输出高清缩略图
        /// </summary>
        /// <param name="filer">路径</param>
        public void ImgGeometricThumbnail(string filer)
        {
            int twidth = 300;
            int theight = 300;
            //处理图片
            string[] textArray = filer.Split(new[] { '\\' });
            string fileName = textArray[textArray.Length - 1];
            if (string.IsNullOrEmpty(fileName))
            {
                return;
            }

            //为上传的图片建立引用
            System.Drawing.Image image = System.Drawing.Image.FromFile(filer.Trim());
            int owidth = image.Width; //原图宽度 
            int oheight = image.Height; //原图高度

            if ((oheight < theight) && (owidth < twidth))
            {
                twidth = owidth;
                theight = oheight;
            }
            else
            {
                //按比例计算出缩略图的宽度和高度 
                if ((owidth >= oheight || theight == 0) && twidth != 0)
                {
                    //等比设定高度
                    theight = (int)Math.Floor(Convert.ToDouble(oheight) * (Convert.ToDouble(twidth) / Convert.ToDouble(owidth)));
                }
                else
                {
                    //等比设定宽度
                    twidth = (int)Math.Floor(Convert.ToDouble(owidth) * (Convert.ToDouble(theight) / Convert.ToDouble(oheight)));
                }
            }
            System.Drawing.Image srcImg = System.Drawing.Image.FromFile(filer);
            var thumbImg = new Bitmap(twidth, theight);
            Graphics graphics = Graphics.FromImage(thumbImg);

            graphics.DrawImage(srcImg, 0, 0, thumbImg.Width, thumbImg.Height);
            //graphics.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.High;
            //graphics.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.HighQuality;

            thumbImg.Save(Response.OutputStream, ImageFormat.Jpeg);//保存到输出流中);

            graphics.Dispose();
            thumbImg.Dispose();
            srcImg.Dispose();
            Response.ContentType = "Image/jpeg";
            Response.Flush();
            Response.End();
        }
    }
}