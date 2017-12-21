<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CashierPrint.aspx.cs" Inherits="Warehousing.Cashier.CashierPrint" %>

<html><head><title>小票打印</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../css/global.css" rel="stylesheet" type="text/css" />
<link href="../css/right.css" rel="stylesheet" type="text/css" /> 
<SCRIPT language="javascript" type=text/javascript src="/js/jquery.js"></SCRIPT>

<style type="text/css" id="print"> 
td
{
font-size:12px;height:14px;line-height:14px;
} 
 .bigtitle {
	font-size: 18px;
	text-decoration: none;
	font-weight: bold; 
}
</style> 

<script language="javascript" src="/print/CheckActivX.js"></script>
<object id="LODOP" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=0 height=0>
  <param name="License" value="845515150585010011211256128900">
</object>
<script language="javascript" type="text/javascript">
    var LODOP = document.getElementById("LODOP"); //这行语句是为了符合DTD规范
    CheckLodop();
</script>

</head>
<body>

<table width="1000" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#CCCCCC" class="tableBorder">
<tr bgcolor="#FFFFFF"> 
<td  align="center"><b><strong>商品管理</strong></b></td>
</tr>
<tr bgcolor="#FFFFFF">
  <td  align="center" bgcolor="#FFFFFF" cellpadding="5" style="text-align:left">
<div class="only_print_view"><input type="button" id="btnPrint" value=" 打印预览 " onClick="OrderPreview()">
<input type="button"  value=" 直接打印 " onClick="OrderPrint()"  id="directPrint">
<input type="button"  value=" 返 回 " onClick="location.href='SellList.aspx'"  id="returnButton">
</div>
</td></tr>
<tr bgcolor="#FFFFFF">
  <td  align="center" bgcolor="#FFFFFF">

  <!-- lodop打印区域开始#################################################################### -->
<div id="view" style="width:180px;margin:0 auto;text-align:center">		
                <div style="width:180px;height:28px;line-height:28px;margin-bottom:10px;font-size:14px;text-align:center;border-bottom:solid 1px #333;"><%=PrintTitle %></div>
                <div style="width:180px;text-align:center"> <%=PrintMessage %></div>
</div>
<!-- lodop打印区域开始#################################################################### -->

</td>
</tr>
</table>
 <script language="javascript" type="text/javascript"> 
 	
	function OrderPrint() {		

		CreateFormPage();
		LODOP.PRINT();	
	};               	
	function OrderPreview() {
	   
		CreateFormPage();
       
		LODOP.PREVIEW();
	};
	function CreateFormPage() {
	    
	    var strBodyStyle = "<style>" + document.getElementById("print").innerHTML + "</style>";
	    
		var strFormHtml=strBodyStyle+"<body>"+document.getElementById("view").innerHTML+"</body>";	
		//var iPageHigh=document.getElementById("view").scrollHeight;
		var iPageHigh=600;
        iPageHigh=iPageHigh+30*<%=count%>;//加上公共信息
        iPageHighs=iPageHigh/96*254;//折算成毫米(单位0.1mm) (这里px是绝对值长度单位：96px/in)
		LODOP.PRINT_INIT("<%=PrintTitle %>"); 
		LODOP.SET_PRINT_PAGESIZE(1,550,iPageHighs,"");
		LODOP.ADD_PRINT_HTM(0,25,740,iPageHigh,strFormHtml); 
		LODOP.SET_PRINT_STYLEA(1,"Horient",1);
	};
</script>	

</body>
</html>
