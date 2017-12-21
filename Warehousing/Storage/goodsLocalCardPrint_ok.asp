<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<!--#include file="conn.asp"-->
<!--#include file="../inc/powerfunction.asp"-->
<!--#include file="../inc/powercheck.asp"-->
<!--#include file="../inc/TXM.asp"-->
<%
call GetPageUrlpower("Storage/goodsLocalCardPrint.asp")'取得页面的所有权限
call CheckPageRead()'检查当前页面是否有页面读取权限
localCard=request.form("localCard")
if trim(localCard)="" then 
response.write "<script>alert('请输入要打印条码的货架号');history.back();</script>"
response.end
end if
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>厂商批量出库管理</title>
<link href="../css/global.css" rel="stylesheet" type="text/css" />
<link href="../css/right.css" rel="stylesheet" type="text/css" /> 
<style media=print id="print">   
body{margin:0px;}
td{font-size:12px;line-height:100%;}
.Noprint{display:none;}   
.only_print_view {display:none;}
</style>
</head>
<body>
<script language="javascript" src="../js/CheckActivX.js"></script>
<object id="LODOP" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=0 height=0>
  <param name="License" value="845515150585010011211256128900">
</object>
<script language="javascript" type="text/javascript">
	var LODOP=document.getElementById("LODOP");//这行语句是为了符合DTD规范
	CheckLodop();
</script>
<div class="only_print_view"><table width="800" border="0" align="center" cellpadding="5">
  <tr>
    <td>  <input type='button' name='PrintPreview' value='打印预览' onclick='Javascript:OrderPreview();'>
  <input type='button' name='Print' value=' 打 印 ' onclick='Javascript:OrderPrint();'>
  <input type='button' name='return' value=' 返 回 ' onclick='history.back();'>
  </td>
  </tr>
</table>
</div>
<div id="view">
<%

localcardarray=split(localCard,vbcrlf)
pagei=0
for i=0 to ubound(localcardarray)
pagei=pagei+1
%>
<table border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="50" align="center" style="font-size:66px;line-height:50px;font-weight:bold;font-family:'宋体';overflow:hidden;"><%=localcardarray(i)%></td>
  </tr>
  <tr>
    <td height="52">
<%=dragcode(haiwaocde(lcase(localcardarray(i))))%></td>
  </tr>
  <tr>
    <td height="60">&nbsp;</td>
  </tr>
    <tr>
    <td height="42"></td>
  </tr>
</table>
<%
next
%>
</div>
<script language="javascript" type="text/javascript">
	function OrderPrint() 
	{		
		CreateFormPage();
		LODOP.PRINT();	
	};               	
	function OrderPreview()
	{		
		CreateFormPage();
		LODOP.PREVIEW();
	};
	function CreateFormPage()
	{
		var strBodyStyle="<style>"+document.getElementById("print").innerHTML+"</style>";
		var strFormHtml=strBodyStyle+"<body>"+document.getElementById("view").innerHTML+"</body>";	
		var iPageHigh=document.getElementById("view").offsetHeight;
		iPageHigh=iPageHigh;//加上公共信息
		iPageHighs=<%=pagei%>*531.81;//折算成毫米(单位0.1mm) (这里px是绝对值长度单位：96px/in)	
		LODOP.SET_PRINT_PAGESIZE(1,850,iPageHighs,"");
		LODOP.ADD_PRINT_HTM(0,0,750,iPageHigh,strFormHtml); 
		LODOP.SET_PRINT_STYLEA(1,"Horient",2);
	};
</script>
</body>
</html>
