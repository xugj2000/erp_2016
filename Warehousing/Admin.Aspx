<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Admin.aspx.cs" Inherits="Warehousing.Admin" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>多彩ERP欢迎您</title>
<link href="css/global.css" rel="stylesheet" type="text/css" />
<link href="css/dailipingtai.css" rel="stylesheet" type="text/css" />
<link href="/js/lhgdialog/skins/iblue.css" rel="stylesheet" type="text/css" /> 
<SCRIPT src="js/jquery.js" type=text/javascript></SCRIPT>
<SCRIPT src="js/index.js" type=text/javascript></SCRIPT>
<SCRIPT src="js/jquery.tabs.js" type=text/javascript></SCRIPT><!-- 左边折叠-->

<script language="javascript" type="text/javascript">
    function ClearSession() {
        var n = window.event.screenX - window.screenLeft;
        var b = n > document.documentElement.scrollWidth - 20;
        if (b && window.event.clientY < 0 || window.event.altKey || window.event.ctrlKey) {
            goout();
        }
    }
    $(function () {
        var thisobject = $(".l_bg02_A ul li a");
        $(".l_bg02_A ul li a").click(function () {
            thisobject.each(function (i) {
                thisobject.eq(i).removeClass("current");
            });
            $(this).addClass("current");
        });
    })
</script>
</head>

<body onunload="ClearSession()">
<!--头部-->
<div class="top">
  <div class="top_left"><img src="images/top_left.jpg" border="0" usemap="#Map" />
    <map name="Map" id="Map">
      <area shape="rect" coords="12, 21, 170, 88" href="/welcome.aspx"  target="right"/>
    </map>
  </div>
  <div class="top_right"><img src="images/top_right.jpg" border="0" usemap="#Map2" />
    <map name="Map2" id="Map2">
      <area shape="rect" coords="512,29,633,95" onclick="return confirm('确定退出管理中心吗');" href="logout.aspx" />
    </map>
  </div>
</div>
<!--头部结束-->
<div class="clear"></div>
<!--导航-->
<div class="nav">
  <div class="left_nav">欢迎您登录多彩ERP：<span><%=TrueName%></span> 您的工号是：<span><%=LoginName%></span></div>
  <div class="right_nav"> 
  </div>
</div>
<!--导航结束-->
<div style="text-align:center; margin-bottom:5px; margin-top:5px">

