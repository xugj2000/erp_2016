<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProductInDetail.aspx.cs" Inherits="Warehousing.Storage.ProductInDetail" %>

<html><head><title>入库管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../css/global.css" rel="stylesheet" type="text/css" />
<link href="../css/right.css" rel="stylesheet" type="text/css" /> 
<SCRIPT language="javascript" type=text/javascript src="/js/jquery.js"></SCRIPT>
<script language="javascript" type="text/javascript" src="/js/tjsetday.js"></script>
<script language="javascript" type="text/javascript" src="/js/jquery.validate.js"></script>
<style type="text/css">
.width2,.width3,.width4,.width6{height:30px;line-height:30px;border:solid 1px #CCC;border-bottom:solid 1px #666}
.width2{width:60px;margin:0px;}
.width3{width:80px;margin:0px;}
.width4{width:40px;margin:0px;text-align:center;}
.width6{width:120px;margin:0px;}
.add_link{color:red;margin:4px;display:block}
</style>

<style type="text/css" id="print"> 
td
{
font-size:14px;height:14px;line-height:14px;
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
<form id="form1" runat="server">
<div id="div1">

<table width="1000" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#CCCCCC" class="tableBorder">
<tr bgcolor="#FFFFFF"> 
<td  align="center"><b><strong>商品管理</strong></b></td>
</tr>
<tr bgcolor="#FFFFFF">
  <td  align="center" bgcolor="#FFFFFF" cellpadding="5" style="text-align:left">
<div class="only_print_view"><input type="button" id="btnPrint" value=" 打印预览 " onClick="OrderPreview()">
<input type="button"  value=" 直接打印 " onClick="OrderPrint()"  id="directPrint">
<input type="button"  value=" 返 回 " onClick="history.back();"  id="returnButton">
</div>
</td></tr>
<tr bgcolor="#FFFFFF">
  <td  align="center" bgcolor="#FFFFFF">
	<div id="view" style="width:800px;margin:0 auto;text-align:center">	
      <table width="100%" cellpadding="4" class="style1">
       <tr>
    <td colspan="2" style="font-size:20px;text-align:center;font-weight:bold;height:40px;">入库清单
    </td>
  </tr>
                    <tr>
              <td colspan=2>
<table width="100%" bgcolor="#FFFFFF" id="mytable" border="1" align="center" cellpadding="5" cellspacing="0">
  <tr bgcolor="#FFFFFF" align="center">
    <td colspan="11" style="text-align:left">
    入库类型： <%=Warehousing.Business.StorageHelper.getTypeText(sm_type)%>
    <%if (sm_supplierid>0){ %> 供应商名称： <%=Warehousing.Business.StorageHelper.getSupplierName(sm_supplierid)%><%} %>
     <%if (warehouse_id_from>0){ %>调货仓库：从<%=Warehousing.Business.StorageHelper.getWarehouseName(warehouse_id_from)%> 到 <%=Warehousing.Business.StorageHelper.getWarehouseName(warehouse_id)%><%} %>
    入库单号：<%=sm_sn%>
    到货日期：<%=sm_date %>

    </td>
  </tr>
  <tr>
     <td>&nbsp;</td>
    <td>条码</td>
  	<td>名称</td>
    <td>款号</td>
    <td>单位</td>
    <td>颜色</td>
    <td>型号</td>
    <td>数量</td>
	<td>单价</td>
    <td>金额</td>
    <td>仓位</td>
    
  </tr>
		<asp:Repeater ID="MemberList" runat="server">
                           <ItemTemplate>   
  <tr bgcolor="#FFFFFF" align="center">
   <td style="height:20px;"><%# Container.ItemIndex + 1%> </td>
    <td><input type=hidden name="p_id" value='<%#Eval("p_id")%>' /><%#Eval("p_txm")%></td>
  	<td><%#Warehousing.Business.PublicHelper.subStr(Convert.ToString(Eval("p_name")),6)%></td>
    <td><%#Eval("p_serial")%></td>
    <td><%#Eval("p_unit")%></td>
    <td><%#Warehousing.Business.PublicHelper.subStr(Convert.ToString(Eval("p_spec")),4)%></td>
    <td><%#Warehousing.Business.PublicHelper.subStr(Convert.ToString(Eval("p_model")), 4)%></td>
	<td><%#Convert.ToDouble(Eval("p_quantity"))%></td>
	<td><%#Convert.ToDouble(Eval("p_price"))%></td>
    <td><%#Convert.ToDouble(Eval("p_price")) * Convert.ToDouble(Eval("p_quantity"))%></td>
    <td><%#Eval("shelf_no")%>&nbsp;</td>
  </tr>
          </ItemTemplate>
          </asp:Repeater>
 <tr>
  <td style="height:20px;text-align:right" colspan=7> 商品合计</td>
	<td align=center><%=all_num%></td>
    <td align=center>&nbsp;</td>
    <td align=center><%=all_price%></td>
    <td align=center>&nbsp;</td>
  </tr>
  <tr bgcolor="#FFFFFF" align="center">
    <td colspan="11" style="text-align:left">
    制表时间:<%=sm_time%> 
    审核人：<span style="display:inline-block;width:70px;">&nbsp;</span> 
    收货员：<span style="display:inline-block;width:70px;"><%=sm_operator %></span> 
    收货签收： <span style="display:inline-block;width:70px;">&nbsp;</span> 
    
    备注:<%=sm_remark%>
    </td>
  </tr>
	</table>
                  </td>
          </tr>
<tr bgcolor="#FFFFFF"<%if (current_sm_status>0){Response.Write("style='display:none;'");} %>> 
<td height="30"  align="left" colspan=2>

                  <asp:DropDownList ID="sm_status" runat="server">
                  <asp:ListItem Text="等待审核" Value="0"></asp:ListItem>
                  <asp:ListItem Text="通过" Value="1"></asp:ListItem>
                  <asp:ListItem Text="作废" Value="2"></asp:ListItem>
                  </asp:DropDownList>

<asp:Button ID="Button1" runat="server" Text=" 审 核 " onclick="Button1_Click" />
</td>
</tr>
          </table>
	</div>
</form>


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
		var iPageHigh=200;
		//iPageHigh=iPageHigh+20*<%=MemberList.Items.Count%>;//加上公共信息
        iPageHigh=iPageHigh+30*<%=MemberList.Items.Count%>;//加上公共信息
		iPageHighs=iPageHigh/96*254;//折算成毫米(单位0.1mm) (这里px是绝对值长度单位：96px/in)
		LODOP.PRINT_INIT("出库单打印"); 
        LODOP.SET_PRINT_STYLE("PenStyle",0);//设置线条风格0--实线 1--破折线 2--点线 3--点划线 4--双点划线 缺省值是0。
        LODOP.SET_PRINT_STYLE("PenWidth",2);//单位是(打印)像素，缺省值是1，非实线的线条宽也是0
		LODOP.SET_PRINT_PAGESIZE(1,2400,iPageHighs,""); 
		LODOP.ADD_PRINT_HTM(20,<%=print_page_width %>,800,iPageHigh,strFormHtml); //四个数值分别表示Top,Left,Width,Height
		LODOP.SET_PRINT_STYLEA(1,"Horient",1);
	};
</script>	

</body>
</html>