</div>
<!--主题内容-->
<div class="main"> 
  <!--左边JQ导航-->
  <div class="left" id=Newsb_toparea >
	<%if (Warehousing.Business.PublicHelper.getReadRightByText("出入库")==1){%>
    <div class="l_bg02"><a class="ui-tscure">出入库</a></div>
    <div class="l_bg02_A">
      <ul>
      <%if (Warehousing.Business.PublicHelper.getReadRightByText("商品入库")==1) {%>
        <li><a href="Storage/ProductIn.aspx"  target="right">商品入库</a></li>
          <%} %>
         <%if (Warehousing.Business.PublicHelper.getReadRightByText("商品出库")==1){%>
        <li><a href="Storage/ProductOut.aspx"  target="right">商品出库</a></li>
          <%} %>
         <%if (Warehousing.Business.PublicHelper.getReadRightByText("商品批发")==1){%>
        <li><a href="Storage/WholeSales.aspx"  target="right">商品批发</a></li>
          <%} %>
         <%if (Warehousing.Business.PublicHelper.getReadRightByText("加盟供货")==1){%>
        <li><a href="Storage/UnionSales.aspx"  target="right">加盟供货</a></li>
          <%} %>
        <%if (Warehousing.Business.PublicHelper.getReadRightByText("调仓入库审核")==1){%>
        <li><a href="Storage/ProductTran.aspx"  target="right">调仓入库审核</a></li>
         <%} %>
        
        <%if (Warehousing.Business.PublicHelper.getReadRightByText("销售统计")==1){%>
        <li><a href="Storage/ProductSales.aspx"  target="right">销售统计</a></li>
          <%} %>
        <%if (Warehousing.Business.PublicHelper.getReadRightByText("出入库统计")==1){%>
        <li><a href="Storage/ProductActive.aspx"  target="right">出入库统计</a></li>
          <%} %>
         
        <%if (Warehousing.Business.PublicHelper.getReadRightByText("调货申请")==1){%>
        <li><a href="Storage/ProductNeedList.aspx"  target="right">调货申请</a></li>
         <%} %>
      </ul>
    </div>
	 <%} %>
    <%if (Warehousing.Business.PublicHelper.getReadRightByText("打单中心")==1){%>
    <div class="l_bg02"><a>仓库打单</a></div>
    <div class="l_bg02_A" style="display:none;">
      <ul>
	  <li><a href="OrderPrint/DirectOrderWillList.asp"  target="right">订单待打印</a></li>
	  <li><a href="OrderPrint/DirectOrderPosted.asp"  target="right">订单已打印</a></li>
	  <li><a href="OrderPrint/WaybillForDirect.aspx"  target="right">运单录入</a></li>
      </ul>
    </div>	
	 <%} %>

	<%if (Warehousing.Business.PublicHelper.getReadRightByText("收银管理")==1){%>
	    <div class="l_bg02"><a>收银中心</a></div>
    <div class="l_bg02_A" style="display:none;">
      <ul>
        <li><a href="Cashier/SellGoods.aspx"  target="right">消费收银</a></li>
		<li><a href="Cashier/SellList.aspx"  target="right">收银记录</a></li>
		<li><a href="Cashier/SellReport.aspx" target="right">收银统计</a></li>
        <li><a href="Cashier/SellDate.aspx" target="right">每日统计</a></li>
        <li><a href="Cashier/SellGuide.aspx" target="right">导购统计</a></li>
        <li><a href="Cashier/SellTotal.aspx" target="right">商品统计</a></li>
      </ul>
    </div>
	 <%} %>
	<%if (Warehousing.Business.PublicHelper.getReadRightByText("库存管理") == 1)
   {%>
	    <div class="l_bg02"><a>库存管理</a></div>
    <div class="l_bg02_A" style="display:none;">
      <ul>
        <%if (Warehousing.Business.PublicHelper.getReadRightByText("商品库存")==1){%>
        <li><a href="Storage/ProductStock.aspx"  target="right">商品库存</a></li>
          <%} %>
        <%if (Warehousing.Business.PublicHelper.getReadRightByText("库存盘点")==1){%>
        <li><a href="Storage/CheckStock.aspx"  target="right">库存盘点</a></li>
         <%} %>
      </ul>
    </div>
	 <%} %>
	<%if (Warehousing.Business.PublicHelper.getReadRightByText("采购管理") == 1)
   {%>
	    <div class="l_bg02"><a>采购管理</a></div>
    <div class="l_bg02_A" style="display:none;">
      <ul>
        <%if (Warehousing.Business.PublicHelper.getReadRightByText("采购计划")==1){%>
        <li><a href="Storage/ProductPlan.aspx"  target="right">采购计划</a></li>
         <%} %>
        <%if (Warehousing.Business.PublicHelper.getReadRightByText("商品列表")==1){%>
        <li><a href="Storage/ProductList.aspx"  target="right">商品列表</a></li>
         <%} %>
        <%if (Warehousing.Business.PublicHelper.getReadRightByText("供应商列表")==1){%>
        <li><a href="Storage/SupplierList.aspx"  target="right">供应商列表</a></li>
         <%} %>
      </ul>
    </div>
	 <%} %>
    <%if (Warehousing.Business.PublicHelper.getReadRightByText("加工管理") == 1)
      {%>
    <div class="l_bg02"><a>加工管理</a></div>
    <div class="l_bg02_A" style="display:none;">
      <ul>
      <%if (Warehousing.Business.PublicHelper.getReadRightByText("加工模板") == 1)
        {%>
	  <li><a href="Production/Template.Aspx"  target="right">加工模板</a></li>
      <%} %>
      <%if (Warehousing.Business.PublicHelper.getReadRightByText("加工列表") == 1)
        {%>
	  <li><a href="Production/ProductionList.Aspx"  target="right">加工列表</a></li>
      <%} %>
      <%if (Warehousing.Business.PublicHelper.getReadRightByText("工厂列表") == 1)
        {%>
      <li><a href="Production/FactoryList.Aspx"  target="right">工厂列表</a></li>
      <%} %>
      </ul>
    </div>	
	 <%} %>
    <%if (Warehousing.Business.PublicHelper.getReadRightByText("会员中心") == 1)
      {%>
    <div class="l_bg02"><a>会员中心</a></div>
    <div class="l_bg02_A" style="display:none;">
      <ul>
	  <li><a href="User/UserList.aspx"  target="right">会员列表</a></li>
	  <li><a href="User/UserTotal.aspx"  target="right">会员统计</a></li>
      </ul>
    </div>	
	 <%} %>
    <div class="l_bg02"><a>综合管理</a></div>
    <div class="l_bg02_A" style="display:none;">
      <ul>
      
      <%if (Warehousing.Business.PublicHelper.getReadRightByText("管理员列表")==1){%>
        <li><a href="member/memberlist.aspx"  target="right">管理员列表</a></li>
         <%} %>
        <%if (Warehousing.Business.PublicHelper.getReadRightByText("系统模块")==1){%>
        <li><a href="member/membergroup.aspx"  target="right">管理员分组</a></li>
		<li><a href="member/pagepriv.aspx"  target="right">系统模块</a></li>
         <%} %>
        <%if (Warehousing.Business.PublicHelper.getReadRightByText("仓库列表")==1){%>
        <li><a href="member/storagelist.aspx"  target="right">仓库列表</a></li>
         <%} %>
        <%if (Warehousing.Business.PublicHelper.getReadRightByText("加盟管理") == 1)
          {%>
        <li><a href="member/AgentList.aspx"  target="right">加盟管理</a></li>
         <%} %>
         

        <%if (Warehousing.Business.PublicHelper.getReadRightByText("品牌列表")==1){%>
        <li><a href="member/BrandList.aspx"  target="right">品牌列表</a></li>
         <%} %>
        <%if (Warehousing.Business.PublicHelper.getReadRightByText("商品分类") == 1)
          {%>
        <li><a href="member/ProductTypeList.aspx"  target="right">商品分类</a></li>
         <%} %>
        <%if (Warehousing.Business.PublicHelper.getReadRightByText("导购列表")==1){%>
        <li><a href="member/GuideList.aspx"  target="right">导购列表</a></li>
         <%} %>
        <li><a href="member/changePwd.aspx"  target="right">修改密码</a></li>
      </ul>
    </div>
	
	
    <div class="l_bg02"><a href="logout.aspx" target="right" onclick="return confirm('确定退出管理中心吗');">安全退出</a></div>
  </div>
  <!--左边JQ导航结束--> 
  
  <!--中间按钮-->
  <div class="div_btn" style="height:778px"><span class="close"></span></div>
  <!--中间按钮结束--> 
  
  <!--右边 onload="this.height=right.document.body.scrollHeight+50;"-->
  <div class="right">
    <iframe id="frame_content" name="right" marginwidth=0 height="960" marginheight=0 src="welcome.aspx" frameborder=0 noresize width="100%" style="overflow:hidden;zoom:1;padding:0;"></iframe>
  </div>
  <!--右边内容结束--> 
</div>
<!--主题内容结束-->
<div class="clear"></div>
<!--底部-->
<div class="footer"><span>多彩ERP2017 版权所有 </span></div>
<!--底部结束--> 
<script type="text/javascript">
    function reinitIframe() {
        var iframe = document.getElementById("frame_content");
        try {
            //var bHeight = iframe.contentWindow.document.body.scrollHeight;
            var bHeight = iframe.contentWindow.document.body.scrollHeight;
            if (bHeight < 500) {
                bHeight = 500;
            }
            iframe.height = bHeight;
            if ($(".left").height() > bHeight) {
                $(".div_btn").height($(".left").height() + 100);
            }
            else {
                $(".div_btn").height(bHeight);
            }
        }
        catch (ex) { }
    }
    window.setInterval("reinitIframe()", 500);
</script> 
<iframe src="blank.asp" width="0" height="0" style="display:none"></iframe>
</body>
</html>
